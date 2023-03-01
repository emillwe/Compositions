/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

/*
----------------------
===== PROBLEM 5 =====
----------------------

Using the code from problem 4 as a starting place, synthesize the first 5 family members (including the normal form) of your bell like tone with the following arguments
  main: object containing project contents
  start: starttime of bell playback
  dur: total duration of bell
  gain: gain of bell
  ris: amount of time each partial takes to reach maximum volume (fraction of duration)
  curve: curve of amplitude envelope
  freq0: frequency of partial 0
  n: spectral family
  modIndex: index of modulation


Each note should be distinct, with starttimes calculated using duration

EXPECTED OUTPUT
---------------

PROBLEM 5
---------
start time 0
nextOSCPacket 0
nextOSCPacket 0
nextOSCPacket 0.5
nextOSCPacket 1
nextOSCPacket 1.5
nextOSCPacket 2
nextOSCPacket 2.5
nextOSCPacket 2.7
nextOSCPacket 2.7
problem-5 successfully rendered
correct!
---------

HINT:
See 05. FM Modulation & Spectral Design

*/

({ |main, start = 0, dur = 2, gain = -6, ris = 0.05, curve = -7, freq0 = 220, modIndex = 1, n = (232.4/116.0)|
	var numFamilyMembers;

	numFamilyMembers = 5;

	numFamilyMembers.do({ |i|
		var cm, thisStart;

		cm = main.functions[\cmRatioFunc].value(n: n, p: i);
		thisStart = (i * dur) + start;

		main.score.add(
			main.synthDefs[\fmPercPan].note(
				starttime: thisStart,
				duration: dur
			)
			.dur_(dur)
			.gain_(gain)
			.ris_(ris)
			.curve_(curve)
			.freq_(freq0)
			.modRatio_(cm[1])
			.carRatio_(cm[0])
			.modIndex_(modIndex)
		);
	});

})
