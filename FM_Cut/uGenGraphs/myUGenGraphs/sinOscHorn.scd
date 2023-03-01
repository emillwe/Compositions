/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

({ |main|
	{ |dur = 2, gain = -6, freq = 440, phase = 0, panAngle = 0, wet = 0.4|

		// variables
		var bus;          // var to specify output bus
		var osc, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal
		var pitchEnv;     // pitch envelope

		// assign values
		bus = 0;          // first output
		phase = 0;        // phase of oscillator

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// Airhorn envelope from analysis
		env = Env.new(
			levels: [0, 1, 0.6, 0],
			times: [0.0079, 0.496, 0.496],
			curve: [-5, 0, -2]
		);
		ampEnv = EnvGen.kr(env, timeScale: dur);

		// pitchEnv = XLine.kr(freq, 0.97 * freq, dur: dur);
		pitchEnv = EnvGen.kr(
			envelope: Env.new(
				[freq, freq * 1.02, freq * 0.995],
				[0.05, 0.95],
				curve: \exp
			),
			timeScale: dur);
		// the oscillator
		osc = SinOsc.ar( // SinOsc UGen
			freq: pitchEnv,        // 1st arg of SinOsc: freq (from synthDef argument)
			phase: phase,       // 2nd arg of SinOsc: (set to a default value)
			mul: amp          // 3rd arg of SinOsc: (set to a default value)
		);

		// rescale osc, by multiplying by ampEnv
		osc = ampEnv * osc;

		// expand to two channels
		out = osc * main.functions[\sinCosPanLaw].value(panAngle);
		// 6.do{out = AllpassN.ar(out, 0.2, [0.04.rand, 0.04.rand], decaytime:4)};
		/*out = FreeVerb2.ar(
			out[0],
			out[1],
			mix: wet,
			room: 1,
			damp: 0.2,
			mul: 4.0
		);*/

		// out!!
		Out.ar(         // Out UGen
			bus,        // 1st arg of Out: (set to a default value - the 1st output)
			out         // 2nd arg of Out: (two channels)
		)
	}
})