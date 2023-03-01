/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Simple FM - with enveloped modulation index
*/

({ |main|
	{ |dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440, carRatio = 1, modRatio = 2, modIndex = 1.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var oscCar, oscMod;  // oscillators
		var out;             // output!
		var amp, phase;  // a few vars for synthesis
		var ampEnv;       // var for envelope signal
		var modEnv;       // ... for modulation envelope
		var freqCar, freqMod;  // carrier and modulator freqs...
		var modDev;  // ... and deviation


		// assign values
		bus = 0;          // first output
		phase = 0;        // phase of oscillator

		// initial calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale
		freqCar = carRatio * freq;
		freqMod = modRatio * freq;
		modDev = modIndex * freqMod;

		// the amplitude envelope nested in the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),  // env
			timeScale: dur
		);

		// the modulation envelope nested in the UGen that synthesises the envelope
		modEnv = EnvGen.kr(
			Env.sine(1.0),  // env
			timeScale: dur
		);


		// the oscillators
		oscMod = SinOsc.ar(freqMod, phase, modDev * modEnv);         // simple modulator (single sinusoid)
		oscCar = SinOsc.ar(freqCar + oscMod, phase, amp);   // simple carrier (single sinusoid)

		// apply the amplitude envelope
		oscCar = ampEnv * oscCar;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * oscCar;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
