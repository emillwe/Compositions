/*
Title: myLastName-final

Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

*/

/*
Evaluate this code block to render.
*/
(
var main;
var renderSection1, renderSection2, renderSection3, renderSection4, renderSection5, renderSection6;

// bussing
var reverbBus, reverbGroup, sourceGroup;

// ambiX buffers
var ding1, ding2;
var typing1, typing2, typing4;
var packageTexture;
var drip3;
var mouse1;
var enter1, enter2, enter3, enter4, enter5, enter6, enter7, enter8, enter9;
var deskScrape;
var shutterRipple;
var trafficLR;
var construction;
var wail1;
var chalkSqueak;

// stereo buffers
var aluminumRing1, aluminumRing6;
var roll1;
var zipper1;
var knife4, knife12;
var pang;
var woodScrape;
var aluminumKlank1, aluminumKlank2, aluminumKlank3, aluminumKlank4, aluminumKlank5, aluminumKlank6, aluminumKlank7, aluminumKlank8;

// mono buffers
var canSwirl1L, canSwirl1R, canSwirl1;
var roll1L, roll1R;
var pangL, pangR;
var quarterRollPlinkL, quarterRollPlinkR;
var woodDrop21L, woodDrop21R;
var drip3L, drip3R;

// iterative stuff
var rates;
var filtFreqs;

main = MainParadigm("".resolveRelative, s, true);


// booleans indicating whether or not specific problem is rendered
renderSection1 = true;
renderSection2 = true;
renderSection3 = true;
renderSection4 = true;
renderSection5 = true;
renderSection6 = true;


///////////////// YOUR CALCS, BUFFERS, &c. //////////////////

ding1 = main.soundIn[\yetiDing];
ding2 = main.soundIn[\ding2];

typing1 = main.soundIn[\typing1];
typing2 = main.soundIn[\typing2];
typing4 = main.soundIn[\typing4];

packageTexture = main.soundIn[\packageTexture];

drip3 = main.soundIn[\drip3];

mouse1 = main.soundIn[\mouse1];

enter1 = main.soundIn[\enter1];
enter2 = main.soundIn[\enter2];
enter3 = main.soundIn[\enter3];
enter4 = main.soundIn[\enter4];
enter5 = main.soundIn[\enter5];
enter6 = main.soundIn[\enter6];
enter7 = main.soundIn[\enter7];
enter8 = main.soundIn[\enter8];
enter9 = main.soundIn[\enter9];

deskScrape = main.soundIn[\deskScrape];

shutterRipple = main.soundIn[\shutterRipple];

trafficLR = main.soundIn[\trafficLR];

construction = main.soundIn[\construction];

wail1 = main.soundIn[\wail1];

chalkSqueak = main.soundIn[\chalkSqueak];

aluminumRing1 = main.soundIn[\aluminumRing1];
aluminumRing6 = main.soundIn[\aluminumRing6];

roll1 = main.soundIn[\roll1];

zipper1 = main.soundIn[\zipper1];

knife4 = main.soundIn[\knife4];
knife12 = main.soundIn[\knife12];

pang = main.soundIn[\pang];

woodScrape = main.soundIn[\woodScrape5];

aluminumKlank1 = main.soundIn[\aluminumKlank1];
aluminumKlank2 = main.soundIn[\aluminumKlank2];
aluminumKlank3 = main.soundIn[\aluminumKlank3];
aluminumKlank4 = main.soundIn[\aluminumKlank4];
aluminumKlank5 = main.soundIn[\aluminumKlank5];
aluminumKlank6 = main.soundIn[\aluminumKlank6];
aluminumKlank7 = main.soundIn[\aluminumKlank7];
aluminumKlank8 = main.soundIn[\aluminumKlank8];


// soundIn: use '' notation for makeMonoBuf
canSwirl1L = main.functions[\makeMonoBuf].value(
	main,
	soundIn: 'canSwirl1',
	channel: 0
);

canSwirl1R = main.functions[\makeMonoBuf].value(
	main,
	soundIn: 'canSwirl1',
	channel: 1
);

roll1L = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'roll1',
				channel: 0
);

roll1R = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'roll1',
				channel: 1
);

pangL = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'ding2',
				channel: 0
);

pangR = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'ding2',
				channel: 1
);

quarterRollPlinkL = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'quarterRollPlink',
				channel: 0
);

