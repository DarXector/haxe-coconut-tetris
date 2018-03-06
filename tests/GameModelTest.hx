package;

import coconut.data.*;
import tetris.data.*;
import tetris.data.GameModel.*;
import tetris.data.GameModel.GameState;
import tink.state.*;
import tink.unit.*;
import tink.unit.Assert.*;


using tink.CoreApi;
using tetris.extensions.ArrayExt;

/**
 * ...
 * @author Marko Ristic
 */
class GameModelTest
{
	public function new() {}

	@:describe("Game state changes")
	public function gameState(test:AssertionBuffer)
	{
		var model = new GameModel();

		test.assert(model.gameState == GameState.Start);
		model.start();
		test.assert(model.gameState == GameState.InProgress);
		model.playerLost();
		test.assert(model.gameState == GameState.End);

		return test.done();
	}
	
	@:describe("Array / List transformation static methods")
	public function arrayTransform(test:AssertionBuffer)
	{
		var emptyBoard = GameModel.getEmptyBoard(3, 3);
		test.assert(emptyBoard.every(function(row) return row.every(function(block) return block == '')));
		
		var listBoard = GameModel.getBoardList(emptyBoard);
		for (rows in listBoard) for (v in rows) test.assert(v == '');
		
		var arrayBoard = GameModel.getBoardArray(listBoard);
		test.assert(arrayBoard.every(function(row) return row.every(function(block) return block == '')));
		
		return test.done();
	}
	
	@:describe("Start game")
	@:describe("New piece instantiation")
	@:describe("Queued piece instantiation")
	public function gameStart(test:AssertionBuffer)
	{
		var model = new GameModel();
		model.start();
		
		for (rows in model.lockedBoard) for (v in rows) test.assert(v == '');
		
		test.assert(model.piece != null);
		test.assert(model.piece.shape != null);
		test.assert(model.piece.position != null);
		test.assert(model.piece.rotation == 0);
		
		test.assert(model.queuedPiece != null);
		test.assert(model.queuedPiece.shape != null);
		test.assert(model.queuedPiece.position != null);
		test.assert(model.queuedPiece.rotation == 0);
		
		test.assert(model.score == 0);

		return test.done();
	}
	
	@:describe("Piece movement")
	public function movement(test:AssertionBuffer)
	{
		var model = new GameModel();
		model.newPiece();
		
		test.assert(model.piece != null);
		test.assert(model.piece.shape != null);
		test.assert(model.piece.position != null);
		test.assert(model.piece.position.x == Math.floor(Constants.BOARD_WIDTH / 2 - model.piece.shape.blocks.length / 2));
		test.assert(model.piece.position.y == 0);
		test.assert(model.piece.rotation == 0);
		
		var startX = model.piece.position.x;
		
		model.moveDown();
		test.assert(model.piece.position.y == 1);
		
		model.moveLeft();
		test.assert(model.piece.position.x == startX - 1);
		
		model.moveRight();
		model.moveRight();
		test.assert(model.piece.position.x == startX + 1);
		
		model.rotate();
		test.assert(model.piece.rotation == 1);
		
		return test.done();
	}
	
	@:describe("Game reset and lock in")
	public function resetGame(test:AssertionBuffer)
	{
		var model = new GameModel();
		var boardArray = GameModel.getBoardArray(model.lockedBoard);
		test.assert(boardArray.every(function(row) return row.every(function(block) return block == '')));
		
		model.newPiece();
		model.lockIn(model.piece);
		var boardArray1 = GameModel.getBoardArray(model.lockedBoard);
		test.assert(!boardArray1.every(function(row) return row.every(function(block) return block == '')));
		
		model.reset();
		var boardArray2 = GameModel.getBoardArray(model.lockedBoard);
		test.assert(boardArray2.every(function(row) return row.every(function(block) return block == '')));
		
		return test.done();
	}
	
	
	@:describe("Remove line and add score")
	public function removeLine(test:AssertionBuffer)
	{
		var model = new GameModel();
		model.queuePiece(Shapes.O);
		model.newPiece();
		for (i in 0...4) model.moveRight();
		model.lockIn(model.piece);
		
		model.queuePiece(Shapes.O);
		model.newPiece();
		for (i in 0...2) model.moveRight();
		model.lockIn(model.piece);
		
		model.queuePiece(Shapes.O);
		model.newPiece();
		for (i in 0...4) model.moveLeft();
		model.lockIn(model.piece);
		
		model.queuePiece(Shapes.O);
		model.newPiece();
		for (i in 0...2) model.moveLeft();
		model.lockIn(model.piece);
		
		model.queuePiece(Shapes.O);
		model.newPiece();
		model.lockIn(model.piece);
		
		var boardArray = GameModel.getBoardArray(model.lockedBoard);
		test.assert(!boardArray.every(function(row) return row.every(function(block) return block == '')));
		
		model.removeLines();
		
		var boardArray1 = GameModel.getBoardArray(model.lockedBoard);
		test.assert(boardArray1.every(function(row) return row.every(function(block) return block == '')));
		test.assert(model.score == 200);
		
		return test.done();
	}
}