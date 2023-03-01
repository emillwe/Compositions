/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
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
