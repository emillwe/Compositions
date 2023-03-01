/*
Course: DXARTS 461a Winter 2022 (https://canvas.uw.edu/courses/1515413)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

An empty function
*/

({ |main, etudeName, condition, name|
	main.score = CtkScore.new;

	main.functions[etudeName.asSymbol].value(main);

	main.render(
		fileName: (name ++ "-" ++ etudeName),
		action: {
			condition.test_(true).signal;
			condition.test_(false);
		}
	);
})
