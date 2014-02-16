package state 
{
	import citrus.core.starling.StarlingState;
	import flash.display.BitmapData;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import view.gamestatelayers.GameLayer;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameState extends StarlingState {

		private var gameLayer:GameLayer;
		
		public function GameState() {
			super();
			gameLayer = new GameLayer();
		}
		
		override public function initialize():void
		{
			super.initialize();
			addChild(gameLayer);
		}
		
		override public function update(timeDelta:Number):void {
			gameLayer.update(timeDelta);
		}
		
	}

}