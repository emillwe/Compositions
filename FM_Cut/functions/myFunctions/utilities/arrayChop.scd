/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Emmett Miller
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Chops up a 1d array into random subsets of given size
    main: main paradigm
    partialData: input array
    size: desired subset size

Returns an array of arrays
*/

({ |main, partialData, size|
	var floor;    // quick maths
	var result;   // returned array
	var wrapAmt;  // makes input array size
	              // an integer multiple
	              // of size

	// shuffle values
	partialData = partialData.scramble;

	// wrap input if necessary
	wrapAmt = partialData.size % size;
	partialData = partialData.wrapExtend(
		partialData.size + wrapAmt
	);

	// figure out partition sizes
	floor = (partialData.size / size).asInt;

	// chop!
	result = partialData.reshape(floor, size);

	result // return
})
