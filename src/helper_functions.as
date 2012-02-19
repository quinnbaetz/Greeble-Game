package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.text.TextFormat;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	public class helper_functions
	{
		//assuming this is doable?
		[Embed(source = "bl_bl_grb.gif")]
		public static const bl_bl_grb:Class;
		[Embed(source = "bl_brwn_grb.gif")]
		public static const bl_brwn_grb:Class;
		[Embed(source = "bl_grb.gif")]
		public static const bl_grb:Class;
		[Embed(source = "bl_grn_grb.gif")]
		public static const bl_grn_grb:Class;
		[Embed(source = "bl_orng_grb.gif")]
		public static const bl_orng_grb:Class;
		[Embed(source = "bl_rd_grb.gif")]
		public static const bl_rd_grb:Class;
		[Embed(source = "bl_yllw_grb.gif")]
		public static const bl_yllw_grb:Class;
		[Embed(source = "brwn_grb.gif")]
		public static const brwn_grb:Class;
		[Embed(source = "grn_bl_grb.gif")]
		public static const grn_bl_grb:Class;
		[Embed(source = "grn_brwn_grb.gif")]
		public static const grn_brwn_grb:Class;
		[Embed(source = "grn_grb.gif")]
		public static const grn_grb:Class;
		[Embed(source = "grn_grn_grb.gif")]
		public static const grn_grn_grb:Class;
		[Embed(source = "grn_orng_grb.gif")]
		public static const grn_orng_grb:Class;
		[Embed(source = "grn_rd_grb.gif")]
		public static const grn_rd_grb:Class;
		[Embed(source = "grn_yllw_grb.gif")]
		public static const grn_yllw_grb:Class;
		[Embed(source = "orng_grb.gif")]
		public static const orng_grb:Class;
		[Embed(source = "rd_bl_grb.gif")]
		public static const rd_bl_grb:Class;
		[Embed(source = "rd_brwn_grb.gif")]
		public static const rd_brwn_grb:Class;
		[Embed(source = "rd_grb.gif")]
		public static const rd_grb:Class;
		[Embed(source = "rd_grn_grb.gif")]
		public static const rd_grn_grb:Class;
		[Embed(source = "rd_orng_grb.gif")]
		public static const rd_orng_grb:Class;
		[Embed(source = "rd_rd_grb.gif")]
		public static const rd_rd_grb:Class;
		[Embed(source = "rd_yllw_grb.gif")]
		public static const rd_yllw_grb:Class;
		[Embed(source = "yllw_grb.gif")]
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
		
		public static function formatText(myText:TextField, tSize:Number, colour:Number, reqFont:String):TextField
		{
			var format:flash.text.TextFormat = new TextFormat();
			//var font:Font;
			if (reqFont == "Courier")
			{
				format.font = "Courier";
			}
			if (reqFont == "Verdana")
			{
				format.font = "Verdana";
			}
			
			format.color = colour;
			format.bold = true;
			format.size = tSize;
			myText.defaultTextFormat = format;
			//myText.embedFonts = true;
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
			//myText.embedFonts = true;
			format.font = font;
			format.color = colour;
			format.bold = true;
			format.size = tSize;
			format.letterSpacing = spacing;
			myText.defaultTextFormat = format;
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
	}
	
}