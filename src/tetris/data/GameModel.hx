package tetris.data;

import coconut.data.Model;
import tink.pure.List;
import haxe.Timer;
import tetris.data.*;

using tetris.extensions.ArrayExt;

/**
 * Game model, containing and manipulating the data observed by game view.
 * Data fused for drawing the board is contained inside a 2-dimensional immutable List
 * @author Marko Ristic
 */

class GameModel implements Model
{
	// Currently active piece being moved on the board
	@:observable var piece:Piece = @byDefault null;
	// Next queued piece
	@:observable var queuedPiece:Piece = @byDefault getQuedPiece();
	// Game State (Start, InProgress, End)
	@:observable var gameState:GameState = @byDefault Start;
	// Board of locked pieces (unmovable) used to merege with the moving piece to get the complete board state
	@:observable var lockedBoard:List<List<String>> = @byDefault getBoardList(getEmptyBoard(Constants.BOARD_WIDTH, Constants.BOARD_HEIGHT));
	// Game score
	@:observable var score:Int = @byDefault 0;

	// Computed bord calculated by merging lockedBoard and currently active piece
	@:computed var board:List<List<String>> = setPiece(piece);
	// Computed 2-dimensional array of next queued shape
	@:computed var queuedBlock:List<List<Int>> = List.fromArray([for (v in queuedPiece.shape.blocks.iterator()) return v]);
	
	// Timer used for automaticly moving the piece down
	@:skipCheck @:editable var frameTimer:Timer = new haxe.Timer(Constants.FRAME_TIME);
	

	/**
	 * Game start.
	 * Empyt the board, sart move timer, place the first piece and queue the next
	 */
	@:transition function start()
	{
		reset();
		startTimer();
		newPiece();
		queuePiece();
		
		return { gameState: InProgress}
	}
	
	/**
	 * Reset the board to empty state
	 * Reset score
	 */
	@:transition function reset(){
		
		return { lockedBoard: getBoardList(getEmptyBoard(Constants.BOARD_WIDTH, Constants.BOARD_HEIGHT)), score: 0 };
	}
	
	/**
	 * Placing the new piece on the board if it can be placed. 
	 * If not that means the board has reached the top so the player lost.
	 */
	@:transition function newPiece()
	{
		if (queuedPiece == null) {
			queuePiece();
		}
		
		queuedPiece.position = new Point({x: Math.floor(Constants.BOARD_WIDTH / 2 - queuedPiece.shape.blocks.length / 2), y: 0});
		
		// Check if the piece is inisde board boundaries and if the fields where it should go are free
		if (canPlace(queuedPiece, queuedPiece.position, queuedPiece.rotation))
		{
			return { piece: queuedPiece }
		}
		else
		{
			playerLost();
			return {};
		}
	}
	
	/**
	 * Queue the next piece to be placed on the board
	 * @param	pshape [Shape]
	 */
	@:transition function queuePiece(?pshape: Shape) 
	{
		return { queuedPiece: getQuedPiece(pshape) }
	}
	
	/**
	 * Create a piece to be placed inside the queue
	 * @param	pshape [Shape]
	 */
	private function getQuedPiece(?pshape: Shape)
	{
		var shape:Shape = pshape == null? Shapes.getRandom() : pshape;
		var pos = new Point({x: 0, y: 0});
		return new Piece( { position: pos, shape: shape } );
	}

	/**
	 * Rotate the piece.
	 * Rotations are kept as an array of shapes that represent a single piece rotation.
	 * Here we give the piece a new rotation index;
	 */
	@:transition function rotate()
	{
		// Get new rotation index
		var newRotation = (piece.rotation + 1) % piece.shape.blocks.length;

		if (canPlace(piece, piece.position, newRotation))
		{
			piece.rotation = newRotation;
		}

		return {piece: piece};
	}

	/**
	 * Move the piece to the left by incrementing the position data x
	 */
	@:transition function moveLeft()
	{
		var newPosition = piece.position.clone();
		newPosition.offset(-1, 0);

		if (canPlace(piece, newPosition, piece.rotation))
		{
			piece.position = newPosition;
		}

		return {piece: piece};
	}

	/**
	 * Move the piece to the right by incrementing the position data x
	 */
	@:transition function moveRight()
	{
		var newPosition = piece.position.clone();
		newPosition.offset(1, 0);

		if (canPlace(piece, newPosition, piece.rotation))
		{
			piece.position = newPosition;
		}

		return {piece: piece};
	}

