package model 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.Animation;
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.messagingsystem.Message;
	import framework1_0.finitestatemachine.messagingsystem.MessageDispatcher;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	import framework1_0.RectangleImage;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * Should only know how to track the target area
	 * @author Nickan
	 */
	public class Zombie extends BaseEntity {
		public var x:Number
		public var y:Number
		
		private var aniStateTime:Number = 0
		
		public var pathTracker:PathTracker
		
		public var life:int = 100
		public var fullLife:int = 100
		
		public var speed:Number = 16
		public var speedScale:Number = 1.0
		private var slowedDuration:Number = 5.0
		private var slowedTimer:Number = 5.0

		public var currentAnimation:Animation = null
		private var aniWalking:Animation
		private var aniFreezing:Animation
		public var lifeBar:RectangleImage
		
		private var image:Image
		
		public var parentSprite:Sprite
		
		public function Zombie(walkingBmpData:BitmapData, freezingBmpData:BitmapData, parentSprite:Sprite, width:uint, height:uint, 
				totalColumns:uint, totalFrames:uint, duration:Number, playMode:uint) {
			super(new Rectangle(0, 0, width, height))
			this.parentSprite = parentSprite
			aniWalking = new Animation(walkingBmpData, width, height, totalColumns, totalFrames, duration, playMode)
			aniFreezing = new Animation(freezingBmpData, width, height, totalColumns, totalFrames, duration, playMode) 
			
			setAnimation(aniWalking)
			
			lifeBar = new RectangleImage(0, 0, 32, 6, 0x0000FF, 1)
			
			pathTracker = new PathTracker(this)
		}
		
		public function update(timeDelta:Number): void {
			if (slowedTimer < slowedDuration) {
				slowedTimer += timeDelta
				
				// Bring back the original speed
				if (slowedTimer >= slowedDuration) {
					speedScale = 1.0
					setAnimation(aniWalking)
				}
			}
			
			pathTracker.move(timeDelta, speed * speedScale)
			aniStateTime += timeDelta;
			
			bounds.x = x
			bounds.y = y
			currentAnimation.update(x + bounds.width / 2, y + bounds.height / 2, aniStateTime)
			lifeBar.x = x
			lifeBar.y = y - 6
		}
		
		public function getImage():Image {
			return image
		}
		
		override public function handleTelegram(telegram:Telegram):Boolean {
			switch (telegram.message) {
			case Message.TARGET:
				MessageDispatcher.dispatchTelegram(id, telegram.senderId, Message.TARGET_RESPONSE, 0, bounds)
				return true
			case Message.HIT:
				var attackDamage:uint = (uint) (telegram.extraInfo)
				life -= attackDamage
				lifeBar.scaleX = life / fullLife
				return true
			case Message.SLOWED:
				var slowScale:Number = (Number) (telegram.extraInfo)
				speedScale = 1.0 * slowScale
				slowedTimer = 0
				
				setAnimation(aniFreezing)
				return true
			default:
				return false
			}
			
		}
		
		private function setAnimation(animation:Animation):void {
			if (currentAnimation != null) {
				parentSprite.removeChild(currentAnimation.image)
				animation.image.rotation = currentAnimation.image.rotation
			}
			currentAnimation = animation
			parentSprite.addChild(currentAnimation.image)
		}
		
	}

}