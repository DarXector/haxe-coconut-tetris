package ;

import js.Browser.*;
import coconut.Ui.hxx;
import tetris.data.*;
import tetris.ui.*;

/**
 * App entry point
 * @author Marko Ristic
 */

class Tetris {
  static function main() {

    document.body.appendChild(
      hxx('
        <TetrisView gameBoard={ new GameModel() }/>
      ').toElement()
    );
  }
}