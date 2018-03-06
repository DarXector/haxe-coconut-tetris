package tetris.ui;

import coconut.ui.*;
import tetris.data.GameModel;

/**
 * Game UI view conainer with start game call to action or score view, 
 * queued next piece and end game popup
 * @author Marko Ristic
 */

@:less("hud.less")
class HUD extends View 
{
	@:attribute var gameBoard:GameModel;
	
	function render ()
	{
		return @hxx '
		<div className="hud">
			<if { gameBoard.gameState == GameState.Start }>
				<div className="score">Press any key to start</div>
			<else>
				<div className="score">Score: {gameBoard.score}</div>
			</if>
			<Queued queuedBlock={ gameBoard.queuedBlock }/>
			<if { gameBoard.gameState == GameState.End } >
				<Modal gameBoard={ gameBoard } />
			</if>
		</div>';
		
	}
}