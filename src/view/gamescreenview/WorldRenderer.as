package view.gamescreenview 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Nickan
	 */
	public class WorldRenderer 
	{
		[Embed(source="../../../assets/allgameimages.png")]
		private var Texture: Class;
		private var texture:Bitmap = new Texture();
		
		private var world:World;
		
		private var tile_1:Rectangle;
		private var pos:Point;
		private var pos2:Point;
		
		public function WorldRenderer(world:World)
		{
			this.world = world;
			tile_1 = new Rectangle(0, 0, 32, 32);
			pos = new Point(0, 0);
			pos2 = new Point(32, 32);
		}

		public function render(canvasBd:BitmapData):void
		{
			canvasBd.copyPixels(texture.bitmapData, tile_1, pos);
			canvasBd.copyPixels(texture.bitmapData, tile_1, pos2);
		}
		
	}

}