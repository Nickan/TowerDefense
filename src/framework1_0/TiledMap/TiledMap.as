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
		private var arrayOfTiles:Array;
		private var width:uint;
		private var height:uint;
		
		private var tempRect:Rectangle;
		private var tiledMapFormat:TiledMapFormat;
		
		public function TiledMap(bitmapData:BitmapData, tiledMapFormat:TiledMapFormat, width:uint = 32, height:uint = 32) 
		{
			this.bitmapData = bitmapData;
			this.width = width;
			this.height = height;
			this.tiledMapFormat = tiledMapFormat;
			createTiledMap();
		}
		
		private function createTiledMap(): void
		{
			arrayOfTiles = new Array();
			var array:Array = tiledMapFormat.array;
			for (var row:uint = 0; row < array.length; row++) {
				arrayOfTiles.push(new Array());
				for (var col:uint = 0; col < array[row].length; col++) {
					arrayOfTiles[row].push(new Point(col * width, row * height));
				}
			}
			
			tempRect = new Rectangle(0, 0, width, height);
		}
		
		public function draw(canvasBd:BitmapData, point:Point):void
		{

			var array:Array = tiledMapFormat.array;
			var tileId:Array = tiledMapFormat.tileId;
			for (var row:uint = 0; row < array.length; row++) {
				for (var col:uint = 0; col < array[row].length; col++) {
					var id:uint = tileId[row][col];
					tempRect.x = width * (id % TiledMapFormat.colNum);
					tempRect.y = height *  (uint) (id / TiledMapFormat.colNum);

					canvasBd.copyPixels(bitmapData, tempRect, arrayOfTiles[row][col]);
				}
			}
		}
		
	}

}