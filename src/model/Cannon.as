package model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.BaseState;
	import framework1_0.finitestatemachine.EntityManager;
	import framework1_0.finitestatemachine.messagingsystem.Message;
	import framework1_0.finitestatemachine.messagingsystem.MessageDispatcher;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	import framework1_0.finitestatemachine.StateMachine;
	import framework1_0.RotationManager;
	import model.cannonstate.AttackState;
	import model.cannonstate.IdleState;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Its bullet default implementation traces the target zombie
	 * @author Nickan
	 */
	public class Cannon extends BaseEntity {
		public var image:Image
		protected var parentSprite:Sprite
		
		public var x:Number
		public var y:Number
		
		public var attackDamage:uint = 10;
		public var attackDelay:Number = 1.0;
		public var attackTimer:Number = 0.0;
		public var range:uint = 256;
		
		protected var targetId:int = -1
		
		public var bullets:Array;
		
		public var rotationSpeed:Number = 100.0;

		protected var targetBounds:Rectangle = null
		
		public var numOfBulletFired:int = 0
		
		
		private static var distX:Number;
		private static var distY:Number;
		private static var distSqr:Number;
		private static var normalizer:Point = new Point();
		
		// Trying to use the FSM
		private var stateMachine:StateMachine
		private static var idleState:BaseState = new IdleState()
		private static var attackState:BaseState = new AttackState()
		
		public function Cannon(parentSprite:Sprite, texture:Texture, bullets:Array, x:uint, y:uint)  {
			this.parentSprite = parentSprite
			image = new Image(texture)
			super(image.bounds)
			image.x = x
			image.y = y
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			this.x = x;
			this.y = y;
			this.bullets = bullets;
			
			stateMachine = new StateMachine(this)
			stateMachine.changeState(idleState)
		}
		
		public function update(timeDelta:Number): void {
			stateMachine.update(timeDelta)
			
			updateImagePosition()
		}
		
		public function updateImagePosition():void {
			image.x = x
			image.y = y
			bounds.x = x
			bounds.y = y
			
			
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
				
					parentSprite.addChild(bullet)
					
					// Place the starting position of the bullet just above the turret
					distX = targetBounds.x + targetBounds.width / 2 - x
					distY = targetBounds.y + targetBounds.height / 2 - y
					
					// Normalize it...
					normalizer.x = distX
					normalizer.y = distY
					normalizer.normalize(1)
					var distFromTurret:Number = 10.0
					bullet.x = this.x + (normalizer.x * distFromTurret)
					bullet.y = this.y + (normalizer.y * distFromTurret)

					bulletFired(bullet)
					break;
				}
			}
			
		}
		
		/**
		 * Called when the bullet is just set to be released
		 * @param	bullet
		 */
		protected function bulletFired(bullet:Bullet):void {
			bullet.targetX = targetBounds.x + targetBounds.width / 2;
			bullet.targetY = targetBounds.y + targetBounds.height / 2;
		}
		
		/**
		 * Updates the bullet being fired
		 * @param	bullet
		 * @param	timeDelta
		 */
		public function bulletUpdate(bullet:Bullet, timeDelta:Number):void {
			if (bullet.targetHit(targetBounds.width, targetBounds.height, timeDelta)) {
				parentSprite.removeChild(bullet)
				bullet.update = false;
				
				if (EntityManager.getEntity(targetId) != null) {
					MessageDispatcher.dispatchTelegram(id, targetId, Message.HIT, 0, attackDamage)
				} else {
					setIdle()
				}
			} else {
				bullet.targetX = targetBounds.x + targetBounds.width / 2;
				bullet.targetY = targetBounds.y + targetBounds.height / 2;
			}
		}

		/**
		 * Returns true if the turret is already straightly viewing the target
		 * @param	timeDelta
		 * @return
		 */
		public function turretLocked(timeDelta:Number): Boolean {
			// Need to be normalized?
			distX = targetBounds.x + 16 - x;
			distY = targetBounds.y + 16 - y;
			var viewRotation:Number = RotationManager.getViewRotation(distX, distY);
			var currentRotation:Number = RotationManager.getDegreeRotation(image.rotation);
		
			image.rotation = RotationManager.getSmoothRotation(currentRotation, viewRotation, rotationSpeed * timeDelta) * 
														RotationManager.DEG_TO_RAD;
			
			var rotDifference:Number = Math.abs(viewRotation - currentRotation);
			
			return (rotDifference < rotationSpeed * timeDelta) ? true : false;
		}
		
		public function isInRange(bounds:Rectangle): Boolean {			
			distX = (bounds.x + bounds.width / 2) - x;
			distY = (bounds.y + bounds.height / 2) - y;
			distSqr = distX * distX + distY * distY;
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
		
		public function setTargetId(targetId:int):void {
			this.targetId = targetId
			
			if (targetId != -1) {
				MessageDispatcher.dispatchTelegram(id, targetId, Message.TARGET, 0, null)
			}
		}
		
		public function getTargetId():int {
			return targetId
		}
		
		public function getTargetBounds():Rectangle {
			return targetBounds
		}
		
		public function setIdle():void {
			stateMachine.changeState(idleState)
		}
		
		override public function handleTelegram(telegram:Telegram):Boolean {
			switch(telegram.message) {
			case Message.TARGET_RESPONSE:
				targetBounds = EntityManager.getEntity(telegram.senderId).getBounds()
				stateMachine.changeState(attackState)
				return true
			case Message.KILLED:
				stateMachine.changeState(idleState)
				return true
			case Message.DEAD:
				stateMachine.changeState(idleState)
				return true
			default:
				return false
			}
		}
		
		
	}

}