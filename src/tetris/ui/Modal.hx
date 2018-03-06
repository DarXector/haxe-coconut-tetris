package tetris.ui;

import coconut.ui.*;
import tetris.data.GameModel;

/**
 * End game popup with game restart button
 * @author Marko Ristic
 */

class Modal extends View 
{
	@:attribute var gameBoard:GameModel;
	
	function render ()
	{
		return @hxx '
		<div className="modal">
			<p>Game over!</p>
			<div className="lower">
				 <button onclick={gameBoard.start()}>RESTART</button>
			</div>
		</div>';
		
	}
}