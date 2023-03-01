/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Stereophonic PlayBuf
*/

({ |main|
	{| dur, gain = 0.0, ris = 0.01, dec = 0.01, rate = 1, startPos = 0, panAngle = 0.0, loop = 0, buffer = 0, freq = 500, q = 1.0, clip = 0.1, sendBus = 0, widthAngle = 0, rotAngle = 0|

		// variables
		var bus;          // var to specify output bus
		var numChannels = 2; // <-- stereo buffer
		var playBuf, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv;       // vars for envelope signal
		var filter; // BPF
		var clipped; // distorted signal;

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// amplitude envelope: Env nested in EnvGen
		ampEnv = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),  // <-- envelope
			timeScale: dur
		);

		// sample playback
		playBuf = PlayBuf.ar(numChannels, buffer,  BufRateScale.kr(buffer) * rate, startPos: startPos * SampleRate.ir, loop: loop);

		// rescale, by multiplying by ampEnv
		playBuf = ampEnv * amp * playBuf;

		filter = BPF.ar(
			in: playBuf,
			freq: freq,
			rq: q.reciprocal
		);

		clipped = Clip.ar(
			in: filter,
			lo: clip.neg,
			hi: clip,
		);

		// width
		out = main.functions[\spatMatFilt].value(
			clipped,
			main.functions[\widthMatrix].value(widthAngle)
		);  // <-- Imaging happens here!

		// rotation
		out = main.functions[\spatMatFilt].value(
			out,
			main.functions[\rotateMatrix].value(rotAngle)
		);  // <-- Imaging happens here!

		// rotation

		// out!!
		Out.ar(sendBus, out)
	}
})
