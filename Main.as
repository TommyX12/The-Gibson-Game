package  {
	
	import flash.display.MovieClip;
	import Screens.Screen_InGame;
	import Utils.Input;
	
	public class Main extends MovieClip {
		var screen_InGame:Screen_InGame;
		var _input:Input;
		public function Main() {
			stage.quality = "medium";
			_input = new Input();
			addChild(_input);
			screen_InGame = new Screen_InGame();
			addChild(screen_InGame);
		}
	}
	
}
