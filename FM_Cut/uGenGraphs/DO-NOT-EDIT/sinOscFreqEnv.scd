/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

A Sine Oscillator with frequency modulation
*/

({ |main|
	{ |dur, gain = -12, cFreq = 440, startFreq = 440.0, endFreq = 880, panAngle = 0, startDelay, fundamental|
		var env, envGen, envTime, amp;
		amp = gain.dbamp;

		envTime = startDelay * (cFreq/fundamental).log2;
		env = Env(
			[0, 1, 0], // amp values
			[envTime,// time to centerFreq
				dur - envTime], // the remainder of the time after centerFreq
			'sin' // curves
		);
		envGen = EnvGen.kr(env);
		amp = envGen * amp * main.functions[\sinCosPanLaw].value(panAngle);
		Out.ar(0,
			// 'amp' is a value between 0 and 1.
			SinOsc.ar(
				XLine.ar(startFreq, endFreq, dur),
				0,
				amp
			); // XLine for exponential between freqs
		)
	}
})
