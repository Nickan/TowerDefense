package framework1_0.TiledMap
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import model.TiledMapFormat;
	
	/**
	 * Draws a tiled map
	 * @author Nickan
	 */
	public class TiledMap
	{
		public var bitmapData:BitmapData;
		private var tiledMapFormat:TiledMapFormat;
		
		public function TiledMap(bitmapData:BitmapData, tiledMapFormat:TiledMapFormat)
		{
			this.bitmapData = bitmapData;
			this.tiledMapFormat = tiledMapFormat;
		}
		
		public function draw(canvasBd:BitmapData, point:Point):void {
			var tiledMap:Array = tiledMapFormat.tiledMapArray;
			for (var row:uint = 0; row < tiledMap.length; row++) {
				for (var col:uint = 0; col < tiledMap[row].length; col++) {
					var tile:Tile = tiledMap[row][col];
					canvasBd.copyPixels(bitmapData, tile.rect, tile.point);
				}
			}
		}
	
	}

}