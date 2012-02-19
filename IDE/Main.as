package 
{
	/**
	 * @mxmlc -library-path+=C:\Program Files (x86)\Adobe\Adobe Flash CS5.5\Common\First Run
	 */
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import Background;
	import flash.utils.Timer;
	import Greeble;
	[SWF(width="800", height="600")]
	/**
	 * ...
	 * @author Gavin
	 */
	public class Main extends Sprite 
	{
			public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//Hi Cathy :) <3
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var myScroller:Background = new Background();
			var myGlowy:Greeble = new Greeble();
			var myGlowy2:Greeble = new Greeble();
			var myGlowy3: Greeble = new Greeble();
			var myGlowy4: Greeble = new Greeble();
			var myGlowy5: Greeble = new Greeble();
			var myGlowy6: Greeble = new Greeble();
			var myGlowy7: Greeble = new Greeble();
			var myShip: starShip = new starShip(stage);
			addChild(myScroller);
			addChild(myGlowy);
			addChild(myGlowy2);
			addChild(myGlowy3);
			addChild(myGlowy4);
			addChild(myGlowy5);
			addChild(myGlowy6);
			addChild(myGlowy7);
			addChild(myShip);
	
		
		}
		
	}
	
}