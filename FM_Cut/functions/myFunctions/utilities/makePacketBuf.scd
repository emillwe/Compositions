/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to:

1) design *readPacket wavetable
2) add buffer to score
2) return buffer
*/

({ |main, size, soundIn, skipTime, freq|
	var path;
	var soundFile;
	var buffer;

	path = main.soundIn[soundIn].path;
	soundFile = SoundFile.new(path);

	// make buffer
	buffer = CtkBuffer.collection(
		Signal.readPacket(
			path,
			size,
			(soundFile.sampleRate * skipTime).asInteger,
			freq: freq
		)  // use signal directly, don't need to use Wavetable class
	);

	// close soundFile, tidy up!
	soundFile.close;

	// add to score
	main.score.add(buffer);

	// return buffer
	buffer
})
