/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

UHJ playback of Ambix Zoom H2n recording
*/

({ |main|
	{ |buffer, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 0, freq = 1000, q = 1.0, clip = 0, rotAngle = 0, widthAngle = 0|
		var encoder, decoder; // AmbiX to B, UHJ
		var zoomSig, foaSig, decode;
		var amp, env;
		var out, bus;
		var numChannels;
		var filter, clipped;

		numChannels = 4; // 4 for AmbiX

		// encoder/decoder
		encoder = FoaEncoderMatrix.newZoomH2n; // for Zoom H2n, i.e. AmbiX -> B Format

		decoder = main.functions[\makeFoaDecoder].value(main); // FOA -> UHJ
		amp = gain.dbamp;

		bus = 0;

		// Buffer playback
		zoomSig = PlayBuf.ar(
			numChannels: numChannels,
			bufnum: buffer,
			rate: BufRateScale.kr(buffer) * rate,
			startPos: startPos * SampleRate.ir,
			loop: loop,
			doneAction: 2 // free enclosing synth
		);

		// amp envelope
		env = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),
			levelScale: amp,
			timeScale: dur
		);

		// encode
		foaSig = FoaEncode.ar(zoomSig, encoder);

		// decode
		decode = FoaDecode.ar(foaSig, decoder);

		filter = BPF.ar(
			in: decode,
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

		// apply amp env
		out = env * out;

		Out.ar(bus, out);
	}
})
