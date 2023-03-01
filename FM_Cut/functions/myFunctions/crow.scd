/*
Title: 01-rendering-wavepackets

Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

*/

/*
Evaluate this code block to render.
*/
(
var main;
var packetBufs;
var refFreq, skipTimes;
var size;

main = MainParadigm("".resolveRelative, s, true);


///////////////// DESIGN WAVETABLE BUFFERS (& ADD TO SCORE) //////////////////

size = 4096;  // wavetable size


// read multiple wave packets - various vowles
refFreq = 233.082;  // estimated frequency:
skipTimes = Array.series(9, 0, 0.055); // every 0.055 seconds of .wav

// collect buffers...
packetBufs = skipTimes.collect({ |skipTime|
	main.functions[\makePacketBuf].value(
		main,
		size,
		soundIn: 'crow',  // soundIn key, use '' notation rather than \
		skipTime: skipTime,
		freq: refFreq
	)
});

///////////////// EVALUATE FUNCTIONS //////////////////

// evaluate density scale function
// vary fundamental - decreasing density
main.functions[\densityScale].value(
	main: main,
	start: 0.0,
	dur: 2.0,
	gain: -18.0,
	ris: 0.1,
	dec: 0.1,
	density: 10.0,  // starting density
	refFreq: refFreq,  // analysis frequency
	wavRatio: 1.0,  // no transposition of formants
	buffer: packetBufs.first,  // the first analyzed wavepacket
);

// evaluate formant scale function
// vary waveform resampling ratio - decending scale
main.functions[\formantScale].value(
	main: main,
	start: 12.0,
	dur: 2.0,
	gain: -18.0,
	ris: 0.1,
	dec: 0.1,
	density: 10.0,  // density
	refFreq: refFreq,  // analysis frequency
	wavRatio: 1.0.neg,  // scale start transposition
	buffer: packetBufs.first,  // the first analyzed wavepacket
);

// evaluate formant scale function
// vary waveform resampling ratio - ascending scale
main.functions[\formantScale].value(
	main: main,
	start: 34.0,
	dur: 2.0,
	gain: -18.0,
	ris: 0.1,
	dec: 0.1,
	density: 10.0,  // density
	refFreq: refFreq,  // analysis frequency
	wavRatio: 1.0,  // scale start transposition
	buffer: packetBufs.first,  // the first analyzed wavepacket
);

// evaluate vowel scale function
// vary vowels
main.functions[\vowelScale].value(
	main: main,
	start: 56.0,
	dur: 2.0,
	gain: -18.0,
	ris: 0.1,
	dec: 0.1,
	density: 10.0,  // density
	refFreq: refFreq,  // analysis frequency
	wavRatio: 1.0,  // no transposition of formants
	buffers: packetBufs,  // qrray with analyzed wavepackets
);


main.render(fileName: "01-rendering-wavepackets");
)
