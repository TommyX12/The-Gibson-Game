package Utils {
	
	import Utils.Util;	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Input extends MovieClip {

		private var _key:Array;
		public var key:Object;
		private var held:Boolean;
		public static var current:Object;
		public static var mouse_Down:Boolean;
		public static var mouse_Clicked:Boolean;
		public function Input() {
			_key = [
			{keyname:"UP",keycode:38},
			{keyname:"DOWN",keycode:40},
			{keyname:"LEFT",keycode:37},
			{keyname:"RIGHT",keycode:39},
			{keyname:"BACKSPACE",keycode:8},
			{keyname:"TAB",keycode:9},
			{keyname:"ENTER",keycode:13},
			{keyname:"SHIFT",keycode:16},
			{keyname:"CTRL",keycode:17},
			{keyname:"CAPSLOCK",keycode:20},
			{keyname:"ESC",keycode:27},
			{keyname:"PGUP",keycode:33},
			{keyname:"PGDN",keycode:34},
			{keyname:"END",keycode:35},
			{keyname:"HOME",keycode:36},
			{keyname:"INS",keycode:45},
			{keyname:"DEL",keycode:46},
			{keyname:"NUMLOCK",keycode:144},
			{keyname:"SCRLOCK",keycode:145},
			{keyname:"PAUSE",keycode:19},
			{keyname:"SPACE",keycode:32},
			{keyname:"A",keycode:65},
			{keyname:"B",keycode:66},
			{keyname:"C",keycode:67},
			{keyname:"D",keycode:68},
			{keyname:"E",keycode:69},
			{keyname:"F",keycode:70},
			{keyname:"G",keycode:71},
			{keyname:"H",keycode:72},
			{keyname:"I",keycode:73},
			{keyname:"J",keycode:74},
			{keyname:"K",keycode:75},
			{keyname:"L",keycode:76},
			{keyname:"M",keycode:77},
			{keyname:"N",keycode:78},
			{keyname:"O",keycode:79},
			{keyname:"P",keycode:80},
			{keyname:"Q",keycode:81},
			{keyname:"R",keycode:82},
			{keyname:"S",keycode:83},
			{keyname:"T",keycode:84},
			{keyname:"U",keycode:85},
			{keyname:"V",keycode:86},
			{keyname:"W",keycode:87},
			{keyname:"X",keycode:88},
			{keyname:"Y",keycode:89},
			{keyname:"Z",keycode:90},
			{keyname:"0",keycode:48},
			{keyname:"1",keycode:49},
			{keyname:"2",keycode:50},
			{keyname:"3",keycode:51},
			{keyname:"4",keycode:52},
			{keyname:"5",keycode:53},
			{keyname:"6",keycode:54},
			{keyname:"7",keycode:55},
			{keyname:"8",keycode:56},
			{keyname:"9",keycode:57},
			{keyname:"COMMA",keycode:188},
			{keyname:"PERIOD",keycode:190},
			]
			key = new Object();
			for (var k:int = 0; k < _key.length; k++){
				key[_key[k].keyname] = false;
			}
			current = this;
			mouse_Down = false;
			mouse_Clicked = false;
			held = false;
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:*):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_UP,_key_isUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,_key_isDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,_mouse_isUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,_mouse_isDown);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}

		private	function onEnterFrame(event:*):void{
			mouse_Clicked = false;
			if (mouse_Down == false && held){
				mouse_Clicked = true;
			}
			held = mouse_Down;
		}
		
		private function _key_isUp(event:KeyboardEvent):void {
			var keyx:Object = Util.getObject(_key,"keycode",event.keyCode)
			if (keyx != null){key[keyx.keyname] = false}
			//trace(event.keyCode)
		}

		private function _key_isDown(event:*):void {
			var keyx:Object = Util.getObject(_key,"keycode",event.keyCode)
			if (keyx != null){key[keyx.keyname] = true}
			//trace(event.keyCode)
		}

		private function _mouse_isUp(event:MouseEvent):void {
			mouse_Down = false
		}

		private function _mouse_isDown(event:MouseEvent):void {
			mouse_Down = true
		}


	}
	
}
