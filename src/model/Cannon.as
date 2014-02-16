package model 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Attacks zombie when in range
	 * @author Nickan
	 */
	public class Cannon extends Image  {
		
		public function Cannon(texture:Texture)  {
			super(texture);
			pivotX = width / 2;
			pivotY = height / 2;
			
		}
		
		public function inRange(zombie:Zombie):void {
			
		}
		
		public function attack(zombie:Zombie):void {
			
		}
		
		public function setPosition(x:uint, y:uint):void {
			var tileWidth:uint = 32;
			var tileHeight:uint = 32;
			this.x = (tileWidth * x) + (width / 2);
			this.y = (tileHeight * y) + (height / 2);
		}
		
	}

}