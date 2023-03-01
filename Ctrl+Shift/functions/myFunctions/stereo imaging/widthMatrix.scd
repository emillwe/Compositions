/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

a function to return coefficients for Width - Matrix form
width argument in degrees
*/
({ |angle = 0|
    var theta = angle.degrad;

    Array2D.fromArray(
        2, // rows, outputs
        2, // columns, inputs
        [
            theta.cos, -1 * theta.sin,
            -1 * theta.sin, theta.cos
        ]
    )
})
