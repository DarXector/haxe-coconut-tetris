package tetris.extensions;

/**
 * Static extension for arrays API
 * @author Marko Ristic
 */

class ArrayExt {
	
	/**
	 * Tests whether all elements in the array pass the test implemented by the provided function
	 */
	static public function every<T>(arr:Array<T>, comparator:T->Bool) {
		for (elem in arr)
		{
			if (!comparator(elem))
			return false;
		}
		return true;
	}
}