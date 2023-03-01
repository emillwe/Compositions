/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

({ |main, start = 0, dur = 2, gain = -12.0, freq = 280, wet = 0.4|

	var numHarms, partialGains, partialFreqs;

	// initialize partial data from airhornPartialData
	partialGains = main.functions[\airhornPartialData].value;

	// get number of partials
    numHarms = partialGains.size;

	// get partial frequencies
	partialFreqs = main.functions[\getHarmonics].value(
		freq: freq,
		numHarms: numHarms
	);

	// Do the following for each partial:
	numHarms.do({ |i|
		var thisPartialGain;
		var thisPartialFreq;
        var thisPartialNote;

		var env; // freq envelope

		// build note parameters from rissetBellPartialData

		// fetch gain
		thisPartialGain = gain + partialGains[i];

		// fetch frequency
		thisPartialFreq = partialFreqs[i];

	    // build note
		thisPartialNote = main.synthDefs[\sinOscHorn].note(
			starttime: start+rrand(0.001, 0.05),
			duration: dur * 8
		)
		.gain_(thisPartialGain)
		.dur_(dur)
		.freq_(thisPartialFreq * (sum3rand(0.02) + 1.0))
		.panAngle_(rrand(-90.0, 90.0))
		.phase_(pi.rand);

		// add note to score
		main.score.add(thisPartialNote);
	});
})
