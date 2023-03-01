/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Normalised Type 2 AM - Cascade Design
*/

({ |main|
	{ |dur, gain = -12.0, ris = 0.1, curve = -7, freqCar = 440.0, freqMod = 440.0, modIndexGain = 0.0, panAngle = 0.0, buffer = 0|

		// variables
		var bus;          // var to specify output bus
		var oscCar, oscMod;  // oscillators
		var out;          // output!
		var amp, phase;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal
		var normFac;      // normalization factor
		var modIndex;     // modulation index (a scalar)

		// assign values
		bus = 0;          // first output
		phase = 0;        // phase of oscillator

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale
		modIndex = modIndexGain.dbamp; // convert " "
		normFac = (1 + (2 * modIndex)).reciprocal; // amplitude normalization factor

		// the amplitude envelope
		env = Env.perc(ris, (1.0 - ris), curve: curve);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// the oscillators
		oscMod = SinOsc.ar(freqMod, phase, modIndex);  // simple modulator (single sinusoid)
		oscCar = Osc.ar(buffer, freqCar, phase, (2 * oscMod) + 1);  // complex carrier (harmonic sinusoids) <-- wavetable oscillator

		// normalize carrier oscillator
		oscCar = (amp * normFac) * oscCar;

		// rescale oscCar, by multiplying by ampEnv
		oscCar = ampEnv * oscCar;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * oscCar;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
