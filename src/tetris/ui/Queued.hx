package tetris.ui;

import coconut.ui.*;
import tetris.data.GameModel;
import coconut.data.List;

/**
 * View displaying the next queued piece
 * @author Marko Ristic
 */
class Queued extends View 
{
	@:attribute var queuedBlock:List<List<Int>>;
	
	function render ()
	{
		var index = 0;
		
		return @hxx '
		<table className="queued">
			<tbody>
				<for {row in queuedBlock}>
					<tr key={ index }>
						<for {block in row}>
							<td key={index++} className={ "game-block " + (block == 0? "block-empty" : "shape") }/>
						</for>
					</tr>
				</for>
			</tbody>
		</table>';
	}
}