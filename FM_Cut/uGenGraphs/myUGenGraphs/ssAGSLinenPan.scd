/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Simple Sinusoid - Asynchronous Granular Synthesis

Formant Synthesis
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, density = 1.0, formFreq = 1760.0, q = 1.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal
		var grainDur, grainFreq, envFreq, wavFreq;
		var trigger;
		var granSig;


		// assign values
		bus = 0;          // first output

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale
		grainFreq = density * q.reciprocal * formFreq;
		envFreq = q.reciprocal * (formFreq/2);
		wavFreq = formFreq;
		grainDur = envFreq.reciprocal;

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// granular (grain frequency) trigger
		trigger = Dust.ar(grainFreq); // <-- Dust gives us an asynchronous trigger!

		// granular synthesis
		granSig = GrainSin.ar(trigger: trigger, dur: grainDur, freq: wavFreq);

		// apply the amplitude envelope
		granSig = amp * ampEnv * granSig;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * granSig;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})