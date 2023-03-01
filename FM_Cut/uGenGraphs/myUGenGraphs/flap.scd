// flap
// uses band-limited noise to simulate flapping wings


({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, density = 1.5, filtFreq = 300, flapRate = 0.8, pan1, pan2, panRate|

		var noise;       // noise source
		var filt;        // BPF
		var lfo;         // tremolo applied to noise
		var env;         // creates discrete flight events
		var freqLfo;     // modulates flap rate and pitch
		var amp, ampEnv; // output amplitude, output amplitude envelope
		var bus, out;    // output channel, output signal

		// housekeeping
		bus = 0;

		amp = gain.dbamp;

		freqLfo = LFNoise2.kr(0.8);

		noise = PinkNoise.ar();

		// synthesis

		env = EnvGen.kr(
			/*envelope: Env.linen(
				attackTime: 0.3,
				sustainTime: 0.4,
				releaseTime: 0.3
			),*/
			envelope: Env.sine(),
			gate: Dust.kr(density) * [1, 1]
		);

		// weighted sum of two LFOs
		lfo = /*(Pulse.ar(
			freq: freqLfo.range(flapRate, flapRate * 2),
			width: 0.5,
			mul: 0.05
		) + */LFTri.ar(
			freq: freqLfo.range(flapRate, flapRate * 2),
		) * env; // apply envelope

		// filtered noise
		filt = BPF.ar(
			in: noise,
			freq: freqLfo.range(filtFreq, filtFreq * 3.0),
			rq: 0.35,
			mul: 1.5
		);

		// apply tremolo
		filt = filt * lfo;

		// amplitude envelope
		ampEnv = EnvGen.kr(
			envelope: Env.linen(
				attackTime: ris,
				sustainTime: 1 - (ris + dec),
				releaseTime: dec
			),
			timeScale: dur,
			levelScale: amp
		);

		// apply amplitude envelope
		filt = ampEnv * filt;

		// pan
		out = filt * main.functions[\sinCosPanLaw].value(
			SinOsc.kr(panRate).range(pan1, pan2)
		);

		// out!!!!!!!!
		Out.ar(bus, out)
	}
})