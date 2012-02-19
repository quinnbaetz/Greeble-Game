package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	
	/**
	 * ...
	 * @author ...
	 */
	public class galaxyMap extends Sprite
	{
		[Embed(source = "blueBox.gif")]
		public static const blueBox:Class;
		[Embed(source = "blueLine.gif")]
		public static const blueLine:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/greenBox.gif")]
		public static const greenBox:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/greenLine.gif")]
		public static const greenLine:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/redBox.gif")]
		public static const redBox:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/redLine.gif")]
		public static const redLine:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/whiteBox.gif")]
		public static const homeBox:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/homeLine.gif")]
		public static const homeLine:Class;
		[Embed(source = "C:/Users/Gavin/NEURON/src/universeMap.jpg")]
		public static const universeMap:Class;
		
		public var container:MovieClip;
		public var myMap:Bitmap;
		public var myblueBox:Bitmap;
		public var myblueLine:Bitmap;
		public var myredBox:Bitmap;
		public var myredLine:Bitmap;
		public var mygreenBox:Bitmap;
		public var mygreenLine:Bitmap;
		public var myhomeBox:Bitmap;
		public var myhomeLine:Bitmap;
		public var galaxyText:TextField;
		private var complText:TextField;
		private var H:Boolean;
		private var R:Boolean;
		private var G:Boolean;
		private var B:Boolean;
		
		public function galaxyMap(H:Boolean, R:Boolean, G:Boolean, B:Boolean)
		{
			myMap = new universeMap();
			myblueBox = new blueBox();
			myblueLine = new blueLine();
			myredBox = new redBox();
			myredLine = new redLine();
			mygreenBox = new greenBox();
			mygreenLine = new greenLine();
			myhomeBox = new homeBox();
			myhomeLine = new homeLine();
			container = new MovieClip();
			container.addChild(myMap);
			//container.addEventListener(MouseEvent.CLICK, readOutMouse, false, 0, true);
			prepareInvisi();
			this.H = H;
			this.R = R;
			this.G = G;
			this.B = B;
			addCompleted();
			this.addChild(container);
			
		}
		
		private function addCompleted():void
		{
			complText = new TextField();
			complText = helper_functions.formatTextSpce(complText, 35, 0xFFFFFF, "Courier", 5);
			complText.text = "COMPLETED";
			complText.width = 200;
			complText.x = 560;
			complText.y = 400;
		}
		
		private function displayOverlayText(colour:String):void
		{
			//x = 535 and y = 490
			galaxyText = new TextField();
			galaxyText.x = 510;
			galaxyText.y = 500;
			galaxyText.width = 350;
			galaxyText.height = 300;
			helper_functions.formatText(galaxyText, 12, 0x00, "Courier");
			if (colour == "Red")
			{
				galaxyText.text = 
				"Name: Planet Rubra\n" +
				"Star class: M\n" +
				"Star color: 620-750 nm (Red)\n" +
				"Scans indicate the surface\n" +
				"has many deep canyons.";
				
			}
			if (colour == "Blue")
			{
				galaxyText.text = 
				"Name: Planet Caerulea\n" +
				"Star class: O\n" +
				"Star color: 450-457 nm (Blue)\n" +
				"A small rocky planet with\n" +
				"no detectable atmosphere";
			}
			if (colour == "Green")
			{
				galaxyText.text = 
				"Name: Planet Pratina\n" +
				"Star class: G\n" +
				"Star color: 570-590 nm\n(Yellow)\n" +
				"The surface is hidden by a\n" +
				"thick green haze";
			}
			if (colour == "Home")
			{
				galaxyText.text = 
				"Name: Planet Doma\n" +
				"Star class: A\n" +
				"Star color: 300-750nm (White)\n" +
				"The beloved home planet of\n" +
				"all Greeble kind.";
			}
			container.addChild(galaxyText);
		}
		
		private function readOutMouse(e:MouseEvent):void
		{
			//trace(mouseX);
			//trace(mouseY);
		}
		private function displayRed(e:MouseEvent):void
		{
			container.addChild(myredLine);
			container.addChild(myredBox);
			myredLine.x = 423;
			myredLine.y = 186;
			myredBox.x = 500;
			myredBox.y = 300;
			displayOverlayText("Red");
			if (R == true) { container.addChild(complText) }
		}
		private function hideRed(e:MouseEvent):void
		{
			if (R == true) { container.removeChild(complText) }
			container.removeChild(myredLine);
			container.removeChild(myredBox);
			container.removeChild(galaxyText);
		}
		private function displayBlue(e:MouseEvent):void
		{
			container.addChild(myblueLine);
			container.addChild(myblueBox);
			displayOverlayText("Blue");
			myblueLine.x = 215;
			myblueLine.y = 309;
			myblueBox.x = 500;
			myblueBox.y = 300;
			if (B == true) { container.addChild(complText) }
		}
		
		private function hideBlue(e:MouseEvent):void
		{
			container.removeChild(myblueBox);
			container.removeChild(myblueLine);
			container.removeChild(galaxyText);
			if (B == true) { container.removeChild(complText) }
		}
		
		private function displayGreen(e:MouseEvent):void
		{
			container.addChild(mygreenBox);
			container.addChild(mygreenLine);
			displayOverlayText("Green");
			mygreenLine.x = 321;
			mygreenLine.y = 309;
			mygreenBox.x = 500;
			mygreenBox.y = 300;
			if (G == true) { container.addChild(complText) }
		}
		
		private function displayHome(e:MouseEvent):void
		{
			container.addChild(myhomeBox);
			container.addChild(myhomeLine);
			displayOverlayText("Home");
			myhomeLine.x = 465;
			myhomeLine.y = 171;
			myhomeBox.x = 500;
			myhomeBox.y = 300;
			if (true) { container.addChild(complText) } //always the case
		}
		
		private function hideGreen(e:MouseEvent):void
		{
			container.removeChild(mygreenBox);
			container.removeChild(mygreenLine);
			container.removeChild(galaxyText);
			if (G == true) { container.removeChild(complText) }
		}
		
		private function hideHome(e:MouseEvent):void
		{
			container.removeChild(myhomeLine);
			container.removeChild(myhomeBox);
			container.removeChild(galaxyText);
			if (H == true) { container.removeChild(complText) }
		}
		
		private function prepareInvisi():void
		{
			var blueOver:MovieClip = new MovieClip();
			var redOver:MovieClip = new MovieClip();
			var greenOver:MovieClip = new MovieClip();
			var homeOver:MovieClip = new MovieClip();
			blueOver.graphics.beginFill(0xFFFFFF, 0);
			blueOver.graphics.drawRect(0, 0, 20, 20);
			blueOver.graphics.endFill();
			redOver.graphics.copyFrom(blueOver.graphics);
			greenOver.graphics.copyFrom(blueOver.graphics);
			homeOver.graphics.copyFrom(blueOver.graphics);
			homeOver.x = 561;
			homeOver.y = 175;
			redOver.x = 428;
			redOver.y = 190;
			greenOver.x = 326;
			greenOver.y = 327;
			blueOver.x = 220;
			blueOver.y = 466;
			container.addChild(blueOver);	
			container.addChild(homeOver);
			container.addChild(redOver);
			container.addChild(greenOver);
			blueOver.addEventListener(MouseEvent.MOUSE_OVER, displayBlue, false, 0, true);
			blueOver.addEventListener(MouseEvent.MOUSE_OUT, hideBlue,false, 0, true);
			redOver.addEventListener(MouseEvent.MOUSE_OVER, displayRed, false, 0, true);
			redOver.addEventListener(MouseEvent.MOUSE_OUT, hideRed, false, 0, true);
			greenOver.addEventListener(MouseEvent.MOUSE_OUT, hideGreen, false, 0, true);
			greenOver.addEventListener(MouseEvent.MOUSE_OVER, displayGreen, false, 0, true);
			homeOver.addEventListener(MouseEvent.MOUSE_OUT,hideHome, false, 0, true);
			homeOver.addEventListener(MouseEvent.MOUSE_OVER, displayHome, false, 0, true);
		}
		
	}
	
}