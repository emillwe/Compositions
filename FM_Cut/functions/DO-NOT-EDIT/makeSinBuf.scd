/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to:

1) design sinusoid (additive synthesis) wavetable
2) add buffer to score
2) return buffer
*/

({ |main, size, partialGains|
	var partialAmps;
	var buffer;

	partialAmps = partialGains.dbamp;  // scale

	// make buffer
	buffer = CtkBuffer.collection(
		Signal.sineFill(
			(size / 2).asInteger,  // wavetable doubles size
			partialAmps
		).asWavetable  // wavetable
	);

	// add to score
	main.score.add(buffer);

	// return buffer
	buffer
})
