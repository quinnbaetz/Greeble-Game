package  
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import helper_functions;
	
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author Gavin
	 */
	/**
	 * @mxmlc -library-path+=C:\Program Files (x86)\Adobe\Adobe Flash CS5.5\Common\First Run\Classes
	 */
	public class Greeble extends Sprite
	{
		//[Embed(source = "nyan.gif")]
		//public static const glowBit:Class;
		public var myBit:Bitmap;
		public var container:MovieClip;
		public var myTimer:Timer;
		public var dead:int = 0;
		//public var ldr:Loader;
		//public var req:URLRequest;
		public var frozen:Boolean = true;
		private var numCollected:int = 0;
		private var greebleType:String;
		private var planetType:String;
		private var myScore:Array;
		private var num_red:Number = 0;
		
		
		
		
		public function Greeble(colour:String, planet:String, type:String = "active") 
		{
			container = new MovieClip();
			planetType = planet;
			chooseGreeble(colour);
			addChild(container);
			container.addChild(myBit);
			
			//active is for the greebles that fall
			if(type === "active"){
				myScore = new Array();
				frozen = false;
				container.x = 700 * Math.random();
				container.y = -500 * Math.random();
				//container.y = 500;
				container.addEventListener(MouseEvent.CLICK, goInvisible, false, 0 , true);
				addEventListener(Event.ENTER_FRAME, scrollMe, false, 0, true);
			}
			
			
			/**
			ldr = new Loader();
			req = new URLRequest("nyanmov.swf");
			ldr.load(req);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandle);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			container.addChild(ldr);
			**/
			
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
			
			/**
			 * var colorTweak:ColorMatrixFilter;
			
			var matrix:Array = new Array();
			if (colour == "blue")
			{
			matrix=matrix.concat([0,1,0,0,0]);// red
			matrix=matrix.concat([0,0,1,0,0]);// green
			matrix=matrix.concat([1,0,0,0,0]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			colorTweak = new ColorMatrixFilter(matrix);
			container.filters = [colorTweak];
			}
			if (colour == "red")
			{
				
			matrix=matrix.concat([1,0,0,0,0]);// red
			matrix=matrix.concat([0,0,1,0,0]);// green
			matrix=matrix.concat([0,1,0,0,0]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			colorTweak = new ColorMatrixFilter(matrix);
			container.filters = [colorTweak];
			}
			
			**/
			
		}
		
		public function returnArray():Array
		{
			myScore.push(numCollected);
			myScore.push(num_red);
			return myScore;
		}
		
		
		private function chooseGreeble(colour:String):void
		{
			greebleType = colour;
			var colourMap:Object = {
				"blue"	: "bl_",
				"green" : "grn_",
				"red"	: "rd_",
				"brown" : "brwn_",
				"yellow" : "yllw_",
				"orange" : "orng_",
				"home"	: ""
			};
			//build up the name of the greeble constructor
			var greebleTypeFunc:String = colourMap[planetType] + colourMap[colour] + "grb";
			helper_functions.fTrace(greebleTypeFunc);
			if (colour == "red")
			{
				num_red++;
			}
			//create greeble of certain colour
			if(typeof helper_functions[greebleTypeFunc] !== "undefined"){
				myBit = new helper_functions[greebleTypeFunc]();
			}
		
		}
		/*
		private function chooseGreeble(colour:String):void
		{
			greebleType = colour;
			if (planetType == "blue")
			{
				bluedGreeble(colour);			
			}
			if (planetType == "green")
			{
				greenedGreeble(colour);
			}
			if (planetType == "red")
			{
				rededGreeble(colour);
			}
			if (planetType == "home")
			{
				normGreeble(colour);
			}
		}
		private function bluedGreeble(colour:String):void
		{
			if (colour == "blue")
			{
				myBit = new helper_functions.bl_bl_grb();
			}
			if (colour == "green")
			{
				myBit = new helper_functions.bl_grn_grb();
			}
			if (colour == "red")
			{
				num_red++;
				myBit = new helper_functions.bl_rd_grb();
			}
			if (colour == "brown")
			{
				myBit = new helper_functions.bl_brwn_grb();
			}
			if (colour == "yellow")
			{
				myBit = new helper_functions.bl_yllw_grb();
			}
			if (colour == "orange")
			{
				myBit = new helper_functions.bl_orng_grb();
			}
		}
		
		private function greenedGreeble(colour:String):void
		{
			if (colour == "blue")
			{
				myBit = new helper_functions.grn_bl_grb();
			}
			if (colour == "green")
			{
				myBit = new helper_functions.grn_grn_grb();
			}
			if (colour == "red")
			{
				num_red++;
				myBit = new helper_functions.grn_rd_grb();
			}
			if (colour == "brown")
			{
				myBit = new helper_functions.grn_brwn_grb();
			}
			if (colour == "yellow")
			{
				myBit = new helper_functions.grn_yllw_grb();
			}
			if (colour == "orange")
			{
				myBit = new helper_functions.grn_orng_grb();
			}
		}
		
		private function rededGreeble(colour:String):void
		{
			if (colour == "blue")
			{
				myBit = new helper_functions.rd_bl_grb();
			}
			if (colour == "green")
			{
				myBit = new helper_functions.rd_grn_grb();
			}
			if (colour == "red")
			{
				num_red++;
				myBit = new helper_functions.rd_rd_grb();
			}
			if (colour == "brown")
			{
				myBit = new helper_functions.rd_brwn_grb();
			}
			if (colour == "yellow")
			{
				myBit = new helper_functions.rd_yllw_grb();
			}
			if (colour == "orange")
			{
				myBit = new helper_functions.rd_orng_grb();
			}
		}
		
		private function normGreeble(colour:String):void
		{
			if (colour == "blue")
			{
				myBit = new helper_functions.bl_grb();
			}
			if (colour == "green")
			{
				myBit = new helper_functions.grn_grb();
			}
			if (colour == "red")
			{
				num_red++;
				myBit = new helper_functions.rd_grb();
			}
			if (colour == "brown")
			{
				myBit = new helper_functions.brwn_grb();
			}
			if (colour == "yellow")
			{
				myBit = new helper_functions.yllw_grb();
			}
			if (colour == "orange")
			{
				myBit = new helper_functions.orng_grb();
			}
		}
		*/
		private function goInvisible(e:MouseEvent):void
		{
			TweenLite.to(container, .5, { alpha:0, onComplete:tweenOver } );
			myScore.push(greebleType);
			numCollected++;
			frozen = true;
			
		}
		
		private function tweenOver():void
		{
			frozen = false;
			container.y = 580;
		}
		
		/**
		private function onCompleteHandler(e:Event):void
		{
			ldr.content.width = 75;
			ldr.content.height = 75;
		}
		**/
		
		private function ioErrorHandle(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		
		
		private function scrollMe(event:Event):void
		{
		    if (!frozen)
			{
			container.y += 2;
			}
			
		
			if(container.y > 600 && dead == 0)
			{
				container.x = 700 * Math.random();
				myTimer = new Timer(Math.random()*1000 + 20, 1);
				myTimer.start();
				myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, appear, false, 0, true);
				dead = 1;
			}
		
			
		}
		
			
		private function appear(event:TimerEvent):void
		{
			container.removeChild(myBit);
			chooseGreeble(helper_functions.genWord());
			container.y = -100;
			container.addChild(myBit);
			TweenLite.to(container, .1, { alpha:1 } );
			dead = 0;
			myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, appear);
		}			
	}
		

}