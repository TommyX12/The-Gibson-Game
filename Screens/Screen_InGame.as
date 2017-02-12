package Screens {

	import flash.display.MovieClip;
	import flash.events.Event;
	import Utils.Input;
	import Objects.Room;
	import Objects.Door;
	import Objects.UIButton;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Screen_InGame extends MovieClip {

		public static const scaleSpeed:Number = 0.25;
		public static const scaleMin:Number = 0.25;
		public static const scaleMax:Number = 1.5;
		public static const dragLimitX:Number = 2048;
		public static const dragLimitY:Number = 1536;
		public static var centerX:int = 0;
		public static var centerY:int = 0;
		public var btn_NewRoom:UIButton;
		public var btn_Cancel:UIButton;
		public var btn_Confirm:UIButton;
		public var btn_ZoomIn:UIButton;
		public var btn_ZoomOut:UIButton;
		public var mode:String;
		public var rooms:Array;
		public var doors:Array;
		public var newRoomStat:int;
		public var mousePosX:Number;
		public var mousePosY:Number;
		private var mouseLastX:Number;
		private var mouseLastY:Number;
		public var objContainer:Sprite;
		public var layer_House:Sprite;
		public var layer_Item:Sprite;
		public var layer_AI:Sprite;
		public var UIContainer:Sprite;
		private var dragBuffer:Boolean;
		public function Screen_InGame() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:*){
			//var xx = new Room();
			//addChild(xx);
			//xx.update(0,0,1024,200);
			centerX = stage.stageWidth/2;
			centerY = stage.stageHeight/2;
			mode = "standby";
			rooms = new Array();
			doors = new Array();
			newRoomStat = 0;
			mousePosX = 0;
			mousePosY = 0;
			mouseLastX = mouseX;
			mouseLastY = mouseY;
			dragBuffer = false;
			objContainer = new Sprite();
			objContainer.x = 1*centerX;
			objContainer.y = 1*centerY;
			addChild(objContainer);
			layer_House = new Sprite();
			objContainer.addChild(layer_House);
			layer_Item = new Sprite();
			objContainer.addChild(layer_Item);
			layer_AI = new Sprite();
			objContainer.addChild(layer_AI);
			UIContainer = new Sprite();
			addChild(UIContainer);
			btn_NewRoom = new UIButton("Btn_NewRoom");
			btn_NewRoom.x = 50;
			btn_NewRoom.y = 50;
			UIContainer.addChild(btn_NewRoom);
			btn_Cancel = new UIButton("Btn_Cancel");
			btn_Cancel.x = 130;
			btn_Cancel.y = 50;
			btn_Cancel.visible = false;
			UIContainer.addChild(btn_Cancel);
			btn_Confirm = new UIButton("Btn_Confirm");
			btn_Confirm.x = 50;
			btn_Confirm.y = 50;
			btn_Confirm.visible = false;
			UIContainer.addChild(btn_Confirm);
			btn_ZoomIn = new UIButton("Btn_ZoomIn");
			btn_ZoomIn.x = 50;
			btn_ZoomIn.y = 630;
			UIContainer.addChild(btn_ZoomIn);
			btn_ZoomOut = new UIButton("Btn_ZoomOut");
			btn_ZoomOut.x = 50;
			btn_ZoomOut.y = 710;
			UIContainer.addChild(btn_ZoomOut);
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function wallSnap(offset:int=0){
			var snapX:Number = -1;
			var snapY:Number = -1;
			for (var h:int = 0; h < rooms.length-offset; h++){
				if (Math.abs(rooms[h].x-mousePosX) < Room.snapRange){
					if (Math.abs(snapX) > Math.abs(rooms[h].x-mousePosX) || snapX == -1){
						snapX = rooms[h].x-mousePosX;
					}
				}
				if (Math.abs(rooms[h].y-mousePosY) < Room.snapRange){
					if (Math.abs(snapY) > Math.abs(rooms[h].y-mousePosY) || snapY == -1){
						snapY = rooms[h].y-mousePosY;
					}
				}
				if (Math.abs(rooms[h].x+rooms[h].w-mousePosX) < Room.snapRange){
					if (Math.abs(snapX) > Math.abs(rooms[h].x+rooms[h].w-mousePosX) || snapX == -1){
						snapX = rooms[h].x+rooms[h].w-mousePosX;
					}
				}
				if (Math.abs(rooms[h].y+rooms[h].h-mousePosY) < Room.snapRange){
					if (Math.abs(snapY) > Math.abs(rooms[h].y+rooms[h].h-mousePosY) || snapY == -1){
						snapY = rooms[h].y+rooms[h].h-mousePosY;
					}
				}
			}
			mousePosX += snapX;
			mousePosY += snapY;
		}
		
		private function roomConnect(room1:Room,offset:int){
			var h:int = 0;
			for (h = 0; h < rooms.length-offset; h++){
				if (Math.abs(room1.rect.x-(rooms[h].rect.x+rooms[h].rect.width)) < Room.overlapTolerance){
					if (Math.min(room1.rect.y+room1.rect.height,rooms[h].rect.y+rooms[h].rect.height) - Math.max(room1.rect.y,rooms[h].rect.y) >= Door.doorSize+Room.wallSize){
						room1.connection.push(rooms[h]);
						rooms[h].connection.push(room1);
						doors.push(new Door(room1,rooms[h],room1.rect.x,(Math.min(room1.rect.y+room1.rect.height,rooms[h].rect.y+rooms[h].rect.height) + Math.max(room1.rect.y,rooms[h].rect.y))/2,true));
						layer_House.addChild(doors[doors.length-1]);
					}
				}
			}
			for (h = 0; h < rooms.length-offset; h++){
				if (Math.abs(rooms[h].rect.x-(room1.rect.x+room1.rect.width)) < Room.overlapTolerance){
					if (Math.min(room1.rect.y+room1.rect.height,rooms[h].rect.y+rooms[h].rect.height) - Math.max(room1.rect.y,rooms[h].rect.y) >= Door.doorSize+Room.wallSize){
						room1.connection.push(rooms[h]);
						rooms[h].connection.push(room1);
						doors.push(new Door(room1,rooms[h],rooms[h].rect.x,(Math.min(room1.rect.y+room1.rect.height,rooms[h].rect.y+rooms[h].rect.height) + Math.max(room1.rect.y,rooms[h].rect.y))/2,true));
						layer_House.addChild(doors[doors.length-1]);
					}
				}
			}
			for (h = 0; h < rooms.length-offset; h++){
				if (Math.abs(room1.rect.y-(rooms[h].rect.y+rooms[h].rect.height)) < Room.overlapTolerance){
					if (Math.min(room1.rect.x+room1.rect.width,rooms[h].rect.x+rooms[h].rect.width) - Math.max(room1.rect.x,rooms[h].rect.x) >= Door.doorSize+Room.wallSize){
						room1.connection.push(rooms[h]);
						rooms[h].connection.push(room1);
						doors.push(new Door(room1,rooms[h],(Math.min(room1.rect.x+room1.rect.width,rooms[h].rect.x+rooms[h].rect.width) + Math.max(room1.rect.x,rooms[h].rect.x))/2,room1.rect.y,false));
						layer_House.addChild(doors[doors.length-1]);
					}
				}
			}
			for (h = 0; h < rooms.length-offset; h++){
				if (Math.abs(rooms[h].rect.y-(room1.rect.y+room1.rect.height)) < Room.overlapTolerance){
					if (Math.min(room1.rect.x+room1.rect.width,rooms[h].rect.x+rooms[h].rect.width) - Math.max(room1.rect.x,rooms[h].rect.x) >= Door.doorSize+Room.wallSize){
						room1.connection.push(rooms[h]);
						rooms[h].connection.push(room1);
						doors.push(new Door(room1,rooms[h],(Math.min(room1.rect.x+room1.rect.width,rooms[h].rect.x+rooms[h].rect.width) + Math.max(room1.rect.x,rooms[h].rect.x))/2,rooms[h].rect.y,false));
						layer_House.addChild(doors[doors.length-1]);
					}
				}
			}
		}
		
		private function onEnterFrame(event:*){
			var point:Point = new Point(mouseX,mouseY);
			point = objContainer.globalToLocal(point);
			mousePosX = int(point.x); 
			mousePosY = int(point.y);
			if (btn_NewRoom.clicked){
				mode = "newroom";
				btn_Cancel.visible = true;
				btn_NewRoom.visible = false;
			}
			if (btn_Cancel.clicked){
				if (newRoomStat != 0){
					rooms[rooms.length-1].destroy();
					rooms.pop();
				}
				mode = "standby";
				btn_Cancel.visible = false;
				btn_NewRoom.visible = true;
				btn_Confirm.visible = false;
				newRoomStat = 0;
			}
			if (btn_Confirm.clicked){
				mode = "standby";
				btn_Cancel.visible = false;
				btn_Confirm.visible = false;
				btn_NewRoom.visible = true;
				rooms[rooms.length-1].alpha = 1;
				newRoomStat = 0;
				roomConnect(rooms[rooms.length-1],1);
			}
			if (mode == "newroom"){
				btn_ZoomIn.visible = false;
				btn_ZoomOut.visible = false;
				if (Input.mouse_Down && newRoomStat == 0){
					newRoomStat = 1;
					wallSnap(0);
					rooms.push(new Room(mousePosX,mousePosY));
					layer_House.addChild(rooms[rooms.length-1]);
				}
				else if (newRoomStat == 1){
					wallSnap(1);
					rooms[rooms.length-1].update(mousePosX,mousePosY)
					var intersectionW:Number = 0;
					var intersectionH:Number = 0;
					var intersectionRect:Rectangle;
					var clear:Boolean = false;
					for (var h = 0; h < rooms.length-1; h++){
						intersectionRect = rooms[rooms.length-1].rect.intersection(rooms[h].rect)
						if (intersectionRect.width > intersectionW){
							intersectionW = intersectionRect.width
						}
						if (intersectionRect.height > intersectionH){
							intersectionH = intersectionRect.height
						}
					}
					if (Math.abs(rooms[rooms.length-1].w) >= Room.minSize && Math.abs(rooms[rooms.length-1].h) >= Room.minSize && Math.min(intersectionW,intersectionH) < Room.overlapTolerance){
						rooms[rooms.length-1].alpha = 0.65;
						clear = true;
					}
					else {
						rooms[rooms.length-1].alpha = 0.15;
						clear = false;
					}
					if (Input.mouse_Down == false){
						newRoomStat = 2;
						if (clear){
							btn_Confirm.visible = true;
						}
						else {
							rooms[rooms.length-1].destroy();
							rooms.pop();
							mode = "standby";
							btn_Cancel.visible = false;
							btn_NewRoom.visible = true;
							btn_Confirm.visible = false;
							newRoomStat = 0;
						}
					}
				}
			}
			else if (mode == "standby"){
				btn_ZoomIn.visible = true;
				btn_ZoomOut.visible = true;
				if (Input.mouse_Down){
					if (dragBuffer){
						objContainer.x = Math.min(Math.max(objContainer.x+(mouseX-mouseLastX),-dragLimitX*objContainer.scaleX+2*centerX),dragLimitX*objContainer.scaleX);
						objContainer.y = Math.min(Math.max(objContainer.y+(mouseY-mouseLastY),-dragLimitY*objContainer.scaleY+2*centerY),dragLimitY*objContainer.scaleY);
					}
					dragBuffer = true;
				}
				else {
					dragBuffer = false;
				}
				mouseLastX = mouseX;
				mouseLastY = mouseY;
				if (btn_ZoomIn.clicked){
					if (objContainer.scaleX < scaleMax){
						objContainer.x = centerX + (objContainer.x - centerX)*((objContainer.scaleX + scaleSpeed)/objContainer.scaleX)
						objContainer.y = centerY + (objContainer.y - centerY)*((objContainer.scaleY + scaleSpeed)/objContainer.scaleY)
					}
					objContainer.scaleX = objContainer.scaleY = Math.min(objContainer.scaleX + scaleSpeed, scaleMax);
					objContainer.x = Math.min(Math.max(objContainer.x,-dragLimitX*objContainer.scaleX+2*centerX),dragLimitX*objContainer.scaleX);
					objContainer.y = Math.min(Math.max(objContainer.y,-dragLimitY*objContainer.scaleY+2*centerY),dragLimitY*objContainer.scaleY);
				}
				if (btn_ZoomOut.clicked){
					if (objContainer.scaleX > scaleMin){
						objContainer.x = centerX + (objContainer.x - centerX)*((objContainer.scaleX - scaleSpeed)/objContainer.scaleX)
						objContainer.y = centerY + (objContainer.y - centerY)*((objContainer.scaleY - scaleSpeed)/objContainer.scaleY)
					}
					objContainer.scaleX = objContainer.scaleY = Math.max(objContainer.scaleX - scaleSpeed, scaleMin);
					objContainer.x = Math.min(Math.max(objContainer.x,-dragLimitX*objContainer.scaleX+2*centerX),dragLimitX*objContainer.scaleX);
					objContainer.y = Math.min(Math.max(objContainer.y,-dragLimitY*objContainer.scaleY+2*centerY),dragLimitY*objContainer.scaleY);
				}
			}
		}

	}
	
}
