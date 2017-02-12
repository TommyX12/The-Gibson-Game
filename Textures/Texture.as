package Textures {
	
	import flash.utils.Dictionary;
	import flash.display.Bitmap;
	
	public class Texture {
		
		[Embed(source="wall.png")]
        private static const Wall:Class;
		[Embed(source="floor.png")]
        private static const Floor:Class;
		[Embed(source="corner.png")]
        private static const Corner:Class;
		[Embed(source="door.png")]
        private static const Door:Class;
		[Embed(source="Buttons/newRoom.png")]
        private static const Btn_NewRoom:Class;
		[Embed(source="Buttons/cancel.png")]
        private static const Btn_Cancel:Class;
		[Embed(source="Buttons/confirm.png")]
        private static const Btn_Confirm:Class;
		[Embed(source="Buttons/zoomIn.png")]
        private static const Btn_ZoomIn:Class;
		[Embed(source="Buttons/zoomOut.png")]
        private static const Btn_ZoomOut:Class;
		
		public static function getTexture(name:String):Bitmap
		{
			return new Texture[name]();
		}

	}
	
}
