/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

/*
Dodge, Charles, and Jerse, Thomas A. Computer Music : Synthesis, Composition, and Performance. 2nd ed., Schirmer Books ; Prentice Hall International, 1997.

Dodge & Jerse Figure 4.28, Page 105
*/

({
	var gains, ratios, durs, beats;

	gains = [0.0, -3.5, 0.0, 5.1, 8.5, 4.5, 3.3, 2.5, 2.5, 0.0, 2.5];
	ratios = [0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2.0, 2.74, 3.0, 3.76, 4.07];
	durs = [1.0, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];

	beats = Array.fill(durs.size, { 0.0 });
	beats[ 1 ] = 1.0;
	beats[ 3 ] = 1.7;

	// collection into a dictionay
	[
		\gains, gains,
		\ratios, ratios,
		\durs, durs,
		\beats, beats
	].asDict
})
