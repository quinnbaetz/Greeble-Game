package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import flash.utils.Timer;
	import flash.text.*
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author Gavin
	 * TimerBar is the HUD class, misnomer I'm too lazy to correct
	 */
	public class TimerBar extends Sprite
	{
		[Embed(source = "img/blue_pl_fuel.gif")]
		public static const blue_pl_fuel:Class;
		[Embed(source = "img/green_pl_fuel.gif")]
		public static const green_pl_fuel:Class;
		[Embed(source = "img/home_pl_fuel.gif")]
		public static const home_pl_fuel:Class;
		[Embed(source = "img/red_pl_fuel.gif")]
		public static const red_pl_fuel:Class;
		public var container:MovieClip;
		public var fuelHUD:Bitmap;
		public var barMeasure:Sprite;
		public var myTimer:Timer;
		public var timeLabel:TextField;
		public var colour:String;
		public var timeDone:Boolean = false;
		private var pl_fuel:Bitmap;
		[Embed(source = "img/fuelWindow.gif")]
		public static const fuelWindow:Class;
		
		
		
		public function TimerBar(starColour:String)
		{
			
			//barBorder = new Sprite();
			fuelHUD = new fuelWindow();
			myTimer = new Timer(1000, 64);
			/**
			barBorder.graphics.beginFill(0xFFFFFF);
			barBorder.graphics.drawRect(0, 0, 100, 30);
			barBorder.x = 650;
			barBorder.y = 540;
			barBorder.graphics.endFill();
			barBorder.alpha = .5;
			**/
			fuelHUD.x = 645;
			fuelHUD.y = 450;
			barMeasure = new Sprite();
			barMeasure.graphics.beginFill(0xFFFFFF);
			barMeasure.graphics.drawRect(0, 0, 17, 1);
			barMeasure.x = 740;
			barMeasure.y = 464;
			barMeasure.graphics.endFill();
			colour = starColour;
			setupPlanetDisp();
			//addChild(barBorder);
			pl_fuel.x = 650;
			pl_fuel.y = 460;
			container = new MovieClip();
			addChild(container);
			container.addChild(pl_fuel);
			container.addChild(fuelHUD);
			container.addChild(barMeasure);
			initLabel();
			myTimer.start();
			myTimer.addEventListener(TimerEvent.TIMER, tweenBar, false, 0, true);
			
		}
		public function stopTween():void{
			myTimer.stop();
		}
		private function setupPlanetDisp():void
		{
			if (colour == "blue")
			{
				pl_fuel = new blue_pl_fuel();
			}
			if (colour == "green")
			{
				pl_fuel = new green_pl_fuel();
			}
			if (colour == "home")
			{
				pl_fuel = new home_pl_fuel();
			}
			if (colour == "red")
			{
				pl_fuel = new red_pl_fuel();
			}
		}
		
		private function initLabel():void
		{
			
			timeLabel = new TextField();
			timeLabel = helper_functions.formatText(timeLabel, 14, 0x00, "Verdana");
			if (colour == "blue")
			{
				timeLabel.text = ("Caerulea");
			}
			if (colour == "green")
			{
				timeLabel.text = ("Pratina");
			}
			if (colour == "home")
			{
				timeLabel.text = ("Doma");
			}
			if (colour == "red")
			{
				timeLabel.text = ("Rubra");
			}
			
			timeLabel.x = 646;
			timeLabel.y = 533;
			container.addChild(timeLabel);
			
		}
		
		private function tweenBar(e:TimerEvent):void
		{
			var height:int = barMeasure.height;
			height++;
			TweenLite.to(barMeasure, 1, { height: height } );
			if (barMeasure.height == 63)
			{
				timeDone = true;
			}
			
		}
		
		

		
	}
	
}