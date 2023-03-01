/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Stereo IN/OUT 16 delay + SAP network

NOTE: includes correction for LocalIn/LocalOut blockSize feedback delay

excursion in seconds
*/

({ |main|
	{| dur, ris = 0.01, dec = 0.01,
		dryGain = 0.0, wetGainLo = 0.0, wetGainHi = 0.0, wetGainFreqX = 700.0,
		delayTime = 0.125,
		decayTimeLo = 2.0, decayTimeHi = 0.5, decayFreqX = 2000.0,
		delayTimeExcursion = 0.01, delayTimeMaxExcursion = 0.01, modRate = 0.1,
		gFacSAP = 0.7,
		inBus, outBus = 0 |

		// variables
		var in, out;
		var feedback, delay;
		var amp;  // a few vars for synthesis
		var ampEnv;  // var for envelope signal
		var modDelayTime;
		var numChannels;
		var dryAmp, wetAmpLo, wetAmpHi;
		var gFacLo, gFacHi;
		var blockDelay;
		var numDelays = 16;  // must set here, for use by NamedControl \delayScalars
		var matrixIn, matrixOut, matrixScat;
		var a0f, a1f, b1f;
		var a0w, a1w, b1w;
		var halfDelayTimeExcursion, halfDelayTimeMaxExcursion;
		var delayScalars;  // var for NamedControl \delayScalars
		var sapScalars;  // var for NamedControl \sapScalars
		var delayTimes, sapTimes;
		var tapOutGains, tapOutAmps;  // var(s) for NamedControl \tapOutGains


		// declare NamedControl (synth arg for arrays)
		delayScalars = NamedControl.ir(\delayScalars, Array.fill(numDelays, { 1 }));
		sapScalars = NamedControl.ir(\sapScalars, Array.fill(numDelays, { 0.75 }));
		tapOutGains = NamedControl.ir(\tapOutGains, Array.fill(numDelays, { 0.0 }));

		// assign values
		numChannels = 2;  // stereo input (& output)

		// matrixIn = main.functions[\acrossStageInput].value(main, numDelays, 0.5pi);
		// matrixIn = main.functions[\circleSpreadInput].value(main, numDelays);  // left / right pairs
		// matrixIn = main.functions[\circleSpreadInput].value(main, numDelays, false);  // left / right pairs
		matrixIn = main.functions[\alternateInput].value(main, numDelays);  // left / right pairs
		matrixOut = matrixIn.flop;
		matrixScat = main.functions[\series].value(numDelays);  // series permutation

		// calcs
		dryAmp = dryGain.dbamp;  // direct scalar
		wetAmpLo = wetGainLo.dbamp;  // delay scalar
		wetAmpHi = wetGainHi.dbamp;  // delay scalar
		tapOutAmps = tapOutGains.dbamp;  // individual delay scalars

		halfDelayTimeExcursion = 0.5 * delayTimeExcursion;
		halfDelayTimeMaxExcursion = 0.5 * delayTimeMaxExcursion;


		// calculate feedback coefficients
		/*
		NOTE: this could be modified to take account of the actual, modulated delay time
		*/
		// // -- same scale for all
		// gFacLo = main.functions[\allPoleCoeff].value(delayTime, decayTimeLo);  // feedback scalar
		// gFacHi = main.functions[\allPoleCoeff].value(delayTime, decayTimeHi);  // feedback scalar
		// -- separate scalars
		gFacLo = (delayTime * delayScalars).collect({ |thisDelayTime|
			main.functions[\allPoleCoeff].value(thisDelayTime, decayTimeLo)
		});  // feedback scalar
		gFacHi = (delayTime * delayScalars).collect({ |thisDelayTime|
			main.functions[\allPoleCoeff].value(thisDelayTime, decayTimeHi)
		});  // feedback scalar


		// calculate allpass coeffs (for shelf filters)
		#a0w, a1w, b1w = main.functions[\fosAPCoeffs].value(wetGainFreqX, SampleRate.ir);  // wet output
		#a0f, a1f, b1f = main.functions[\fosAPCoeffs].value(decayFreqX, SampleRate.ir);  // feedback


		// calculate blockSize delay - introduced by LocalIn/LocalOut pair
		blockDelay = ControlDur.ir;

		// amplitude envelope: Env nested in EnvGen
		ampEnv = EnvGen.kr(
			Env.linen(ris, 1.0 - (ris + dec), dec),  // <-- envelope
			timeScale: dur
		);

		// calculate delay time
		delayTimes = delayTime * (delayScalars * sapScalars.collect({ |thisSapScalar| 1 - thisSapScalar }));
		sapTimes = delayTime * (delayScalars * sapScalars);

		// modulate delay times
		// NOTE: only Delay is modulated, NOT SAP
		modDelayTime = delayTimes.collect({ |thisDelayTime|
			LFNoise2.kr(
				modRate,
				halfDelayTimeExcursion,
				thisDelayTime
			).clip(0.0, thisDelayTime + halfDelayTimeMaxExcursion)
		});

		// sample playback - direct
		in = In.ar(inBus, numChannels);


		// -----------------------
		// begin feedback delay block

		feedback = LocalIn.ar(numDelays);  // "receive" from local bus, blockDelay "added" internally here

		// apply scattering matrix (& scale)
		feedback = main.functions[\matrixMix].value(feedback, matrixScat);
		feedback = feedback;

		// apply feedback shelf & gain - via Regalia-Mitra
		// NOTE: this could be written as a function
		feedback = 0.5 * (((gFacLo + gFacHi) * feedback) + ((gFacLo - gFacHi) * FOS.ar(feedback, a0f, a1f, b1f)));

		// matrix & mix input
		feedback = feedback + main.functions[\matrixMix].value(in, matrixIn);  // <-- input here!!

		// SAP
		delay = AllpassC.ar(
			feedback,
			sapTimes,
			sapTimes,
			sapTimes.collect({ |sapTime|
				main.functions[\combT60].value(
					sapTime,
					gFacSAP
				)
			})
		);

		// Delay
		delay = DelayC.ar(
			delay,
			delayTime + halfDelayTimeMaxExcursion - blockDelay,  // shorten max delay by blockDelay
			modDelayTime - blockDelay  // shorten delay by blockDelay
		);
		LocalOut.ar(delay);  // "send" to local bus --> routes to feedback
		delay = DelayN.ar(delay, blockDelay, blockDelay); // blockSize make up delay

		// end feedback delay block
		// -----------------------

		// matrix delay to output (reuse var)
		delay = tapOutAmps * delay;  // scale individual delays
		delay = main.functions[\matrixMix].value(delay, matrixOut);  // mix (back) to stereo

		// apply output wet shelf & gain - via Regalia-Mitra
		// NOTE: this could be written as a function
		delay = 0.5 * (((wetAmpLo + wetAmpHi) * delay) + ((wetAmpLo - wetAmpHi) * FOS.ar(delay, a0w, a1w, b1w)));

		// add direct and delay, & then envelope
		out = ampEnv * (
			(dryAmp * in) +  // <-- direct
			delay  // <-- delay / reverb
		);

		// out!!
		Out.ar(outBus, out)
	}
})
