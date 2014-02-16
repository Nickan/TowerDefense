package model 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.Animation;
	import starling.display.Image;
	
	/**
	 * Should only know how to track the target area
	 * @author Nickan
	 */
	public class Zombie extends Image{
		public var animation:Animation;
		
		public var position:Point;
		public var rect:Rectangle;
		
		private var aniStateTime:Number = 0;
		
		public function Zombie(animation:Animation, rect:Rectangle)  {
			super(animation.image.texture);
			this.animation = animation;
			this.rect = rect;
		}
		
		public function update(timeDelta:Number): void {
			aniStateTime += timeDelta;
			
			// I don't know why the address should be updated over and over again
			this.texture = animation.image.texture;
			
			animation.update(aniStateTime);
		}
		
		private function move(timeDelta:Number): void {
			
		}
		
		/**
		 * Creates a new instance of the zombie
		 * @param	srcBmpData
		 * @param	bounds
		 * @return
		 */
		public static function newInstance(srcBmpData:BitmapData, rect:Rectangle): Zombie {
			var animation:Animation = new Animation(srcBmpData, rect.width, rect.height, 15, 15, 1, Animation.PLAYMODE_ABNORMAL);
			
			var zombie:Zombie = new Zombie(animation, rect);
			
			// Sets the rotation in the center of the imagevar image:Image = animation.image;
			var image:Image = animation.image;
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			
			// Position the zombie at the center of the tile
			zombie.x = (rect.x * 32) + 16 - image.pivotX;
			zombie.y = (rect.y * 32) + 16 - image.pivotY;
			return zombie;
		}
		
	}

}