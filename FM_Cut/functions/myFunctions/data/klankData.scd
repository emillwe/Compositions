// helper for klank addititive function:
// store octaves, pingRates, and panRates in a dictionary
// for easy retrieval during iteration.
// overall idea is proportionality of octave/register with ping and pan rates
// and inverse proportionality of same with duration


({ |main|
	var octaves, pingRates, panRates, durOffsets;

	// Defines variables as empty arrays. You will need to overwrite these.
	octaves = [];
	pingRates = [];
	panRates = [];
	durOffsets = [];

	// scalars for bell spectrum, quasi-octaves. Iterating over this
	// gives a nicer texture than the sorted geometric series that
	// produced these data
	octaves = [ 0.97524875312188, 3.8620825872379, 0.123753125, 1.9407450187125, 0.03125, 0.24626871875, 0.0621875, 0.4900747503125 /*, 7.6855443486035*/ ];

	// async grain densities (pings/sec) corresponding to above octaves
	// lower octaves ping less frequently
	pingRates = [ 6/6, 8/6, 3/6, 7/6, 1/6, 4/6, 2/6, 5/6/*, 9/6 */] /*/ 1.3333*/;

	panRates = [ 6/9, 8/9, 3/9, 7/9, 1/9, 4/9, 2/9, 5/9/*, 9/9*/] * 2;

	durOffsets = [ 5/8, 7/8, 2/8, 6/8, 0/8, 3/8, 1/8, 4/8/*, 8/8 */];

	// collection into a dictionay
	[
		\octaves, octaves,
		\pingRates, pingRates,
		\panRates, panRates,
		\durOffsets, durOffsets
	].asDict
})