/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Simple Sinusoid - Asynchronous Granular Synthesis

Formant Synthesis
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, densityL = 1.0, densityH = 1.0, formFreq = 1760.0, qL = 1.0, qH = 1.0, panAngle = 0.0|

		// variables
		var bus;          // var to specify output bus
		var out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal
		var grainDur, grainFreq, envFreq, wavFreq;
		var trigger;
		var granSig;

		var densityLine;
		var qLine;
		var reverse;

		reverse = true;

		// assign values
		bus = 0;          // first output

		// calcs
		// TODO: unnecessary? can I reverse just by switching high and low values?
		reverse.if( { // if reversed:
			densityLine = Env.new([densityL, densityH, densityL], [0.5, 0.5], curve: \exp);
			// densityLine = XLine.kr(0.001, density / 2, dur);
			qLine = Env.new([qL, qH, qL], [0.5, 0.5], curve: \exp);

			// qLine = XLine.kr(q / 4, q, dur);
			},
			{ // if not reversed
			// densityLine = XLine.kr(density / 2, 0.001, dur);
			// qLine = XLine.kr(q, q / 4, dur);
			densityLine = Env.new([densityH, densityL, densityH], [0.5, 0.5], curve: \exp);
			// densityLine = XLine.kr(0.001, density / 2, dur);
			qLine = Env.new([qH, qL, qH], [0.5, 0.5], curve: \exp);
			}
		);
		densityLine = EnvGen.kr(densityLine, timeScale: dur);
		qLine = EnvGen.kr(qLine, timeScale: dur);

		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale
		grainFreq = densityLine * qLine.reciprocal * formFreq;
		envFreq = qLine.reciprocal * (formFreq/2);
		wavFreq = formFreq;
		grainDur = envFreq.reciprocal;

		// the amplitude envelope
		env = Env.linen(ris, 1 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);


		// granular (grain frequency) trigger
		trigger = Dust.ar(grainFreq); // <-- Dust gives us an asynchronous trigger!

		// granular synthesis
		granSig = GrainSin.ar(trigger: trigger, dur: grainDur, freq: wavFreq);

		// apply the amplitude envelope
		granSig = amp * ampEnv * granSig;

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(
			SinOsc.kr(
				freq: EnvGen.kr(
					Env.new(
						levels: [0.1, 30, 0.1],
						times: [dur/2.dup],
						curve: \exp
					)
				),
				mul: 45
			)
		) * granSig;  // <-- Panning happens here!

		// out!!
		Out.ar(bus, out)
	}
})