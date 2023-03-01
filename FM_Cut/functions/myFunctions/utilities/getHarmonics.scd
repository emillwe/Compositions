///////////// Harmonic Series /////////////
// Generate harmonic series from a given frequency and
// number of harmonics
({
	|freq, numHarms|

	numHarms.collect({ |i|
		freq * (i + 1)
	})

})