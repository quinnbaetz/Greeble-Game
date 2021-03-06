package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.external.ExternalInterface;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	public class helper_functions
	{
		[Embed(source='fonts/verdana.ttf', fontFamily = "verdana", mimeType='application/x-font', embedAsCFF="false")]
		public static const Greeble_Font:Class;
		//assuming this is doable?
		[Embed(source = "img/bl_bl_grb.gif")]
		public static const bl_bl_grb:Class;
		[Embed(source = "img/bl_brwn_grb.gif")]
		public static const bl_brwn_grb:Class;
		[Embed(source = "img/bl_grb.gif")]
		public static const bl_grb:Class;
		[Embed(source = "img/bl_grn_grb.gif")]
		public static const bl_grn_grb:Class;
		[Embed(source = "img/bl_orng_grb.gif")]
		public static const bl_orng_grb:Class;
		[Embed(source = "img/bl_rd_grb.gif")]
		public static const bl_rd_grb:Class;
		[Embed(source = "img/bl_yllw_grb.gif")]
		public static const bl_yllw_grb:Class;
		[Embed(source = "img/brwn_grb.gif")]
		public static const brwn_grb:Class;
		[Embed(source = "img/grn_bl_grb.gif")]
		public static const grn_bl_grb:Class;
		[Embed(source = "img/grn_brwn_grb.gif")]
		public static const grn_brwn_grb:Class;
		[Embed(source = "img/grn_grb.gif")]
		public static const grn_grb:Class;
		[Embed(source = "img/grn_grn_grb.gif")]
		public static const grn_grn_grb:Class;
		[Embed(source = "img/grn_orng_grb.gif")]
		public static const grn_orng_grb:Class;
		[Embed(source = "img/grn_rd_grb.gif")]
		public static const grn_rd_grb:Class;
		[Embed(source = "img/grn_yllw_grb.gif")]
		public static const grn_yllw_grb:Class;
		[Embed(source = "img/orng_grb.gif")]
		public static const orng_grb:Class;
		[Embed(source = "img/rd_bl_grb.gif")]
		public static const rd_bl_grb:Class;
		[Embed(source = "img/rd_brwn_grb.gif")]
		public static const rd_brwn_grb:Class;
		[Embed(source = "img/rd_grb.gif")]
		public static const rd_grb:Class;
		[Embed(source = "img/rd_grn_grb.gif")]
		public static const rd_grn_grb:Class;
		[Embed(source = "img/rd_orng_grb.gif")]
		public static const rd_orng_grb:Class;
		[Embed(source = "img/rd_rd_grb.gif")]
		public static const rd_rd_grb:Class;
		[Embed(source = "img/rd_yllw_grb.gif")]
		public static const rd_yllw_grb:Class;
		[Embed(source = "img/yllw_grb.gif")]
		public static const yllw_grb:Class;
		
		
		//[Embed(source="../src/Courier.ttf", fontFamily = "Courier", mimeType='application/x-font')]
		//public static var _courier:Class;
		//[Embed(source="../VERDANA.TTF", fontFamily = "Verdana", mimeType='application/x-font')]
		//public static var _verdana:Class;

		//takes a Sprite, assumes 0,0 relative draw...
		public static function drawBox(myBox:Sprite, colour:Number, width:Number, height:Number, outl_fl:Number):void
		{//outl_fl used as alpha (determines whether filled or not).
			myBox.graphics.beginFill(colour, outl_fl);
			myBox.graphics.lineStyle(3, 0xFF0000);
			myBox.graphics.drawRect(0, 0, width, height);
			myBox.graphics.endFill();
		}
		
		public static function makeInputBox():TextField
		{
			var format:TextFormat = new TextFormat();
			format.size = 24;
			var inputField:TextField = new TextField();
			format.align = "center";
			inputField.border = true;
			inputField.width = 35;
			inputField.height = 35;
			inputField.type = "input";
			inputField.defaultTextFormat = format;
			inputField.restrict = "0-9"
			return inputField;
		}
		
		public static function formatText(myText:flash.text.TextField, tSize:Number, colour:Number, reqFont:String):TextField
		{
			var myFont:Font = new Greeble_Font();
			var format:flash.text.TextFormat = new TextFormat(myFont.fontName, 12, colour);
			myText.embedFonts=true;
			myText.defaultTextFormat = format;
			//myText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
			
			return myText;
		}
		
		public static function formatTextSpce(myText:TextField, tSize:Number, colour:Number, font:String, spacing:Number):TextField
		{
			var format:flash.text.TextFormat = new TextFormat();
			if (font == "Courier")
			{
				format.font = "Courier"
			}
			if (font == "Verdana")
			{
				format.font = "Verdana"
			}
			myText.embedFonts = true;
			format.font = font;
			format.color = colour;
			format.bold = true;
			format.size = tSize;
			format.letterSpacing = spacing;
			myText.defaultTextFormat = format;
			myText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
			return myText;
		}
		
		//builds horizontal div line at pos (x,y)
		public static function drawDivLine(x:int, y:int, color:Number):MovieClip
		{
			var myLine:MovieClip = new MovieClip();
			myLine.graphics.clear();
			myLine.graphics.lineStyle(2, color); //line style
			myLine.graphics.moveTo(x, y);
			myLine.graphics.lineTo(x + 40, y);
			return myLine;
		}
		
		public static function genWord():String
		{
			var myNum:int = 160 * Math.random();
			if (myNum <= 60)
			{
				return "red";
			}
			if (myNum > 60 && myNum <= 80)
			{
				return "blue";
			}
			if (myNum > 80 && myNum <= 100)
			{
				return "green";
			}
			if (myNum > 100 && myNum <= 120)
			{
				return "brown";
			}
			if (myNum > 120 && myNum <= 140)
			{
				return "orange";
			}
			if (myNum > 140)
			{
				return "yellow";
			}
			return "";
		}
		public static function fTrace(...args):void{
			try{
				if(ExternalInterface.available){
					for(var i:Object in args){
						trace(args[i]);
						ExternalInterface.call("console.log", args[i]);
					}
				}
			}catch(e:Error){
				for(var k:Object in args){
					trace(args[k]);
				}
			}
		}
	}
	
}