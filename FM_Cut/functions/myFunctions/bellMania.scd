/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

ring the bells! Call a bunch of klank notes and pan em all around
*/

{| main, start, dur, gain = -12.0, ris = 0.1, dec = 0.1, pingRate = 3, numBells = 9, type = 0|

	var synth;
	var synthDef;
	var data;

	data = main.functions[\klankData].value; // octave scalars, ping & pan rates

	synth = switch(type)
	    {0} {\klank}
	    {1} {\klankMed}
	    {2} {\klankLong};

	synthDef = main.synthDefs[synth];

	/*Array.geom(numBells, 1/32, 1.99).scramble.do({ |mult, i|
		// Array.series(numBells, 1, 0.05).scramble.do({ |mult, i|
		[50, -50].do({ |angle|
			main.score.add(
				synthDef.note(
					starttime: start + ((i / numBells) * dur),
					duration: dur -((i/(numBells-1)) * dur)
				)
				.dur_(dur -((i/(numBells-1)) * dur))
				.ris_(ris)
				.dec_(dec)
				.gain_(gain)
				.mult_(mult)
				.pingRate_((i + 1) / 6)
				.panAngle_(angle)
				.panRate_(i / numBells * 1.5)
			);
		});
	});*/
	data[\octaves].do({ |mult, i|
		[90, -90].do({ |angle|
			main.score.add(
				synthDef.note(
					starttime: start + ((i / (numBells - 1)) * 0.7 * dur),
					duration: dur -(data[\durOffsets][i] * dur) // omits last one
				)
				.dur_(dur -(data[\durOffsets][i] * dur))
				.ris_(ris)
				.dec_(dec)
				.gain_(gain)
				.mult_(mult)
				.pingRate_(data[\pingRates][i])
				.panAngle_(angle)
				.panRate_(data[\panRates][i])
			);
		});
	});
}