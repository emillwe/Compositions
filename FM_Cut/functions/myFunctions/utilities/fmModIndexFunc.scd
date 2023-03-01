/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

FM-family helper function

approximate modulation index required to return spectrum with no significant
energy above freqHi

args: freq, freqHi, c, m
return modIndex
*/
({ |freq = 440.0, freqHi = 1320.0, c = 1, m = 1|
	((freqHi / freq) - c) / m - 1
})
