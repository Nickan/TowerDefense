package model 
{
	import flash.geom.Point;
	import starling.textures.Texture;
	/**
	 * Overrides the default bullet's settings, straightly traces the target area
	 * @author Nickan
	 */
	public class SplashCannon extends Cannon {
		private var targetArea:Point = new Point()
		
		public function SplashCannon(texture:Texture, bullets:Array, x:Number, y:Number) {
			super(texture, bullets, x, y)
		}
		
		override protected function bulletFired(bullet:Bullet):void {
			targetArea.x = targetBounds.x + targetBounds.width / 2
			targetArea.y = targetBounds.y + targetBounds.height / 2
		}
		
		override public function bulletUpdate(bullet:Bullet, timeDelta:Number):void {
			if (bullet.targetHit(targetBounds.width, targetBounds.height, timeDelta)) {
				bullet.needToBeRemovedOnScreen = true;
				bullet.update = false;
			}
		}
	}

}