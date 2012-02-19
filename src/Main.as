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
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.geom.Matrix;
	import com.greensock.*;
	import Background;
	import flash.text.TextField;
	import flash.ui.KeyLocation;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	import Greeble;
	import helper_functions;
	import countingScene;
	import TimeFlow;
	[SWF(width="800",height="600",backgroundColor="0x00")]
	
	/**
	 * ...
	 * @author Gavin
	 */
	
	public class Main extends Sprite
	{
		//private var startButt:Button
		//different integer codes to change game state
		private var gameState:int = 0;
		[Embed(source="sepaLogo.png")]
		public static const sepaLogo:Class;
		[Embed(source="up_arrow.gif")]
		public static const arrow:Class;
		[Embed(source="intro1.gif")]
		public static const introBg1:Class;
		[Embed(source="intro2.gif")]
		public static const introBg2:Class;
		[Embed(source="neuron.png")]
		public static const neuronLogo:Class;
		[Embed(source="NIH_Logo.png")]
		public static const NIH_logo:Class;
		[Embed(source="imark.png")]
		public static const imark:Class;
		public var fadeLock:Boolean = false;
		public var scoreArray:Array = new Array();
		public var countScene:countingScene;
		//for complete in galaxyMap
		private var R:Boolean = false;
		private var G:Boolean = false;
		private var B:Boolean = false;
		private var H:Boolean = false;
		
		public var firstPlay:Boolean = true;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function fadeIn():void
		{
			fadeLock = true;
			var fader:MovieClip = new MovieClip();
			fader.graphics.lineStyle(1, 0x00);
			fader.graphics.beginFill(0x00);
			fader.graphics.drawRect(0, 0, 800, 600);
			fader.graphics.endFill();
			addChild(fader);
			TweenLite.to(fader, 3, {alpha: 0, onComplete: removeFunc, onCompleteParams: [fader]});
		}
		
		private function removeFunc(fader:MovieClip):void
		{
			removeChild(fader);
			fadeLock = false;
		}
		
		//training
		private function tutorialSeq():void
		{
			removeEventListener(MouseEvent.CLICK, changePlay);
			firstPlay = false;
			var myBackground:Background = new Background("home");
			var myShip:starShip = new starShip(stage);
			var myGlowy:Greeble;
			var myGlowy2:Greeble;
			var myGlowy3:Greeble;
			var myGlowy4:Greeble;
			var myGlowy5:Greeble;
			var myGlowy6:Greeble;
			var myGlowy7:Greeble;
			var commMan:commBox;
			addChild(myBackground);
			addChild(myShip);
			var boxOutline:Sprite = new Sprite();
			helper_functions.drawBox(boxOutline, 0xFFFFFF, 133, 115, 0);
			var trainingTimer:TimerBar = new TimerBar("home");
			addChild(trainingTimer);
			var pArrow:point_Arrow = new point_Arrow(655, 500, 160);
			
			//Radio Text Here
			commMan = new commBox();
			commMan.x = 125;
			commMan.y = 80;
			addChild(commMan);
			//format text for the commBox
			var commText:TextField = new TextField();
			commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
			commText.width = 255;
			commText.height = 300;
			commText.x = 356;
			commText.y = 180;
			commText.wordWrap = true;
			commText.text = "Looks like they were right, you DO know how to fly that thing! There is a crystal deposit not too far from here." + "\n\n[Press any key to continue]";
			addChild(commText);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, nextText);
			function nextText(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextText);
				commText.text = "Before we get there I’ll walk you through the mineral collection system I’ve added to the ship." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, drawOutline);
			}
			function drawOutline(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, drawOutline);
				boxOutline.x = 645;
				boxOutline.y = 450;
				addChild(pArrow);
				addChild(boxOutline);
				commText.text = "First, you’ll notice your ship’s fuel bar on the left side of the screen." + " Fuel runs out over time, so this bar lets you how much time you have left for collection." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, finalSpeech);
			}
			function finalSpeech(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, finalSpeech);
				removeChild(pArrow);
				removeChild(boxOutline);
				commText.text = "Ok, you should be arriving at the crystal deposit now." + " Remember, we are only interested in RED Crystals! Don’t waste cargo space" + " by filling it with  with the other colors. Just Red!" + " Good Luck!" + "\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, removeOutline);
				//More Radio Text Explainy Business Here
			}
			
			function removeOutline(e:KeyboardEvent):void
			{
				removeChild(commText);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, removeOutline);
				removeChild(commMan);
				removeChild(trainingTimer);
				var scoreArr:Array = new Array();
				trainingTimer = new TimerBar("home");
				myGlowy = new Greeble("red", "home");
				myGlowy2 = new Greeble("blue", "home");
				myGlowy3 = new Greeble("green", "home");
				myGlowy4 = new Greeble("yellow", "home");
				myGlowy5 = new Greeble("orange", "home");
				myGlowy6 = new Greeble("brown", "home");
				//myGlowy7 = new Greeble("red");
				addChild(myGlowy);
				addChild(myGlowy2);
				addChild(myGlowy3);
				addChild(myGlowy4);
				addChild(myGlowy5);
				addChild(myGlowy6);
				removeChild(myShip);
				addChild(myShip);
				addChild(trainingTimer);
				//addChild(myGlowy7);
				var tutOver:Timer = new Timer(2000, 0);
				tutOver.start();
				tutOver.addEventListener(TimerEvent.TIMER, tutorialOver);
				
				function tutorialOver(e:TimerEvent):void
				{
					if (trainingTimer.timeDone == true)
					{
						tutOver.removeEventListener(TimerEvent.TIMER, tutorialOver);
						addChild(commMan);
						commText.text = "Oh no! Looks like you've run out of fuel for this trip." + " Let's see how well you did collecting the red crystals.";
						addChild(commText);
						TweenLite.to(commMan, 0, {alpha: 0, delay: 3});
						TweenLite.to(commText, 0, {alpha: 0, delay: 3, onComplete: exitTutorial});
						
						function exitTutorial():void
						{
							scoreArray.push(myGlowy.returnArray());
							removeChild(myGlowy);
							scoreArray.push(myGlowy2.returnArray());
							removeChild(myGlowy2);
							scoreArray.push(myGlowy3.returnArray());
							removeChild(myGlowy3);
							scoreArray.push(myGlowy4.returnArray());
							removeChild(myGlowy4);
							scoreArray.push(myGlowy5.returnArray());
							removeChild(myGlowy5);
							scoreArray.push(myGlowy6.returnArray());
							removeChild(myGlowy6);
							removeChild(trainingTimer);
							removeChild(myShip);
							removeChild(myBackground);
							tutOver.stop();
							//initGalaxyMap();
							setupCountSc("home");
						}
					}
				}
			
			}
		
		/*
		 * Reference Code -----
		   var bmpData:BitmapData = new BitmapData(800, 600);
		   var bmp:Bitmap = new Bitmap(bmpData);
		   addChild(bmp);
		   bmp.alpha = .5;
		   this.addEventListener(Event.ENTER_FRAME, genNoise);
		   function genNoise(e:Event):void
		   {
		   bmpData.noise(Math.floor(100000 * Math.random()), 0, 255, 0, true);
		
		   }
		
		   var myArrow:Bitmap = new arrow();
		   var tMatrix:Matrix = myArrow.transform.matrix;
		   tMatrix.scale(.16, .16);
		   myArrow.transform.matrix = tMatrix;
		 */
		}
		
		private function initMainPlay(planet:String):void
		{
			
			removeEventListener(MouseEvent.CLICK, changePlay);
			var myScroller:Background = new Background(planet);
			var scoreArr:Array = new Array();
			var myGlowy:Greeble = new Greeble("red", planet);
			var myGlowy2:Greeble = new Greeble("blue", planet);
			var myGlowy3:Greeble = new Greeble("green", planet);
			var myGlowy4:Greeble = new Greeble("yellow", planet);
			var myGlowy5:Greeble = new Greeble("orange", planet);
			var myGlowy6:Greeble = new Greeble("brown", planet);
			//var myGlowy7: Greeble = new Greeble("blue");
			var myShip:starShip = new starShip(stage);
			var myTimerBar:TimerBar = new TimerBar(planet);
			addChild(myScroller);
			addChild(myGlowy);
			addChild(myGlowy2);
			addChild(myGlowy3);
			addChild(myGlowy4);
			addChild(myGlowy5);
			addChild(myGlowy6);
			//addChild(myGlowy7);
			addChild(myShip);
			addChild(myTimerBar);
			var tutOver:Timer = new Timer(2000, 0);
			tutOver.start();
			tutOver.addEventListener(TimerEvent.TIMER, tutorialOver);
			
			function tutorialOver(e:TimerEvent):void
			{
				if (myTimerBar.timeDone == true)
				{
					var commMan:commBox = new commBox();
					commMan.x = 125;
					commMan.y = 80;
					addChild(commMan);
					//format text for the commBox
					var commText:TextField = new TextField();
					commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
					commText.width = 255;
					commText.height = 300;
					commText.x = 356;
					commText.y = 180;
					commText.wordWrap = true;
					tutOver.removeEventListener(TimerEvent.TIMER, tutorialOver);
					addChild(commMan);
					commText.text = "Oh no! Looks like you've run out of fuel for this trip." + " Let's see how well you did collecting the red crystals.";
					addChild(commText);
					TweenLite.to(commMan, 0, {alpha: 0, delay: 3});
					TweenLite.to(commText, 0, { alpha: 0, delay: 3, onComplete: exitPlanet } );
					
					function exitPlanet():void
					{
					scoreArray.push(myGlowy.returnArray());
					removeChild(myGlowy);
					scoreArray.push(myGlowy2.returnArray());
					removeChild(myGlowy2);
					scoreArray.push(myGlowy3.returnArray());
					removeChild(myGlowy3);
					scoreArray.push(myGlowy4.returnArray());
					removeChild(myGlowy4);
					scoreArray.push(myGlowy5.returnArray());
					removeChild(myGlowy5);
					scoreArray.push(myGlowy6.returnArray());
					removeChild(myGlowy6);
					removeChild(myTimerBar);
					removeChild(myShip);
					removeChild(myScroller);
					tutOver.stop();
					//initGalaxyMap();
					setupCountSc(planet);
					}
				}
			}
		
		}
		
		private function initWelcome():void
		{
			//gameState is zero
			/**
			   var welcomeButton:MovieClip = new MovieClip;
			   addChild(welcomeButton);
			   welcomeButton.graphics.lineStyle(3, 0xffffff);
			   welcomeButton.graphics.beginFill(0xffffff);
			   welcomeButton.graphics.drawRect(0, 0, 200, 50);
			   welcomeButton.graphics.endFill();
			   welcomeButton.x = 300;
			   welcomeButton.y = 250;
			   welcomeButton.addEventListener(MouseEvent.MOUSE_DOWN, changeState);
			 **/
			var introBG:Bitmap = new introBg1();
			addChild(introBG);
			fadeIn();
			//display Logos
			var neuronLogo:Bitmap = new neuronLogo();
			addChild(neuronLogo);
			neuronLogo.x = 500;
			neuronLogo.y = 200;
			var nihLogo:Bitmap = new NIH_logo();
			nihLogo.x = 500;
			nihLogo.y = 425;
			TweenLite.to(nihLogo, 0, {width: width / 8, height: height / 6});
			addChild(nihLogo);
			var sepaLogo:Bitmap = new sepaLogo();
			sepaLogo.x = 500;
			sepaLogo.y = 350;
			addChild(sepaLogo);
			var imark:Bitmap = new imark();
			imark.x = 650;
			imark.y = 450;
			addChild(imark);
			TweenLite.to(nihLogo, 3, {delay: 3, alpha: 0});
			TweenLite.to(sepaLogo, 3, {delay: 3, alpha: 0});
			TweenLite.to(imark, 3, {delay: 3, alpha: 0});
			TweenLite.to(neuronLogo, 3, {delay: 3, alpha: 0, onComplete: transitionFunc});
			//end of display logo chunk
		
		}
		
		private function transitionFunc():void
		{
			var welcomeText:TextField = new TextField();
			//format the text
			welcomeText = helper_functions.formatText(welcomeText, 12, 0x00, "Verdana");
			welcomeText.width = 275;
			welcomeText.height = 425;
			welcomeText.x = 500;
			welcomeText.y = 225;
			welcomeText.wordWrap = true;
			welcomeText.text = "Welcome to the Greeble Academy of Science!" + " Here at GAS, researchers are excited about a recent" + " announcement from the astronomy division: we discovered" + " three new star systems within range of our space ship !" + "\n\n As the newest scientist at the academy (and the only one who could figure out how to start the space ship) you are the first member of our planetary exploration team!" +
				
				"\n\n Report to the astronomy division to find out more about your first assignment. Good Luck!" + "\n\n\n [Press any key to continue]";
			
			addChild(welcomeText);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, changeState);
		
		}
		
		private function makeScoreBox(box:Sprite):void
		{
			box.graphics.beginFill(0xFFFFFF, .93);
			box.graphics.lineStyle(3, 0x00);
			box.graphics.drawRect(0, 0, 150, 150);
			box.graphics.endFill();
		}
		
		private function popupScore():void
		{
			var hBox:Sprite = new Sprite();
			hBox.x = 360;
			hBox.y = 60;
			var hScore:TextField = new TextField();
			helper_functions.formatText(hScore, 5, 0x00, "Courier");
			hScore.x = 370;
			hScore.y = 70;
			hScore.width = 125;
			hScore.height = 100;
			hScore.text = "Home Planet\n" + "Selection:\n " + TimeFlow.getHomeScore + "\n\n" + "Completion:\n " + TimeFlow.getHomeScoreC;
			
			var gBox:Sprite = new Sprite();
			gBox.x = 510;
			gBox.y = 60;
			var gScore:TextField = new TextField();
			helper_functions.formatText(gScore, 5, 0x00, "Courier");
			gScore.x = 520;
			gScore.y = 70;
			gScore.width = 125;
			gScore.height = 100;
			gScore.text = "Green Planet\n" + "Selection:\n " + TimeFlow.getGreenScore + "\n\n" + "Completion:\n " + TimeFlow.getGreenScoreC;
			
			var bBox:Sprite = new Sprite();
			bBox.x = 510;
			bBox.y = 210;
			var bScore:TextField = new TextField();
			helper_functions.formatText(bScore, 5, 0x00, "Courier");
			bScore.x = 520;
			bScore.y = 220;
			bScore.width = 125;
			bScore.height = 100;
			bScore.text = "Blue Planet\n" + "Selection:\n " + TimeFlow.getBlueScore + "\n\n" + "Completion:\n " + TimeFlow.getBlueScoreC;
			
			var rBox:Sprite = new Sprite();
			rBox.x = 360;
			rBox.y = 210;
			var rScore:TextField = new TextField();
			helper_functions.formatText(rScore, 5, 0x00, "Courier");
			rScore.x = 370;
			rScore.y = 220;
			rScore.width = 125;
			rScore.height = 100;
			rScore.text = "Red Planet\n" + "Selection:\n " + TimeFlow.getRedScore + "\n\n" + "Completion:\n " + TimeFlow.getRedScoreC;
			
			makeScoreBox(hBox);
			makeScoreBox(gBox);
			makeScoreBox(bBox);
			makeScoreBox(rBox);
			addChild(hBox);
			addChild(gBox);
			addChild(bBox);
			addChild(rBox);
			addChild(hScore);
			addChild(bScore);
			addChild(rScore);
			addChild(gScore);
		}
		
		private function restartGame():void
		{
			var restartBox:Sprite = new Sprite();
			restartBox.graphics.beginFill(0xFFFFFF, .8);
			restartBox.graphics.lineStyle(3, 0x0);
			restartBox.graphics.drawRect(0, 0, 150, 50);
			restartBox.graphics.endFill();
			restartBox.x = 400;
			restartBox.y = 500;
			var restartText:TextField = new TextField();
			helper_functions.formatText(restartText, 10, 0x00, "Courier");
			restartText.text = "Replay";
			restartText.width = 150;
			restartText.height = 50;
			restartText.x = 440;
			restartText.y = 515;
			addChild(restartBox);
			addChild(restartText);
			addEventListener(MouseEvent.CLICK, replaySetup);
		}
		
		private function replaySetup(e:MouseEvent):void
		{
			if (mouseX > 400 && mouseY > 500)
			{
				if (mouseX < 550 && mouseY < 550)
				{
					removeEventListener(MouseEvent.CLICK, replaySetup);
					TimeFlow.allValues = 0;
					R = false;
					B = false;
					H = false;
					G = false;
					gameState = 0;
					initWelcome();
				}
			}
		}
		
		private function finalScene():void
		{
			var researchRoom:Bitmap = new introBg2();
			addChild(researchRoom);
			fadeIn();
			var rschText:TextField = new TextField();
			helper_functions.formatText(rschText, 16, 0, "Verdana");
			rschText.width = 400;
			rschText.height = 250;
			rschText.x = 320;
			rschText.y = 520;
			rschText.wordWrap = true;
			rschText.text = "Welcome back! We almost forgot about you out there..." + " Let's see what you have.. you did remember to just collect" + " the red crystals, right?";
			addChild(rschText);
			TweenLite.to(rschText, 3, {delay: 8, alpha: 0, onComplete: restartGame});
			popupScore();
		}
		
		private function initGalaxyMap():void
		{
			if (getChildByName("myMap") != null)
			{
				removeChild(myMap);
			}
			var myMap:galaxyMap = new galaxyMap(H, R, G, B);
			var welcomePrompt:Sprite = new Sprite();
			welcomePrompt.graphics.beginFill(0, .8);
			welcomePrompt.graphics.lineStyle(3, 0xFFFFFF);
			welcomePrompt.graphics.drawRect(0, 0, 375, 25);
			welcomePrompt.graphics.endFill();
			welcomePrompt.x = 60;
			welcomePrompt.y = 60;
			//stage.focus = myMap;
			addChild(myMap);
			addChild(welcomePrompt);
			
			//text
			var welcomeText:TextField = new TextField();
			helper_functions.formatText(welcomeText, 3, 0xFFFFFF, "Courier");
			welcomeText.width = 385;
			welcomeText.height = 25;
			welcomeText.x = 60;
			welcomeText.y = 60;
			if (!H || !R || !G || !B)
			{
				welcomeText.text = "Welcome pilot, choose your destination...";
			}
			else
			{
				welcomeText.text = "Mission complete! Return to home planet.";
			}
			addChild(welcomeText);
			fadeIn();
			addEventListener(MouseEvent.CLICK, changePlay, false, 0, true);
		
		}
		
		private function changePlay(e:MouseEvent):void
		{
			//series of cumbersome if - else statements will ensue
			if (fadeLock == false)
			{
				if (mouseX > 565 && mouseX < 580)
				{
					if (mouseY > 180 && mouseY < 195)
					{
						if (firstPlay)
						{
							tutorialSeq();
							H = true;
						}
						else
						{
							if (R && G && B && H)
							{
								finalScene();
							}
							else
							{
								if (!H)
								{
									H = true;
									initMainPlay("home");
								}
							}
						}
					} // home if
				}
				if (mouseX > 430 && mouseX < 447)
				{
					if (mouseY > 192 && mouseY < 206)
					{
						if (firstPlay)
						{
							//do nothing
						}
						else if (R && G && B && H)
						{
							//nothing..
						}
						else
						{
							if (!R)
							{
								initMainPlay("red");
								R = true;
							}
						}
					}
				} // red if
				if (mouseX > 327 && mouseX < 346)
				{
					if (mouseY > 327 && mouseY < 346)
					{
						if (firstPlay)
						{
							//blank for now
						}
						else if (R && G && B && H)
						{
							//nothing
						}
						else
						{
							if (!G)
							{
								initMainPlay("green");
								G = true;
							}
						}
					}
				} //green if
				if (mouseX > 220 && mouseX < 239)
				{
					if (mouseY > 466 && mouseY < 485)
					{
						if (firstPlay)
						{
							//do nothing for now
						}
						else if (R && G && B && H)
						{
							//also do nothing
						}
						else
						{
							if (!B)
							{
								initMainPlay("blue");
								B = true;
							}
						}
					}
				} //blue if
				
			} // fadelock if
		}
		
		private function initResearchCenter():void
		{
			var introBg:Bitmap = new introBg2();
			addChild(introBg);
			fadeIn();
			var researchText:TextField = new TextField();
			helper_functions.formatText(researchText, 12, 0, "Verdana");
			researchText.width = 400;
			researchText.height = 250;
			researchText.x = 320;
			researchText.y = 500;
			researchText.wordWrap = true;
			researchText.text = "Welcome! I’m the lead researcher here in the" + " astronomy division and you must be our first recruit." + "\n\n[Press any key to continue]";
			addChild(researchText);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, nextDialogue);
			function nextDialogue(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextDialogue);
				researchText.text = "These new planets we’ve discovered are really interesting!" + " In our research, we determine the ages of planets by analyzing certain minerals." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, nextDialogue2);
			}
			function nextDialogue2(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextDialogue2);
				researchText.text = "Your first assignment will be to visit each of the newly discovered" + "planets to bring back mineral crystal samples for us to analyze." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, nextDialogue3);
			}
			function nextDialogue3(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextDialogue3);
				researchText.text = "But you can’t just go grabbing anything you want, we need RED crystals in order to complete our research!" + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, nextDialogue4);
			}
			function nextDialogue4(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextDialogue4);
				researchText.text = "These crystals seem to be common in the galaxy, so you should find some on each planet." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, nextDialogue5);
			}
			function nextDialogue5(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextDialogue5);
				researchText.text = "We even have some here! In fact, put on your space suit and jump" + " in the ship for a test flight, I’ll explain more on the way via radio..." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, changeStateMap);
			}
		
		}
		
		public function changeStateMap(e:KeyboardEvent):void
		{
			if (fadeLock == false)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, changeStateMap);
				//initGalaxyMap();
				//A bit of a hack here... change firstplay to false, and H to true. Immediately segway to tutorialSeq()
				firstPlay = false;
				H = true;
				tutorialSeq();
			}
		}
		
		public function changeState(e:KeyboardEvent):void
		{
			if (gameState == 0 && fadeLock == false)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, changeState);
				gameState = 1;
				initResearchCenter();
			}
		
		}
		
		private function setupCountSc(planet:String):void
		{
			countScene = new countingScene(scoreArray, planet);
			addChild(countScene);
			countScene.addEventListener(Event.ENTER_FRAME, changeScene);
		}
		
		private function changeScene(e:Event):void
		{
			if (Boolean(TimeFlow.getChangeCount))
			{
				TimeFlow.changeCount = false;
				removeChild(countScene);
				initGalaxyMap();
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			firstPlay = true;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			//initialize tutorialState?
			TimeFlow.tutorialState = true;
			if (gameState == 0){
				initWelcome();
				//initResearchCenter();
				//initGalaxyMap();
				//setupCountSc("home");
				//finalScene();
			}
			if (gameState == 1) {
				initGalaxyMap();
			}
		
		}
	
	}

}