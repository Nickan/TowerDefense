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
	public class Zombie {
		private var aniStateTime:Number = 0;
		
		public var pathTracker:PathTracker;
		
		public var life:int = 100;
		
		public var speed:Number = 16;
		
		public var x:Number;
		public var y:Number;
		public var width:uint;
		public var height:uint;
		
		public var animation:Animation;
		
		/**
		 * Don't use this to instantiate a new zombie, use newInstance() instead
		 * @param	animation
		 * @param	rect
		 */
		public function Zombie(srcBmpData:BitmapData, width:uint, height:uint, totalColumns:uint, totalFrames:uint, 
				duration:Number, playMode:uint) {
			this.width = width;
			this.height = height;
			animation = new Animation(srcBmpData, width, height, totalColumns, totalFrames, duration, playMode);
			
			pathTracker = new PathTracker(this);
		}
		
		public function update(timeDelta:Number): void {
			pathTracker.move(timeDelta);
			aniStateTime += timeDelta;

			animation.update(x + width / 2, y + height / 2, aniStateTime);
		}
		
		public function getImage():Image {
			return animation.image;
		}
	}

}