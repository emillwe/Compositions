/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Attribution:

Dodge, Charles, and Jerse, Thomas A. Computer Music : Synthesis, Composition, and Performance. 2nd ed., Schirmer Books ; Prentice Hall International, 1997.

Tables 7.2, 7.3 (pp. 230, 231)

[1] Vowel Formats (freq & gain)

Male Sung Vowel A
*/

({
	var freqs, gains, qs;

	freqs =[ 609.0, 1000.0, 2450.0, 2700.0, 3240.0 ];  // [ 1 ] freqs, in Hz
	gains = [ 0.0, -6.0, -12.0, -11.0, -24.0 ];  // [ 1 ] gains, in dB

	// qs were not provided by Dodge & Jerse
	qs = [ 2.0, 3.0, 5.0, 5.0, 5.0 ];  // quality factor

	// collection into a dictionay
	[
		\freqs, freqs,
		\gains, gains,
		\qs, qs,
	].asDict
})
