/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3


five different densities, begining with density, decreasing...
*/

({ |main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, freq = 220.0, densityL = 1.0, densityH = 1.0, qL = 1.0, qH = 1.0, partialGains, partialFreqs|

	///////////////// EVALUATE FUNCTIONS //////////////////

	main.functions[\agsHorn].value(
		main: main,
		start: start,
		dur: dur,
		gain: gain,
		ris: ris,
		dec: dec,
		freq: freq,
		densityL: densityL,
		densityH: densityH,
		qL: qL,
		qH: qH,
		partialGains: partialGains,
		partialFreqs: partialFreqs
	)

})
