/*
Course: DXARTS 462a Spring 2020 (https://canvas.uw.edu/courses/1372118)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

Bouncing Ball:
Trigger sample playback at increasingly shorter intervals
samples come from a bank of similar sounds

Inputs:
    grow: shrink factor (less than 1)
    interval: time in seconds between first two events
    start: start time of first note event
    n: number of events

Outputs:
    adds "bouncing ball" events to score
*/

({ |main, gain = 0.0, start, interval = 3.0, grow = 0.5, n = 100, thresh = 0.01, slope = 1.5, rateHigh = 1.5, useStapler = true, isZoom = true|
	var startTimes; // note event start times
	var synth; // SynthDef
	var prevStart; // iterated start time
	var buffers;

	useStapler.if(
		{ buffers = [
		main.soundIn[\stapler1],
		main.soundIn[\stapler2],
		main.soundIn[\stapler3],
		main.soundIn[\stapler4],
		main.soundIn[\stapler5],
		main.soundIn[\stapler7],
		main.soundIn[\stapler8],
		main.soundIn[\stapler9],
		main.soundIn[\stapler10],
		main.soundIn[\stapler11],
		main.soundIn[\stapler12],
		main.soundIn[\stapler13],
		main.soundIn[\stapler14],
		main.soundIn[\stapler15],
		main.soundIn[\stapler16],
		main.soundIn[\stapler17],
		main.soundIn[\stapler18],
		main.soundIn[\stapler19],
		main.soundIn[\stapler20],
		main.soundIn[\stapler21],
		main.soundIn[\stapler22]
	]; },
		{ buffers = [
		main.soundIn[\enter1],
		main.soundIn[\enter2],
		main.soundIn[\enter3],
		main.soundIn[\enter4],
		main.soundIn[\enter5],
		main.soundIn[\enter6],
		main.soundIn[\enter7],
		main.soundIn[\enter8],
		main.soundIn[\enter9]
	]; }
	);

/*buffers = [
		main.soundIn[\aluminumKlank1],
		main.soundIn[\aluminumKlank2],
		main.soundIn[\aluminumKlank3],
		main.soundIn[\aluminumKlank4],
		main.soundIn[\aluminumKlank5],
		main.soundIn[\aluminumKlank6],
		main.soundIn[\aluminumKlank7],
		main.soundIn[\aluminumKlank8]
	];*/
/*buffers = [
		main.soundIn[\stapler1],
		main.soundIn[\stapler2],
		main.soundIn[\stapler3],
		main.soundIn[\stapler4],
		main.soundIn[\stapler5],
		main.soundIn[\stapler7],
		main.soundIn[\stapler8],
		main.soundIn[\stapler9],
		main.soundIn[\stapler10],
		main.soundIn[\stapler11],
		main.soundIn[\stapler12],
		main.soundIn[\stapler13],
		main.soundIn[\stapler14],
		main.soundIn[\stapler15],
		main.soundIn[\stapler16],
		main.soundIn[\stapler17],
		main.soundIn[\stapler18],
		main.soundIn[\stapler19],
		main.soundIn[\stapler20],
		main.soundIn[\stapler21],
		main.soundIn[\stapler22]
	];*/

	// get array of start time offsets
	startTimes = interval * Array.series(n, 1, grow).reciprocal;

	isZoom.if(
		{synth = main.synthDefs[\zoomPlayBufCompanderConstRotate];},
		{synth = main.synthDefs[\stereoPlayBufCompanderConstRotate];}
	);

	prevStart = start;

	n.do({ |i|
		var thisBuf;
		var thisNote;
		var thisAngle;
		var rateMod;

		rateMod = rrand(0.7, rateHigh);
		thisAngle = rrand(-90.0, 90.0);

		thisBuf = buffers[(buffers.size - 1).rand];

		// |buffer, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 0, thresh = 0.01, slope = 3.0, rotAngle = 0.0|
		thisNote = synth.note(
			starttime: prevStart,
			duration: thisBuf.duration / rateMod
		)
		.dur_(thisBuf.duration / rateMod)
		.buffer_(thisBuf)
		.gain_(gain)
		.rate_(rateMod)
		.ris_(0.01)
		.dec_(0.01)
		.thresh_(thresh)
		.slope_(slope)
		.rotAngle_(thisAngle);

		// increment start time
		prevStart = prevStart + startTimes[i];

		// add to score
		main.score.add(thisNote);
	});
})