/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to add individual notes to our score for additive synthesis

partialData is array of frequencies

*/

({ |main, start, dur = 2.0, gain = -25.0, partialData|

	// chop partial data into pairs:
	partialData = main.functions[\arrayChop].value(
		main,
		partialData,
		size: 2
	);

	// iterate over the partialData subsets
	partialData.do({ |subset, i|

		// fundamental is first element of pair
		var thisPartialNote;

		var cFreq; // center glissando frequency

		cFreq = (subset[0] - subset[1]).abs;

		// |dur, gain = -12, cFreq = 440, startFreq = 440.0, endFreq = 880, panAngle = 0, startDelay, fundamental|

		thisPartialNote = main.synthDefs[\sinOscFreqEnv].note(
			starttime: start,
			duration: dur,
		)
		.dur_(dur)
		.gain_(gain)
		.cFreq_(cFreq)
		.startFreq_(subset[0])
		.endFreq_(subset[1])
		.phase_((pi/4.0).rand)
		.panAngle_(1)
		.startDelay_(5)
		.fundamental_(cFreq / (dur / 2.0)); // caluclated to give 50/50 rise/decay split in amp envelope

		// then and add note for each partial to the score
		main.score.add(thisPartialNote);
	})
})
