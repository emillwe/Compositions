/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

FM helper function

args: c, m, k
return partial ratios
*/
({ |c = 1, m = 1, k = 3|
	var ratios;

	// -k ... 0 ... +k
	ratios = Array.series((2 * k) + 1, k.neg).collect({ |kNum|
		c + (kNum * m)
	});

	// abs, sort, and remove duplicates
	ratios.abs.sort.removeDuplicates
})
