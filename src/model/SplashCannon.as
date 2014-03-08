package model 
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * Overrides the default bullet's settings, straightly traces the target area
	 * @author Nickan
	 */
	public class SplashCannon extends Cannon {
		private var targetArea:Point = new Point()
		private var bulletHitTheGround:Boolean = false
		public var blastRadius:uint = 16
		
		// This is exclusively for Ice cannon, this is the only thing that differs from Splash to Ice Cannon. So I think there
		// is no point of creating a separate Ice Cannon class
		public var slowScale:Number = 0.2
		
		public function SplashCannon(parentSprite:Sprite, texture:Texture, bullets:Array, x:Number, y:Number) {
			super(parentSprite, texture, bullets, x, y)
		}
		
		override protected function bulletFired(bullet:Bullet):void {
			bullet.targetX = targetBounds.x + targetBounds.width / 2
			bullet.targetY = targetBounds.y + targetBounds.height / 2
		}
		
		override public function bulletUpdate(bullet:Bullet, timeDelta:Number):void {
			if (bullet.targetHit(targetBounds.width, targetBounds.height, timeDelta)) {
				parentSprite.removeChild(bullet)
				bullet.update = false;
				bulletHitTheGround = true
				targetArea.x = bullet.targetX
				targetArea.y = bullet.targetY
			}
		}
		
		/**
		 * For the game update, to know if the bullet has hit the ground as this Class doesn't apply any damage to zombie.
		 * It automatically set it to false when this method is called
		 * @return
		 */
		public function isBulletHitTheGround():Boolean {
			if (bulletHitTheGround) {
				bulletHitTheGround = false
				return true
			}
			return false
		}
		
		public function getTargetArea():Point {
			return targetArea
		}
		
	}

}