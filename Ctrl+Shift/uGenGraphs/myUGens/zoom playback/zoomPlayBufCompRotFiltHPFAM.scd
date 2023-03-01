/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

UHJ playback of Ambix Zoom H2n recording
*/

({ |main|
	{ |buffer, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 1, thresh = 0.01, slope = 3.0, rotRate = 0.3, rotAngle = 0.0, fmRate = 0.3, mix = 1.0, freqMult = 1.0, cutoff = 1000|
		var encoder, decoder; // AmbiX to B, UHJ
		var zoomSig, foaSig;
		var amp, env;
		var out, bus;
		var numChannels;
		var freqs, amps, decs; // filter bank
		var comp, filtered; // compressed, filtered signals
		var freqMod; // FM LFO
		var dryAmp, wetAmp; // wet/dry mix coeffs
		var amMod;
		var pitch;

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
			angle: rotAngle
		);

		// decode
		comp = FoaDecode.ar(foaSig, decoder);

		comp = Compander.ar(
			in: comp,
			control: comp,
			thresh: thresh,
			slopeBelow: slope,
			clampTime: 0.15,
			relaxTime: 0.15
		);

		pitch = Pitch.kr(in: comp, maxBinsPerOctave: 16);

		comp = SinOsc.ar(pitch * 1.5) * comp;

		// filter!
		freqs = [387.5, 455.6, 719, 982, 1301, 1457, 2087, 2175, 2503, 3763, 3855, 4451, 4686, 5301, 6100, 6901, 7068, 7701, 8190, 8892, 9265, 9922, 10736, 13185, 13833, 14266, 16028] * freqMult; // partial freqs from pang!

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

		out = (wetAmp * filtered) + (dryAmp * comp);

		out = HPF.ar(out, cutoff);

		// out!!!!
		Out.ar(bus, out);
	}
})
