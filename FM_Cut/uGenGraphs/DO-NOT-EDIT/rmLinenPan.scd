/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

RM (DSB) - Multiply Design: Simple Carrier, Complex Modulator
*/

({ |main|
	{ |dur, gain = -12.0, ris = 0.1, dec = 0.1, freqCar  = 0.0, freqMod = 440.0, panAngle = 0.0, buffer = 0|

		// variables
		var bus;          // var to specify output bus
		var oscCar, oscMod;  // oscillators
		var out;          // output!
		var amp, phase;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal

		// assign values
		bus = 0;          // first output
		phase = pi/2;  // phase of oscillators - setting to pi/2 (cosine) allows freqCar = 0 for no modulation

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// the oscillators
		oscMod = Osc.ar(buffer, freqMod, phase);  // complex modulator (harmonic sinusoids) <-- wavetable oscillator
		oscCar = SinOsc.ar(freqCar, phase);  // simple carrier (single sinusoid)

		// modulate
		oscCar = oscMod * oscCar;

		// rescale by amp
		oscCar = amp * oscCar;

		// rescale oscCar, by multiplying by ampEnv
		oscCar = ampEnv * oscCar;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * oscCar;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
