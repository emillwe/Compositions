// flap
// uses band-limited noise to simulate flapping wings


({ |main|
	{| start, dur, gain = -12.0, ris = 0.1, dec = 0.1, panL, panR, panRate|

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

		noise = WhiteNoise.ar();

		// synthesis

		env = EnvGen.kr(
			envelope: Env.linen(
				attackTime: 0.3,
				sustainTime: 0.4,
				releaseTime: 0.3
			),
			gate: Dust.kr(1)
		);

		// weighted sum of two LFOs
		lfo = (Pulse.ar(
			freq: freqLfo.range(0.3, 3),
			width: 0.5,
			mul: 0.05
		) + LFCub.ar(
			freq: freqLfo.range(0.3, 3),
			mul: 1
		) ) * env; // apply envelope

		// filtered noise
		filt = BPF.ar(
			in: noise,
			freq: freqLfo.range(300, 400),
			rq: 0.8
		);

		// apply tremolo
		filt = filt * lfo;

		// pan
		out = filt * main.functions[\sinCosPanLaw].value(
			LFSaw.kr(panRate).range(panL, panR)
		);

		// out!!!!!!!!
		Out.ar(bus, out)
	}
})