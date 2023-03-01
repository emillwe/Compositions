/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to calculate filter coefficients

1st-order All-Pass
*/
({ |freq, sampleRate|

	var tanFac, cFac, a0, a1, b1;

	tanFac = tan(pi * freq / sampleRate);
	cFac = (tanFac - 1) / (tanFac + 1);

	// filter coefficients
	a0 = cFac;
	a1 = 1;
	b1 = -1 * cFac;

	// return
	Array.with(a0, a1, b1);
})
