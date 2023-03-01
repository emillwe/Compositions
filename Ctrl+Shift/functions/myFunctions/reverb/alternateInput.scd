/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

design input (stereo) encoding matrix
--> alternate L, R, L, R...
*/

({ |main, size|
	var angles = Array.series(size, 0.25pi, 0.5pi.neg);

	angles.collect({ |angle| main.functions[\sinCosPanLawRad].value(angle) })
})
