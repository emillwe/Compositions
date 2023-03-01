/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Complex Waveform - Synchronous Granular Synthesis

Wavepacket Synthesis w/ multiple wavepackets & crossfading
*/

({ |main|
	{| dur, gain = -12.0, ris = 0.1, dec = 0.1, wavRatio = 1.0, panAngle = 0.0, wet = 0.3,
		freq0 = 364, freq1 = 400, freq2 = 373, freq3 = 340, freq4 = 332, freq5 = 323, freq6 = 311,
		freq7 = 293, freq8 = 285,
		refFreq0 = 364, refFreq1 = 400, refFreq2 = 373, refFreq3 = 340, refFreq4 = 332, refFreq5 = 323,
		refFreq6 = 311, refFreq7 = 293, refFreq8 = 285,
		buf0, buf1, buf2, buf3, buf4, buf5, buf6, buf7, buf8|

		// variables
		var bus;          // var to specify output bus
		var out;     // vars assigned to audio signals
		var amp;  // a few vars for synthesis
		var ampEnv, env;       // vars for envelope signal
		var freq; // pitch envelope
		var freqs, refFreqs, buffers; // wavepacket synthesis vars
		var granSigs; // array of wavepacket UGens
		var dustSigs; // noise component
		var envArr; // array of crossfading functions/envelopes
		var envGenArr;

		var grainFreq, envFreqs, grainDurs;
		var trigger;

		// assign values
		bus = 0;          // first output

		// calcs
		amp = gain.dbamp; // convert from gain in dB to linear amplitude scale

		// the amplitude envelope
		env = Env.linen(ris, 1.0 - (ris + dec), dec);

		// the UGen that synthesises the envelope
		ampEnv = EnvGen.kr(env, timeScale: dur);

		// consolidate wavepacket vars as arrays
		freqs = [freq0, freq1, freq2, freq3, freq4, freq5, freq6, freq7, freq8];
		refFreqs = [refFreq0, refFreq1, refFreq2, refFreq3, refFreq4, refFreq5, refFreq6, refFreq7, refFreq8];
		buffers = [buf0, buf1, buf2, buf3, buf4, buf5, buf6, buf7, buf8];

		// synthesize pitch envelope
		freq = EnvGen.kr(
			Env.new(freqs, (freqs.size-1).reciprocal.dup(freqs.size-1), \wel),
			timeScale: dur
		);

		// granular synthesis
		// Create array of granular UGens:
		// iterate through buffers and make a granular signal from each
		// with frequency from refFreqs
/*		granSigArr = packetBufs.size.collect({ |i|
			var thisGrainFreq, thisEnvFreq, thisGrainDur;
			var trigger;
			var thisGranSig;

			thisGrainFreq = refFreqs[i];
			thisEnvFreq = wavRatio * refFreqs[i]/2;
			thisGrainDur = thisEnvFreq.reciprocal;

			// granular (grain frequency) trigger
			trigger = Impulse.ar(thisGrainFreq);

			thisGranSig = GrainIn.ar(
				trigger: trigger,
				dur: thisGrainDur,
				in: DC.ar(1.0),
				envbufnum: packetBufs[i]
			);
		});*/

		// synthesize with multichannel expansion
		grainFreq = freq; // pitch envelope

		envFreqs = wavRatio * refFreqs / 2; // an array!

		grainDurs = envFreqs.reciprocal; // an array!

		trigger = Impulse.ar(grainFreq);

		granSigs = GrainIn.ar(
			trigger: trigger,
			dur: grainDurs,
			in: DC.ar(1.0),
			envbufnum: buffers
		); // array of UGens

		// noise component: async
		dustSigs = GrainIn.ar(
			trigger: Dust.ar(grainFreq / 4),
			dur: grainDurs,
			in: DC.ar(1.0),
			envbufnum: buffers
		);

		// apply the amplitude envelope
		granSigs = amp * ampEnv * granSigs;
		dustSigs = amp * ampEnv * dustSigs;

		// create array of crossfading functions
		envArr = [
			Env.new([1, 0, 0, 0, 0, 0, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 1, 0, 0, 0, 0, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 1, 0, 0, 0, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 1, 0, 0, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 0, 1, 0, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 0, 0, 1, 0, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 0, 0, 0, 1, 0, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 0, 0, 0, 0, 1, 0], Array.fill(8, {1/9}), curve: \wel),
			Env.new([0, 0, 0, 0, 0, 0, 0, 0, 1], Array.fill(8, {1/9}), curve: \wel)
		];

		// synthesize crossfading UGen
		envGenArr = envArr.size.collect({ |i|
			EnvGen.kr(envArr[i], timeScale: dur)
		});
		// NOTE: Can I do this below?
		// envGenArr = EnvGen.kr(envArr, timeScale: dur);

		// apply crossfading
		granSigs = granSigs * envGenArr;
		dustSigs = dustSigs * envGenArr;

		// sum array of UGens
		granSigs = granSigs.sum;
		dustSigs = dustSigs.sum;

		granSigs = granSigs + (0.66 * dustSigs);
		granSigs = granSigs + (granSigs * LFNoise2.kr(1000, 0.3));

		// expand to two channels - panning
		out = main.functions[\sinCosPanLaw].value(panAngle) * granSigs;  // <-- Panning happens here!
		out = FreeVerb2.ar(out[0], out[1], mix: wet);

		// out!!
		Out.ar(bus, out)
	}
})