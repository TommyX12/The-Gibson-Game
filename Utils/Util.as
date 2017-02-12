package Utils {
	
	import flash.geom.*;
	public class Util {

		public function Util() {
			// constructor code
		}
		
		public static function getObject(array:Array,paramname:String,searchname):Object{
			var hh:int = -1
			for (var h:int = 0; h < array.length; h++){
				if (array[h][paramname] == searchname){hh = h; break;}
			}
			if (hh >= 0){
			return array[h];}
			else {return null}
		}
		
		public static function randomInt(max:int):int {
			return Math.min(Math.max(Math.floor(Math.random() * max),0),max-1)
		}

		public static function random(min:Number, max:Number):Number {
			return Math.random() * (max - min) + min;
		}

		public static function easeInQuad(t:Number, c:Number, d:Number):Number {
			c = (c*d*d)/(2*d-1)
			if (t > 0){
				return (c*(t/d)*(t/d)-(c*((t-1)/d)*((t-1)/d)))}
			else if (t < 0){
				return (-1*(c*(t/d)*(t/d)-(c*((t+1)/d)*((t+1)/d))))}
			else{
				return 0}
		};

		public static function rotDistance(start:Number,end:Number,useRadians:Boolean=false):Number{
			var cap:Number = useRadians ? Math.PI * 2 : 360;
			var dif:Number = (end - start) % cap;
			if (dif != dif % (cap / 2)) {
				dif = (dif < 0) ? dif + cap : dif - cap;
			}
			return dif
		}

		public static function getDistance(targetx:Number,targety:Number,fromx:Number=0,fromy:Number=0):Number{
			return Math.sqrt((targetx-fromx)*(targetx-fromx)+(targety-fromy)*(targety-fromy))
		}

		public static function getAngle(targetx:Number,targety:Number,fromx:Number=0,fromy:Number=0,radian:Boolean=false):Number{
			var dx:Number = targetx-fromx;  var dy:Number = targety-fromy;  var angle:Number = radian ? Math.atan2(dy,dx) : Math.atan2(dy,dx)*180/Math.PI
			return angle
		}

		public static function hitTestLine2Rect(p1:Point, p2:Point, r:Rectangle):Boolean{
				return hitTestLine2Line(p1, p2, new Point(r.x, r.y), new Point(r.x + r.width, r.y)) ||
					   hitTestLine2Line(p1, p2, new Point(r.x + r.width, r.y), new Point(r.x + r.width, r.y + r.height)) ||
					   hitTestLine2Line(p1, p2, new Point(r.x + r.width, r.y + r.height), new Point(r.x, r.y + r.height)) ||
					   hitTestLine2Line(p1, p2, new Point(r.x, r.y + r.height), new Point(r.x, r.y)) ||
					   (r.contains(p1.x,p1.y) && r.contains(p2.x,p2.y));
		}
		public static function hitTestLine2Line(l1p1:Point, l1p2:Point, l2p1:Point, l2p2:Point):Boolean{
				var q:Number = (l1p1.y - l2p1.y) * (l2p2.x - l2p1.x) - (l1p1.x - l2p1.x) * (l2p2.y - l2p1.y);
				var d:Number = (l1p2.x - l1p1.x) * (l2p2.y - l2p1.y) - (l1p2.y - l1p1.y) * (l2p2.x - l2p1.x);

				if( d == 0 )
				{
					return false;
				}

				var r:Number = q / d;

				q = (l1p1.y - l2p1.y) * (l1p2.x - l1p1.x) - (l1p1.x - l2p1.x) * (l1p2.y - l1p1.y);
				var s:Number = q / d;

				if( r < 0 || r > 1 || s < 0 || s > 1 )
				{
					return false;
				}

				return true;
		}
		
		public static function hitTestLine2Circle(Ax:Number,Ay:Number,Bx:Number,By:Number,Cx:Number,Cy:Number,R:Number):Boolean{
			// compute the euclidean distance between A and B
			var LAB:Number = Math.sqrt( (Bx-Ax)*(Bx-Ax)+(By-Ay)*(By-Ay) )

			// compute the direction vector D from A to B
			var Dx:Number = (Bx-Ax)/LAB
			var Dy:Number = (By-Ay)/LAB

			// Now the line equation is x = Dx*t + Ax, y = Dy*t + Ay with 0 <= t <= 1.

			// compute the value t of the closest point to the circle center (Cx, Cy)
			var t:Number = Dx*(Cx-Ax) + Dy*(Cy-Ay)    

			// This is the projection of C on the line from A to B.

			// compute the coordinates of the point E on line and closest to C
			var Ex:Number = t*Dx+Ax
			var Ey:Number = t*Dy+Ay

			// compute the euclidean distance from E to C
			var LEC:Number = Math.sqrt( (Ex-Cx)*(Ex-Cx)+(Ey-Cy)*(Ey-Cy) )

			// test if the line intersects the circle
			if( LEC < R )
			{
				return true;
			}
			
			return false;
		}
	}
	
}
