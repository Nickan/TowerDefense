package screen 
{
	import flash.display.BitmapData;
	import framework1_0.Game;
	import framework1_0.Screen;
	import view.gamescreenview.Controller;
	import view.gamescreenview.World;
	import view.gamescreenview.WorldRenderer;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameScreen implements Screen 
	{
		private var game:Game;
		private var controller:Controller;
		private var renderer:WorldRenderer;
		private var world:World;
		
		public function GameScreen(game:Game) 
		{
			this.game = game;
			world = new World();
			renderer = new WorldRenderer(world);
		}
		
		/* INTERFACE Framework1_0.Screen */
		
		public function Update():void 
		{
			world.Update();
		}
		
		public function Render(canvasBd:BitmapData):void 
		{
			renderer.render(canvasBd);
		}
		
	}

}