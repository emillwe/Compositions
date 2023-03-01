/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

equal power mixing coefficients

mix argument as 0 - 1 scalar
*/
({ |mix = 0.5|

	Array.with((1 - mix).sqrt, mix.sqrt)
})
