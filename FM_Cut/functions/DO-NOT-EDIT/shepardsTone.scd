/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

An empty function
*/

({ |main, start, repetitions = 12, fundamental = 100, numOctaves = 4, startDelay = 5, centerFreq = 660, gain = -30, panAngle = 0|
	var endFreq, duration;

	endFreq = fundamental * (2**(numOctaves));
	duration = startDelay * numOctaves * 2;

	repetitions.do({ |i|
		var thisStart;
		thisStart = startDelay * i;
		main.score.add(
			main.synthDefs[\sinOscFreqEnv]
			.note(starttime: thisStart + start, duration: duration)
			.dur_(duration)
			.gain_(gain)
			.cFreq_(centerFreq)
			.startFreq_(fundamental)
			.endFreq_(endFreq)
			.panAngle_(panAngle)
			.startDelay_(startDelay)
			.fundamental_(fundamental)
		);
	})

});



