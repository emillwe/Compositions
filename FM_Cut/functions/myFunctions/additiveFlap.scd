// additive flap function:
// create a bunch of flaps at different rates and
// pan them around

// {| start, dur, gain = -12.0, ris = 0.1, dec = 0.1, density, panL, panR, panRate|
({
	|main, start|

	var synth;     // flap

	synth = main.synthDefs[\flap].value;

	main.score.add(
		synth.note(
			starttime: start,
			duration: 60
		)
		.dur_(60)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.2)
		.density_(1.84)
		.filtFreq_(20.0)
		.flapRate_(0.3)
		.pan1_(-90.0)
		.pan2_(90.0)
		.panRate_(1/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 12,
			duration: 60
		)
		.dur_(60)
		.gain_(3.0)
		.ris_(0.15)
		.dec_(0.2)
		.density_(1.4)
		.filtFreq_(35.5)
		.flapRate_(0.4)
		.pan1_(-90.0)
		.pan2_(90.0)
		.panRate_(1/15)
	);

	main.score.add(
		synth.note(
			starttime: start,
			duration: 60
		)
		.dur_(60)
		.gain_(3.0)
		.ris_(0.15)
		.dec_(0.2)
		.density_(2.0)
		.filtFreq_(100.0)
		.flapRate_(0.75)
		.pan1_(90.0)
		.pan2_(-90.0)
		.panRate_(3/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 8,
			duration: 52
		)
		.dur_(52)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(1.75)
		.filtFreq_(300.0)
		.flapRate_(1.5)
		.pan1_(-90.0)
		.pan2_(90.0)
		.panRate_(5/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 20,
			duration: 38
		)
		.dur_(38)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(1.5)
		.filtFreq_(69.9)
		.flapRate_(0.75)
		.pan1_(90.0)
		.pan2_(-90.0)
		.panRate_(4/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 25,
			duration: 36
		)
		.dur_(36)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(1.3)
		.filtFreq_(4000)
		.flapRate_(9.9)
		.pan1_(-90.0)
		.pan2_(90.0)
		.panRate_(24/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 15,
			duration: 41
		)
		.dur_(41)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(0.6)
		.filtFreq_(8000)
		.flapRate_(13.9)
		.pan1_(-90.0)
		.pan2_(90.0)
		.panRate_(31/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 7,
			duration: 50
		)
		.dur_(50)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(2.0)
		.filtFreq_(1100.1)
		.flapRate_(1.9)
		.pan1_(90.0)
		.pan2_(-90.0)
		.panRate_(7/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 10,
			duration: 43
		)
		.dur_(43)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(2.3)
		.filtFreq_(1874.5)
		.flapRate_(4.7)
		.pan1_(-90.9)
		.pan2_(90.9)
		.panRate_(9/15)
	);

	main.score.add(
		synth.note(
			starttime: start + 13,
			duration: 37
		)
		.dur_(37)
		.gain_(3.0)
		.ris_(0.1)
		.dec_(0.3)
		.density_(1.7)
		.filtFreq_(1912.6)
		.flapRate_(6.45)
		.pan1_(90.0)
		.pan2_(-90.9)
		.panRate_(13/15)
	);
})