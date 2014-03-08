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
	import starling.display.Image;
	
	/**
	 * Should only know how to track the target area
	 * @author Nickan
	 */
	public class Zombie extends BaseEntity {
		private var aniStateTime:Number = 0
		
		public var pathTracker:PathTracker
		
		public var life:int = 100
		
		public var speed:Number = 16
		
		public var x:Number
		public var y:Number
		
		public var animation:Animation
		
		public function Zombie(srcBmpData:BitmapData, width:uint, height:uint, totalColumns:uint, totalFrames:uint, 
				duration:Number, playMode:uint) {
			super(new Rectangle(0, 0, width, height))
			animation = new Animation(srcBmpData, width, height, totalColumns, totalFrames, duration, playMode)
			
			pathTracker = new PathTracker(this)
		}
		
		public function update(timeDelta:Number): void {
			pathTracker.move(timeDelta)
			aniStateTime += timeDelta;
			
			bounds.x = x
			bounds.y = y
			animation.update(x + bounds.width / 2, y + bounds.height / 2, aniStateTime)
			
			//...
//			trace("2:Cannon pos:" + x + ": " + y ) 
		}
		
		public function getImage():Image {
			return animation.image
		}
		
		override public function handleTelegram(telegram:Telegram):Boolean {
			
			switch (telegram.message) {
			case Message.TARGET:
				MessageDispatcher.dispatchTelegram(id, telegram.senderId, Message.TARGET_RESPONSE, 0, bounds)
				return true
			default:
				return false
			}
			
		}
	}

}