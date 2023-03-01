/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Stereophonic PlayBuf
*/

({ |main|
	{| dur, gain = 0.0, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, panAngle = 0.0, loop = 0, buffer = 0, sendBus = 0, widthAngle = 0, rotAngle = 0, amFreq = 0.3|

		// variables
		var bus;          // var to specify output bus
		var numChannels = 2; // <-- stereo buffer
		var playBuf, out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv;       // vars for envelope signal
		var filter; // BPF

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// amplitude envelope: Env nested in EnvGen
		ampEnv = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),  // <-- envelope
			timeScale: dur
		);

		// sample playback
		playBuf = PlayBuf.ar(numChannels, buffer, BufRateScale.kr(buffer) * rate, startPos: startPos, loop: loop)/* *
		SinOsc.kr(amFreq + LFNoise2.kr(0.6).range(-2.0, 2.0)).range(0.0, 1.0)*/;

		// rescale, by multiplying by ampEnv
		playBuf = ampEnv * amp * playBuf;

		// width
		out = main.functions[\spatMatFilt].value(
			playBuf,
			main.functions[\widthMatrix].value(widthAngle)
		);  // <-- Imaging happens here!

		// rotation
		out = main.functions[\spatMatFilt].value(
			out,
			main.functions[\rotateMatrix].value(rotAngle)
		);  // <-- Imaging happens here!

		// out!!
		Out.ar(sendBus, out)
	}
})
