package
{
	/**
	 * @mxmlc -library-path+=C:\Program Files (x86)\Adobe\Adobe Flash CS5.5\Common\First Run
	 */
	import Background;
	
	import Greeble;
	
	import TimeFlow;
	
	import com.greensock.*;
	
	import countingScene;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.GestureEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import helper_functions;
	
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
		[Embed(source="img/sepaLogo.png")]
		public static const sepaLogo:Class;
		[Embed(source="img/up_arrow.gif")]
		public static const arrow:Class;
		[Embed(source="img/intro1.gif")]
		public static const introBg1:Class;
		[Embed(source="img/intro2.gif")]
		public static const introBg2:Class;
		[Embed(source="img/neuron.png")]
		public static const neuronLogo:Class;
		[Embed(source="img/NIH_Logo.png")]
		public static const NIH_logo:Class;
		[Embed(source="img/imark.png")]
		public static const imark:Class;
		[Embed(source = "img/WhiteGif.gif")]
		public static const whiteSc:Class;
		[Embed(source = "img/TryAgain.gif")]
		public static const tryAgain:Class;
		[Embed(source = "img/GreenGif.gif")]
		public static const greenSc:Class;
		[Embed(source = "img/BlueGif.gif")]
		public static const blueSc:Class;
		[Embed(source = "img/RedGif.gif")]
		public static const redSc:Class;
		public var fadeLock:Boolean = false;
		public var scoreArray:Array = new Array();
		public var countScene:countingScene;
		
		
		//constant
		private static var KEY_CONTINUE:String = "\n\n[Press any key to continue]";
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
		
			var commMan:commBox;
			addChild(myBackground);
			addChild(myShip);
			var boxOutline:Sprite = new Sprite();
			helper_functions.drawBox(boxOutline, 0xFFFFFF, 133, 115, 0);
			var trainingTimer:TimerBar = new TimerBar("home");
			trainingTimer.stopTween();
			addChild(trainingTimer);
			var pArrow:point_Arrow = new point_Arrow(655, 500, 160);

			//Radio Text Here
			commMan = new commBox();
			commMan.x = 125;
			commMan.y = 80;
			addChild(commMan);
			//format text for the commBox
			var plBoxOutline:Sprite
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
				commText.text = "Before we get there, I’ll walk you through the mineral collection system I’ve added to the ship." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, drawOutline);
			}
			function drawOutline(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, drawOutline);
				boxOutline.x = 645;
				boxOutline.y = 450;
				addChild(pArrow);
				addChild(boxOutline);
				commText.text = "First, you’ll notice your ship’s fuel bar on the right side of the screen." + " Fuel runs out over time, so this bar lets you how much time you have left for collection." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, notFinalSpeech);
			}
			function notFinalSpeech(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, notFinalSpeech);
				removeChild(boxOutline);
				plBoxOutline = new Sprite();
				helper_functions.drawBox(plBoxOutline, 0xFFFFFF, 80, 25, 0);
				plBoxOutline.x = 645;
				plBoxOutline.y = 530;
				addChild(plBoxOutline);
				commText.text = "Next to the fuel bar is your location display, this will indicate what planet your ship is on." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, mouseSpeach);
				//More Radio Text Explainy Business Here
			}
			function mouseSpeach(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, mouseSpeach);
				removeChild(plBoxOutline);
				plBoxOutline = new Sprite();
				helper_functions.drawBox(plBoxOutline, 0xFFFFFF, 80, 25, 0);
				plBoxOutline.x = 645;
				plBoxOutline.y = 530;
				addChild(plBoxOutline);
				commText.text = "When you see a crystal, click it to fire the collection laser." + "\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, finalSpeech);
				//More Radio Text Explainy Business Here
			}
			
			function finalSpeech(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, finalSpeech);
				removeChild(pArrow);
				removeChild(plBoxOutline);
				commText.text = "Ok, you should be arriving at the crystal deposit now. Remember, we are only interested in RED crystals!"
				+ " Good Luck!" +"\n\n[Press any key to continue]";
				stage.addEventListener(KeyboardEvent.KEY_DOWN, removeOutline);
			}

			function removeOutline(e:KeyboardEvent):void
			{
				removeChild(commText);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, removeOutline);
				removeChild(commMan);
				removeChild(trainingTimer);
				var scoreArr:Array = new Array();
				trainingTimer = new TimerBar("home");
				
				var colors:Array = ["red", "blue", "green", "yellow", "orange", "brown"];
				var crystals: Array = [];
				for(var i:String in colors){
					var myGrb:Greeble = new Greeble(colors[i], "home");
					crystals.push(myGrb);
					addChild(myGrb);
				}
				
				//myGlowy7 = new Greeble("red");
			
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
						for(var i in crystals){
							crystals[i].stopCollecting();
						}
						tutOver.removeEventListener(TimerEvent.TIMER, tutorialOver);
						addChild(commMan);
						commText.text = "Looks like you've run out of fuel," + " head back to the lab to count the cargo." + "\n\n[Press any key to continue]";
						addChild(commText);
						TimeFlow.lockLazer = true;
						stage.addEventListener(KeyboardEvent.KEY_DOWN, exitTutorial);
						
						function exitTutorial(e: KeyboardEvent):void
						{
							TimeFlow.lockLazer = false;
							stage.removeEventListener(KeyboardEvent.KEY_DOWN, exitTutorial);
							removeChild(commMan);
							removeChild(commText);
							for(var i in crystals){
								scoreArray.push(crystals[i].returnArray());
								removeChild(crystals[i]);
							}
							
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
			
			var myShip:starShip = new starShip(stage);
			var myTimerBar:TimerBar = new TimerBar(planet);
			addChild(myScroller);
			var colors:Array = ["red", "blue", "green", "yellow", "orange", "brown"];
			var crystals: Array = [];
			for(var i in colors){
				var myGrb:Greeble = new Greeble(colors[i], planet);
				crystals.push(myGrb);
				addChild(myGrb);
			}
			addChild(myShip);
			addChild(myTimerBar);
			var tutOver:Timer = new Timer(2000, 0);
			tutOver.start();
			tutOver.addEventListener(TimerEvent.TIMER, tutorialOver);

			function tutorialOver(e:TimerEvent):void
			{
				if (myTimerBar.timeDone == true)
				{
					for(var i in crystals){
						crystals[i].stopCollecting();
					}
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
					commText.text = "Looks like you are almost out of fuel, head back to the lab to count the cargo" + "\n\n[Press any key to continue]";
					addChild(commText);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, exitPlanet);
					TimeFlow.lockLazer = true;
					

					function exitPlanet():void
					{
						TimeFlow.lockLazer = false;
						stage.removeEventListener(KeyboardEvent.KEY_DOWN, exitPlanet);
						removeChild(commMan);
						removeChild(commText);
						for(var i in crystals){
							scoreArray.push(crystals[i].returnArray());
							removeChild(crystals[i]);
						}
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
			imark.x = 655;
			imark.y = 415;
			addChild(imark);
			TweenLite.to(imark, 0, { width: 89, height:  115 } );
			TweenLite.to(nihLogo, 3, {delay: 3, alpha: 0});
			TweenLite.to(sepaLogo, 3, {delay: 3, alpha: 0});
			TweenLite.to(imark, 3, {delay: 3, alpha: 0});

			TweenLite.to(neuronLogo, 3, {delay: 3, alpha: 0, onComplete: transitionFunc});
			//end of display logo chunk

		}

		private function transitionFunc():void
		{
			var welcomeText:flash.text.TextField = new TextField();
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
			var hBox:Bitmap = new whiteSc();
			hBox.x = 0;
			hBox.y = 60;
			var hScore:TextField = new TextField();
			helper_functions.formatText(hScore, 5, 0x00, "Courier");
			hScore.x = 160;
			hScore.y = 158;
			hScore.width = 300;
			hScore.height = 50;
			hScore.text =  TimeFlow.getHomeScoreC + "                            " + TimeFlow.getHomeScore;

			var gBox:Bitmap = new greenSc();
			gBox.x = 400;
			gBox.y = 60;
			var gScore:TextField = new TextField();
			helper_functions.formatText(gScore, 5, 0x00, "Courier");
			gScore.x = 560;
			gScore.y = 158;
			gScore.width = 300;
			gScore.height = 50;
			gScore.text = TimeFlow.getGreenScoreC + "                            " + TimeFlow.getGreenScore;

			var bBox:Bitmap = new blueSc();
			bBox.x = 00;
			bBox.y = 230;
			var bScore:TextField = new TextField();
			helper_functions.formatText(bScore, 5, 0x00, "Courier");
			bScore.x = 160;
			bScore.y = 328;
			bScore.width = 300;
			bScore.height = 50;
			bScore.text = TimeFlow.getBlueScoreC + "                            " + TimeFlow.getBlueScore;

			var rBox:Bitmap = new redSc();
			rBox.x = 400;
			rBox.y = 230;
			var rScore:TextField = new TextField();
			helper_functions.formatText(rScore, 5, 0x00, "Courier");
			rScore.x = 560;
			rScore.y = 328;
			rScore.width = 300;
			rScore.height = 50;
			rScore.text = TimeFlow.getRedScoreC + "                            " + TimeFlow.getRedScore;

			/*makeScoreBox(hBox);
			makeScoreBox(gBox);
			makeScoreBox(bBox);
			makeScoreBox(rBox);*/
			addChild(hBox);
			addChild(gBox);
			addChild(bBox);
			addChild(rBox);
			TweenLite.to(hBox, 0, { alpha: .9 } );
			TweenLite.to(gBox, 0, { alpha: .9 } );
			TweenLite.to(bBox, 0, { alpha: .9 } );
			TweenLite.to(rBox, 0, { alpha: .9 } );
			addChild(hScore);
			addChild(bScore);
			addChild(rScore);
			addChild(gScore);
		}


		private function finalScene():void
		{
			var researchRoom:Bitmap = new introBg2();
			var replayButton:Bitmap;
			addChild(researchRoom);
			fadeIn();
			var rschText:TextField = new TextField();
			helper_functions.formatText(rschText, 16, 0, "Verdana");
			rschText.width = 400;
			rschText.height = 250;
			rschText.x = 320;
			rschText.y = 520;
			rschText.wordWrap = true;
			rschText.text = "Welcome back! We almost forgot about you out there..." + " Let's see what you have.. you did remember to just collect" + " the red crystals, right?"
			+ "\n[Press any key to continue]";
			addChild(rschText);
			popupScore();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, restartGame);
		
		 function restartGame(e:KeyboardEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, restartGame);
			replayButton = new tryAgain();
			removeChild(rschText);
			/*var restartBox:Sprite = new Sprite();
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
			addChild(restartText);*/
			addChild(replayButton);
			replayButton.x = 400;
			replayButton.y = 500;
			stage.addEventListener(MouseEvent.CLICK, replaySetup);
		}

		function replaySetup(e:MouseEvent):void
		{
			trace(mouseX);
			trace(mouseY);
			if (mouseX > 400 && mouseY > 500)
			{
				if (mouseX < 545 && mouseY < 560)
				{
					stage.removeEventListener(MouseEvent.CLICK, replaySetup);
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
			var researchText:flash.text.TextField = new TextField();
			researchText = helper_functions.formatText(researchText, 12, 0, "Verdana");
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
				researchText.text = "Your first assignment will be to visit each of the newly discovered" + " planets to bring back mineral crystal samples for us to analyze." + "\n\n[Press any key to continue]";
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
			var myComm:commBox = new commBox();
			myComm.x = 125;
			myComm.y = 30;
			if (TimeFlow.getTutorialState){
				addChild(myComm);
				//dialogue portion
				var commText:TextField = new TextField();
				var currentText:int = 0;
				commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
				commText.width = 250;
				commText.height = 200;
				commText.x = 356;
				commText.y = 125;
				commText.wordWrap = true;
				commText.text = "Let's see how you did." + KEY_CONTINUE;
				addChild(commText);
				
				
				var DialogText:Array = ["The crystals you collected are displayed along the top of this inventory screen." + KEY_CONTINUE,
							  "Any crystal that you didn’t pick up is displayed in the inventory display as a transparent icon." + KEY_CONTINUE,
							  "Use the calculation display to count up your cargo." + KEY_CONTINUE,
							  "Selection accuracy will tell us how good you were at picking up red crystals and avoiding the other colors..." + KEY_CONTINUE,
							  "Completion accuracy will tell us if you left any red crystals behind"  + KEY_CONTINUE];
				
				var nextText:Function = function(e:KeyboardEvent):void
				{
					currentText++;
					if(currentText < DialogText.length){
						commText.text = DialogText[currentText];
					}else{
						stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextText);
						removeChild(myComm);
						removeChild(commText);
					}
				}
					
				stage.addEventListener(KeyboardEvent.KEY_DOWN, nextText);
			}
		}
		
		private function displayErrMessage():void
		{
			TimeFlow.showIncorrect = false;
			var myCommer:commBox = new commBox();
			addChild(myCommer);
			myCommer.x = 125;
			myCommer.y = 30;
			var commText:TextField = new TextField();
			commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
			commText.width = 250;
			commText.height = 200;
			commText.x = 356;
			commText.y = 125;
			commText.wordWrap = true;
			commText.text = "Check your numbers again, the computer is giving an error message, make sure you counted all the crystals correctly.";
			addChild(commText);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, removeComm);
			function removeComm(e:KeyboardEvent):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, removeComm);
				
					removeChild(myCommer);
			
					removeChild(commText);
				
			}
		}
		
		private function popupSwitch():void
		{
			TimeFlow.showCorrect = false;
			var myComm:commBox = new commBox();
			myComm.x = 125;
			myComm.y = 30;
			addChild(myComm);
			var commText:TextField = new TextField();
			commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
			commText.width = 250;
			commText.height = 200;
			commText.x = 356;
			commText.y = 125;
			commText.wordWrap = true;
			commText.text = "Looks like you did a pretty good job! I think you are ready to head to the new planets and start searching for red crystals!" + "\n\n[Press any key to continue]";
			addChild(commText);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, changeVal);
			function changeVal(e:KeyboardEvent):void
			{
				TimeFlow.changeCount = true;
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, changeVal);
			}
		}

		private function changeScene(e:Event):void
		{
			if (Boolean(TimeFlow.displayIncorrect))
			{
				displayErrMessage();
			}
			if (Boolean(TimeFlow.displayCorrect))
			{
				popupSwitch();
			}
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
				//initMainPlay("green");
				//setupCountSc("home");
				//finalScene();
			}
			if (gameState == 1) {
				initGalaxyMap();
			}

		}

	}

}