quarterRollPlinkR = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'quarterRollPlink',
				channel: 1
);

woodDrop21L = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'woodDrop21',
				channel: 0
);

woodDrop21R = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'woodDrop21',
				channel: 1
);

drip3L = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'drip3',
				channel: 0
);

drip3R = main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'drip3',
				channel: 1
);

rates = Array.series(8, 0.5, 0.1); // playback rates

filtFreqs = [ 393, 451, 727, 990, 1307, 1459, 2531, 3732, 4500, 4611, 5227,
		6967, 7699, 8098 ] / 2;

// create a private bus
reverbBus = CtkAudio.new(numChans: 2);  // a stereo bus

// create two node groups...
sourceGroup = CtkGroup.new(addAction: \head);
reverbGroup = CtkGroup.new(addAction: \tail);  // add to tail

// ... and add to score
main.score.add(sourceGroup);
main.score.add(reverbGroup);

///////////////// SECTIONS //////////////////


// SECTION 1
renderSection1.if({
	var sectionStartTime = 0.0;  // start first section at 0.0 seconds!

	// post some info!
	"-----------".postln;
	"SECTION 1".postln;
	"--> start: ".post;
	sectionStartTime.postln;

	// typing 1
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 2,
			duration: 30
		)
		.buffer_(typing1)
		.gain_(10)
		.dur_(30)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// laptop speaker filter playback 1
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime + 12.15,
			duration: 7.0,
			target: sourceGroup
		)
		.buffer_(aluminumRing1)
		.gain_(30)
		.dur_(7)
		.dec_(0.4)
		.freq_(1200)
		.q_(30)
		.clip_(0.01)
		.widthAngle_(0)
		.rotAngle_(-90)
		.sendBus_(reverbBus)
	);

	// typing 2
	main.score.add(
		main.synthDefs[\zoomPlayBufCompanderRotate].note(
			starttime: sectionStartTime + 18,
			duration: 8
		)
		.buffer_(typing2)
		.gain_(12)
		.dur_(8)
		.startPos_(16)
		.thresh_(0.01)
		.slope_(1.5)
		.rotRate_(0.3)
	);

	//  laptop playback reverb 1
	main.score.add(  // add to score
		main.synthDefs[\seriesDelaySAP16].note(
			starttime: sectionStartTime + 12.15,
			duration: 15,
			target: reverbGroup
		)
		.dur_(20.0)  // envelope dur
		.dryGain_(0.0)
		.wetGainLo_(-6.0)
		.wetGainHi_(-12.0)
		.wetGainFreqX_(2000.0)  // output shelf crossover freq
		.tapOutGains_(Array.series(8, 0.0, -6.0).dup(2).flop.flatten)  // all, scaled: 6db rolloff (pairs)
		.delayTime_(1.0)
		.delayScalars_(main.functions[\superWarp].value(16, 0.8))  // super warped!
		.decayTimeLo_(0.25)
		.decayTimeHi_(0.5)
		.decayFreqX_(2500.0)  // loop crossover freq
		.delayTimeExcursion_(0.08)
		.delayTimeMaxExcursion_(0.2)
		.modRate_(0.5)
		.gFacSAP_(0.7)
		.sapScalars_(Array.fill(16, { 0.25 }))  // all SAP lengths = 0.25 * delayTime
		.inBus_(reverbBus)
		.outBus_(0)  // hardware
	);

	// laptop speaker filter playback 2
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime + 23.2,
			duration: 7.0 / 0.7,
			target: sourceGroup
		)
		.buffer_(aluminumRing6)
		.rate_(0.5)
		.gain_(10)
		.dur_(7 / 0.7)
		.dec_(0.4)
		.freq_(1200)
		.q_(30)
		.clip_(0.8)
		.widthAngle_(0)
		.rotAngle_(
			CtkControl.env(
				Env.new([-90, 90, -90], [ (7.0 / 0.7) / 2, (7.0 / 0.7) / 2 ])
				)
		)
		.sendBus_(reverbBus)
	);

	//  laptop playback reverb 2
	main.score.add(  // add to score
		main.synthDefs[\seriesDelaySAP16].note(
			starttime: sectionStartTime + 23.2,
			duration: 15,
			target: reverbGroup
		)
		.dur_(20.0)  // envelope dur
		.dryGain_(0.0)
		.wetGainLo_(-6.0)
		.wetGainHi_(-12.0)
		.wetGainFreqX_(2000.0)  // output shelf crossover freq
		.tapOutGains_(Array.series(8, 0.0, -6.0).dup(2).flop.flatten)  // all, scaled: 6db rolloff (pairs)
		.delayTime_(1.0)
		.delayScalars_(main.functions[\superWarp].value(16, 0.8))  // super warped!
		.decayTimeLo_(0.25)
		.decayTimeHi_(0.5)
		.decayFreqX_(2500.0)  // loop crossover freq
		.delayTimeExcursion_(0.08)
		.delayTimeMaxExcursion_(0.2)
		.modRate_(0.5)
		.gFacSAP_(0.7)
		.sapScalars_(Array.fill(16, { 0.25 }))  // all SAP lengths = 0.25 * delayTime
		.inBus_(reverbBus)
		.outBus_(0)  // hardware
	);

	// time to get weird
	// typing 4
	main.score.add(
		main.synthDefs[\zoomPlayBufCompanderRotate].note(
			starttime: sectionStartTime + 28,
			duration: 10
		)
		.buffer_(typing4)
		.gain_(12)
		.dur_(10)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
		.rotRate_(
			CtkControl.env(
				Env.new([0.1, 0.5], [10])
			)
		)
	);

	// ambience
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfRM].note(
			starttime: sectionStartTime + 35.5,
			duration: 9,
			target: sourceGroup
		)
		.buffer_(roll1)
		.startPos_(1.0)
		.rate_(1.0)
		.gain_(26)
		.dur_(10)
		.ris_(0.5)
		.dec_(0.1)
		.freq_(1200)
		.q_(
			CtkControl.env(
				Env.new([30, 0.1], 9)
			)
		)
		.rotAngle_(
			CtkControl.env(
				Env.new([90, 0], 9)
			)
		)
		.widthAngle_(
			CtkControl.env(
				Env.new([0, 90], 9)
			)
		)
		.sendBus_(0)
	);

	// knife
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime + 36.0,
			duration: 24,
			target: sourceGroup
		)
		.buffer_(knife12)
		.rate_(0.176)
		.startPos_(0.7)
		.gain_(18)
		.dur_(24)
		.ris_(0.3)
		.dec_(0.1)
		.freq_(1200)
		.q_(0.1)
		.clip_(1.0)
		.widthAngle_(
			CtkControl.env(
				Env.new([0, 90], 9)
			)
		)
		.rotAngle_(
			CtkControl.env(
				Env.new([-90, 0], 9)
			)
		)
		.sendBus_(0)
	);

	// ambience + knife 'verb
	main.score.add(  // add to score
		main.synthDefs[\seriesDelaySAP16].note(
			starttime: sectionStartTime + 35.5,
			duration: 20.0,
			target: reverbGroup
		)
		.dur_(20.0)  // envelope dur
		.dryGain_(0)
		.wetGainLo_(-10.0)
		.wetGainHi_(-15.0)
		.wetGainFreqX_(2000.0)  // output shelf crossover freq
		.tapOutGains_(Array.series(8, 0.0, -6.0).dup(2).flop.flatten)  // all, scaled: 6db rolloff (pairs)
		.delayTime_(1.5)
		.delayScalars_(main.functions[\superWarp].value(16, 0.8))  // super warped!
		.decayTimeLo_(3.0)
		.decayTimeHi_(5.0)
		.decayFreqX_(2500.0)  // loop crossover freq
		.delayTimeExcursion_(0.08)
		.delayTimeMaxExcursion_(0.2)
		.modRate_(0.5)
		.gFacSAP_(0.7)
		.sapScalars_(Array.fill(16, { 0.25 }))  // all SAP lengths = 0.25 * delayTime
		.inBus_(reverbBus)
		.outBus_(0)  // hardware
	);

	// granular texture
	main.score.add(
		main.synthDefs[\granulator].note(
			starttime: sectionStartTime + 35.5,
			duration: 9
		)
		.buffer_(canSwirl1L)
		.gain_(4)
		.dur_(9)
		.ris_(0.9)
		.dec_(0.1)
		.density_(60.0)
		.rateModDepth_(5.0)
		.durModDepth_(2.5)
		.posModRate_(1.2)
		.dlyTime_(0.1)
	);

	"-----------".postln;
	"".postln;
	Buffer.freeAll;
});


