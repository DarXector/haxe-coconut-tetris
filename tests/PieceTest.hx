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
class PieceTest
{
	public function new() {}
	
	@:describe("Piece instantiation")
	public function instantiate(test:AssertionBuffer)
	{
		var point = new Point({x: 12, y: 4});
		var piece = new Piece({rotation: 3, position: point, shape:Shapes.O});
		
		test.assert(piece.rotation == 3);
		test.assert(piece.position != null);
		test.assert(piece.position.x == 12);
		test.assert(piece.position.y == 4);
		test.assert(piece.shape == Shapes.O);
		
		return test.done();
	}
}