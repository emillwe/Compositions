/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

design input (stereo) encoding matrix
*/

({ |main, size, vertex = true|
	var angles = (pi / size) * (size / 2).asInteger.collect({ |i|
		[ i, i.neg ]
	}).flatten.drop(1).add((size / 2).asInteger);

	// flip to side
	vertex.not.if({
		angles = (angles - (angles.at(1) / 2)).neg
	});

	angles.collect({ |angle| main.functions[\sinCosPanLawRad].value(angle) })
})
