package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	
	
	public class starShip extends Sprite 
	{
		[Embed(source="laser_head.gif")]
		public static const g_laserShip:Class;
		[Embed(source="smiling_head.gif")]
		public static const g_Ship:Class;
		public var myshipBit:Bitmap;
		public var myshipbit_Lzr:Bitmap;
		public var container:MovieClip;
		public var shipTimer:Timer;
		public var laserbeam1:MovieClip;
		public var laserbeam2:MovieClip;
		public var laserOn:Boolean;
		
		public function starShip(stage:Stage)
		{
		container = new MovieClip();
		laserbeam1 = new MovieClip();
		laserbeam2 = new MovieClip();
		addChild(laserbeam1);
		addChild(laserbeam2);
		myshipBit = new g_Ship();
		myshipbit_Lzr = new g_laserShip();
		var matrix:Matrix = myshipBit.transform.matrix;
		matrix.scale(.5, .5);
		myshipBit.transform.matrix = matrix;
		matrix = myshipbit_Lzr.transform.matrix;
		matrix.scale(.5, .5);
		myshipbit_Lzr.transform.matrix = matrix;
		container.x = 350;
		container.y = 475;
		container.addChild(myshipBit);
		addChildAt(container, 0);
		stage.addEventListener(MouseEvent.CLICK, laserEyes);
		addEventListener(Event.ENTER_FRAME, mouseFollow);
		addEventListener(Event.ENTER_FRAME, headTension);
		}
		
		private function headTension(e:Event):void
		{
			if (laserOn != true)
			{
			if (container.x > 350 || container.x < 350)
			{
				//computer container distance
				var distance:int = Math.abs(container.x - 350);
				//modify distance
				distance = distance * .1;
				if (container.x > 350)
				{
					container.x -= distance;
				}
				if (container.x < 350)
				{
					container.x += distance;
				}
			}
			}
		}
		
		private function mouseFollow(e:Event):void
		{
			if (laserOn != true)
			{
			if (Math.abs(stage.mouseX - container.x) > 20)
			{
				if (stage.mouseX < container.x)
				{
					container.x -= 5;
				}
				
				if (stage.mouseX > container.x)
				{
					container.x += 5;
				}
			}
			}
		}
		
		private function drawLaser():void
		{
			laserbeam1.graphics.clear();
			laserbeam1.graphics.lineStyle(4, 0xF52727); //line style
			laserbeam1.graphics.moveTo(container.x + 30, container.y + 50);
			laserbeam1.graphics.lineTo(stage.mouseX, stage.mouseY);
			var glowy:GlowFilter = new GlowFilter();
			glowy.color = 0xFF2200;
			glowy.blurX = 4;
			glowy.blurY = 4;
			glowy.quality = 6;
			glowy.alpha = 0.3;
			var filtersArray:Array = new Array(glowy);
			laserbeam1.filters = filtersArray;
			laserbeam2.graphics.clear();
			laserbeam2.graphics.lineStyle(4, 0xF52727); //line style
			laserbeam2.filters = filtersArray;
			laserbeam2.graphics.moveTo(container.x + 65, container.y + 50);
			laserbeam2.graphics.lineTo(stage.mouseX, stage.mouseY);			
			
		}
	
	
		private function laserEyes(e:MouseEvent):void
		{
			container.addChildAt(myshipbit_Lzr, 1);
			shipTimer = new Timer(300, 1);
			shipTimer.start();
			laserOn = true;
			drawLaser();
			shipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, deLzr);
		}
	
		private function deLzr(e:TimerEvent):void
		{
			shipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, deLzr);
			container.removeChildAt(1);
			laserOn = false;
			laserbeam1.graphics.clear();
			laserbeam2.graphics.clear();
		}
	}
	
}