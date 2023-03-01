/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to:

1) design quadrature sinusoid (additive synthesis) wavetables
2) add buffers to score
2) return buffers
*/

({ |main, size, partialGains|
	var partialAmps;
	var complex;
	var bufferReal, bufferImag;

	partialAmps = partialGains.dbamp;  // scale

	complex = Signal.analyticFill((size / 2).asInteger, partialAmps);  // Complex

	// make real and imag buffer
	bufferReal = CtkBuffer.collection(
		complex.real.asWavetable  // wavetable
	);
	bufferImag = CtkBuffer.collection(
		complex.imag.asWavetable  // wavetable
	);

	// add to score
	main.score.add(bufferReal);
	main.score.add(bufferImag);

	// return buffers
	[ bufferReal, bufferImag ]
})
