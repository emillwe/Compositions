/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to calculate T60

IIR Comb Filter Decay Time
*/
({ |delay, gFac|

	var t60;

	t60 = gFac.sign * (3.neg * delay / gFac.abs.log10);

	// return
	t60
})
