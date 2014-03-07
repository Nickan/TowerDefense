package model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.BaseState;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	import framework1_0.finitestatemachine.StateMachine;
	import framework1_0.RotationManager;
	import model.cannonstate.AttackState;
	import model.cannonstate.IdleState;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Its bullet default implementation traces the target zombie
	 * @author Nickan
	 */
	public class Cannon extends BaseEntity {
		public var image:Image
		
		public var x:Number
		public var y:Number
		
		public var attack:uint = 10;
		public var attackDelay:Number = 1.0;
		public var attackTimer:Number = 0.0;
		public var range:uint = 256;
		
		public var targetZombie:Zombie = null;
		
		public var bullets:Array;
		
		public var rotationSpeed:Number = 100.0;
		
		public var bounds:Rectangle
		
		
		private static var distX:Number;
		private static var distY:Number;
		private static var distSqr:Number;
		private static var normalizer:Point = new Point();
		
		// Trying to use the FSM
		private var stateMachine:StateMachine
		private static var idleState:BaseState = new IdleState()
		private static var attackState:BaseState = new AttackState()
		
		public function Cannon(texture:Texture, bullets:Array, x:uint, y:uint)  {
			image = new Image(texture)
			image.x = x
			image.y = y
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			this.x = x;
			this.y = y;
			this.bullets = bullets;
			
			stateMachine = new StateMachine(this)
			stateMachine.changeState(attackState)
			
			bounds = image.bounds
		}
		
		public function update(timeDelta:Number): void {
			stateMachine.update(timeDelta)
			
			
		//	var tileWidth:uint = 32;
		//	var tileHeight:uint = 32;
		//	image.x = (tileWidth * x) + tileWidth / 2;
		//	image.y = (tileHeight * y) + tileHeight / 2;
			updateImagePosition()
		}
		
		public function updateImagePosition():void {
			image.x = x
			image.y = y
		}
		
		override public function handleTelegram(telegram:Telegram):Boolean {
			return false
		}
		
		/**
		 * Sets an available bullet to be fired
		 */
		public function fireBullet():void {
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
			
		}
		
		
		/**
		 * Updates the bullet being fired
		 * @param	bullet
		 * @param	timeDelta
		 */
		public function bulletUpdate(bullet:Bullet, timeDelta:Number):void {
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
		public function turretLocked(timeDelta:Number): Boolean {
			// Need to be normalized?
			distX = targetZombie.x + 16 - x;
			distY = targetZombie.y + 16 - y;
			var viewRotation:Number = RotationManager.getViewRotation(distX, distY);
			var currentRotation:Number = RotationManager.getDegreeRotation(image.rotation);
		
			image.rotation = RotationManager.getSmoothRotation(currentRotation, viewRotation, rotationSpeed * timeDelta) * 
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
			image.x = (tileWidth * x) + tileWidth / 2;
			image.y = (tileHeight * y) + tileHeight / 2;
			this.x = x
			this.y = y
		}
		
	}

}