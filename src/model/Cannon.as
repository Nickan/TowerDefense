package model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.RotationManager;
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
		public var range:uint = 64;
		
		public var targetZombie:Zombie = null;
		
		public var bullets:Array;
		
		public var rotationSpeed:Number = 100.0;
		
		
		private static var distX:Number;
		private static var distY:Number;
		private static var distSqr:Number;
		private static var normalizer:Point = new Point();
		
		public function Cannon(texture:Texture, bullets:Array, x:uint, y:uint)  {
			super(texture);
			pivotX = width / 2;
			pivotY = height / 2;
			this.x = x;
			this.y = y;
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
				var bullet:Bullet = bullets[index];
				
				if (bullet.update) {
					bulletUpdate(bullet, timeDelta);
				}
			}
			
		}
		
		/**
		 * Sets an available bullet to be fired
		 */
		private function fireBullet():void {
			// Just one bullet for now
			for (var index:uint = 0; index < bullets.length; ++index) {
				var bullet:Bullet = bullets[index];
				if (!bullet.update) {
					bullet.update = true;
					
					// Place the starting position of the bullet just above the turret
					distX = targetZombie.x + targetZombie.width / 2 - x;
					distY = targetZombie.y + targetZombie.height / 2 - y;
					
					// Normalize it...
					normalizer.x = distX;
					normalizer.y = distY;
					normalizer.normalize(1);
					var distFromTurret:Number = 10.0;
					bullet.x = this.x + (normalizer.x * distFromTurret);
					bullet.y = this.y + (normalizer.y * distFromTurret);
					
					bullet.targetX = targetZombie.x + targetZombie.width / 2;
					bullet.targetY = targetZombie.y + targetZombie.height / 2;
					
					bullet.needToBeAddedOnScreen = true;
					bulletFired(bullet);
					break;
				}
			}
			
		}
		
		/**
		 * Called when the bullet is just set to be released
		 * @param	bullet
		 */
		protected function bulletFired(bullet:Bullet):void {
			//...
		//	trace("2:bullet fired: " + bullet.x + ": " + bullet.y);
		}
		
		
		/**
		 * Updates the bullet being fired
		 * @param	bullet
		 * @param	timeDelta
		 */
		protected function bulletUpdate(bullet:Bullet, timeDelta:Number):void {
			if (bullet.targetHit(targetZombie.width, targetZombie.height, timeDelta)) {
				bullet.needToBeRemovedOnScreen = true;
				bullet.update = false;
			} else {
				bullet.targetX = targetZombie.x + targetZombie.width / 2;
				bullet.targetY = targetZombie.y + targetZombie.height / 2;
				//...
			//	trace("2:pos: " + bullet.x + ": " + bullet.y);
			}
		}
		
		
		/**
		 * Returns true if the turret is already straightly viewing the target
		 * @param	timeDelta
		 * @return
		 */
		private function turretLocked(timeDelta:Number): Boolean {
			// Need to be normalized?
			distX = targetZombie.x + 16 - x;
			distY = targetZombie.y + 16 - y;
			var viewRotation:Number = RotationManager.getViewRotation(distX, distY);
			var currentRotation:Number = RotationManager.getDegreeRotation(this.rotation);
		
			this.rotation = RotationManager.getSmoothRotation(currentRotation, viewRotation, rotationSpeed * timeDelta) * 
														RotationManager.DEG_TO_RAD;
			
			var rotDifference:Number = Math.abs(viewRotation - currentRotation);
			
			return (rotDifference < rotationSpeed * timeDelta) ? true : false;
		}
		
		public function isInRange(zombie:Zombie): Boolean {
			distX = (zombie.x + zombie.width / 2) - x;
			distY = (zombie.y + zombie.height / 2) - y;
			distSqr = distX * distX + distY * distY;
			
			//...
		//	trace("2:range: " + Math.sqrt(distSqr) + " zomPos: " + (zombie.x + zombie.width / 2) + " :" + (zombie.y + zombie.height / 2) );
		//	trace("2:cannon: " + x + ": " + y);
			
			return (distSqr < range * range) ? true : false;
		}
		
		public function setPosition(x:uint, y:uint):void {
			var tileWidth:uint = 32;
			var tileHeight:uint = 32;
			this.x = (tileWidth * x) + tileWidth / 2;
			this.y = (tileHeight * y) + tileHeight / 2;
		}
		
	}

}