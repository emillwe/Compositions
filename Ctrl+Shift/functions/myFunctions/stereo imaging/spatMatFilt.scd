/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

spatial matrix filter
*/
({ |in, coeffMatrix|

	// wrap input as array if needed --> for mono inputs
	in.isArray.not.if({
		in = Array.with(in)
	});

	Mix.fill(coeffMatrix.cols, { |i| // fill input
		UGen.replaceZeroesWithSilence(
			coeffMatrix.asArray.reshape(coeffMatrix.rows, coeffMatrix.cols).flop.at(i) * in.at(i)
		)
	})
})
