/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3


iterate through vowels, passed as buffers
*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, refFreq = 440.0, wavRatio = 1.0, buffers = ([ 0, 1, 2 ])|

	var synthDef;

	// let's post details for inspection
	"".postln;
	"--------------------------------------------------------".postln;
	"time  |  buffer no. ".postln;
	"--------------------------------------------------------".postln;

	// synthDef, assign outside the loop...
	synthDef = main.synthDefs[\cwSGSLinenPan];

	// iterate through intervals, and add notes to the score
	buffers.do({ |buffer, i|
		var thisStart;
		var thisNote;

		thisStart = start + (i * dur);

		// post details
		thisStart.post;
		"   |   ".post;
		i.postln;


		///////////////// CREATE SYNTH NOTE CALLS //////////////////


		// create a note, and set arguments
		thisNote = synthDef.note(
			starttime: thisStart,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.freq_(freq)
		.refFreq_(refFreq)
		.wavRatio_(wavRatio)
		.buffer_(buffer);


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)
	});

	"--------------------------------------------------------".postln;
	"".postln;

})
