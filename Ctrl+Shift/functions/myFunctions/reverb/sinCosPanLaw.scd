/*
Course: DXARTS 461a Winter 2021 (https://canvas.uw.edu/courses/1434166)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

sine-cosine panning law coefficient function
angle argument in degrees
*/
({ |angle = 0|
	var theta = (pi / 4) * (1 - (angle / 45));

	[theta.cos, theta.sin]
})
