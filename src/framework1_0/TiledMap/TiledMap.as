package framework1_0.TiledMap
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import model.TiledMapFormat;
	
	import framework1_0.Graphics.Sprite;
	
	/**
	 * Draws a tiled map
	 * @author Nickan
	 */
	public class TiledMap
	{
		public var bitmapData:BitmapData;
		private var tiledMapFormat:TiledMapFormat;
		
		private var sprite:Sprite;
		private var tiles:Array;
		
		public function TiledMap(bitmapData:BitmapData, tiledMapFormat:TiledMapFormat)
		{
			this.bitmapData = bitmapData;
			this.tiledMapFormat = tiledMapFormat;

			sprite = new Sprite(bitmapData, new Rectangle(64, 0, 32, 32));
			
			initializeTiles();
		}
		
		private function initializeTiles(): void {
			var tiledMap:Array = tiledMapFormat.tiledMapArray;
			tiles = new Array();
			for (var row:uint = 0; row < tiledMap.length; row++) {
				tiles.push(new Array());
				for (var col:uint = 0; col < tiledMap[row].length; col++) {
					var tile:Tile = tiledMap[row][col];
					tiles[row].push(new Sprite(bitmapData, tile.rect));
				//	canvasBd.copyPixels(bitmapData, tile.rect, tile.point);
				}
			}
		}
		
		public function draw(canvasBd:BitmapData, point:Point):void {
			// Clears the canvas
			canvasBd.fillRect(canvasBd.rect, 0x000000);
			var tiledMap:Array = tiledMapFormat.tiledMapArray;
			for (var row:uint = 0; row < tiledMap.length; row++) {
				for (var col:uint = 0; col < tiledMap[row].length; col++) {
					var tile:Tile = tiledMap[row][col];
					tiles[row][col].draw(canvasBd, tile.point);
				}
			}
		}
		
		private function getScaledBitmapData(srcBitmapData:BitmapData, srcRect:Rectangle, scaleX:Number = 1, scaleY:Number = 1,  resizedRect:Rectangle = null):BitmapData {
			var tempBitmapData:BitmapData;
			var matrix:Matrix = new Matrix();
			
			if (resizedRect != null)
			{
				
				tempBitmapData = new BitmapData(resizedRect.width, resizedRect.height, false, 0x000000);
				tempBitmapData.copyPixels(srcBitmapData, srcRect, new Point(0, 0));
				matrix.scale(resizedRect.width / srcRect.width, resizedRect.height / srcRect.height);
				tempBitmapData.draw(srcBitmapData, matrix);
				return tempBitmapData;
			} else {
				tempBitmapData = new BitmapData(srcRect.width * scaleX, srcRect.height * scaleY, false, 0x000000);
				tempBitmapData.copyPixels(srcBitmapData, srcRect, new Point(0, 0));
				matrix.scale(scaleX, scaleY);
				tempBitmapData.draw(srcBitmapData, matrix);
				return tempBitmapData;
			}
		}
		
		private function newBitmapData(srcBitmapData:BitmapData, srcRect:Rectangle, matrix:Matrix): BitmapData {
			var newBitmapData:BitmapData;
			newBitmapData = new BitmapData(srcRect.width, srcRect.height, false, 0x000000);
			newBitmapData.copyPixels(srcBitmapData, srcRect, new Point(0, 0));
		//	newBitmapData.draw(srcBitmapData, matrix);
			return newBitmapData;
		}
	
	}

}