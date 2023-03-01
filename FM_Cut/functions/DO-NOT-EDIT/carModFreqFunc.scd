/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Return carrier and modulator frequency from f0 (carrier) and f1 (difference)
*/

({ |freq0, freq1|
	var freqCar, freqMod;

	freqCar = freq0;
	freqMod = freq0 - freq1;

	Array.with(freqCar, freqMod)
})
