/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

/*
Synthesize Risset Bell spectrum via AGS

*/

({ |main, start = 0, dur = 2, gain = -12.0, ris = 0.1, dec = 0.1, freq = 220.0, density = 1.0, q = 1.0, partialData|

	var numPartials;
	var thisSynthDef;

	// catch - minimum number of items!
	numPartials = partialData.collect({ |item|
		item.size
	}).minItem;

	// set synthDef, before loop
	thisSynthDef = main.synthDefs[\ssAGSLinenPan];

	// iterate through the partialData dictionary to generate individual notes to add to the score
	// nothing fancy...
	numPartials.do({ |i|
		var thisPartialGain;
		var thisPartialFreq;
		var thisPartialDur;

		thisPartialDur = dur;  // all partials same dur

		thisPartialGain = gain + partialData[\gains].at(i);  // scale partialGain by gain
		thisPartialFreq = freq * partialData[\ratios].at(i);  // scale freq
		thisPartialFreq = thisPartialFreq + partialData[\beats].at(i);

		// create a note for each partial...
		// ... one for left... and one for right...
		// NOTE: this another loop!
		[ 45.0, 45.0.neg].do({ |thisAngle|  // two angles!!
			var thisPartialNote;

			thisPartialNote = thisSynthDef.note(
				starttime: start, duration: thisPartialDur
			)
			.dur_(dur)
			.gain_(thisPartialGain)
			.ris_(ris)
			.dec_(dec)
			.formFreq_(thisPartialFreq)
			.density_(density)
			.q_(q)
			.panAngle_(thisAngle);

			// then and add note for each partial to the score
			main.score.add(thisPartialNote)
		})
	})
})
