// crow call

// create a repeating crow call from a single CAW UGen

({ |main, start = 0, dur = 0.5, gain = -12.0, ris = 0.1, dec = 0.3, wavRatio = 1.0, numCaws = 3, wait = 0.5, wet = 0.3|

	var packetBufs;
	var skipTimes;
	var size;
	var refFreqs; // reference frequencies for each packet
	var snipSize;

	var synthDef;

	synthDef = main.synthDefs[\wavepacketMult];
	///////////////// DESIGN WAVETABLE BUFFERS (& ADD TO SCORE) //////////////////

	size = 4096;  // wavetable size
	snipSize = 0.055; // sample snippet size

	// read multiple wave packets - various segments of crow sample
	refFreqs = [364, 400, 373, 340, 332, 323, 311, 293, 285];  // estimated frequencies of each sample snippet
	skipTimes = Array.series(9, 0, snipSize); // every 0.055 seconds of .wav

	// collect buffers...
	packetBufs = skipTimes.collect({ |skipTime, i|
		main.functions[\makePacketBuf].value(
			main,
			size,
			soundIn: 'crow',  // soundIn key, use '' notation rather than \
			skipTime: skipTime,
			freq: refFreqs[i]
		)
	});

	/////////////// SUMMON THE CROW /////////////////////////

	numCaws.do({ |i|
		main.score.add(
			synthDef.note(
				starttime: start + (i * dur) + wait,
				duration: dur * 2
			)
			.dur_(dur + 0.2.sum3rand)
			.gain_(gain + 3.sum3rand)
			.ris_(ris)
			.dec_(dec + 0.25.sum3rand)
			.wet_(wet)
			.wavRatio_(1 - wavRatio.linrand)
			.buf0_(packetBufs[0])
			.buf1_(packetBufs[1])
			.buf2_(packetBufs[2])
			.buf3_(packetBufs[3])
			.buf4_(packetBufs[4])
			.buf5_(packetBufs[5])
			.buf6_(packetBufs[6])
			.buf7_(packetBufs[7])
			.buf8_(packetBufs[8])
			.freq0_(364 + 20.sum3rand)
			.freq1_(400 + 20.sum3rand)
			.freq2_(373 + 20.sum3rand)
			.freq3_(340 + 20.sum3rand)
			.freq4_(332 + 20.sum3rand)
			.freq5_(323 + 20.sum3rand)
			.freq6_(311 + 20.sum3rand)
			.freq7_(293 + 20.sum3rand)
			.freq8_(285 + 20.sum3rand)
		);
	});
})