/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

additive karplus-strong function
*/

{
	|main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, lfoRate|

	var freqs;
	var synthDef;

	synthDef = main.synthDefs[\karplusStrong];
	freqs = main.functions[\bellFreqs] / 8;

	freqs.do({|freq|
		main.score.add(
			synthDef.note(
				starttime: start,
				duration: dur
			)
			.dur_(dur)
			.gain_(gain)
			.ris_(ris)
			.dec_(dec)
			.freq_(freq)
			.lfoRate_(lfoRate)
		);
	});
}
