/*
Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

play a ton of buffers at the same time
*/

({ |main, dur, buffers, gain = -10.0, start, ris = 0.01, dec = 0.01, startPos = 0, rate = 1.0, rotAngle = 0|
	var synth;

	synth = main.synthDefs[\stereoPlayBufAM];

	buffers.do({ |thisBuffer, i|
		var rateMod = ((i + 1) / buffers.size) * 3.0;

		main.score.add(
			synth.note(
				starttime: start,
				duration: thisBuffer.duration / rateMod
			)
			.dur_(thisBuffer.duration / rateMod)
			.gain_(gain)
			.ris_(ris)
			.dec_(dec)
			.startPos_(startPos)
			.rate_(rateMod)
			.buffer_(thisBuffer)
			.amFreq_(rateMod)
			.rotAngle_(rotAngle)
		);
	});
});
