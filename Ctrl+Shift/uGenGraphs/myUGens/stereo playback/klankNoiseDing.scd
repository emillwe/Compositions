/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

White noise filtered by an FIR kernel
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, width = 90.0, freqModScalar = 1.0, freqModRate = 0.5, freqModDepth = 0.03, ampModRate = 2.0|

		// variables
		var bus;          // var to specify output bus
		var noise, filtered, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var env;       // vars for envelope signal
		var freqs, amps, decs; // for filter bank
		var mod; // LFO

		// assign values
		bus = 0;          // first output

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		env = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),
			levelScale: amp,
			timeScale: dur
		);

		// complex sources synthesis
		noise = WhiteNoise.ar(LFNoise2.kr(ampModRate).range(0.1, 1.0));

		// FM LFO
		mod = LFNoise2.kr(freqModRate).range(1.0 - (freqModDepth/10.0), 1.0 + (freqModDepth/10.0));

		freqs = [
			1218, 1548, 1728, 2384, 2527, 2633, 2878, 2998, 3146, 3558, 3784, 4281, 4460, 4600, 4842, 5329, 5572,
			5766, 6154, 7008, 7327, 7982, 8577, 8096, 8636, 8898, 9802, 10005
		] * freqModScalar;

		amps = Array.rand(freqs.size, 0.1, 1.0);

		decs = Array.series(freqs.size, 0.1, 0.1); // increasing partial decay times

		// Everybody loves Klank
		filtered = DynKlank.ar(`[freqs, amps, decs], noise, mod) * 0.01; // <-- Subtractive Synthesis

		// apply amp env
		filtered = env * filtered;

		// rotate
		out = main.functions[\spatMatFilt].value(
			[filtered, filtered],
			main.functions[\widthMatrix].value(width);  // <-- Imaging happens here!
		);

		// out!!
		Out.ar(bus, out)
	}
})
