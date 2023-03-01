// granulator!

({ |main|
	{| gain = 0, dur, ris = 0.1, dec = 0.1, bufferL = 0, bufferR = 0, density = 3.0, rateModFreq = 0.3, rateLow = 0.3, rateModDepth = 1.5, durLow = 0.2, durModDepth = 1.5, posModRate = 0.5, rotAngle = 0|
		var out, bus;               // audio out bread and butter
		var numChannels;            // mono/stereo
		var trigger;                // Dust or Impulse
		var rateMod, posMod, durMod, trigMod, panRateMod; // playback rate,
		                             // sample position,
		                             // grain duration, and
		                             // trig rate modulators
		var env;         // amplitude envelope
		var amp;         // amplitude
		var granSig;     // granular signal

		// assignment
		numChannels = 1; // mono
		amp = gain.dbamp;

		// async grain trigger
		trigger = Dust.ar(density);

		// playback rate modulator
		rateMod = LFNoise0.kr(
			rateModFreq
		).range(rateLow, rateModDepth);

		// buffer position modulator
		posMod = LFNoise2.kr(posModRate).range(0.0, 1.0);

		// grain duration modulator
		durMod = LFNoise0.kr(3.0).range(durLow, durModDepth);

		// amp envelope
		env = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),
			levelScale: amp,
			timeScale: dur
		);

		granSig = GrainBuf.ar(
			numChannels: numChannels,
			trigger: trigger,
			dur: durMod,
			sndbuf: [bufferL, bufferR],
		 	rate: rateMod,
		 	pos: posMod,
		);

		// apply amp envelope
		out = granSig * env;
		// granSig = granSig * env;

		// rotate
		out = main.functions[\spatMatFilt].value(
			out,
			main.functions[\rotateMatrix].value(rotAngle)
		);  // <-- Imaging happens here!

		bus = 0;

		Out.ar(bus, out);
	}
})