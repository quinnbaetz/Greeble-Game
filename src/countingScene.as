package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import helper_functions;
	import TimeFlow;
	import commBox;
	import com.greensock.*;
	/**
	 * ...
	 * @author ...
	 */
	[SWF(width="800",height="600",backgroundColor="0x00")]
	
	public class countingScene extends Sprite
	{
		[Embed(source = "img/CheckScoreDown.gif")]
		public static const chkSc_down:Class;
		[Embed(source = "img/checkScoreUp.gif")]
		public static const chkSc_Up:Class;
		[Embed(source = "img/Correct.gif")]
		public static const crrct_img:Class;
		[Embed(source = "img/countingMenu.gif")]
		public static const cntMenu:Class;
		[Embed(source = "img/Incorrect.gif")]
		public static const inc_img:Class;
		
		//constant
		private static var KEY_CONTINUE:String = "\n\n[Press any key to continue]";
		
		private var chkDwn1:Bitmap;
		private var chkUp1:Bitmap;
		private var chkUp2:Bitmap;
		private var correct:Bitmap;
		private var correct2:Bitmap;
		private var incorrect:Bitmap;
		private var incorrect2:Bitmap;
		private var cntInfce:Bitmap;
		private var container:MovieClip;
		private var collected_cm:TextField;
		private var total_cm:TextField;
		private var percent_cm:TextField;
		private var collected_se:TextField;
		private var total_se:TextField;
		private var percent_se:TextField;
		private var isDone:int = 0;
		private var isDone2:int = 0;
		private var buttonClick:int = 0;
		private var myComm:commBox;
		
		private var scoreCnt:Array;
		private var num_red:Number = 0;
		private var num_green:Number = 0;
		private var num_yellow:Number = 0;
		private var num_blue:Number = 0;
		private var num_orange:Number = 0;
		private var num_brown:Number = 0;
		private var total_red:Number = 0;
		private var total_collected:int = 0;
		private var thisPlanet:String;
		
		private function setupInput():void
		{
			
			addEventListener(MouseEvent.CLICK, readOutMouse);
			function readOutMouse(e:MouseEvent):void
			{
				//trace(mouseX);
				//trace(mouseY);
			}
			
			//completion score
			collected_cm = helper_functions.makeInputBox();
			collected_cm.x = 215;
			collected_cm.y = 285;
			container.addChild(collected_cm);
			
			total_cm = helper_functions.makeInputBox();
			total_cm.x = 215;
			total_cm.y = 336;
			container.addChild(total_cm);
			
			percent_cm = new TextField();
			percent_cm = helper_functions.formatText(percent_cm, 12, 0x00, "null");
			percent_cm.width = 50;
			percent_cm.x = 465;
			percent_cm.y = 315;
			//container.addChild(percent_cm);
			
			//selection score
			collected_se = helper_functions.makeInputBox();
			collected_se.x = 215;
			collected_se.y = 456;
			container.addChild(collected_se);
			
			total_se = helper_functions.makeInputBox();
			total_se.x = 215;
			total_se.y = 507;
			container.addChild(total_se);
			
			percent_se = new TextField();
			percent_se = helper_functions.formatText(percent_se, 12, 0x00, "booboo");
			percent_se.width = 50;
			percent_se.x = 465;
			percent_se.y = 488;
			//container.addChild(percent_se);
		}
		
		private function countingDialogue():void
		{
			container.addChild(myComm);
			//dialogue portion
			var commText:TextField = new TextField();
			commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
			commText.width = 250;
			commText.height = 200;
			commText.x = 356;
			commText.y = 125;
			commText.wordWrap = true;
			commText.text = "Let's see how you did." + KEY_CONTINUE;
			container.addChild(commText);
			addEventListener(KeyboardEvent.KEY_DOWN, nextText);
			
			function nextText(e:KeyboardEvent):void
			{
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText);
				addEventListener(KeyboardEvent.KEY_DOWN, nextText2);
				commText.text = "The crystals you collected are displayed along the top of this inventory screen." + KEY_CONTINUE;
			}
			
			function nextText2(e:KeyboardEvent):void
			{
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText2);
				addEventListener(KeyboardEvent.KEY_DOWN, nextText3);
				commText.text = "Any crystal that you didn’t pick up is displayed in the inventory display as a transparent icon." + KEY_CONTINUE;
			
			}
			
			function nextText3(e:KeyboardEvent):void
			{
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText3);
				addEventListener(KeyboardEvent.KEY_DOWN, nextText4);
				commText.text = "Use the calculation display to count up your cargo." + KEY_CONTINUE;
			}
			function nextText4(e:KeyboardEvent):void
			{
				addEventListener(KeyboardEvent.KEY_DOWN, nextText5);
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText4);
				commText.text = "Selection accuracy will tell us how good you were at picking up red crystals and avoiding the other colors..." + KEY_CONTINUE;
			}
			function nextText5(e:KeyboardEvent):void
			{
				addEventListener(KeyboardEvent.KEY_DOWN, nextText7);
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText5);
				commText.text = "Completion accuracy will tell us if you left any red crystals behind." + KEY_CONTINUE;
			
			}
			/**
			function nextText6(e:KeyboardEvent):void
			{
				addEventListener(KeyboardEvent.KEY_DOWN, nextText7);
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText6);
				commText.text = "Completion accuracy will tell us if you left any red Crystals behind that you could have picked up. Remember that the transparent crystals are the ones you missed." + KEY_CONTINUE;
			}
			*/
			function nextText7(e:KeyboardEvent):void
			{
				removeEventListener(KeyboardEvent.KEY_DOWN, nextText7);
				container.removeChild(myComm);
				container.removeChild(commText);
			}
		
		}
		
		private function dispText():void
		{
			var cHold:TextField = new TextField();
			cHold = helper_functions.formatText(cHold, 22, 0x00, "Verdana");
			cHold.text = "Cargo Hold";
			cHold.width = 150;
			cHold.x = 17;
			cHold.y = 5;
			container.addChild(cHold);
			var eqColl:TextField = new TextField();
			helper_functions.formatText(eqColl, 14, 0x00, "Verdana");
			eqColl.text = "Collected";
			eqColl.x = 17;
			eqColl.y = 20;
			container.addChild(eqColl);
			var eqLeft:TextField = new TextField();
			helper_functions.formatText(eqLeft, 14, 0x00, "Verdana");
			eqLeft.text = "Missed";
			eqLeft.width = 175;
			eqLeft.x = 17;
			eqLeft.y = 135;
			container.addChild(eqLeft);
			var mult1:TextField = new TextField();
			helper_functions.formatText(mult1, 20, 0x00, "Verdana");
			mult1.text = "X";
			mult1.x = 282;
			mult1.y = 318;
			container.addChild(mult1);
			var mult2:TextField = new TextField();
			helper_functions.formatText(mult2, 20, 0x00, "Verdana");
			mult2.text = "X";
			mult2.x = 282;
			mult2.y = 490;
			container.addChild(mult2);
			var hundr:TextField = new TextField();
			helper_functions.formatText(hundr, 25, 0x00, "Verdana");
			hundr.text = "1 0 0";
			hundr.x = 320;
			hundr.y = 315;
			container.addChild(hundr);
			var hundr2:TextField = new TextField();
			helper_functions.formatText(hundr2, 25, 0x00, "Verdana");
			hundr2.text = "1 0 0";
			hundr2.x = 320;
			hundr2.y = 485;
			container.addChild(hundr2);
			var equals:TextField = new TextField();
			helper_functions.formatText(equals, 25, 0x00, "Verdana");
			equals.text = "=";
			equals.x = 400;
			equals.y = 315;
			equals.width = 20;
			container.addChild(equals);
			var equals2:TextField = new TextField();
			helper_functions.formatText(equals2, 25, 0x00, "Verdana");
			equals2.text = "=";
			equals2.width = 20;
			equals2.x = 400;
			equals2.y = 485;
			container.addChild(equals2);
			var prc1:TextField = new TextField();
			helper_functions.formatText(prc1, 20, 0x00, "Verdana");
			prc1.text = "%";
			prc1.x = 520;
			prc1.y = 315;
			container.addChild(prc1);
			var prc2:TextField = new TextField();
			helper_functions.formatText(prc2, 20, 0x00, "Verdana");
			prc2.text = "%";
			prc2.x = 520;
			prc2.y = 484;
			container.addChild(prc2);
			var compSc:TextField = new TextField();
			helper_functions.formatText(compSc, 16, 0x00, "Verdana");
			compSc.text = "Completion Score: ";
			compSc.width = 180;
			compSc.x = 38;
			compSc.y = 255;
			container.addChild(compSc);
			var compScFllw:TextField = new TextField();
			helper_functions.formatText(compScFllw, 14, 0x00, "Verdana");
			compScFllw.text = "How many of the red greebles did you collect?";
			compScFllw.x = 200;
			compScFllw.y = 256;
			compScFllw.height = 20;
			compScFllw.width = 400;
			container.addChild(compScFllw);
			var sellSc:TextField = new TextField();
			helper_functions.formatText(sellSc, 16, 0x00, "Verdana");
			sellSc.text = "Selection Score: ";
			sellSc.x = 38;
			sellSc.y = 430;
			sellSc.width = 180;
			container.addChild(sellSc);
			var sellScFllw:TextField = new TextField();
			helper_functions.formatText(sellScFllw, 14, 0x00, "Verdana");
			sellScFllw.text = "Of the greebles you collected, how many were red?";
			sellScFllw.width = 410;
			sellScFllw.height = 20;
			sellScFllw.x = 182;
			sellScFllw.y = 431;
			container.addChild(sellScFllw);
			var redColl:TextField = new TextField();
			helper_functions.formatText(redColl, 14, 0x00, "Verdana");
			redColl.text = "Red collected:";
			redColl.width = 150;
			redColl.x = 68;
			redColl.y = 294;
			container.addChild(redColl);
			var redColl2:TextField = new TextField();
			helper_functions.formatText(redColl2, 14, 0x00, "Verdana");
			redColl2.text = "Red collected:";
			redColl2.width = 150;
			redColl2.x = 68;
			redColl2.y = 466;
			container.addChild(redColl2);
			var tRedOn:TextField = new TextField();
			helper_functions.formatText(tRedOn, 14, 0x00, "Verdana");
			tRedOn.text = "Total red" + "\n" + "on  planet: ";
			tRedOn.x = 68;
			tRedOn.y = 338;
			container.addChild(tRedOn);
			var tColl:TextField = new TextField();
			helper_functions.formatText(tColl, 14, 0x00, "Verdana");
			tColl.text = "Total collected:";
			tColl.width = 150;
			tColl.x = 68;
			tColl.y = 517;
			container.addChild(tColl);
		}
		
		private function dispDivLines():void
		{
			var line1:MovieClip;
			var line2:MovieClip;
			line1 = helper_functions.drawDivLine(213, 329, 0x000000);
			line2 = helper_functions.drawDivLine(213, 500, 0x000000);
			container.addChild(line1);
			container.addChild(line2);
		
		}
		
		private function storePercent(percent:Number):void
		{
			if (thisPlanet == "home")
			{
				TimeFlow.setHomeScore = percent;
			}
			if (thisPlanet == "green")
			{
				TimeFlow.setGreenScore = percent;
			}
			if (thisPlanet == "blue")
			{
				TimeFlow.setBlueScore = percent;
			}
			if (thisPlanet == "red")
			{
				TimeFlow.setRedScore = percent;
			}
		
		}
		
		private function storePercentC(percent:Number):void
		{
			if (thisPlanet == "home")
			{
				TimeFlow.setHomeScoreC = percent;
			}
			if (thisPlanet == "green")
			{
				TimeFlow.setGreenScoreC = percent;
			}
			if (thisPlanet == "blue")
			{
				TimeFlow.setBlueScoreC = percent;
			}
			if (thisPlanet == "red")
			{
				TimeFlow.setRedScoreC = percent;
			}
		
		}
		
		private function displayErrMessage():void
		{
			var myCommer:commBox = new commBox();
			container.addChild(myCommer);
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
			container.addChild(commText);
			container.addEventListener(KeyboardEvent.KEY_DOWN, removeComm);
			function removeComm(e:KeyboardEvent):void
			{
				container.removeEventListener(KeyboardEvent.KEY_DOWN, removeComm);
				if (container.contains(myCommer))
				{
					container.removeChild(myCommer);
				}
				if (container.contains(commText))
				{
					container.removeChild(commText);
				}
			}
		}
		
		private function chkScore_se():void
		{
			var top:Number = num_red;
			var bottom:Number = Number(total_collected);
			var usrBottom:Number = Number(total_se.getLineText(0));
			var usrTop:Number = Number(collected_se.getLineText(0));
			var percent:Number = (top / bottom) * 100;
			if (bottom == 0 || top == 0)
			{
				percent = 0;
			}
			percent = Number(percent.toPrecision(2));
			percent_se.text = percent.toString();
			storePercent(percent);
			//trace(percent);
			//TODO: RENDER PERCENTAGE INSTEAD OF TAKING IN USER INPUT
			//var percent_i:Number = Number(percent_se.getLineText(0));
			var erredInput:Boolean = ((usrTop != top) || (usrBottom != bottom));
			if (erredInput)
			{
				if (correct != null && container.contains(correct))
				//display incorrect
				{
					container.removeChild(correct);
				}
				if (incorrect == null)
				{
				incorrect = new inc_img();
				incorrect.x = 667;
				incorrect.y = 480;
				container.addChild(incorrect);
				}
				buttonClick++;
				if (buttonClick >= 2)
				{
					//displayErrMessage();
					TimeFlow.showIncorrect = true;
				}
			}
			else
			{
				//display correct
				if (incorrect != null && container.contains(incorrect))
				{
					container.removeChild(incorrect);
				}
				if (correct == null)
				{
				container.addChild(percent_se);
				correct = new crrct_img();
				correct.x = 667;
				correct.y = 480;
				isDone++;
				container.addChild(correct);
				}
			}
		
		}
		
		private function chkScore_cm():void
		{
			//counts total reds
			var usrTop:Number = Number(collected_cm.getLineText(0));
			var usrBottom:Number = Number(total_cm.getLineText(0));
			var top:Number = num_red;
			var bottom:Number = total_red;
			var percent:Number = (top / bottom) * 100;
			percent = Number(percent.toPrecision(2));
			if (bottom == 0 || top == 0)
			{
				percent = 0;
			}
			percent_cm.text = percent.toString();
			storePercentC(percent);
			//trace(percent);
			//var percent_i:Number = Number(percent_cm.getLineText(0));
			var erredInput:Boolean = ((usrTop != top) || (usrBottom != bottom));
			if (erredInput)
			{
				//display incorrect
				if (correct2 != null && container.contains(correct2))
				{
					container.removeChild(correct2);
				}
				if (incorrect2 == null)
				{
				incorrect2 = new inc_img();
				incorrect2.x = 667;
				incorrect2.y = 305;
				container.addChild(incorrect2);
				}
				
				buttonClick++;
				if (buttonClick >= 2)
				{
					//displayErrMessage();
					TimeFlow.showIncorrect = true;
				}
			}
			else
			{
				//display correct
				if (incorrect2 != null && container.contains(incorrect2))
				{
					container.removeChild(incorrect2);
				}
				//trace("success!")
				if (correct2 == null)
				{
				container.addChild(percent_cm);
				correct2 = new crrct_img();
				correct2.x = 667;
				correct2.y = 305;
				isDone2++;
				container.addChild(correct2);
				}
			}
		
		}
		
		private function dispGreebleCargo():void
		{
			//make greebles here
			var dispGrbArray:Array = new Array();
			var i:int = 0;
			var strtPos:int;
			var newY:int = 40;
			//display red
			for (i = 1; i <= num_red; i++)
			{
				dispGrbArray[i] = new helper_functions.rd_grb();
				dispGrbArray[i].x = i * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display green
			strtPos = i;
			for (i = 1; i <= num_green; i++)
			{
				dispGrbArray[i] = new helper_functions.grn_grb();
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display blue
			strtPos = strtPos + i;
			//move Y down one in display
			
			if (strtPos > 40)
			{
				newY = (newY + 20);
				strtPos = 0;
			}
			for (i = 1; i <= num_blue; i++)
			{
				dispGrbArray[i] = new helper_functions.bl_grb();
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display yellow
			strtPos = strtPos + i;
			//trace(strtPos);
			//move Y down one in display
			if (strtPos > 40)
			{
				newY = (newY + 20);
				strtPos = 0;
			}
			for (i = 1; i <= num_yellow; i++)
			{
				dispGrbArray[i] = new helper_functions.yllw_grb();
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display orange
			strtPos = strtPos + i;
			//trace(strtPos);
			//move Y down one in display
			if (strtPos > 40)
			{
				newY = (newY + 20);
				strtPos = 0;
			}
			for (i = 1; i <= num_orange; i++)
			{
				dispGrbArray[i] = new helper_functions.orng_grb();
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display brown
			strtPos = strtPos + i;
			//trace(strtPos);
			//move Y down one in display
			if (strtPos > 40)
			{
				newY = (newY + 20);
				strtPos = 0;
			}
			for (i = 1; i <= num_brown; i++)
			{
				dispGrbArray[i] = new helper_functions.brwn_grb();
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{ 
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
			//display left behind greebles
			strtPos = 0;
			//trace(strtPos);
			//move Y down into "missed display"
			newY = 150;
			for (i = 1; i <= (total_red - num_red); i++)
			{
				dispGrbArray[i] = new helper_functions.rd_grb();
				dispGrbArray[i].alpha = .5;
				dispGrbArray[i].x = (strtPos + i) * 16;
				if (i % 5 == 0)
				{
					dispGrbArray[i].y += (newY + 5);
				}
				else
				{
					dispGrbArray[i].y += (newY);
				}
				container.addChild(dispGrbArray[i]);
			}
		}
		
		private function countGreebles():void
		{
			//trace("this is a waste");
			var firstArray:Array;
			var i:uint;
			var j:uint;
			var greebleColor:String;
			var numArrays:uint = scoreCnt.length;
			var ArrSize:uint;
			for (i = 0; i < numArrays; i++)
			{
				firstArray = scoreCnt.pop();
				total_red += firstArray.pop();
				total_collected += firstArray.pop();
				ArrSize = firstArray.length;
				for (j = 0; j < ArrSize; j++)
				{
					//trace(firstArray.pop());
					greebleColor = firstArray.pop();
					if (greebleColor == "red")
					{
						num_red++;
					}
					if (greebleColor == "blue")
					{
						num_blue++;
					}
					if (greebleColor == "green")
					{
						num_green++;
					}
					if (greebleColor == "yellow")
					{
						num_yellow++;
					}
					if (greebleColor == "orange")
					{
						num_orange++;
					}
					if (greebleColor == "brown")
					{
						num_brown++;
					}
					
				}
			}
		}
		
		private function animateChk1(e:MouseEvent):void
		{
			if (mouseX > 580 && mouseX < 644)
			{
				if (mouseY > 295 && mouseY < 359)
				{
					chkDwn1 = new chkSc_down();
					//trace("working?")
					chkDwn1.x = 580;
					chkDwn1.y = 295;
					addEventListener(MouseEvent.MOUSE_UP, removeDwn1);
					container.addChild(chkDwn1);
					chkScore_cm();
					function removeDwn1(e:MouseEvent):void
					{
						removeEventListener(MouseEvent.MOUSE_UP, removeDwn1);
						container.removeChild(chkDwn1);
					}
				} //if brackets
			} //if brackets
			if (mouseX > 580 && mouseX < 644)
			{
				if (mouseY > 466 && mouseY < 530)
				{
					chkDwn1 = new chkSc_down();
					chkDwn1.x = 580;
					chkDwn1.y = 466;
					chkScore_se();
					addEventListener(MouseEvent.MOUSE_UP, removeDwn2);
					container.addChild(chkDwn1);
					function removeDwn2(e:MouseEvent):void
					{
						removeEventListener(MouseEvent.MOUSE_UP, removeDwn2);
						container.removeChild(chkDwn1);
					}
					
				}
			}
		}
		
		private function makeDiv():void
		{
			var myLine:MovieClip = new MovieClip();
			myLine.graphics.clear();
			myLine.graphics.lineStyle(3, 0x00); //line style
			myLine.graphics.moveTo(10, 130);
			myLine.graphics.lineTo(790, 130);
			//return myLine;
			container.addChild(myLine);
		}
		
		private function popupSwitchComm():void
		{
			container.addChild(myComm);
			var commText:TextField = new TextField();
			commText = helper_functions.formatText(commText, 8, 0x35BA00, "Courier");
			commText.width = 250;
			commText.height = 200;
			commText.x = 356;
			commText.y = 125;
			commText.wordWrap = true;
			commText.text = "Looks like you did a pretty good job! I think you are ready to head to the new planets and start searching for red crystals!" + "\n\n[Press any key to continue]";
			container.addChild(commText);
		}
		
		private function leaveScene(e:Event):void
		{
			if (isDone && isDone2)
			{
				if (TimeFlow.getTutorialState)
				{
					//TimeFlow.tutorialState = false;
					//popupSwitchComm(); tutorialState is probably useless now
					TimeFlow.showCorrect = true;
				}		
				//popupSwitchComm();
				//container.addEventListener(KeyboardEvent.KEY_DOWN, changeScene);
				removeEventListener(Event.ENTER_FRAME, leaveScene);
			}
		}
		
		/**
		 * This class is probably useless now
		 * @param	e
		 *
		private function changeScene(e:KeyboardEvent):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN, changeScene);
			TimeFlow.changeCount = true;
			//removeChild(container);
			//dispatchEvent(new Event(Event.COMPLETE));
		}
		*/
		
		private function dispMiniGreebles():void
		{
			var greebleColl:Bitmap = new helper_functions.rd_grb();
			TweenLite.to(greebleColl, 0, {width: 10, height: 20});
			greebleColl.x = 415;
			greebleColl.y = 198;
			container.addChild(greebleColl);
			var greebleMiss:Bitmap = new helper_functions.rd_rd_grb();
			TweenLite.to(greebleMiss, 0, {width: 10, height: 20, alpha: .5});
			greebleMiss.x = 605;
			greebleMiss.y = 198;
			container.addChild(greebleMiss);
		}
		
		public function countingScene(scoreArr:Array, planet:String)
		{
			thisPlanet = planet;
			container = new MovieClip();
			cntInfce = new cntMenu();
			chkUp1 = new chkSc_Up();
			chkUp2 = new chkSc_Up();
			scoreCnt = scoreArr;
			cntInfce.y = 220;
			chkUp1.x = 580;
			chkUp1.y = 295;
			chkUp2.x = 580;
			chkUp2.y = 466;
			addEventListener(MouseEvent.MOUSE_DOWN, animateChk1);
			addEventListener(Event.ENTER_FRAME, leaveScene);
			var bGround:MovieClip = new MovieClip();
			bGround.graphics.lineStyle(1, 0xFFFFFF);
			bGround.graphics.beginFill(0xFFFFFF);
			bGround.graphics.drawRect(0, 0, 800, 600);
			bGround.graphics.endFill();
			addChild(container);
			container.addChild(bGround);
			container.addChild(cntInfce);
			container.addChild(chkUp1);
			container.addChild(chkUp2);
			countGreebles(); //used as input into dispGreebleCargo
			dispGreebleCargo(); //displays the greebles above
			setupInput(); //setups the input boxes
			dispDivLines(); //will display div lines
			dispText();
			//dispMiniGreebles();
			//should always be initialized
			//myComm = new commBox();
			//myComm.x = 125;
			//myComm.y = 30;
			makeDiv();

		}
	}

}