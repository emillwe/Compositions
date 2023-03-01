/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Complex Waveform - Synchronous Granular Synthesis

Wavepacket Synthesis
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, refFreq = 440.0, wavRatio = 1.0, panAngle = 0.0, buffer = 0|

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
		grainFreq = freq;
		envFreq = wavRatio * refFreq/2;
		grainDur = envFreq.reciprocal;

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// granular (grain frequency) trigger
		trigger = Impulse.ar(grainFreq);

		// granular synthesis
		granSig = GrainIn.ar(trigger: trigger, dur: grainDur, in: DC.ar(1.0), envbufnum: buffer);

		// apply the amplitude envelope
		granSig = amp * ampEnv * granSig;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * granSig;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})
