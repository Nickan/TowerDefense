package model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Attacks zombie when in range
	 * @author Nickan
	 */
	public class Cannon extends Image  {
		public var attack:uint = 10;
		public var attackDelay:Number = 1.0;
		public var attackTimer:Number = 0.0;
		public var range:uint = 1000;
		
		public var targetZombie:Zombie = null;
		
		public var bullets:Array;
		public var rotManager:RotationManager = new RotationManager();
		
		public var rotationSpeed:Number = 100.0;
		
		public function Cannon(texture:Texture, bullets:Array)  {
			super(texture);
			pivotX = width / 2;
			pivotY = height / 2;
			this.bullets = bullets;
		}
		
		public function update(timeDelta:Number): void {
			// No reason to update the cannon if there is no target zombie
			if (targetZombie == null) { return; }
			
			if (turretLocked(timeDelta) ) {
				attackTimer += timeDelta;
				
				if (attackTimer >= attackDelay) {
					attackTimer -= attackDelay;
					
					fireBullet();
				}
			}
			
			for (var index:uint = 0; index < bullets.length; ++index) {
				var tempBullet:Bullet = bullets[index];
				
				if (tempBullet.fired) {
					if (tempBullet.targetHit(targetZombie.x + 16, targetZombie.y + 16, 
						targetZombie.rect.width, targetZombie.rect.height, timeDelta)) {
							//...
							trace("2:target hit!!!");
							tempBullet.fired = false;
							tempBullet.needToBeRemovedOnScreen = true;
					}
					
					//...
				//	trace("2:tracing target" + tempBullet.x + ": " + tempBullet.y);
				}
			}
			
		}
		
		/**
		 * Sets an available bullet to be fired
		 */
		private function fireBullet(): void {
			// Just one bullet for now
			for (var index:uint = 0; index < bullets.length; ++index) {
				var bullet:Bullet = bullets[index];
				if (bullet.fired == false) {
					bullet.fired = true;
					bullet.x = this.x;
					bullet.y = this.y;
					bullet.needToBeAddedOnScreen = true;
					break;
				}
			}
			
		}	
		
		/**
		 * Returns true if the turret is already straightly viewing the target
		 * @param	timeDelta
		 * @return
		 */
		private function turretLocked(timeDelta:Number): Boolean {
			// Need to be normalized?
			var vectorX:Number = targetZombie.x + 16 - x;
			var vectorY:Number = targetZombie.y + 16 - y;
			var viewRotation:Number = RotationManager.getViewRotation(vectorX, vectorY);
			var currentRotation:Number = RotationManager.getDegreeRotation(this.rotation);
		
			this.rotation = RotationManager.getSmoothRotation(currentRotation, viewRotation, rotationSpeed * timeDelta) * 
														RotationManager.DEG_TO_RAD;
			
			var rotDifference:Number = Math.abs(viewRotation - currentRotation);
			
			return (rotDifference < rotationSpeed * timeDelta) ? true : false;
		}
		
		public function setPosition(x:uint, y:uint):void {
			var tileWidth:uint = 32;
			var tileHeight:uint = 32;
			this.x = (tileWidth * x) + tileWidth / 2;
			this.y = (tileHeight * y) + tileHeight / 2;
		}
		
	}

}