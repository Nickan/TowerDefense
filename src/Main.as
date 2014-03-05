package 
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.ViewportMode;
	import flash.events.Event;
	import view.gamestate.GameState;
	
	/**
	 * ...
	 * @author Nickan
	 */
	
//	[SWF(width = "800", height = "600", framerate = "60", backgroundColor = "#000000")]
	public class Main extends StarlingCitrusEngine
	{
		
		public function Main():void 
		{
			_baseWidth = 800;
			_baseHeight = 600;
			_viewportMode = ViewportMode.LETTERBOX;
		}
		
		//We have a stage so we can call setup starling
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage(e);
			setUpStarling(true);
		}
 		//starling is ready, we can start a state
		override public function handleStarlingReady():void
		{
			//load assets etc..
			super.handleStarlingReady();
			state = new GameState();
		}
		
	}
	
}