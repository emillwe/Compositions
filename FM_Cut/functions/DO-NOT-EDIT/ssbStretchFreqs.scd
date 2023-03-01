/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to return complex modulator and simple carrier freqs
for "spectral stretching"

freq: freq0 of returned spectrum
ratio: ratio to the next partial
*/
({ |freq, ratio = 2|
	var freqMod, freqCar;

	freqCar = (2 - ratio) * freq;
	freqMod = (ratio - 1) * freq;

	[ freqCar, freqMod ]
})
