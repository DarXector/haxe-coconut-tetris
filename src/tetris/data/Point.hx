package tetris.data;

import coconut.data.Model;

/**
 * Point data model containing and manipulating position data.
 * @author Marko Ristic
 */
class Point implements Model {
	
	@:observable var x:Int = @byDefault 0;
	@:observable var y:Int = @byDefault 0;
	
	/**
	 * Comparing coordinates of two Point instances
	 * @param	toCompare [Point]
	 * @return	[Bool]
	 */
	public function equals (toCompare:Point):Bool {
		return toCompare != null && toCompare.x == x && toCompare.y == y;
	}
	
	/**
	 * Offset the position by a certain ammount
	 * @param	dx [Int]
	 * @param	dy [Int]
	 */
	@:transition function offset (dx:Int, dy:Int) {
		return {x: x + dx, y: y + dy};
	}
	
	/**
	 * Set the position to certain values
	 * @param	xa [Int]
	 * @param	ya [Int]
	 */
	@:transition function setTo (xa:Int, ya:Int) {
		return {x: xa, y: ya};
	}
	
	/**
	 * Clone position data
	 * @return 	[Point]
	 */
	public function clone ():Point {
		return new Point({x: this.x, y: this.y});
	}
}