// SECTION 2
renderSection2.if({
	var sectionStartTime = 44.4;  // start first section at 45.0 seconds! CHANGE as desired

	// post some info!
	"-----------".postln;
	"SECTION 2".postln;
	"--> start: ".post;
	sectionStartTime.postln;


	// big ding 1/2
	rates.scramble.do({ |thisRate, i|
		main.score.add(
			main.synthDefs[\zoomPlayBuf].note(
				starttime: i / 20 + sectionStartTime,
				duration: 7 / thisRate
			)
			.gain_(-3.0)
			.buffer_(ding1)
			.dur_(7 / thisRate)
			.startPos_(3.0)
			.rate_(thisRate)
			.rotRate_(thisRate)
		);
	});

	// big ding 2/2
	(rates * 1.1).scramble.do({ |thisRate, i|
		main.score.add(
			main.synthDefs[\zoomPlayBuf].note(
				starttime: i / 20 + sectionStartTime,
				duration: 7 / thisRate
			)
			.gain_(-4.0)
			.buffer_(ding2)
			.dur_(7 / thisRate)
			.startPos_(0)
			.rate_(thisRate)
			.rotRate_(thisRate)
		);
	});

	// granular attack
	main.score.add(
		main.synthDefs[\granulatorRot].note(
			starttime: sectionStartTime - 0.7,
			duration: 14.9
		)
		.bufferL_(roll1L)
		.bufferR_(roll1R)
		.gain_(-10)
		.dur_(14)
		.ris_(0.2)
		.dec_(0.8)
		.density_(
			CtkControl.env(
				Env.new([150, 0.001], 8, \exp)
			)
		)
		// .density_(150)
		.rateModDepth_(0.01)
		.durLow_(2.0)
		.durModDepth_(2.5)
		.posModRate_(0.3)
		.rotAngle_(
			CtkControl.env(
				Env.new([90, -90], 8)
			)
		)
	);

	// granular decay
	main.score.add(
		main.synthDefs[\granulatorRot].note(
			starttime: sectionStartTime,
			duration: 16
		)
		.bufferL_(roll1L)
		.bufferR_(roll1R)
		.gain_(-25)
		.dur_(16)
		.ris_(0.2)
		.dec_(0.8)
		.density_(
			CtkControl.env(
				Env.new([150, 0.001], 14, \exp)
			)
		)
		// .density_(150)
		.rateModDepth_(3.5)
		.durLow_(2.0)
		.durModDepth_(2.5)
		.posModRate_(0.3)
		.rotAngle_(
			CtkControl.env(
				Env.new([-90, 90], 12)
			)
		)
	);

	// buildup to tiny ding
	main.score.add(
		main.synthDefs[\zoomPlayBufCompRotFilt].note(
			starttime: sectionStartTime + 4.0,
			duration: 8
		)
		.buffer_(ding1)
		.gain_(7)
		.dur_(8)
		.rate_(-1.0)
		.startPos_(10)
		.thresh_(0.01)
		.slope_(1.0)
		.rotRate_(1.5)
		.mix_(0.7)
		.freqMult_(0.25)
	);

	// tiny ding
	main.score.add(
		main.synthDefs[\zoomPlayBuf].note(
			starttime: 10.8 + sectionStartTime,
			duration: 5
		)
		.buffer_(ding2)
		.gain_(12)
		.dur_(5)
		.startPos_(0)
	);

	// tiny ding sustain
	main.score.add(
		main.synthDefs[\klankNoiseDing].note(
			starttime: 10.99 + sectionStartTime,
			duration: 15
		)
		.gain_(-27)
		.dur_(15)
		.ris_(0.01)
		.dec_(0.5)
		.ampModRate_(
			CtkControl.env(
				Env.new([1.0, 45.0], [15])
			)
		)
		.freqModDepth_(
			CtkControl.env(
				Env.new([0.01, 0.25], [15])
			)
		)
	);

	// sustain texture
	main.functions[\cascadePlayback].value(
		main: main,
		buffer: packageTexture,
		gain: 1.0,
		start: sectionStartTime + 9.7,
		dur: 25.0,
		ris: 0.2,
		dec: 0.4,
		startPos: 15.0,
		n: 15,
		isZoom: true,
		mix: CtkControl.env(
			Env.new(
				[0.0, 0.75], [20.0]
			)
		),
		noteSpace: 0.3
	);

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

	"-----------".postln;
	"".postln;

	// breathing filter
	filtFreqs.do({ |freq, i|
		main.score.add(
			main.synthDefs[\stereoFilterSinPan2].note(
				starttime: sectionStartTime,
				duration: 38.0
			)
			.dur_(30.0)
			.gain_(-20.0)
			.dec_(0.5)
			.panRate_(i / filtFreqs.size)
			.cutoff_(freq)
			.rate_(4)
			.rqRange_(0.01)
			.freqModRate_(i / filtFreqs.size)
			.rqModRate_(i / filtFreqs.size)
			.buffer_(woodScrape)
			.loop_(1)
		);
	});

	// drip weirdness
	main.score.add(
		main.synthDefs[\zoomPlayBufCompRotFiltHPFAM].note(
			starttime: sectionStartTime + 18,
			duration: 25
		)
		.buffer_(drip3)
		.gain_(7)
		.dur_(25)
		.ris_(0.5)
		.dec_(0.2)
		.startPos_(5.0)
		.thresh_(0.01)
		.slope_(3.0)
		.rotAngle_(
			CtkControl.env(
				Env.new([pi, 0], [20])
			)
		)
		.freqMult_(1.5)
		.mix_(
			CtkControl.env(
				Env.new([0.25, 0.1], [20])
			)
		)
		.cutoff_(2000)
	);

	// drip normalness
	main.score.add(
		main.synthDefs[\zoomPlayBufCompRotFiltHPF].note(
			starttime: sectionStartTime + 23,
			duration: 25
		)
		.buffer_(drip3)
		.gain_(2)
		.dur_(25)
		.ris_(0.5)
		.dec_(0.5)
		.rate_(0.5)
		.startPos_(0.0)
		.thresh_(0.0015)
		.slope_(1.0)
		.rotRate_(0.1)
		.mix_(
			CtkControl.env(
				Env.new([0.25, 0.0], [20])
			)
		)
		.cutoff_(1000)
	);

	// drip low
	main.score.add(
		main.synthDefs[\zoomPlayBufCompRotFiltHPF].note(
			starttime: sectionStartTime + 28,
			duration: 20
		)
		.buffer_(drip3)
		.gain_(2)
		.dur_(20)
		.ris_(0.5)
		.dec_(0.5)
		.rate_(0.1)
		.startPos_(0.0)
		.thresh_(0.0015)
		.slope_(1.0)
		.rotRate_(0.05)
		.mix_(
			CtkControl.env(
				Env.new([0.25, 0.0], [20])
			)
		)
		.cutoff_(150)
	);

	// granular texture
/*	main.score.add(
		main.synthDefs[\granulatorRot].note(
			starttime: sectionStartTime + 15.0,
			duration: 30.0
		)
		.bufferL_(
			main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'aluminumRing6',
				channel: 0
			)
		)
		.bufferR_(
			main.functions[\makeMonoBuf].value(
				main,
				soundIn: 'aluminumRing6',
				channel: 1
			)
		)
		.gain_(-15)
		.dur_(30.0)
		.ris_(0.3)
		.dec_(0.3)
		/*.density_(
			CtkControl.env(
				Env.new([150, 0.001], 30, \exp)
			)
		)*/
		.density_(15.0)
		.rateLow_(0.3)
		.rateModDepth_(1.5)
		.durLow_(0.5)
		.durModDepth_(2.5)
		.posModRate_(1.2)
		.rotAngle_(
			CtkControl.env(
				Env.new([90, -90, 90, -90], [10, 10, 10])
			)
		)
	);*/

	Buffer.freeAll;
});


