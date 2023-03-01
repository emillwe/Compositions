/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Band-pass AM Band-limited Noise (BLN) Synthesis

AM Sample & Hold Noise
Order: 2

*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, q = 1.0, modIndexGain = 0.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var shNoise, out;     // vars assigned to audio signals
		var amp, phase;  // a few vars for synthesis
		var freqN;  // s&h frequency
		var ampEnv, env;       // vars for envelope signal
		var shOrder;
		var normFac;      // normalization factor
		var modIndex;     // modulation index (a scalar)

		// assign values
		bus = 0;          // first output
		shOrder = 2;  // s&h order - LFNoise2
		phase = pi/2;  // phase of oscillator - setting to pi/2 (cosine) allows freq = 0 for no modulation

		// calcs
		amp = gain.dbamp;  // convert from gain in dB to linear amplitude scale
		modIndex = modIndexGain.dbamp; // convert " "
		normFac = (1 + (2 * modIndex)).reciprocal; // amplitude normalization factor
		freqN = main.functions[\shBPFreq].value(freq, q, shOrder);  // map cutoff frequency to s&h frequency

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);

		// the sample & hold noise
		shNoise = LFNoise2.ar(freqN, modIndex);

		// the oscillator - modulate
		shNoise =  SinOsc.ar(freq, phase, (2 * shNoise) + 1);  // simple carrier (single sinusoid)

		// normalize, and scale by amp
		shNoise = (amp * normFac) * shNoise;

		// rescale shNoise, by multiplying by ampEnv
		shNoise = ampEnv * shNoise;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * shNoise;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
