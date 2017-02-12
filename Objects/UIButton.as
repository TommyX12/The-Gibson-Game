package Objects {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import Textures.Texture;
	import Utils.Input;

	public class UIButton extends MovieClip {

		public var isDown:Boolean;
		public var clicked:Boolean;
		public var texture:Bitmap;
		private var held:Boolean;
		public function UIButton(textureName:String) {
			isDown = false;
			texture = Texture.getTexture(textureName);
			held = false;
			clicked = false;
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:*){
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			texture.x = -Math.ceil(texture.width/2);
			texture.y = -Math.ceil(texture.height/2);
			addChild(texture);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:*){
			clicked = false;
			if (this.visible && Input.mouse_Down && held == false && this.hitTestPoint(mouseX+this.x,mouseY+this.y)){
				isDown = true;
				this.scaleX = this.scaleY = 0.8;
			}
			if (isDown && Input.mouse_Down == false){
				isDown = false;
				this.scaleX = this.scaleY = 1;
				if (this.hitTestPoint(mouseX+this.x,mouseY+this.y)){
					clicked = true;
				}
			}
			held = Input.mouse_Down;
		}

	}
	
}
