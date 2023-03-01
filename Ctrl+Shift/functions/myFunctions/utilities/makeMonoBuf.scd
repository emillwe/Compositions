/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to:

1) add (mono) buffer to score
2) return buffer
*/

({ |main, soundIn, startFrame = 0, numFrames = nil, channel = 0|
	var path;
	var buffer;

	path = main.soundIn[soundIn].path;

	// make buffer
	buffer = CtkBuffer.playbuf(
		path: path,
		startFrame: startFrame,
		numFrames: numFrames,
		channels: channel
	);

	// add to score
	main.score.add(buffer);

	// return buffer
	buffer
})
