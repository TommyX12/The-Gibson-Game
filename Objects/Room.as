package Objects {
	
	import flash.display.MovieClip;
	import Textures.Texture;
	import flash.display.Bitmap;
	import flash.events.Event;
	import Screens.Screen_InGame;
	import flash.geom.Rectangle;
	import Objects.Door;

	public class Room extends MovieClip {

		public static const wallSize:Number = 10;
		public static const minSize:Number = Door.doorSize+wallSize;
		public static const snapRange:Number = 15;
		public static const overlapTolerance:Number = 5;
		public var minX:Number;
		public var minY:Number;
		public var w:Number;
		public var h:Number;
		public var rect:Rectangle;
		public var connection:Array;
		private var bm_floor:Bitmap;
		private var bm_wall1:Bitmap;
		private var bm_wall2:Bitmap;
		private var bm_wall3:Bitmap;
		private var bm_wall4:Bitmap;
		private var bm_corner1:Bitmap;
		private var bm_corner2:Bitmap;
		private var bm_corner3:Bitmap;
		private var bm_corner4:Bitmap;
		public function Room(_minX,_minY) {
			bm_floor = Texture.getTexture("Floor");
			bm_wall1 = Texture.getTexture("Wall");
			bm_wall2 = Texture.getTexture("Wall");
			bm_wall3 = Texture.getTexture("Wall");
			bm_wall4 = Texture.getTexture("Wall");
			bm_corner1 = Texture.getTexture("Corner");
			bm_corner2 = Texture.getTexture("Corner");
			bm_corner3 = Texture.getTexture("Corner");
			bm_corner4 = Texture.getTexture("Corner");
			w = 0;
			h = 0;
			minX = _minX;
			minY = _minY;
			connection = new Array();
			bm_wall1.scaleY = wallSize/bm_wall1.height;
			bm_wall2.scaleX = wallSize/bm_wall2.width;
			bm_wall3.scaleY = wallSize/bm_wall3.height;
			bm_wall4.scaleX = wallSize/bm_wall4.width;
			bm_corner1.scaleX = bm_corner1.scaleY = bm_corner2.scaleX = bm_corner2.scaleY = bm_corner3.scaleX = bm_corner3.scaleY = bm_corner4.scaleX = bm_corner4.scaleY = wallSize/bm_corner1.width;
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:*){
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.visible = false;
			addChild(bm_floor);
			addChild(bm_wall1);
			addChild(bm_wall2);
			addChild(bm_wall3);
			addChild(bm_wall4);
			addChild(bm_corner1);
			addChild(bm_corner2);
			addChild(bm_corner3);
			addChild(bm_corner4);
		}
		
		public function update(maxX,maxY){
			this.visible = true;
			this.x = minX;
			this.y = minY;
			this.w = maxX-minX;
			this.h = maxY-minY;
			this.rect = new Rectangle(this.x,this.y,this.w,this.h);
			if (this.w < 0){
				this.rect.x += this.w;
				this.rect.width *= -1;
			}
			if (this.h < 0){
				this.rect.y += this.h;
				this.rect.height *= -1;
			}
			this.bm_floor.scaleX = this.w/32;
			this.bm_floor.scaleY = this.h/32;
			this.bm_wall1.y = -wallSize/2;
			this.bm_wall1.scaleX = this.w/32;
			this.bm_wall2.x = -wallSize/2;
			this.bm_wall2.scaleY = this.h/32;
			this.bm_wall3.y = this.h-wallSize/2;
			this.bm_wall3.scaleX = this.w/32;
			this.bm_wall4.x = this.w-wallSize/2;
			this.bm_wall4.scaleY = this.h/32;
			this.bm_corner1.x = -wallSize/2;
			this.bm_corner1.y = -wallSize/2;
			this.bm_corner2.x = this.w-wallSize/2;
			this.bm_corner2.y = -wallSize/2;
			this.bm_corner3.x = -wallSize/2;
			this.bm_corner3.y = this.h-wallSize/2;
			this.bm_corner4.x = this.w-wallSize/2;
			this.bm_corner4.y = this.h-wallSize/2;
		}
		
		public function destroy(){
			this.parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:*){
			
		}

	}
	
}
