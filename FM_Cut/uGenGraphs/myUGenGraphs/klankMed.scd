({ |main|
	{ |dur = 2, ris = 0.1, dec = 0.1, gain = -25, pingRate = 3, mult = 1, type = 0, panAngle = 0, panRate = 0.3|

		// variables!
		var bus;      // output bus
		var freqs;    // resonant frequencies
		var klank;    // resonator UGen
		var input;    // input to resonator
		var size;     // number of partials
		var len;      // attack/release times
		var amp, ampEnv;    // loudness, fade in/out
		var out;            // output signal

		// assign values
		bus = 0;
		freqs = mult * main.functions[\bellFreqs].value;
		size = freqs.size;

		amp = gain.dbamp;

		ampEnv = EnvGen.kr(
			envelope: Env.linen(ris, 1 - (ris + dec), dec),
			timeScale: dur
		);

		// the input to resonator
		// input = [Dust.ar(pingRate), Dust.ar(pingRate)];
		input = WhiteNoise.ar() * EnvGen.kr(
			envelope: Env.perc(
				attackTime: LFNoise2.kr(0.05).range(0.3, 1.0),
				releaseTime: LFNoise2.kr(0.05).range(1.0, 3.0)
				// attackTime: LFNoise2.kr(0.05).range(0.001, 0.025),
				// releaseTime: LFNoise2.kr(0.05).range(0.01, 2)
/*				attackTime: XLine.kr(0.001, 2, dur),
				releaseTime: XLine.kr(0.01, 4, dur)*/
			),
			gate: Dust.kr(pingRate * [1, 1])
		);

		// the resonator
		klank = DynKlank.ar(
			[ freqs, Array.rand(15, 0.1, 0.4), Array.rand(15, 0.01, 1) ].asRef,
			input: input,
			freqscale: LFNoise2.kr(0.7).range(1.0, 1.01)
		);

		// scale output
		klank = klank * ampEnv * amp;

		// pan output
		out = klank * main.functions[\sinCosPanLaw].value(
			LFNoise2.kr(panRate) * panAngle
			// SinOsc.kr(panRate) * panAngle
		);

		// out!!!!!!!!!!!!!!
		Out.ar(bus, out)
	}
})
