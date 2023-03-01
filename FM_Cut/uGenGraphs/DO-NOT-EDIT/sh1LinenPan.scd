/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Low-pass Band-limited Noise (BLN) Synthesis

Sample & Hold Noise
Order: 1

*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, freqCutoff = 440.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var shNoise, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var freqN;  // s&h frequency
		var ampEnv, env;       // vars for envelope signal
		var shOrder;

		// assign values
		bus = 0;          // first output
		shOrder = 1;  // s&h order - LFNoise1

		// calcs
		amp = gain.dbamp;  // convert from gain in dB to linear amplitude scale
		freqN = main.functions[\shLPFreq].value(freqCutoff, shOrder);  // map cutoff frequency to s&h frequency

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// the sample & hold noise (MusicV RANDI)
		shNoise = LFNoise1.ar(freqN, amp);

		// rescale shNoise, by multiplying by ampEnv
		shNoise = ampEnv * shNoise;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * shNoise;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
