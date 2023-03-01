/*
Course: DXARTS 461a Winter 2021 (https://canvas.uw.edu/courses/1434166)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

A _very_ simple matrix mixer, similar to spatMatFilt (Week 8)
*/

({ |in, array|
	Mix.fill(in.size, { |i| // fill input
		UGen.replaceZeroesWithSilence(
			array.flop[i] * in[i]
		)
	})
})
