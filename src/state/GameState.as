package state 
{
	import citrus.core.starling.StarlingState;
	import flash.display.BitmapData;
	import framework1_0.Game;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import view.gamescreenview.Controller;
	import view.gamescreenview.World;
	import view.gamescreenview.WorldRenderer;
	
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameState extends StarlingState
	{
		private var game:Game;
		private var controller:Controller;
		private var renderer:WorldRenderer;
		private var world:World;
		
//		[Embed(source="../../assets/allgameimages.png")]
//		private var SourceImage:Class;
//		private var imgBmp:Bitmap = new SourceImage();
		
		
		
		public function GameState()
		{
			super();
			renderer = new WorldRenderer();
		}
		
		override public function initialize():void
		{
			super.initialize();
			renderer.initialize();
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}

}