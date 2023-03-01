/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, refFreqs, wavRatio = 1.0, packetBufs = ([ 0, 1, 2 ])|

	var synthDef;

	// synthDef, assign outside the loop...
	synthDef = main.synthDefs[\wavepacketMult];

	// create a note, set arguments, and add to score
	main.score.add(
		synthDef.note(
			starttime: start,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.refFreqs_(refFreqs)
		.wavRatio_(wavRatio)
		.packetBufs_(packetBufs);
	);

})
