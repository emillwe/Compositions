// granulator!

({ |main|
	{| gain = 0, dur, ris = 0.1, dec = 0.1, buffer = 0, density = 3.0, rateModFreq = 0.3, rateModDepth = 1.5, durLow = 0.2, durModDepth = 1.5, posModRate = 0.5, dlyTime = 0.2|
		var out, bus;               // audio out bread and butter
		var numChannels;            // mono/stereo
		var trigger;                // Dust or Impulse
		var rateMod, posMod, durMod, trigMod, panRateMod; // playback rate,
		                             // sample position,
		                             // grain duration, and
		                             // trig rate modulators
		var env;         // amplitude envelope
		var amp;         // amplitude
		var left, right; // pseudo-stereo

		// assignment
		numChannels = 1; // mono
		amp = gain.dbamp;

		// async grain trigger
		trigger = Dust.ar(density);

		// playback rate modulator
		rateMod = LFNoise0.kr(
			rateModFreq
		).range(0.5, rateModDepth);

		// buffer position modulator
		posMod = LFNoise0.kr(posModRate).range(0.0, 1.0);

		// grain duration modulator
		durMod = LFNoise0.kr(3.0).range(durLow, durModDepth);

		// amp envelope
		env = EnvGen.kr(
			Env.linen(
				ris,
				1 - (ris + dec),
				dec
			),
			timeScale: dur,
			levelScale: amp
		);

		left = GrainBuf.ar(
			numChannels: numChannels,
			trigger: trigger,
			dur: durMod / rateMod,
			sndbuf: buffer,
		 	rate: rateMod,
		 	pos: posMod,
		 	mul: 0.5
		);

		/*// apply amp envelope
		left = left * env;*/

		// pseudo-stereo
		right = DelayN.ar(left, 0.5, dlyTime);

		out = [left, right];

		// apply amp envelope
		out = out * env;

		bus = 0;

		Out.ar(bus, out);
	}
})