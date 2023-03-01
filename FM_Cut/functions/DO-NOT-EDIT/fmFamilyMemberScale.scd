/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

iterate ps, playing a note with each, consecutively

Synthesise FM Family (n), Member (p)

*/

({ |main, start = 0.0, dur = 1.0, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, freqHi = 5000.0, n = 2, ps = ([0, 1, 2, 3]), panAngle = 0|

	// let's post details for inspection
	"".postln;
	"--------------------------------------------------------".postln;
	"time  |  [ n, p ]  |  [ c, m ]  |  [ p0, p1, p2... ] ".postln;
	"--------------------------------------------------------".postln;


	// iterate through the FM family member array, and add notes to the score
	ps.do({ |thisP, i|
		var thisStart;
		var thisNote;
		var thisCm;
		var thisModIndex;
		var thisRatios;  // for display...

		// find carrier and modulator freqs
		thisCm = main.functions[\cmRatioFunc].value(n, thisP);
		thisModIndex = main.functions[\fmModIndexFunc].value(freq, freqHi, thisCm.first, thisCm.last);
		thisRatios = main.functions[\fmFamilyRatiosFunc].value(n, thisP, (thisModIndex + 1).round);  // jusr for display

		thisStart = start + (i * dur);


		// post details
		thisStart.post;
		"   |   ".post;
		[ n, thisP ].asFloat.round(0.01).post;
		"   |   ".post;
		thisCm.round(0.01).post;
		"   |   ".post;
		thisRatios.round(0.01).postln;


		///////////////// CREATE SYNTH NOTE CALLS //////////////////

		// args: start, dur, gain, ris, dec, freq
		thisNote = main.synthDefs[\fmLinenPan].note(
			starttime: thisStart,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.freq_(freq)
		.carRatio_(thisCm.first)
		.modRatio_(thisCm.last)
		.modIndex_(thisModIndex)
		.panAngle_(panAngle);


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)
	});

	"--------------------------------------------------------".postln;
	"".postln;

})
