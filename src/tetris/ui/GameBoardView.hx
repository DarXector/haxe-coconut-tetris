package tetris.ui;

import coconut.ui.*;
import tetris.data.GameModel;
import js.html.KeyboardEvent;

import haxe.Timer;
import tetris.data.Constants;

/**
 * Game Board View.
 * Based on table cells being drawn depending on the piece positions.
 * @author Marko Ristic
 */

@:less("gameboard.less")
class GameBoardView extends View
{
	@:attribute var gameBoard:GameModel;
		
	function render ()
	{
		var index = 0;
		
		return @hxx '
		<table className="game-board">
			<tbody>
				<for {row in gameBoard.board}>
					<tr key={ index }>
						<for {block in row}>
							<td key={index++} className={ "game-block " + (block == ""? "block-empty" : block) }/>
						</for>
					</tr>
				</for>
			</tbody>
		</table>';
	}
	
	override function afterInit(_) 
	{
		js.Browser.document.addEventListener( "keydown", this._onKeyDown );
	}
	
	function _onKeyDown(e:KeyboardEvent)
	{
		if (gameBoard.gameState == GameState.Start) {
			gameBoard.start();
		} else if (gameBoard.gameState == GameState.InProgress) {
			switch(e.keyCode) {
				case KeyboardEvent.DOM_VK_UP:
					gameBoard.rotate();
				case KeyboardEvent.DOM_VK_LEFT:
					gameBoard.moveLeft();
				case KeyboardEvent.DOM_VK_RIGHT:
					gameBoard.moveRight();
				case KeyboardEvent.DOM_VK_DOWN:
					gameBoard.moveDown();
			}
		}
	}
}