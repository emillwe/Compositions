/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Delay scaling, as recommended by Sean Costello
*/

({ |numDelays = 8, warpFac = 0.6, backward = false|
	var array = Array.geom(
		numDelays,
		1.0,
		1 - (2.sqrt.reciprocal * warpFac).pow(3)
	);

	backward.not.if({
		array.reverse
	})
})
