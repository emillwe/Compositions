/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

iterate ns, playing a note with each, consecutively

Synthesise FM Families (n), in Normal Form

*/

({ |main, start = 0.0, dur = 1.0, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, freqHi = 5000.0, ns = ([2, 3, 4, 5]), panAngle = 0, dev = 4.0|

	// iterate through the FM family (n) array, and add notes to the score
	ns.do({ |thisN, i|
		var thisStart;
		var thisNote;
		var thisCm;
		var thisModIndex;
		var thisRatios;  // for display...

		var startTime;

		startTime = Pgauss.new(
			mean: 15,
			dev: dev,
			length: 20
		).asStream.nextN(1)[0];

		// find carrier and modulator freqs
		thisCm = main.functions[\cmRatioFunc].value(thisN);
		thisModIndex = main.functions[\fmModIndexFunc].value(freq, freqHi, thisCm.first, thisCm.last);
		thisRatios = main.functions[\fmFamilyRatiosFunc].value(thisN, 0, (thisModIndex + 1).round);  // just for display

		// thisStart = start + (i * dur);
		thisStart = start + startTime;

		///////////////// CREATE SYNTH NOTE CALLS //////////////////

		// args: start, dur, gain, ris, dec, freq
		thisNote = main.synthDefs[\fmPerc].note(
			starttime: thisStart,
			duration: dur * 4
		)
		.dur_(dur)
		.gain_(gain)
		.freq_(freq)
		.carRatio_(thisCm.first)
		.modRatio_(thisCm.last)
		.modIndex_(thisModIndex)
		.panAngle_(rrand(-45.0, 45.0))
		.space_(1.0.linrand)
		.room_(1.0.linrand);


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)
	});
})
