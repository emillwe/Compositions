/*
Returns equally tempered scale
*/
({ |baseInt, numDivs|

	Array.fill(numDivs, { |i| (baseInt**(i/numDivs))});
})
