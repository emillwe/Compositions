/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

UHJ playback of Ambix Zoom H2n recording
*/

({ |main|
	{ |buffer, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 0, thresh = 0.01, slope = 3.0, rotRate = 0.3|
		var encoder, decoder; // AmbiX to B, UHJ
		var zoomSig, foaSig;
		var amp, env;
		var out, bus;
		var numChannels;

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

		// apply amp env
		zoomSig = env * zoomSig;

		// encode
		foaSig = FoaEncode.ar(zoomSig, encoder);

		foaSig = FoaRotate.ar(
			in: foaSig,
			// angle: SinOsc.kr(rotRate).range(0, 2pi)
			angle: Saw.kr(rotRate).range(0, 2pi)
		);

		// decode
		out = FoaDecode.ar(foaSig, decoder);

		out = Compander.ar(
			in: out,
			control: out,
			thresh: thresh,
			slopeBelow: slope,
			clampTime: 0.15,
			relaxTime: 0.15
		);

		Out.ar(bus, out);
	}
})
