package tetris.data;
import coconut.data.*;

/**
 * Shape data model containing all shape rotation variations and CSS class name of the shape
 * @author Marko Ristic
 */
class Shape implements Model
{
	// 3-dimensional List containing rotations (1st dimension) and shape for each rotation (2nd and 3rd dimension)
	@:constant var blocks:List<List<List<Int>>>;
	@:constant var className:String;

	/**
	 * Utility to allow callback methods an every field of a shape.
	 * For example: to check if the field can be placed on the board, and for placing it on the board
	 * @param	rotationIndex [Int]
	 * @param	position [Point]
	 * @param	callback [Int->Int->Int->Void]
	 */
	public function foreEach(rotationIndex:Int, position: Point,  callback: Int->Int->Int->Void)
	{
		var posX = -1;
		var posY = -1;
		
		var rotation = [for (v in blocks.iterator()) v][rotationIndex];
			
		for (row in rotation)
		{
			posY++;
			posX = -1;
			for (block in row )
			{
				posX++;
				callback(position.x + posX, position.y + posY, block);
			}
		}
	}

	/**
	 * Convert shape data to 3-dimensional List
	 * @param	blocks [Array<Array<Array<Int>>>]
	 * @return	[List<List<List<Int>>>]
	 */
	public static function toList(blocks: Array<Array<Array<Int>>>):List<List<List<Int>>>
	{
		return List.fromArray([for (rotation in blocks) List.fromArray([for (row in rotation) List.fromArray(row)])]);
	}
}