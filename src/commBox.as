package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
	import flash.events.TimerEvent;
    import flash.filters.DisplacementMapFilter;
    import flash.filters.DisplacementMapFilterMode;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	public class commBox extends Sprite
	{
		public var portrait:Bitmap;
		private var fuzzMin:int = 0;
		private var fuzzMax:int = 2;
		public var container:MovieClip;
		public var commBoxDisp:Bitmap;
		[Embed(source = "scientist.gif")]
		public static const scienceMan:Class;
		[Embed(source = "static.gif")]
		public static const staticMap:Class;
		[Embed(source = "commBox.gif")]
		public static const commBoxGif:Class;
		private var filter:DisplacementMapFilter = createDMFilter();
		public var intensityTimer:Timer;
		
		public function commBox()
		{
			container = new MovieClip();
			intensityTimer = new Timer(1200, 0);
			
			addChild(container);
			portrait = new scienceMan();
			commBoxDisp = new commBoxGif();
			portrait.filters = new Array(filter);
			commBoxDisp.x = 55;
			commBoxDisp.y = 68;
			container.addChild(commBoxDisp);
			container.addChild(portrait);
			addEventListener(Event.ENTER_FRAME, displayStatic, false, 0 , true);
			intensityTimer.start();
			intensityTimer.addEventListener(TimerEvent.TIMER, intStatic, false, 0, true);
		}
		
		private function createDMFilter():DisplacementMapFilter 
		{
			var mapBit:Bitmap = new staticMap(); 
            var mapBitmap:BitmapData = mapBit.bitmapData; // use the bitmap data from our StaticMap image
            var mapPoint:Point       = new Point(0, 0);  // this is the position of the StaticMap image in relation to our button
            var channels:uint        = BitmapDataChannel.RED; // which color to use for displacement
            var componentX:uint      = channels;
            var componentY:uint      = channels;
            var scaleX:Number        = 5; // the amount of horizontal shift
            var scaleY:Number        = 1; // the amount of vertical shift
            var mode:String          = DisplacementMapFilterMode.COLOR;
            var color:uint           = 0;
            var alpha:Number         = 0;
 
            return new DisplacementMapFilter(
                            mapBitmap,
                            mapPoint,
                            componentX,
                            componentY,
                            scaleX,
                            scaleY,
                            mode,
                            color,
                            alpha   );
 
        }
		
		private function randRange(min:int, max:int):int 
		{
			var randomNum:int = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		private function displayStatic(e:Event):void 
		{
			filter.scaleX = randRange(fuzzMin, fuzzMax);
			filter.mapPoint = new Point(0, randRange(0, -160));
			portrait.filters = new Array(filter);
		}
		
		private function intStatic(e:TimerEvent):void 
		{
			var newMin:int = randRange(0, 10);
			if (newMin < 5)
			{
				fuzzMin = 1;
				fuzzMax = 3;
			}
			if (newMin >= 5 && newMin < 8)
			{
				fuzzMin = 6;
				fuzzMax = 12;
			}
			if (newMin > 8)
			{
				fuzzMin = 18;
				fuzzMax = 28;
			}
			
		}
		
		
	}
	
}