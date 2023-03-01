/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3
*/

/*
----------------------
===== PROBLEM 1c =====
----------------------

Modify additiveBell so that it synthesizes the Risset bell via the Single Sinusoid UGen graph model using the following parameters ->
  main: object containing project information
  start: starttime of bell playback
  dur: total duration of bell
  gain: gain of loudest bell partial
  ris: amount of time each partial takes to reach maximum volume (fraction of duration)
  curve: decay curve of each partial
  freq: frequency partial ratios will be scaled by

EXAMPLE OUTPUT ->

PROBLEM 1c
---------
start time 0
nextOSCPacket 0
nextOSCPacket 0
nextOSCPacket 0.375
nextOSCPacket 0.5
nextOSCPacket 0.75
nextOSCPacket 1
nextOSCPacket 1.25
nextOSCPacket 1.625
nextOSCPacket 1.75
nextOSCPacket 2.75
nextOSCPacket 3.25
nextOSCPacket 4.5
nextOSCPacket 5
nextOSCPacket 5.2
nextOSCPacket 5.2
problem-1c successfully rendered
correct!
---------

HINT: see 03a. additive synthesis

*/

({ |main, start = 0, dur = 2, gain = -12.0, ris = 0.1, curve = -7, freq = 440.0|

	var numPartials, partialData;

	// YOUR CODE HERE
	// ---
	partialData = main.functions[\rissetBellPartialData].value();

	// catch - minimum number of items!
	numPartials = partialData.values.collect({ |item|
		item.size
	}).minItem;

	// iterate through the partialData dictionary to generate individual notes to add to the score
	// nothing fancy...
	numPartials.do({ |i|
		var thisPartialGain;
		var thisPartialFreq;
		var thisPartialDur;
		var thisPartialNote;

		thisPartialDur = dur * partialData[\durs].at(i);  // scale dur
		thisPartialGain = gain + partialData[\gains].at(i);  // scale partialGain by gain
		thisPartialFreq = freq * partialData[\ratios].at(i);  // scale freq
		thisPartialFreq = thisPartialFreq + partialData[\beats].at(i);

		// create a note for each partial...
		thisPartialNote = main.synthDefs[\sinOscPerc].note(
			starttime: start, duration: thisPartialDur
		)
		.dur_(thisPartialDur)
		.gain_(thisPartialGain)
		.ris_(ris)
		.curve_(curve)
		.freq_(thisPartialFreq);

		// then and add note for each partial to the score
		main.score.add(thisPartialNote);
	})
	// ---
})
