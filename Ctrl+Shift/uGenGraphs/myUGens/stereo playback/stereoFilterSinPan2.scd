/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Stereophonic Filtered PlayBuf
*/

({ |main|
	{| dur, gain = 0.0, ris = 0.01, dec = 0.01, rate = 1, panRate = 0.3, cutoff, rqRange = 0.1, freqModRate = 0.5, rqModRate = 1.0, loop = 0, buffer = 0|

		// variables
		var bus;          // var to specify output bus
		var numChannels = 2; // <-- stereo buffer
		var playBuf, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv;       // vars for envelope signal
		var panFunc; // panning function
		var freqs; // frequency bank
		var filtered; // filter bank
		var rqMod;

		freqs = [ 393, 451, 727, 990, 1307, 1459, 2531, 3732, 4500, 4611, 5227,
		6967, 7699, 8098];

		// assign values
		bus = 0;          // first output

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// amplitude envelope: Env nested in EnvGen
		ampEnv = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),  // <-- envelope
			timeScale: dur
		);

		// sample playback
		playBuf = PlayBuf.ar(numChannels, buffer,  BufRateScale.kr(buffer) * LFNoise2.kr(0.5).range(rate - 4.0, rate + 2.0), loop: loop);

		// rqMod = LFNoise2.kr(rqModRate).range(0.0, rqRange);
		rqMod = XLine.kr(1.0, rqRange, dur);
		// rqMod = 0.0001;

		filtered = BPF.ar(
			in: playBuf,
			freq: cutoff * LFNoise2.kr(freqModRate).range(0.95, 1.05),
			rq: rqMod,
			mul: 1 / ((rqMod+0.05)**2)
		);

		// rescale, by multiplying by ampEnv
		filtered = ampEnv * amp * filtered;

		panFunc = SinOsc.kr(panRate).range(-90.0, 90.0);

		// expand to two channels - panning
		// out = main.functions[\sinCosPanLaw].value(panFunc) * filtered;  // <-- Panning (balance) happens here!

		// rotate
		out = main.functions[\spatMatFilt].value(
			filtered,
			main.functions[\rotateMatrix].value(panFunc)
		);  // <-- Imaging happens here!

		// out!!
		Out.ar(bus, out)
	}
})
