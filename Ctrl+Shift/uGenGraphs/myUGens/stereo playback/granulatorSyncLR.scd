// granulator!

({ |main|
	{| gain = 0, dur, ris = 0.1, dec = 0.1, bufferL = 0, bufferR = 0, rateModFreq = 0.3, rateLow = 0.3, rateModDepth = 1.5, durLow = 0.2, durModDepth = 1.5, posModRate = 0.5, rotAngle = 0, trigRate = 3.0|
		var out, bus;               // audio out bread and butter
		var numChannels;            // mono/stereo
		var triggerL, triggerR;                // Dust or Impulse
		var rateMod, posMod, durMod, trigMod, panRateMod; // playback rate,
		                             // sample position,
		                             // grain duration, and
		                             // trig rate modulators
		var env;         // amplitude envelope
		var amp;         // amplitude
		var granSigL, granSigR;     // granular signal
		var trigRateModL, trigRateModR;

		// assignment
		numChannels = 1; // mono
		amp = gain.dbamp;

		trigRateModL = SinOsc.kr(
			freq: 0.3,
			phase: 0
		).range(0, trigRate);

		trigRateModR = SinOsc.kr(
			freq: 0.3,
			phase: pi/2
		).range(0, trigRate);

		// quadrature grain trigger
		triggerL = Impulse.ar(trigRateModL);
		triggerR = Impulse.ar(trigRateModR);

		// playback rate modulator
		rateMod = LFNoise0.kr(
			rateModFreq
		).range(rateLow, rateModDepth);

		// buffer position modulator
		// posMod = LFNoise2.kr(posModRate).range(0.0, 1.0);
		posMod = 0; // quick fix

		// grain duration modulator
		durMod = LFNoise0.kr(3.0).range(durLow, durModDepth);

		// amp envelope
		env = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),
			levelScale: amp,
			timeScale: dur
		);

		granSigL = GrainBuf.ar(
			numChannels: numChannels,
			trigger: triggerL,
			dur: durMod,
			sndbuf: [bufferL, bufferR],
		 	rate: rateMod,
		 	pos: posMod,
		);

		granSigR = GrainBuf.ar(
			numChannels: numChannels,
			trigger: triggerR,
			dur: durMod,
			sndbuf: [bufferL, bufferR],
		 	rate: rateMod,
		 	pos: posMod,
		);

		// apply amp envelope
		out = [granSigL, granSigR] * env;
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