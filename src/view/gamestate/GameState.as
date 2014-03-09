package view.gamestate 
{
	import citrus.core.starling.StarlingState;
	import view.gamestate.GameLayer;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameState extends StarlingState {
		public var main:Main
		
		private var gameLayer:GameLayer;
		
		public function GameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			gameLayer = new GameLayer(camera);
			addChild(gameLayer);
		}
		
		override public function update(timeDelta:Number):void {
			gameLayer.update(timeDelta);
		}
		
	}

}