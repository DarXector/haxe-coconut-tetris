package tetris.data;

/**
 * Conatining all shape types data.
 * Shape rotations as 3-dimensional Lists and shape CSS class name
 * @author Marko Ristic
 */
class Shapes
{
	static public var I:Shape = new Shape({
		blocks: Shape.toList([
			[
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 1, 0, 0]
			],
			[
				[0, 0, 0, 0],
				[1, 1, 1, 1],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 0, 1, 0],
				[0, 0, 1, 0],
				[0, 0, 1, 0],
				[0, 0, 1, 0]
			],
			[
				[0, 0, 0, 0],
				[0, 0, 0, 0],
				[1, 1, 1, 1],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-i'
	});

	static public var J = new Shape({
		blocks: Shape.toList([
			[
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[1, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[1, 0, 0, 0],
				[1, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 1, 0],
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 0, 0, 0],
				[1, 1, 1, 0],
				[0, 0, 1, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-j'
	});

	static public var L = new Shape({
		blocks: Shape.toList([
			[
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 0, 0, 0],
				[1, 1, 1, 0],
				[1, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[1, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 0, 1, 0],
				[1, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-l'
	});

	static public var O = new Shape({
		blocks: Shape.toList([
			[
				[0, 1, 1, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 1, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 1, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 1, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-o'
	});

	static public var S = new Shape({
		blocks: Shape.toList([
			[
				[0, 0, 0, 0],
				[0, 1, 1, 0],
				[1, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[1, 0, 0, 0],
				[1, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 1, 0],
				[1, 1, 0, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 0, 0],
				[0, 1, 1, 0],
				[0, 0, 1, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-s'
	});

	static public var T = new Shape({
		blocks: Shape.toList([
			[
				[0, 0, 0, 0],
				[1, 1, 1, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 0, 0],
				[1, 1, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 0, 0],
				[1, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 0, 0],
				[0, 1, 1, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-t'
	});

	static public var Z = new Shape({
		blocks: Shape.toList([
			[
				[0, 0, 0, 0],
				[1, 1, 0, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 1, 0, 0],
				[1, 1, 0, 0],
				[1, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[1, 1, 0, 0],
				[0, 1, 1, 0],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			],
			[
				[0, 0, 1, 0],
				[0, 1, 1, 0],
				[0, 1, 0, 0],
				[0, 0, 0, 0]
			]
		]),
		className: 'shape-z'
	});
	
	/**
	 * Get a random shape
	 * @return 	[Shape]
	 */
	static public function getRandom():Shape {
		var types = [I, J, L, O, S, T, Z];
		return types[Math.floor(Math.random() * types.length)];
	}
}