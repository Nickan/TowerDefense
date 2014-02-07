package view.gamescreenview
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class WorldRenderer
	{
		[Embed(source="../../../assets/allgameimages.png")]
		private var SourceImage:Class;
		private var imgBmp:Bitmap = new SourceImage();
		
		private var world:World;
		
		private var tile_1:Rectangle;
		private var pos:Point;
		private var pos2:Point;
		
		private var scaledBmpData:BitmapData;
		private var resizedRect:Rectangle;
		
		public function WorldRenderer(world:World)
		{
			this.world = world;
			tile_1 = new Rectangle(0, 0, 32, 32);
			pos = new Point(0, 0);
			pos2 = new Point(64, 64);
			
			resizedRect = new Rectangle(0, 0, 64, 64);
			scaledBmpData = getScaledBitmapData(imgBmp.bitmapData, tile_1, 2, 2);
		}
		
		public function render(canvasBd:BitmapData):void
		{
			//	canvasBd.copyPixels(texture.bitmapData, tile_1, pos);
			canvasBd.copyPixels(imgBmp.bitmapData, tile_1, pos2);
			canvasBd.copyPixels(scaledBmpData, resizedRect, pos);
		}
		
		/**
		 * Scales a BitmapData to be passed
		 * @param	srcBitmapData
		 * @param	srcRect
		 * @param	scaleX
		 * @param	scaleY
		 * @param	resizedRect
		 * @return 	- The newly created scaled BitmapData
		 */
		private function getScaledBitmapData(srcBitmapData:BitmapData, srcRect:Rectangle, scaleX:Number = 1, scaleY:Number = 1, resizedRect:Rectangle = null):BitmapData
		{
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
	
	}

}