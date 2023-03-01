/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Attribution:

[1] Partial Gains

Listed partial gains analyzed from Bb Clarinet tone: A220Hz, @ 37.5 seconds.

Downloaded on April 3rd, 2014
Bb Clarinet
Performer: Christine Bellomy
Technicians: John Ritz, Eric Durian
http://theremin.music.uiowa.edu/sound%20files/MIS/Woodwinds/Bbclarinet/BbClar.mf.D3B3.aiff
License: UNKNOWN

See also:
http://theremin.music.uiowa.edu/MIS-Pitches-2012/MISBbClarinet2012.html
http://theremin.music.uiowa.edu/MIS.html
*/

({
	var gains, ratios, durs;

	gains = [ 0, -38, -1, -23, -4, -25, -22, -21, -25, -47, -24, -38, -24, -29, -41, -43, -43, -46, -56, -52 ];  // [ 1 ] gains, in dB

	// this data is "made up!"
	ratios = [ 1, 2.02, 3.04, 4.06, 5.08, 6.1, 7.12, 8.14, 9.16, 10.18, 11.2, 12.22, 13.24, 14.26, 15.28, 16.3, 17.32, 18.34, 19.36, 20.38 ]; // stretched tuning ratios for each partial

	// collection into a dictionay
	[
		\gains, gains,
		\ratios, ratios,
	].asDict
})
