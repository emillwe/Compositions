/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

stereo version of zoomPlayBufCompanderConstRate ugh I need to go to sleep
*/

({ |main|
	{ |buffer = 0, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 0, thresh = 0.01, slope = 3.0, rotAngle = 0.0, cutoff = 500|
		var sig;
		var amp, env;
		var out, bus;
		var numChannels;
		var filter;

		numChannels = 2; // stereo

		amp = gain.dbamp;

		bus = 0;

		// Buffer playback
		sig = PlayBuf.ar(
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

		out = Compander.ar(
			in: sig,
			control: sig,
			thresh: thresh,
			slopeBelow: slope,
			clampTime: 0.15,
			relaxTime: 0.15
		);

		// rotate
		out = main.functions[\spatMatFilt].value(
			out,
			main.functions[\rotateMatrix].value(rotAngle)
		);  // <-- Imaging happens here!

		// apply amp env
		out = env * out;

		out = HPF.ar(out, cutoff);

		Out.ar(bus, out);
	}
})
