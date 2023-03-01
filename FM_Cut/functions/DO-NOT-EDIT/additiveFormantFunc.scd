/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to add individual notes to our score for additive synthesis

partialData Dictionary with keys: \gains, \ratios, \durs

*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, density = 1.0, formantData|

	var numForms;
	var thisSynthDef;

	// catch - minimum number of items!
	numForms = formantData.values.collect({ |item|
		item.size
	}).minItem;

	// set synthDef, before loop
	thisSynthDef = main.synthDefs[\ssAGSLinenPan];


	// iterate through the partialData dictionary to generate individual notes to add to the score
	// nothing fancy...
	numForms.do({ |i|
		var thisFormFreq;
		var thisFormGain;
		var thisFormQ;
		var thisFormNote;

		thisFormFreq = formantData[\freqs].at(i);  // formant freq
		thisFormGain = gain + formantData[\gains].at(i);  // scale by gain
		thisFormQ = formantData[\qs].at(i);  // q

		// create a note for each formant... SGS: pitch
		thisFormNote = thisSynthDef.note(
			starttime: start, duration: dur
		)
		.dur_(dur)
		.gain_(thisFormGain)
		.ris_(ris)
		.dec_(dec)
		.density_(density)
		.formFreq_(thisFormFreq)  // formant
		.q_(thisFormQ);

		// then and add notes for each formant to the score
		main.score.add(thisFormNote);
	})
})
