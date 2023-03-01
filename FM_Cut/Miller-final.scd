/*
Title: Miller-final: FM CUT

Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

*/

/*
Evaluate this code block to render.
*/
(
var main;
var renderSection1, renderSection2, renderSection3;
var waveStartTimes;
var numLifejackets;

main = MainParadigm("".resolveRelative, s, true);

waveStartTimes = [0, 15, 30, 45, 60, 168];

// booleans indicating whether or not specific problem is rendered
renderSection1 = true;
renderSection2 = true;
renderSection3 = true;

///////////////// YOUR CALCS, BUFFERS, &c. //////////////////


postln("PRE-FLIGHT CHECK");
postln("CALIBRATING TENSILE AND COMPRESSIVE FORCES . . .");
post("COUNTING LIFEJACKETS . . . ");
numLifejackets = postln(12.rand);
postln("MAKING SURE THE STOVE IS OFF . . .");
postln("CLEAR FOR DEPARTURE");

///////////////// SECTIONS //////////////////


// SECTION 1
renderSection1.if({
	var sectionStartTime = 0.0;  // start first section at 0.0 seconds!
	/*
	YOUR VARS HERE
	*/

	// post some info!
	"-----------".postln;
	"SECTION 1".postln;
	"--> start: ".post;
	sectionStartTime.postln;

	// wave sounds
	waveStartTimes.do({ |thisStart|
		main.functions[\agsWaves].value(
			main: main,
			start: thisStart,
			dur: 45,
			gain: -35,
			ris: 0.1,
			dec: 0.1,
			freq: 280.0,
			densityL: 0.01,
			densityH: 1,
			qH: 0.1,
			qL: 4.0,
			partialGains: Array.rand(18, -30, -5),
			partialFreqs: Array.exprand(18, 500, 1500)
		);
	});

	// passing ship
	// 2.do({ |i|
	[1, 1.5].do({ |i|
		main.functions[\glissAddition].value(
			main,
			start: 30,
			dur: 60,
			gain: -22.0,
			// partialData: main.functions[\bellFreqs].value / (16 + i)
			partialData: main.functions[\bellFreqs].value / (16 * i)
		)
	});

	// ship horn
	30.do({ |i|
		main.functions[\additiveHorn].value(
			main,
			start: (i + 1) * 0.15 + 60,
			dur: 2.0,
			gain: (2.5 * (i + 1)).neg - 12,
			freq: 500,
		);
	});

	30.do({ |i|
		main.functions[\additiveHorn].value(
			main,
			start: (i + 1) * 0.15 + 63,
			dur: 0.75,
			gain: (2.5 * (i + 1)).neg - 12,
			freq: 500,
		);
	});

	// ship horn aux1
	main.functions[\agsHorn].value(
		main: main,
		start: 60,
		dur: 2.0,
		gain: -25,
		ris: 0.01,
		dec: 0.99,
		freq: 250,
		densityL: 2.0,
		densityH: 2.0,
		qH: 100.0,
		qL: 100.0,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\getHarmonics].value(250, main.functions[\airhornPartialData].value.size)

	);
	// ship horn aux2
	main.functions[\agsHorn].value(
		main: main,
		start: 63,
		dur: 0.75,
		gain: -25,
		ris: 0.01,
		dec: 0.99,
		freq: 250,
		densityL: 2.0,
		densityH: 2.0,
		qH: 100.0,
		qL: 100.0,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\getHarmonics].value(250, main.functions[\airhornPartialData].value.size)
	);

	// ship horn weirdness
	main.functions[\agsHorn].value(
		main: main,
		start: 55.8,
		dur: 13.5,
		gain: -18.0,
		ris: 0.3,
		dec: 0.3,
		freq: 505,
		densityL: 0.01,
		densityH: 0.75,
		qH: 69.0,
		qL: 0.1,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\getHarmonics].value(505, main.functions[\airhornPartialData].value.size)
	);

	// fremont bridge horn
	30.do({ |i|
		main.functions[\additiveHorn].value(
			main,
			start: (i + 1) * 0.15 + 75,
			dur: 3,
			gain: (2.5 * (i + 1)).neg - 8,
			// gain: -15.0 - (12 * (i + 1)),
			freq: 280.0
		)
	});

	30.do({ |i|
		main.functions[\additiveHorn].value(
			main,
			start: (i + 1) * 0.15 + 78.5,
			dur: 1,
			gain: (2.5 * (i + 1)).neg - 8,
			freq: 280.0
		)
	});

	// uncomment for a surprise
	/*main.functions[\summonCrow].value(
	main: main,
	start: 10,
	dur: 0.5,
	gain: -30.0,
	ris: 0.1,
	dec: 0.3,
	wavRatio: 1.0,
	numCaws: 3,
	wait: 5,
	wet: 0.5
	);

	main.functions[\summonCrow].value(
	main: main,
	start: 20,
	dur: 0.5,
	gain: -30.0,
	ris: 0.1,
	dec: 0.3,
	wavRatio: 1.0,
	numCaws: 5,
	wait: 5,
	wet: 0.5
	);*/

	// bridge horn weirdness
	main.functions[\agsHorn].value(
		main: main,
		start: 73,
		dur: 8,
		gain: -19,
		ris: 0.3,
		dec: 0.5,
		freq: 280.0,
		densityL: 0.1,
		densityH: 2.0,
		qL: 5.0,
		qH: 69.0,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\getHarmonics].value(280, main.functions[\airhornPartialData].value.size)
	);

	// granular horn aux
	main.functions[\agsHorn].value(
		main: main,
		start: 75,
		dur: 7,
		gain: -25,
		ris: 0.1,
		dec: 0.9,
		freq: 140.0,
		densityL: 2.0,
		densityH: 2.0,
		qH: 100.0,
		qL: 100.0,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\getHarmonics].value(140, main.functions[\airhornPartialData].value.size)
	);

	"-----------".postln;
	"".postln;
});


