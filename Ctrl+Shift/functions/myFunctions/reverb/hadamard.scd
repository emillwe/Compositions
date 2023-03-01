/*
Course: DXARTS 461a Winter 2021 (https://canvas.uw.edu/courses/1434166)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3


(normalized) Hadamard generation: order = power of two

Adapted from:

https://introcs.cs.princeton.edu/python/14array/hadamard.py.html
Robert Sedgewick, Kevin Wayne, and Robert Dondero
*/

({ |n|
	var array = Array2D.fromArray(n, n, Array.fill(n.squared, { n.sqrt.reciprocal }));

	n.isPowerOfTwo.if({
		Array.geom(n.log2.asInteger, 1, 2).do({ |i|
			i.do({ |row|
				i.do({ |col|
					array.put(row + i, col,
						array.at(row, col)
					);
					array.put(row, col + i,
						array.at(row, col)
					);
					array.put(row + i, col + i,
						array.at(row, col).neg
					)
				})
			})
		});

		array.asArray.reshape(n, n)
	}, {
		Error.new("n % != power of two!".format(n)).throw
	})
})
