package model 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Manages to track the given 2D coordinates
	 * @author Nickan
	 */
	public class Bullet extends Image {
		public var vector:Point = new Point();
		public var speed:Number = 128;
		
		public var fired:Boolean = false;
		public var needToBeAddedOnScreen:Boolean = false;
		public var needToBeRemovedOnScreen:Boolean = false;
		
		public function Bullet(texture:Texture, x:Number = 0, y:Number = 0) {
			super(texture);
			this.x = x;
			this.y = y;
			this.pivotX = width / 2;
			this.pivotY = height / 2;
		}
		
		public function targetHit(targetX:Number, targetY:Number, targetWidth:Number, targetHeight:Number, timeDelta:Number): Boolean {
			// Get the normal vector between the target and this bullet
			vector.x = x - targetX;
			vector.y = y - targetY;
			
			// If the length of the distance betweem the target(zombie) and the bullet is lower than the half of the width
			// or height of the target, then it already hit the zombie. No point of updating anything
			if (vector.length < targetWidth / 2 || vector.length < targetHeight / 2) {
				return true;
			}
			
			vector.normalize(1);
			
			this.x -= vector.x * speed * timeDelta;
			this.y -= vector.y * speed * timeDelta;
			
			var viewRotation:Number = RotationManager.getViewRotation(vector.x, vector.y);
			rotation = RotationManager.getSmoothRotation(RotationManager.getDegreeRotation(rotation), 
									viewRotation, timeDelta);
									
			return false;
		}
		
	}

}