/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Karplus-Strong Synthesis
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, freq, lfoRate, panAngle = 0|

		var bus;
		var env;
		var trig;
		var string;
		var trigFreq;
		var out;

		bus = 0;
		trigFreq = LFNoise2.kr(1).range(1, 5.5);
		trig = Impulse.kr(trigFreq);

		string = Pluck.ar(
			in: [WhiteNoise.ar(), WhiteNoise.ar()],
			trig: trig,
			delaytime: freq.reciprocal,
			decaytime: LFNoise2.kr(0.1).range(1, 20),
			mul: 0.4,
			coef: LFNoise2.kr(0.2).range(-0.1, 0.8)
		);

		env = EnvGen.kr(
			envelope: Env.linen(
				attackTime: ris,
				sustainTime: dec,
				releaseTime: 1 - (ris + dec)
			),
			levelScale: gain.dbamp,
			timeScale: dur,
		);

		out = string * env;

/*		out = main.functions[\sinCosPanLaw].value(panAngle) * out;*/

		// out!!
		Out.ar(bus, out)
	}
})
