/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

An empty function
*/

({ |main, start, dur, gain = -12.0, ris = 0.01, dec = 0.01, rate = 1, buffer = 0|

	var synthDef; // uGen Graph

	// {| dur, gain = 0.0, ris = 0.01, dec = 0.01, rate = 1, panAngle = 0.0, loop = 0, buffer = 0|
	synthDef = main.synthDefs[\stereoPlayBufLinenPan]; // stereo buffer playback

	// create a note and add to score
	main.score.add(
		synthDef.note(
			starttime: start,
			duration: dur
		)
		.dur_(dur)
		.gain_(gain)
		.ris_(ris)
		.dec_(dec)
		.rate_(rate)
		.loop_(0)
		.buffer_(buffer);
	);
})
