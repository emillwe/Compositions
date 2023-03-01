/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3


five different densities, begining with density, decreasing...
*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, density = 1.0, refFreq = 440.0, wavRatio = 1.0, buffer = 0|

	var intervals = Array.geom(5, 1, 0.25);
	var synthDef;


	// let's post details for inspection
	"".postln;
	"--------------------------------------------------------".postln;
	"time  |  density ".postln;
	"--------------------------------------------------------".postln;


	// synthDef, assign outside the loop...
	synthDef = main.synthDefs[\cwAGSLinenPan];

	// iterate through intervals, and add notes to the score
	intervals.do({ |interval, i|
		var thisStart;
		var thisNote;
		var thisDensity;

		thisStart = start + (i * dur);
		thisDensity = density * interval;

		// post details
		thisStart.post;
		"   |   ".post;
		thisDensity.postln;


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
		.density_(thisDensity)
		.refFreq_(refFreq)
		.wavRatio_(wavRatio)
		.buffer_(buffer);


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)
	});

	"--------------------------------------------------------".postln;
	"".postln;

})
