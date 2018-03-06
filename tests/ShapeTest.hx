package;

import coconut.data.*;
import tetris.data.*;
import tetris.data.GameModel.*;
import tink.state.*;
import tink.unit.*;
import tink.unit.Assert.*;


using tink.CoreApi;
using tetris.extensions.ArrayExt;

/**
 * ...
 * @author Marko Ristic
 */
class ShapeTest
{
	public function new() {}
	
	var array3 = [
		[
			[1, 1, 1],
			[1, 1, 1]
		], 
		[
			[1, 1, 1],
			[1, 1, 1]
		]
	];
	
	@:describe("Static toList test")
	public function toList(test:AssertionBuffer)
	{
		var list3 = Shape.toList(array3);
		
		for (first in list3) for (second in first) for (v in second) test.assert(v == 1);
		
		test.assert(list3.prepend != null);
		for (first in list3) test.assert(first.prepend != null);
		for (first in list3) for (second in first) test.assert(second.prepend != null);
		
		return test.done();
	}
	
	@:describe("Shape instantiation, forEach test")
	public function instantiate(test:AssertionBuffer)
	{
		var list3 = Shape.toList(array3);
		
		var shape = new Shape({blocks: list3, className: 'some-class'});
		test.assert(shape.blocks != null);
		test.assert(shape.className == 'some-class');
		
		var sum = 0;
		shape.foreEach(0, new Point({x: 0, y: 0}), function(x, y, value) sum += value);
		test.assert(sum == 6);

		return test.done();
	}
}