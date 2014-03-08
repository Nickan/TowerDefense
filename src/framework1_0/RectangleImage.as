package framework1_0 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Super very basic rectangle image I want, needs a lot of fixing
	 * @author Nickan
	 */
	public class RectangleImage extends Image {
		private static var shape:Shape = new Shape()
		private var bmpData:BitmapData
		
		private var outlineThickness:Number;
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var outlineColor:uint;
		private var outlineAlpha:Number;

		public function RectangleImage(x:Number, y:Number, width:Number = 10, height:Number = 10, 
			fillColor:Number = 0xFFFFFF, fillAlpha:Number = 1, 
				outlineColor:uint = 0xFFFFFF, outlineThickness:Number = 0, outlineAlpha:Number = 0) {
			
			this.fillColor = fillColor;
			this.fillAlpha = fillAlpha;
			this.outlineColor = outlineColor;
			this.outlineThickness = outlineThickness;
			this.outlineAlpha = outlineAlpha;		
			
			drawRect(width, height)
			super(getTexture(width, height))
			this.x = x
			this.y = y
			this.width = width
			this.height = height
		}
		
		public function setSize(width:Number, height:Number):void {
			this.width = width
			this.height = height
			drawRect(width, height)
			texture = getTexture(width, height)
		}
		
		public function setAttribute(fillColor:Number = 0xFFFFFF, fillAlpha:Number = 1, outlineColor:uint = 0xFFFFFF, 
			outlineThickness:Number = 0, outlineAlpha:Number = 0):void {
			this.fillColor = fillColor;
			this.fillAlpha = fillAlpha;
			this.outlineColor = outlineColor;
			this.outlineThickness = outlineThickness;
			this.outlineAlpha = outlineAlpha;
			drawRect(width, height)
			texture = getTexture(width, height)
		}
		
		private function drawRect(width:Number, height:Number):void {
			shape.graphics.clear()
		
			shape.graphics.beginFill(fillColor, fillAlpha);
			shape.graphics.lineStyle(outlineThickness, outlineColor, outlineAlpha);

			shape.graphics.drawRect(0, 0, width, height)
			shape.graphics.endFill()
		}
		
		private function getTexture(width:Number, height:Number):Texture {
			// Draw an invisible background
			bmpData = new BitmapData(width, height, true, 0x00FFFFFF)
			bmpData.draw(shape);
			return Texture.fromBitmap(new Bitmap(bmpData, "auto", true));
		}
		
	}

}