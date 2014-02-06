package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import framework1_0.Game;
	import screen.GameScreen;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class Main extends Sprite 
	{
		private var game:Game;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			game = new Game(stage.stageWidth, stage.stageHeight);
			
			// SEtting the screen of the game as GameScreen (for now)
			game.SetScreen(new GameScreen(game));
			
			addChild(game.canvasBitmap);
			
			addEventListener(Event.ENTER_FRAME, Run);
		}
		
		private function Run(e:Event):void
		{
			game.Update();
		}
		
	}
	
}