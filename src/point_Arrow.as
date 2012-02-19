package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import com.greensock.TweenLite;
	import flash.utils.Timer;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	public class point_Arrow extends Sprite 
	{
		[Embed(source = "up_arrow.gif")]
		public static const upArrow:Class;
		private var myArrow:Bitmap;
		public var container:MovieClip;
		public var tMatrix:Matrix;
		public var resMatrix:Matrix;
		public var arrDynTimer:Timer;
		private var numCount:int = 0;
		
		public function point_Arrow(x:int, y:int, degree:Number)
		{
			
			myArrow = new upArrow();
			arrDynTimer = new Timer(1050, 0);
			tMatrix = myArrow.transform.matrix;
			resMatrix = tMatrix;
			tMatrix.scale(.18, .18);
			tMatrix.rotate(degree);
			myArrow.transform.matrix = tMatrix;
			container = new MovieClip();
			container.x = x;
			container.y = y;
			container.addChild(myArrow);
			arrDynTimer.start();
			TweenLite.to(container, 1, { x:x + 20, rotation:container.rotation - 20, onComplete: reset} );
			arrDynTimer.addEventListener(TimerEvent.TIMER, motionTo);
			addChild(container);
		}
		private function reset():void
		{
			
			container.x -= 20;
			container.rotation += 20;
		}
		
		private function motionTo(e:TimerEvent):void
		{
			
			TweenLite.to(container, 1, {x: container.x+20, rotation:container.rotation - 20, onComplete: reset} );
		
		}
		
	}
	
}