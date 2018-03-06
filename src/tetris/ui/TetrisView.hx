package tetris.ui;

import tetris.data.*;
import coconut.ui.*;

/**
 * Main view conainer.
 * @author Marko Ristic
 */

@:less("tetris.less")
class TetrisView extends View {
	
	@:attribute var gameBoard:GameModel;
	
	function render () return @hxx '
	<div className="game">
		<HUD gameBoard={ gameBoard }/>
		<GameBoardView gameBoard={ gameBoard } />
	</div>';
}