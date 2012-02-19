package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.transitions.Tween;
	import flash.transitions.easing.*
	
	/**
	 * ...
	 * @author Gavin
	 */
	/**
	 * @mxmlc -library-path+=C:\Program Files (x86)\Adobe\Adobe Flash CS5.5\Common\First Run\Classes
	 */
	public class Greeble extends Sprite
	{
		[Embed(source = "nyan.gif")]
		public static const glowBit:Class;
		public var myBit:Bitmap;
		public var container:MovieClip;
		public var myTimer:Timer;
		public var dead:int = 0;
		public var greebleTween:Tween;
		public var ldr:Loader;
		public var req:URLRequest;
		
		
		public function Greeble() 
		{
			container = new MovieClip();
			ldr = new Loader();
			req = new URLRequest("nyanmov.swf");
			ldr.load(req);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandle);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			container.addChild(ldr);
			/*
			addChild(container);
			myBit = new glowBit();
			var tMatrix:Matrix = myBit.transform.matrix;
			tMatrix.scale(.4, .4);
			myBit.transform.matrix = tMatrix;
			container.addChild(myBit);
			
			container.x = 700 * Math.random();
			container.y -= 600 * Math.random();
			*/
			addChild(container);
			container.x = 700 * Math.random();
			container.y = -500 * Math.random();
			//container.y = 500;
			container.addEventListener(MouseEvent.CLICK, goInvisible);
			addEventListener(Event.ENTER_FRAME, scrollMe);
		}
		
		
		private function goInvisible(e:MouseEvent):void
		{
			
			greebleTween = new Tween(ldr.content, "alpha", None.easeNone, 1, 0, 1, true);
			container.y = 580;
			
		}
		
		
		private function onCompleteHandler(e:Event):void
		{
			ldr.content.width = 75;
			ldr.content.height = 75;
		}
		
		private function ioErrorHandle(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		
		
		private function scrollMe(event:Event):void
		{
			container.y += 2;
			if(container.y > 600 && dead == 0)
			{
				container.x = 700 * Math.random();
				myTimer = new Timer(Math.random()*1000 + 20, 1);
				myTimer.start();
				myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, appear);
				dead = 1;
			}
		}
		
			
		private function appear(event:TimerEvent):void
		{
			container.y = -100;
			ldr.content.alpha = 1;
			dead = 0;
			myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, appear);
		}			
	}
		

}