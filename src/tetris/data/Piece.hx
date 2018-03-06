package tetris.data;

import coconut.data.Model;
import tetris.data.Point;
import tetris.data.Shape;
import tetris.data.Shapes;

/**
 * Piece data model containing rotation, position and shape data
 * @author Marko Ristic
 */
class Piece implements Model
{
	@:editable var rotation:Int = @byDefault 0;
    @:editable var position:Point = @byDefault null;
    @:constant var shape:Shape = @byDefault null;
}