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
	import com.greensock.TweenLite;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	
	
	public class starShip extends Sprite 
	{
		[Embed(source = "img/spaceShip_lzr.gif")]
		public static const g_laserShip:Class;
		[Embed(source = "img/spaceShip.gif")]
		public static const g_Ship:Class;
		//public var entryLzrFixer:Boolean = false;
		public var refStage:Stage;
		public var myshipBit:Bitmap;
		public var shipSprite:Sprite;
		public var myshipbit_Lzr:Bitmap;
		public var container:MovieClip;
		public var shipTimer:Timer;
		public var laserbeam1:MovieClip;
		public var laserbeam2:MovieClip;
		public var laserOn:Boolean;
		public var lockLzr:Boolean = true;
		
		public function starShip(stage:Stage)
		{
		container = new MovieClip();
		laserbeam1 = new MovieClip();
		laserbeam2 = new MovieClip();
		shipSprite = new Sprite();
		refStage = stage;
		addChild(laserbeam1);
		addChild(laserbeam2);
		myshipBit = new g_Ship();
		myshipbit_Lzr = new g_laserShip();
		//var matrix:Matrix = myshipBit.transform.matrix;
		//matrix.scale(.5, .5);
		//myshipBit.transform.matrix = matrix;
		container.addChild(myshipBit);
		//var matrix:Matrix = myshipbit_Lzr.transform.matrix;
		//matrix.scale(.5, .5);
		//myshipbit_Lzr.transform.matrix = matrix;
		container.x = 350;
		container.y = 488;
		addChildAt(container, 0);
		TweenLite.to(myshipBit, 0, { width: width * 2, height: height * 2 } );
		TweenLite.to(myshipBit, 3, { width: width / 2, height: height / 2, onComplete: unlockMe} );
		addEventListener(Event.ENTER_FRAME, mouseFollow, false, 0 , true);
		addEventListener(Event.ENTER_FRAME, headTension, false, 0, true);
		refStage.addEventListener(MouseEvent.CLICK, laserEyes, false, 0, true);
		}
		
		private function unlockMe():void
		{
			lockLzr = false;		
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
			if (laserOn != true && refStage != null)
			{
			if (Math.abs(refStage.mouseX - container.x) > 20)
			{
				if (refStage.mouseX < container.x)
				{
					container.x -= 5;
				}
				
				if (refStage.mouseX > container.x)
				{
					container.x += 5;
				}
			}
			}
		}
		
		private function drawLaser():void
		{
			laserbeam1.graphics.clear();
			laserbeam1.graphics.lineStyle(4, 0xFF6512); //line style prev:0xF52727
			laserbeam1.graphics.moveTo(container.x + 10, container.y + 25);
			laserbeam1.graphics.lineTo(refStage.mouseX, refStage.mouseY);
			var glowy:GlowFilter = new GlowFilter();
			glowy.color = 0xFF2200;
			glowy.blurX = 4;
			glowy.blurY = 4;
			glowy.quality = 6;
			glowy.alpha = 0.3;
			var filtersArray:Array = new Array(glowy);
			laserbeam1.filters = filtersArray;
			laserbeam2.graphics.clear();
			laserbeam2.graphics.lineStyle(4, 0xFF6512); //line style
			laserbeam2.filters = filtersArray;
			laserbeam2.graphics.moveTo(container.x + 150, container.y + 25);
			laserbeam2.graphics.lineTo(refStage.mouseX, refStage.mouseY);			
			
		}
	
	
		private function laserEyes(e:MouseEvent):void
		{
			if (lockLzr == false)
			{
			container.addChildAt(myshipbit_Lzr, 1);
			shipTimer = new Timer(300, 1);
			shipTimer.start();
			laserOn = true;
			drawLaser();
			shipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, deLzr, false, 0 , true);
			}
		}
	
		private function deLzr(e:TimerEvent):void
		{
			shipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, deLzr, false);
			container.removeChildAt(1);
			laserOn = false;
			laserbeam1.graphics.clear();
			laserbeam2.graphics.clear();
		}
	}
	
}