// SECTION 4
// TODO: Fix gain

renderSection4.if({
	var sectionStartTime = 105;  // start first section at 90.0 seconds! CHANGE as desired

	// post some info!
	"-----------".postln;
	"SECTION 4".postln;
	"--> start: ".post;
	sectionStartTime.postln;

	// typing again
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 2.0,
			duration: 10.0
		)
		.buffer_(mouse1)
		.gain_(14)
		.dur_(30)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 9.6,
			duration: 1.5
		)
		.buffer_(enter1)
		.gain_(16)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// auditioning sounds: desk
	main.score.add(
		main.synthDefs[\zoomPlayBufBpfClip].note(
			starttime: sectionStartTime + 9.9,
			duration: 2.8
		)
		.gain_(9.0)
		.buffer_(deskScrape)
		.dur_(2.3)
		.startPos_(11.3)
		.freq_(1200)
		.q_(30)
		.clip_(0.2)
		.rotAngle_(-90)
		.widthAngle_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 12,
			duration: 1.5
		)
		.buffer_(enter2)
		.gain_(16)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// auditioning sounds: shutters
	main.score.add(
		main.synthDefs[\zoomPlayBufBpfClip].note(
			starttime: sectionStartTime + 12.1,
			duration: 2.05
		)
		.gain_(10.0)
		.buffer_(shutterRipple)
		.dur_(2.05)
		.rate_(1.0)
		.startPos_(181)
		.freq_(1200)
		.q_(20)
		.clip_(0.2)
		.rotAngle_(
			CtkControl.env(
				Env.new(
					[-90, 90], [2.12]
				)
			)
		)
		.widthAngle_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 14,
			duration: 1.5
		)
		.buffer_(enter3)
		.gain_(17)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// auditioning sounds: traffic
	main.score.add(
		main.synthDefs[\zoomPlayBufBpfClip].note(
			starttime: sectionStartTime + 14.1,
			duration: 2.05
		)
		.gain_(10.0)
		.buffer_(trafficLR)
		.dur_(2.05)
		.rate_(1.0)
		.startPos_(42.6)
		.freq_(1200)
		.q_(8)
		.clip_(0.2)
		.rotAngle_(0)
		.widthAngle_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 16.1,
			duration: 1.5
		)
		.buffer_(enter5)
		.gain_(18)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// auditioning sounds: construction site
	main.score.add(
		main.synthDefs[\zoomPlayBufBpfClip].note(
			starttime: sectionStartTime + 16.25,
			duration: 2.05
		)
		.gain_(12.0)
		.buffer_(construction)
		.dur_(2.05)
		.rate_(1.0)
		.startPos_(12.9)
		.freq_(1200)
		.q_(6)
		.clip_(0.2)
		.rotAngle_(0)
		.widthAngle_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 18.25,
			duration: 1.5
		)
		.buffer_(enter6)
		.gain_(16.0)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// chicken breath!
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime + 18.4,
			duration: 0.8,
		)
		.buffer_(wail1)
		.gain_(12.0)
		.dur_(0.8)
		.freq_(1200)
		.q_(6)
		.clip_(0.2)
		.widthAngle_(0)
		.rotAngle_(-90)
		.sendBus_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 19.1,
			duration: 1.5
		)
		.buffer_(enter7)
		.gain_(16.0)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// let's get weird
	main.score.add(
		main.synthDefs[\zoomPlayBufBpfClip].note(
			starttime: sectionStartTime + 19.25,
			duration: 0.8
		)
		.gain_(16.0)
		.buffer_(construction)
		.dur_(0.8)
		.rate_(
			CtkControl.env(
				Env.new(
					[1.0, 2.5], [0.8]
				)
			)
		)
		.startPos_(12.9)
		.freq_(1200)
		.q_(2)
		.clip_(0.3)
		.rotAngle_(-90)
		.widthAngle_(0)
	);

	// enter
	main.score.add(
		main.synthDefs[\zoomPlayBufCompander].note(
			starttime: sectionStartTime + 20,
			duration: 1.5
		)
		.buffer_(enter8)
		.gain_(16.0)
		.dur_(1.5)
		.startPos_(0)
		.thresh_(0.01)
		.slope_(1.5)
	);

	// TODO: one more sample playback
	"-----------".postln;
	"".postln;
});


