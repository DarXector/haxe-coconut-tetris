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
class PointTest
{
	public function new() {}
	
	@:describe("Point instantiation and methods")
	public function instantiate(test:AssertionBuffer)
	{
		var point = new Point({x: 12, y: 4});
		
		test.assert(point.x == 12);
		test.assert(point.y == 4);
		
		point.offset(2, 4);
		
		test.assert(point.x == 14);
		test.assert(point.y == 8);
		
		point.setTo(2, 7);
		
		test.assert(point.x == 2);
		test.assert(point.y == 7);
		
		var point2 = point.clone();
		
		test.assert(point.equals(point2));
		test.assert(point != point2);
		
		return test.done();
	}
}