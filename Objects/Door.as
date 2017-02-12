package Objects {
	import flash.display.MovieClip;
	import Objects.Room;
	import flash.display.Bitmap;
	import flash.events.Event;
	import Textures.Texture;

	public class Door extends MovieClip {

		public static var doorSize:int = 35;
		public static var doorThickness:int = 5;
		public var bm_floor:Bitmap;
		public var bm_door:Bitmap;
		public var room1:Room;
		public var room2:Room
		public function Door(_room1:Room,_room2:Room,posX:Number,posY:Number,vertical:Boolean) {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			room1 = _room1;
			room2 = _room2;
			bm_floor = Texture.getTexture("Floor");
			bm_door = Texture.getTexture("Door");
			this.x = vertical ? posX : posX - doorSize/2;
			this.y = vertical ? posY - doorSize/2 : posY;
			bm_floor.x = vertical ? -Room.wallSize/2-1 : 0;
			bm_floor.y = vertical ? 0 : -Room.wallSize/2-1;
			bm_floor.scaleX = vertical ? (Room.wallSize+1)/32 : doorSize/32;
			bm_floor.scaleY = vertical ? doorSize/32 : (Room.wallSize+1)/32;
			bm_door.x = vertical ? -doorThickness/2 : 0;
			bm_door.y = vertical ? 0 : -doorThickness/2;
			bm_door.scaleX = vertical ? doorThickness/32 : doorSize/32;
			bm_door.scaleY = vertical ? doorSize/32 : doorThickness/32;
		}
		
		private function onAddedToStage(event:*){
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			addChild(bm_floor);
			addChild(bm_door);
		}
		
		public function destroy(){
			this.parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:*){
			
		}

	}
	
}
