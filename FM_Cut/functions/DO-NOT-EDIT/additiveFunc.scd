/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to add individual notes to our score for additive synthesis

partialData Dictionary with keys: \gains, \ratios, \durs

*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, partialData|

	var numPartials;

	// catch - minimum number of items!
	numPartials = partialData.values.collect({ |item|
		item.size
	}).minItem;

	// iterate through the partialData dictionary to generate individual notes to add to the score
	// nothing fancy...
	numPartials.do({ |i|
		var thisPartialGain;
		var thisPartialFreq;
		var thisPartialDur;
		var thisPartialNote;

		thisPartialDur = dur * partialData[\durs].at(i);  // scale dur
		thisPartialGain = gain + partialData[\gains].at(i);  // scale partialGain by gain
		thisPartialFreq = freq * partialData[\ratios].at(i);  // scale freq

		// create a note for each partial...
		thisPartialNote = main.synthDefs[\sinOscLinenPan].note(
			starttime: start, duration: thisPartialDur
		)
		.dur_(thisPartialDur)
		.gain_(thisPartialGain)
		.ris_(ris)
		.dec_(dec)
		.freq_(thisPartialFreq);

		// then and add note for each partial to the score
		main.score.add(thisPartialNote);
	})
})
