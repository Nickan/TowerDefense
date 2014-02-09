package framework1_0.Graphics 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Draws a portion of the BitmapData to be passed which sets the origin to the center of the BitmapData. Cleaning up the code and scaling will be implemented later
	 * @author Nickan
	 */
	public class Sprite  {
		public var point:Point;
		
		public var bounds:Rectangle;
		
		/** The basis BitmapData */
		private var baseBmpData:BitmapData;
		
		/** The modified BitmapData */ 
		private var modBmpData:BitmapData;
		
		private static var matrix:Matrix = new Matrix();
		
		
		public function Sprite(srcBmpData:BitmapData, srcRect:Rectangle)  {
			baseBmpData = new BitmapData(srcRect.width, srcRect.height, true, 0x000000);
			baseBmpData.copyPixels(srcBmpData, srcRect, new Point(0, 0));
			this.bounds = srcRect;
			bounds.x = 0;
			bounds.y = 0;
			modBmpData = new BitmapData(srcRect.width * 1.5, srcRect.height * 1.5, true, 0x000000);
		}
		
		public function draw(canvasBmpData:BitmapData, point:Point, rotation:Number = 0): void {
			Sprite.matrix.identity();
			Sprite.matrix.translate( -bounds.width / 2, -bounds.height / 2);
			Sprite.matrix.rotate(rotation * (Math.PI / 180));
			Sprite.matrix.translate( bounds.width * 0.75, bounds.height * 0.75);
			
			// Clears the bitmapdata
			modBmpData.fillRect(modBmpData.rect, 0x000000);
			
			// Draw the base bitmapdata to the modBmpdata
			modBmpData.draw(baseBmpData, Sprite.matrix);
			
			point.x -= (bounds.width * 0.25);
			point.y -= (bounds.height * 0.25);
			canvasBmpData.copyPixels(modBmpData, modBmpData.rect, point);
			point.x += (bounds.width * 0.25);
			point.y += (bounds.height * 0.25);
		}
		
	}

}