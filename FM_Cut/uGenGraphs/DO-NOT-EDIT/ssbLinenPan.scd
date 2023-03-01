/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

SSB (FS) - Simple Carrier, Complex Modulator
*/

({ |main|
	{ |dur, gain = -12.0, ris = 0.1, dec = 0.1, freqCar  = 0.0, freqMod = 440.0, panAngle = 0.0, bufferCos = 0, bufferSin = 1|

		// variables
		var bus;          // var to specify output bus
		var oscCar, oscMod;  // oscillators
		var ssb;          // ssb signal!
		var out;          // output!
		var amp, phase;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal

		// assign values
		bus = 0;          // first output
		phase = [pi/2, 0];  // phase of oscillators, in quadrature: phase = [cos, sin]

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// the oscillators
		oscMod = Osc.ar([bufferCos, bufferSin], freqMod); // complex complex modulator, in quadrature: phase =  [cos, sin]
		oscCar = SinOsc.ar(freqCar, phase); // simple carrier, in quadrature: phase = [cos, sin]

		// modulate - generate single sideband - upper sideband
		ssb = ((oscCar.at(0) * oscMod.at(0)) - (oscCar.at(1) * oscMod.at(1)));
		/*
		The above could also be expressed as:

		ssb = ((oscCar * oscMod) * [ 1, -1]).sum;
		*/

		// rescale by amp
		ssb = amp * ssb;

		// rescale oscCar, by multiplying by ampEnv
		ssb = ampEnv * ssb;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * ssb;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