// SECTION 2
renderSection2.if({
	var sectionStartTime = 30.0;  // start first section at 30.0 seconds! CHANGE as desired
	/*
	YOUR VARS HERE
	*/

	// post some info!
	"-----------".postln;
	"SECTION 2".postln;
	"--> start: ".post;
	sectionStartTime.postln;

	// granular bell
	main.functions[\agsBell].value(
		main: main,
		start: 89,
		dur: 40,
		gain: -15.0,
		ris: 0.5,
		dec: 0.5,
		freq: 280.0,
		densityL: 0.01,
		densityH: 2.0,
		qL: 1.0,
		qH: 100.0,
		partialGains: main.functions[\airhornPartialData].value,
		partialFreqs: main.functions[\bellFreqs].value
	);

	// fm bells
	main.functions[\bellFreqs].value.do({ |thisFreq|
		main.functions[\fmFamilyScale].value(
			main,
			start: 90,
			dur: 5.0.linrand,  // "note" duration
			gain: -29.0,
			freq: thisFreq,  // lowest partial
			freqHi: 4840,  // highest "significant" frequency
			ns: Array.series(12, 1).scramble,  // families
			dev: 4.9 // deviation in time (note spread)
		)
	});
	"-----------".postln;
	"".postln;
});


// SECTION 3
renderSection3.if({
	var sectionStartTime = 60.0;  // start first section at 60.0 seconds! CHANGE as desired

	// post some info!
	"-----------".postln;
	"SECTION 3".postln;
	"--> start: ".post;
	sectionStartTime.postln;

	// flap
	main.functions[\additiveFlap].value(
		main,
		start: 116
	);

	/*main.functions[\playBuffer].value(
	    main,
	    start: 125,
	    dur: 45,
	    gain: 6,
	    ris: 0.3,
	    dec: 0.3,
	    rate: 0.5,
	    buffer: main.soundIn['flap']
	); REMOVE BEFORE FLIGHT */

	// bell mania short
	main.functions[\bellMania].value(
		main,
		start: 140,
		dec: 0.3,
		dur: 30,
		gain: -47.0,
		type: 0
	);

	// bell mania med
	main.functions[\bellMania].value(
		main,
		start: 148,
		dec: 0.3,
		dur: 30,
		gain: -47.0,
		type: 1
	);

	// bell mania long
	main.functions[\bellMania].value(
		main,
		start: 152,
		dec: 0.4,
		dur: 30,
		gain: -47.0,
		type: 2
	);

	"-----------".postln;
	"".postln;
});

// render
main.render(fileName: "Miller-final");
)
