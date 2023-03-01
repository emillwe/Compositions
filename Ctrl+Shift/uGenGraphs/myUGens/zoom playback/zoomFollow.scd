/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

UHJ playback of Ambix Zoom H2n recording
*/

({ |main|
	{ |buffer1, buffer2, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 1, thresh = 0.01, slope = 3.0, fmRate = 0.3, mix = 1.0, freqMult = 1.0|
		var encoder, decoder; // AmbiX to B, UHJ
		var zoomSig1, foaSig1;
		var zoomSig2, foaSig2;
		var amp, env;
		var out, bus;
		var numChannels;
		var freqs, amps, decs; // filter bank
		var comp, filtered; // compressed, filtered signals
		var freqMod; // FM LFO
		var dryAmp, wetAmp; // wet/dry mix coeffs
		var uhj; // env follower source
		var follower; // envelope follower to buffer2

		numChannels = 4; // 4 for AmbiX

		// encoder/decoder
		encoder = FoaEncoderMatrix.newZoomH2n; // for Zoom H2n, i.e. AmbiX -> B Format
		decoder = main.functions[\makeFoaDecoder].value(main); // FOA -> UHJ

		amp = gain.dbamp;

		bus = 0;

		// Buffer playback
		zoomSig1 = PlayBuf.ar(
			numChannels: numChannels,
			bufnum: buffer1,
			rate: BufRateScale.kr(buffer1) * rate,
			startPos: startPos * SampleRate.ir,
			loop: loop,
			doneAction: 2 // free enclosing synth
		);

		zoomSig2 = PlayBuf.ar(
			numChannels: numChannels,
			bufnum: buffer1,
			rate: BufRateScale.kr(buffer2) * rate,
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
		zoomSig1 = env * zoomSig1;
		zoomSig2 = env * zoomSig2;

		// encode
		foaSig1 = FoaEncode.ar(zoomSig1, encoder);
		foaSig2 = FoaEncode.ar(zoomSig2, encoder);

		// decode
		comp = FoaDecode.ar(foaSig1, decoder);
		uhj = FoaDecode.ar(foaSig2, decoder);

		comp = Compander.ar(
			in: comp,
			control: comp,
			thresh: thresh,
			slopeBelow: slope,
			clampTime: 0.15,
			relaxTime: 0.15
		);

		follower = EnvFollow.ar(uhj);

		// filter!
		/*freqs = [387.5, 455.6, 719, 982, 1301, 1457, 2087, 2175, 2503, 3763, 3855, 4451, 4686, 5301, 6100, 6901, 7068, 7701, 8190, 8892, 9265, 9922, 10736, 13185, 13833, 14266, 16028] * freqMult; // partial freqs from pang!

		amps = Array.rand(freqs.size, 0.1, 1.0); // random partial amplitudes
		decs = Array.rand(freqs.size, 0.1, 1.2); // random partial decay times

		freqMod = LFNoise2.kr(fmRate).range(0.97, 1.03);

		// apply filter bank
		filtered = Klank.ar(
			specificationsArrayRef: `[freqs, amps, decs],
			input: comp,
			freqscale: freqMod
		) * 0.01; // extremely loud and incredibly dope

		// wet/dry mix
		#dryAmp, wetAmp = main.functions[\equalPowCoeffs].value(mix);

		out = (wetAmp * filtered) + (dryAmp * comp);*/

		out = comp * follower;

		// out!!!!
		Out.ar(bus, out);
	}
})
