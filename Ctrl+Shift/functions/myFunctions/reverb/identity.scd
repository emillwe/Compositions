/*
Course: DXARTS 461a Winter 2021 (https://canvas.uw.edu/courses/1434166)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Identity matrix generation

*/

({ |size|
	var array = Array2D.fromArray(size, size, Array.fill(size.squared, { 0 }));

	size.do({ |i|
		array.put(i, i , 1)
	});

	array.asArray.reshape(size, size)
})