	/**
	 * Move the piece down by incrementing the position data y
	 * If there is no more room for moving, the piece has reached the board bottom, or has ran upto locked pieces, lock it in,
	 * remove full lines if viable, place a new piece on the board and queue next.
	 */
	@:transition function moveDown()
	{
		var piece = this.piece;
		var newPosition = piece.position.clone();
		newPosition.offset(0, 1);

		if (canPlace(piece, newPosition, piece.rotation))
		{
			piece.position = newPosition;
			return {piece: piece};
		}
		else
		{
			lockIn(piece);
			removeLines();
			newPiece();
			queuePiece();
			return {};
		}
	}
	
	/**
	 * Place the locked piece data into the locked board data
	 * @param	piece [Piece]
	 */
	@:transition function lockIn(piece:Piece) 
	{
		return {lockedBoard: setPiece(piece)};
	}
	
	/**
	 * Remove full lines from the board
	 * Add score for destroyed rows
	 */
	@:transition function removeLines() 
	{
		var board = getBoardArray(lockedBoard);
		var add = 0;
		
		for (rowIndex in 0...board.length) {
			var row = board[rowIndex];
			
			// Check if all fields in the row are full
            if (row.every(function(block) return block != '')) {
                board.splice(rowIndex, 1); // Remove the row from locked board
                board.unshift([for (v in row) '']); // The above opration removes a row from the board. We need to add an empty row at the start
				add += 100;
            }
        }
		
		return { lockedBoard: getBoardList(board), score: score + add };
    }

	/**
	 * Player lost, end the game
	 */
	@:transition function playerLost()
	{
		frameTimer.stop();
		return { gameState: End };
	}
	
	/**
	 * Initialize and start the timer
	 */
	private function startTimer():Void
	{
		frameTimer = new haxe.Timer(Constants.FRAME_TIME);
		frameTimer.run = timedUpdate;
	}
	
	/**
	 * On time update move the piece down
	 */
	private function timedUpdate():Void
	{
		moveDown();
	}

	/**
	 * Check if new piece position is inside board bounds or the fields in the board are free
	 * @param	piece [Piece]
	 * @param	newPosition [Pint]
	 * @param	newRotation [Int]
	 * @return  [Bool]
	 */
	private function canPlace(piece:Piece, newPosition:Point, newRotation:Int):Bool
	{
		var validSpace = true;
		var board = getBoardArray(lockedBoard);
		
		piece.shape.foreEach(newRotation, newPosition, function (x, y, value)
		{
			if (value == 1 && (isOutOfBounds(x, y) || board[y][x] != ''))
			{
				validSpace = false;
			}
		});
		
		return validSpace;
	}

	/**
	 * Set the piece on the new position by marking the board fields with the piece CSS class name 
	 * @param	piece [Piece]
	 * @return 	[List<List<String>>]
	 */
	private function setPiece(piece: Piece):List<List<String>>
	{
		var board = getBoardArray(lockedBoard);

		if (piece != null)
		{
			piece.shape.foreEach(piece.rotation, piece.position, function (x, y, value)
			{
				if (value == 1)
				{
					board[y][x] = piece.shape.className;
				}
			});
		}
		
		var list = getBoardList(board);
		
		return list;
	}

	/**
	 * Get a 2-dimensional array representing an empty board
	 * @param	width [Int]
	 * @param	height [Int]
	 * @return 	[Array<Array<String>>]
	 */
	public static function getEmptyBoard(width: Int, height: Int):Array<Array<String>>
	{
		return [for (y in 0...height) [for (x in 0...width) '']];
	}
	
	/**
	 * Convert board data from immutable List to array for easier manipulation
	 * @param	board [List<List<String>>]
	 * @return	[Array<Array<String>>]
	 */
	public static function getBoardArray(board: List<List<String>>):Array<Array<String>>
	{
		return [for(rows in board.iterator()) [for(v in rows.iterator()) v]];
	}

	/**
	 * Convert board data from array to immutable List
	 * @param	board [Array<Array<String>>]
	 * @return	[List<List<String>>]
	 */
	public static function getBoardList(board: Array<Array<String>>):List<List<String>>
	{
		return List.fromArray([for (row in board) List.fromArray(row)]);
	}

	/**
	 * Out of bounds check
	 * @param	x [Int]
	 * @param	y [Int]
	 * @return	[Bool]
	 */	
	public static function isOutOfBounds(x, y):Bool
	{
		return x < 0 || x >= Constants.BOARD_WIDTH || y < 0 || y >= Constants.BOARD_HEIGHT;
	}
}

/**
 * Enum of game states
 */
enum GameState
{
	Start;
	InProgress;
	End;
}