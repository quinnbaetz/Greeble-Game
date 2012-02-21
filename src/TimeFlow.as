package 
{
	import flash.display.MovieClip;
	[SWF(width="800", height="600", backgroundColor="0x00")]
	/**
	 * ...
	 * @author ...
	 */
	public class TimeFlow extends MovieClip 
	{
		private static var changeFromCountScene:Boolean;
		private static var displayInc:Boolean;
		private static var displayCor:Boolean;
		private static var tutorial:Boolean;
		private static var HomeScore:Number;
		private static var GreenScore:Number;
		private static var BlueScore:Number;
		private static var RedScore:Number;
		private static var HomeScoreC:Number;
		private static var GreenScoreC:Number;
		private static var RedScoreC:Number;
		private static var BlueScoreC:Number;
		private static var lockLzrMessage:Boolean;
		
		
		public function TimeFlow()
		{
			changeFromCountScene = false;
			tutorial = true;
			HomeScore = 0;
			GreenScore = 0;
			BlueScore = 0;
			RedScore = 0;
			HomeScoreC = 0;
			GreenScoreC = 0;
			RedScoreC = 0;
			BlueScoreC = 0;
		}
		
		public static function set allValues(mark:Number):void
		{
			changeFromCountScene = false;
			tutorial = false;
			HomeScore = 0;
			GreenScore = 0;
			BlueScore = 0;
			RedScore = 0;
			HomeScoreC = 0;
			GreenScoreC = 0;
			RedScoreC = 0;
			BlueScoreC = 0;
		}
		
		public static function set setHomeScoreC(score:Number):void
		{
			HomeScoreC = score;
		}
		
		public static function set lockLazer(lockIt:Boolean):void
		{
			lockLzrMessage = lockIt;
		}
		
		public static function set setGreenScoreC(score:Number):void
		{
			GreenScoreC = score;
		}
		
		public static function set setBlueScoreC(score:Number):void
		{
			BlueScoreC = score;
		}
		
		public static function set setRedScoreC(score:Number):void
		{
			RedScoreC = score;
		}
		
		public static function set setHomeScore(score:Number):void
		{
			HomeScore = score;
		}
		
		public static function set setGreenScore(score:Number):void
		{
			GreenScore = score;
		}
		
		public static function set setRedScore(score:Number):void
		{
			RedScore = score;
		}
		
		public static function set setBlueScore(score:Number):void
		{
			BlueScore = score;
		}
		
		public static function set tutorialState(changeVal:Boolean):void
		{
			tutorial = changeVal;
		}
		
		public static function set changeCount(changeVal:Boolean):void
		{
			changeFromCountScene = changeVal;	
		}
		
		public static function set showCorrect(changeVal:Boolean):void
		{
			displayCor = changeVal;	
		}
		
		public static function set showIncorrect(changeVal:Boolean):void
		{
			displayInc = changeVal;	
		}
		public static function get getLockLazer():Boolean
		{
			return lockLzrMessage;
		}
		
		public static function get getTutorialState():Boolean
		{
			return tutorial;
		}
		public static function get getChangeCount():Boolean
		{
			return changeFromCountScene;
		}
		public static function get displayIncorrect():Boolean
		{
			return displayInc;
		}
		public static function get displayCorrect():Boolean
		{
			return displayCor;
		}
		
		public static function get getHomeScore():Number
		{
			return HomeScore;
		}
		
		public static function get getGreenScore():Number
		{
			return GreenScore;
		}
		
		public static function get getRedScore():Number
		{
			return RedScore;
		}
		
		public static function get getBlueScore():Number
		{
			return BlueScore;
		}
		
		public static function get getHomeScoreC():Number
		{
			return HomeScoreC;
		}
		
		public static function get getGreenScoreC():Number
		{
			return GreenScoreC;
		}
		
		public static function get getBlueScoreC():Number
		{
			return BlueScoreC;
		}
		
		public static function get getRedScoreC():Number
		{
			return RedScoreC;
		}
	}
	
}