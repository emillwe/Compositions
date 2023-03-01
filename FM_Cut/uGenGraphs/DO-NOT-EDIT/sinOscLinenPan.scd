/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

A Sine Oscillator
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var osc, out;     // vars assigned to audio signals
		var amp, phase;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal

		// assign values
		bus = 0;          // first output
		phase = 0;        // phase of oscillator

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// the oscillator
		osc = SinOsc.ar(freq, phase, amp);

		// rescale osc, by multiplying by ampEnv
		osc = ampEnv * osc;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * osc;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
