/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

iterate freq1, playing a note with each, consecutively
*/

({ |main, start = 0.0, dur = 1.0, gain = -12.0, ris = 0.1, dec = 0.1, freq = 440.0, ratios = ([2, 3]), panAngle = 0, buffers = 0|

	// iterate through the freqCar array, and add notes to the score
	ratios.do({ |thisRatio, i|
		var thisStart;
		var thisNote;
		var thisStretchFreqs;

		thisStart = start + (i * dur);
		thisStretchFreqs = main.functions[\ssbStretchFreqs].value(freq, thisRatio);

		///////////////// CREATE SYNTH NOTE CALLS //////////////////

		// args: start, dur, gain, ris, dec, freq
		thisNote = main.synthDefs[\ssbLinenPan].note(
			starttime: thisStart,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.freqCar_(thisStretchFreqs.at(0))
		.freqMod_(thisStretchFreqs.at(1))
		.panAngle_(panAngle)
		.bufferCos_(buffers.at(0))
		.bufferSin_(buffers.at(1));


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)

	})
})
