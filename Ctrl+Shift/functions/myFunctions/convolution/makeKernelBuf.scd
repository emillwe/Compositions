/*
Course: DXARTS 461a Winter 2020 (https://canvas.uw.edu/courses/1354133)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

function to:

1) read soundfile
2) design kernel
3) add buffer to score
4) return buffer
*/

({ |main, soundIn, skipTime, freq, q = 1.0, normalizeMagnitude = true, phase = nil, sampleRate = 44100|
	var path;
	var soundFile;
	var readSize, resampleSize, kernelSize;
	var readSignal, kernel;
	var buffer;
	var oversample = 4;  // minimum phase oversampleing

	path = main.soundIn[soundIn].path;
	soundFile = SoundFile.new(path);

	readSize = (2 * q / freq * soundFile.sampleRate).round.asInteger;
	resampleSize = (readSize * sampleRate / soundFile.sampleRate).asInteger;
	kernelSize = resampleSize.nextPowerOfTwo;

	// read soundfile, and apply (smoothing) window
	readSignal = Signal.read(
		path,
		readSize,
		(soundFile.sampleRate * skipTime).asInteger
	) * Signal.hannWindow(readSize);

	// resample to synthesis sampling rate, and zero pad
	(readSize != resampleSize).if({
		readSignal = readSignal.resize(resampleSize);
	});
	readSignal = readSignal.zeroPad(kernelSize);

	// make kernel
	kernel = readSignal.copy;

	// normalize?
	normalizeMagnitude.if({
		kernel = kernel.normalizeMagnitude
	});

	// reset phase?
	phase.switch(
		\linear,   { kernel.linearPhase },
		\minimum, { kernel.minimumPhase(oversample: oversample) },
	);

	// make buffer
	buffer = CtkBuffer.collection(
		kernel
	);

	// close soundFile, tidy up!
	soundFile.close;

	// add to score
	main.score.add(buffer);

	// return buffer
	buffer
})
