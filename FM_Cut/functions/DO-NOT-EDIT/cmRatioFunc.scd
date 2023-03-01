/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

FM-family helper function

args: family n, family member p (integer)
return c:m as array [c, m]
*/
({ |n = 2, p = 0|
	var cm;

	p.even.if({
		cm = [                        // p is even case
			(p)/2 * (1 + n) + 1,  // carrier
			(1 + n).asFloat         // modulator
		]
	},{
		cm = [                        // p is odd case
			(p + 1)/2 * (1 + n) - 1,  // carrier
			(1 + n).asFloat              // modulator
		]
	});
	cm
})
