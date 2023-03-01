/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

/*
Synthesize Fremont Bridge spectrum via AGS
*/

({ |main, start = 0, dur = 2, gain = -12.0, ris = 0.1, dec = 0.1, freq = 220.0, densityL = 1.0, densityH = 1.0, qL = 1.0, qH = 1.0, partialGains, partialFreqs|

	var numPartials;
	var thisSynthDef;

	// catch - minimum number of items!
	numPartials = [partialGains.size, partialFreqs.size].minItem;

	// set synthDef, before loop
	thisSynthDef = main.synthDefs[\ssAGSPercPan2];

	// iterate through the partialData array to generate individual notes to add to the score
	// nothing fancy...
	numPartials.do({ |i|
		// var thisPartialGain;
		var thisPartialGain;
		var thisPartialFreq;
		var thisPartialDur;

		thisPartialDur = dur;  // all partials same dur

		thisPartialGain = gain + partialGains[i];  // scale partialGain by gain
		// thisPartialFreq = freq * (i + 1); // harmonic series
		thisPartialFreq = partialFreqs[i];


		// create a note for each partial...
		// ... one for left... and one for right...
		// NOTE: this another loop!
		[ 90.0, 90.0.neg].do({ |thisAngle|  // two angles!!
			var thisPartialNote;

			thisPartialNote = thisSynthDef.note(
				starttime: start, duration: thisPartialDur
			)
			.dur_(dur)
			.gain_(thisPartialGain)
			.ris_(ris)
			.dec_(dec)
			.formFreq_(thisPartialFreq)
			.densityL_(densityL)
			.densityH_(densityH)
			.qL_(qL)
			.qH_(qH)
			.panAngle_(thisAngle);

			// then and add note for each partial to the score
			main.score.add(thisPartialNote)
		})
	})
})