// SECTION 5
renderSection5.if({
	var sectionStartTime = 125.8;  // start first section at 120.0 seconds! CHANGE as desired
	var buffers1, buffers2;

	buffers1 = [ enter1, enter2, enter3, enter4, enter5, enter6, enter7, enter8, enter9 ];
	buffers2 = [
		aluminumKlank1,
		aluminumKlank2,
		aluminumKlank3,
		aluminumKlank4,
		aluminumKlank5,
		aluminumKlank6,
		aluminumKlank7,
		aluminumKlank8,
	];

	// increasing rate of enter keys
	main.functions[\bouncingBall].value(
		main: main,
		gain: 13,
		start: sectionStartTime - 0.3,
		interval: 0.5,
		grow: 0.2,
		n: 501,
		useStapler: false
	);

	// stapler time
	main.functions[\bouncingBall].value(
		main: main,
		gain: -10.0,
		start: sectionStartTime - 0.3,
		interval: 0.39,
		grow: 0.2,
		n: 500,
		useStapler: true,
		isZoom: false
	);

	// knife1 buildup
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime,
			duration: 14.0,
			target: sourceGroup
		)
		.buffer_(knife12)
		.rate_(0.129)
		.startPos_(0.7)
		.gain_(15)
		.dur_(14.0)
		.ris_(0.3)
		.dec_(0.1)
		.freq_(1200)
		.q_(0.1)
		.clip_(1.0)
		.rotAngle_(
			CtkControl.env(
				Env.new([-90, 0], 12)
			)
		)
		.sendBus_(reverbBus)
	);

	// knife2 buildup
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfClip].note(
			starttime: sectionStartTime + 6.75,
			duration: 12.0,
			target: sourceGroup
		)
		.buffer_(knife4)
		.rate_(0.229)
		.startPos_(0.7)
		.gain_(15)
		.dur_(12.0)
		.ris_(0.3)
		.dec_(0.1)
		.freq_(1200)
		.q_(0.1)
		.clip_(1.0)
		.rotAngle_(
			CtkControl.env(
				Env.new([90, 0], 15.0)
			)
		)
		.sendBus_(reverbBus)
	);

	// AM buildup
	main.score.add(
		main.synthDefs[\stereoPlayBufBpfRM].note(
			starttime: sectionStartTime,
			duration: 11.6,
			target: sourceGroup
		)
		.buffer_(roll1)
		.startPos_(1.0)
		.rate_(1.2)
		.gain_(33.0)
		.dur_(11.6)
		.ris_(0.5)
		.dec_(0.01)
		.freq_(1000)
		.amFreqLow_(0.01)
		.amFreqHigh_(20.0)
		.q_(
			CtkControl.env(
				Env.new([30, 0.1], 11.6)
			)
		)
		.widthAngle_(
			CtkControl.env(
				Env.new([0, 90], 11.6)
			)
		)
		.sendBus_(reverbBus)
	);

	// knife 'verb
	main.score.add(  // add to score
		main.synthDefs[\seriesDelaySAP16].note(
			starttime: sectionStartTime,
			duration: 20.0,
			target: reverbGroup
		)
		.dur_(20.0)  // envelope dur
		.dryGain_(0.0)
		.wetGainLo_(-32.0)
		.wetGainHi_(-40.0)
		.wetGainFreqX_(2000.0)  // output shelf crossover freq
		.tapOutGains_(Array.series(8, 0.0, -6.0).dup(2).flop.flatten)  // all, scaled: 6db rolloff (pairs)
		.delayTime_(1.5)
		.delayScalars_(main.functions[\superWarp].value(16, 0.8))  // super warped!
		.decayTimeLo_(3.0)
		.decayTimeHi_(5.0)
		.decayFreqX_(2500.0)  // loop crossover freq
		.delayTimeExcursion_(0.08)
		.delayTimeMaxExcursion_(0.2)
		.modRate_(0.5)
		.gFacSAP_(0.7)
		.sapScalars_(Array.fill(16, { 0.25 }))  // all SAP lengths = 0.25 * delayTime
		.inBus_(reverbBus)
		.outBus_(0)  // hardware
	);
	// TODO: More knives? Another Big Ding w/ AM

	// bass (slow desk)
	main.score.add(
		main.synthDefs[\zoomPlayBufCompanderConstRotate].note(
			starttime: 136.8,
			duration: 12.0
		)
		.buffer_(deskScrape)
		.gain_(-3.0)
		.dur_(12.0)
		.dec_(0.3)
		.rate_(0.2)
		.startPos_(11.6)
		.thresh_(1.0)
		.slope_(1.0)
		.rotAngle_(-2.5)
	);

	[60, -60, 0].do({ |rotAngle, i|
		var buffs;
		buffs = [buffers2, buffers2.reverse, buffers2.scramble];
		main.functions[\playAll].value(
			main: main,
			start: sectionStartTime + 11.52,
			dur: 10.0,
			buffers: buffs[i],
			gain: -8.0,
			rotAngle: rotAngle
		);
	});

	// squeak among slow desks
	main.functions[\cascadePlayback].value(
		main: main,
		buffer: chalkSqueak,
		gain: 9.0,
		start: sectionStartTime + 9.7,
		dur: 16.0,
		ris: 0.2,
		dec: 0.4,
		startPos: 0,
		n: 15,
		isZoom: true,
		mix: CtkControl.env(
			Env.new(
				[0.0, 0.75], [15.0]
			)
		),
		noteSpace: 0.3
	);

	// granular decay
	main.score.add(
		main.synthDefs[\granulatorRot].note(
			starttime: sectionStartTime + 16.5,
			duration: 20.0
		)
		.bufferL_(drip3L)
		.bufferR_(drip3R)
		.gain_(-5)
		.dur_(20.0)
		.ris_(0.4)
		.dec_(0.6)
		.density_(
			CtkControl.env(
				Env.new([1, 50, 1], [10.0, 10.0])
			)
		)
		// .density_(150)
		.rateModDepth_(2.0)
		.durLow_(0.2)
		.durModDepth_(2.5)
		.posModRate_(0.5)
		.rotAngle_(
			CtkControl.env(
				Env.new([-90, 90], 20.0)
			)
		)
	);

	// traffic
	main.functions[\cascadePlayback].value(
		main: main,
		buffer: trafficLR,
		gain: 4.0,
		start: sectionStartTime + 21.5,
		dur: 23.0,
		ris: 0.3,
		dec: 0.4,
		startPos: 40,
		n: 8,
		isZoom: true,
		mix: CtkControl.env(
			Env.new(
				[0.1, 0.75, 0.1, 0.3], 6.5 ! 4
			)
		),
		noteSpace: 2.0
	);

	// still typing
	main.functions[\cascadePlayback].value(
		main: main,
		buffer: typing2,
		gain: 12.0,
		startPos: 7.6,
		start: sectionStartTime + 26.5,
		dur: 30,
		ris: 0.3,
		dec: 0.3,
	);


	// post some info!

	// main.soundIn.path.postln;
	"-----------".postln;
	"SECTION 5".postln;
	"--> start: ".post;
	sectionStartTime.postln;


	"-----------".postln;
	"".postln;
	Buffer.freeAll;
});


