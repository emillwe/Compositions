/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

cascade playback

playback a sample at varying rates, with filtering
*/

({ |main, buffer = 0, gain = -15.0, start, dur, ris = 0.01, dec = 0.01, startPos = 0, n = 8, isZoom = true, noteSpace = 0.3, mix = 0.8|

	////////// DECLARATIONS //////////

	var synth; // ambisonic playback w/ foa rotate, filtering

	////////// ASSIGNMENT //////////

	isZoom.if(
		{synth = main.synthDefs[\zoomPlayBufCompRotFilt];},
		{synth = main.synthDefs[\stereoPlayBufRotFilt];}
	);

	// synth = main.synthDefs[\zoomPlayBufCompRotFilt];

	////////// LIFTOFF //////////

	n.do({ |i|
		var modRate = ((i + 1) / n) * 3.0;
		var randSpace;

		randSpace = noteSpace.rand2 / 3;

		// add note to score
		main.score.add(
			synth.note(
				starttime: start + (i * noteSpace) + randSpace,
				duration: dur
			)
			.buffer_(buffer)
			.gain_(gain)
			.dur_(dur)
			.ris_(ris)
			.dec_(dec)
			.rate_(modRate)
			.startPos_(startPos)
			.rotRate_(modRate)
			.fmRate_(modRate)
			.mix_(mix)
			.freqMult_(modRate)
		);
	});

})
