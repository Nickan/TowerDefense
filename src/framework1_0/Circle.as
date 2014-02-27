package framework1_0 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Handles some common operations to draw circle. My big problem is when I am setting its pivot, later I will fix it if needed
	 * @author Nickan
	 */
	public class Circle extends Image {
		
		private static var shape:Shape = new Shape();
		private var bmpData:BitmapData;
		
		private var radius:Number;
		private var outlineThickness:Number;
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var outlineColor:uint;
		private var outlineAlpha:Number;
		
		private var sizeAllowance:uint;		// The image is always cut one pixel from all sides, this is an adjustment to prevent to cut of circle too
		
		public function Circle(x:Number, y:Number, radius:Number, fillColor:Number = 0xFFFFFF, fillAlpha:Number = 1, 
				outlineColor:uint = 0xFFFFFF, outlineThickness:Number = 0, outlineAlpha:Number = 0) {
			this.radius = radius;
			this.fillColor = fillColor;
			this.fillAlpha = fillAlpha;
			this.outlineColor = outlineColor;
			this.outlineThickness = outlineThickness;
			this.outlineAlpha = outlineAlpha;

			drawCircle();
			super(getTexture())
			setRadius(radius);
			this.x = x;
			this.y = y;
		}
		
		public function setFill(color:uint = 0x000000, alpha:Number = 1):void {
			fillColor = color;
			fillAlpha = alpha;
			
			shape.graphics.beginFill(fillColor, fillAlpha);
			shape.graphics.lineStyle(outlineThickness, outlineColor, outlineAlpha);
			
			drawCircle();
			texture = getTexture();
		}
		
		/**
		 * Outline alpha works in an strange way
		 * @param	color
		 * @param	thickNess
		 * @param	alpha
		 */
		public function setOutline(color:uint = 0xFFFFFF, thickNess:Number = 1, alpha:Number = 1):void {
			outlineColor = color;
			outlineThickness = thickNess;
			outlineAlpha = alpha;
			
			drawCircle();
			texture = getTexture();
		}
		
		/**
		 * Disposes this instance and replacing it with the new settings
		 * @param	radius
		 */
		public function setRadius(radius:Number):void {
			this.radius = radius;
			drawCircle();
			this.width = radius * 2;
			this.height = radius * 2;
			texture = getTexture();
		}
		
		private function drawCircle():void {
			shape.graphics.clear();
			shape.graphics.beginFill(fillColor, fillAlpha);
			shape.graphics.lineStyle(outlineThickness, outlineColor, outlineAlpha);
			
			// Adjusting the outline to prevent cut of the outline of the circle
			sizeAllowance = outlineThickness + 2;
			shape.graphics.drawCircle(radius + sizeAllowance / 2, radius + sizeAllowance / 2, radius);
			shape.graphics.endFill();
		}
		
		private function getTexture():Texture {
			// Draw an invisible background
			bmpData = new BitmapData(radius * 2 + sizeAllowance, radius * 2 + sizeAllowance, true, 0x00FFFFFF);
			bmpData.draw(shape);
			return Texture.fromBitmap(new Bitmap(bmpData, "auto", true));
		}
				
	}

}