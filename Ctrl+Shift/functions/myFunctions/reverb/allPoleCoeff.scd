/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to calculate All-pole feedback coefficient

All-pole Feedback (delay)
*/
({ |delayTime, decayTime|

    var gFac;

    gFac = 10.pow(-3 * delayTime / decayTime);

    // return
    gFac;
})
