/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Function to map cutoff frequency to sample & hold frequency.

freqCutoff: cutoff frequency
order: sample & hold order (integer)
*/

({ |freqCutoff, order = 0|
    (order + 1) * freqCutoff
})
