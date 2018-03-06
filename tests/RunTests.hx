package;

import coconut.data.*;
import tetris.data.GameModel.*;
import tink.state.*;
import tink.testrunner.Runner.*;
import tink.unit.*;
import tink.unit.Assert.*;


using tink.CoreApi;
using tetris.extensions.ArrayExt;

/**
 * ...
 * @author Marko Ristic
 */
class RunTests
{

	static function main()
	{
		run(TestBatch.make([
							   new GameModelTest(),
							   new ShapeTest(),
							   new PointTest(),
							   new PieceTest()
						   ])).handle(exit);
	}

}