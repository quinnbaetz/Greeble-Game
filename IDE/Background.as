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
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import Greeble;
	
	/**
	 * ...
	 * @author Gavin
	 */
	
	public class Background extends Sprite
	{
		public var container:MovieClip;
		public var backgroundHold:Bitmap;
		public var backgroundDisp:Bitmap;
		[Embed(source = "star-scroller-test.jpg")]
		public static const bGround:Class;
		
		public function Background() 
		{
			
			backgroundHold = new bGround();
			container = new MovieClip();
			addChild(container);
			var myMatrix:Matrix = backgroundHold.transform.matrix;
			container.addChild(backgroundHold);
			addEventListener(Event.ENTER_FRAME, scrollImage);
			container.y -= 640;
			
		}
			
			public function scrollImage(event:Event):void
		{
			
			//moveMatrix.ty += 1;
			if (container.y == 0) {
				container.y -= 640;
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