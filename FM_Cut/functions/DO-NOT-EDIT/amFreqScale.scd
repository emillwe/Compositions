/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

iterate freq1, playing a note with each, consecutively
*/

({ |main, start = 0.0, dur = 1.0, gain = -12.0, ris = 0.1, dec = 0.1, freq0 = 440.0, freq1 = ([440.0, 220.0]), modIndexGain = -9.0, panAngle = 0|

	// iterate through the modulation index gains array, and add notes to the score
	freq1.do({ |thisFreq, i|
		var thisStart;
		var thisNote;
		var carModFreqs;

		// find carrier and modulator freqs
		carModFreqs = main.functions[\carModFreqFunc].value(freq0, thisFreq);

		thisStart = start + (i * dur);

		///////////////// CREATE SYNTH NOTE CALLS //////////////////

		// args: start, dur, gain, ris, dec, freq
		thisNote = main.synthDefs[\amType1LinenPan].note(
			starttime: thisStart,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.freqCar_(carModFreqs.first)
		.freqMod_(carModFreqs.last)
		.modIndexGain_(modIndexGain)
		.panAngle_(panAngle);


		///////////////// POPULATE THE SCORE //////////////////
		main.score.add(thisNote)

	})
})