// SECTION 6
/////////////// DEMO ZONE ////////////////////
renderSection6.if({
	var sectionStartTime = 150.0;  // start first section at 150.0 seconds! CHANGE as desired

	var buffers;

	// post some info!
	"-----------".postln;
	"SECTION 6".postln;
	"--> start: ".post;
	sectionStartTime.postln;


	/*main.score.add(
		main.synthDefs[\zoomPlayBuf].note(
			starttime: sectionStartTime,
			duration: 4.0
		)
		.buffer_(pang)
		.gain_(10.0)
		.dur_(4.0)
	);

	main.functions[\cascadePlayback].value(
		main: main,
		buffer: pang,
		gain: 10,
		start: sectionStartTime,
		dur: 4.0,
		ris: 0.2,
		dec: 0.3,
		startPos: 0.05,
		n: 15,
		isZoom: false
	);
*/
	// |buffer1, buffer2, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 1, thresh = 0.01, slope = 3.0, rotRate = 0.3, fmRate = 0.3, mix = 1.0, freqMult = 1.0|
	/*main.score.add(
		main.synthDefs[\zoomFollow].note(
			starttime: sectionStartTime,
			duration: 30.0
		)
		.buffer1_(typing2)
		.buffer2_(trafficLR)
		.gain_(12.0)
		.dur_(30.0)
		.loop_(1)
		.thresh_(0.001)
		.slope_(1.5)
	);

	// traffic
	// |buffer, gain = 0.0, dur, ris = 0.01, dec = 0.01, rate = 1.0, startPos = 0, loop = 0, rotRate = 0|
	main.score.add(
		main.synthDefs[\zoomPlayBuf].note(
			starttime: sectionStartTime,
			duration: 30.0
		)
		.buffer_(trafficLR)
		.gain_(0.0)
		.dur_(30.0)
		.loop_(1)
	);*/

	"-----------".postln;
	"".postln;
	Buffer.freeAll
});

// render
main.render(fileName: "miller-final");
)
