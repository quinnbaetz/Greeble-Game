package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import com.greensock.*; 
	import com.greensock.easing.*;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import Greeble;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author Gavin
	 */
	
	public class Background extends Sprite
	{
		public var container:MovieClip;
		public var backgroundHold:Bitmap;
		//public var backgroundDisp:Bitmap;
		//[Embed(source = "star-scroller-test.jpg")]
		[Embed(source="greeble_plsurf_fix.gif")]
		public static const bGround:Class;
		
		
		public function Background(star:String) 
		{
			
			backgroundHold = new bGround();
			hueBackground(star);
			container = new MovieClip();
			addChild(container);
			var myMatrix:Matrix = backgroundHold.transform.matrix;
			container.addChild(backgroundHold);
			addEventListener(Event.ENTER_FRAME, scrollImage);
			container.y -= 3600;			
		}
		/**
		 * BLUE HUE = 006cff
		 * GREEN HUE = 00dd00
		 * RED HUE = ff0000
		**/
		private function hueBackground(star:String):void
		{
			//if home no HUE
			if (star == "blue")
			{
				TweenMax.to(backgroundHold, 0, {colorMatrixFilter: {colorize: 0x006cff, amount: 1 }} );
			}
			if (star == "red")
			{
				TweenMax.to(backgroundHold, 0, {colorMatrixFilter: {colorize: 0xff0000, amount: 1 }} );
			}
			if (star == "green")
			{
				TweenMax.to(backgroundHold, 0, {colorMatrixFilter: {colorize: 0x00dd00, amount: 1 }} );
			}
		}
			
			public function scrollImage(event:Event):void
		{
			
			//moveMatrix.ty += 1;
			if (container.y == 0) {
				container.y -= 3600;
			}
			container.y += 2;
			
		}
		
		/*
		public function loadImage(path:String):void
		{
			var _loader:Loader = new Loader();
			var _loaderToLoad:URLRequest = new URLRequest(path);
			_loader.load(_loaderToLoad);
		    _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded, false, 0 , true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		public function imageLoaded(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, imageLoaded);
			addChild(event.target.content);
		}
		
		public function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("Unable to load image");
		}
		*/
	
		
	}

}