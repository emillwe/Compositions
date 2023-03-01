/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

FM-family helper function

args: family n, family member p (integer), k
return partial ratios
*/
({ |n = 2, p = 0, k = 3|
	var ratios;

	// -k ... 0 ... +k
	ratios = Array.series((2 * k) + 1, p - k).collect({ |kNum|
		1 + (kNum * (1 + n))
	});

	// abs, sort, and remove duplicates
	ratios.abs.sort.removeDuplicates
})
