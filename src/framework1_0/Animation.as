package framework1_0 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Handles the animation by giving the required parameters
	 * @author Nickan
	 */
	public class Animation 
	{
		private var srcBmpData:BitmapData;
		private var modBmpData:BitmapData;
		public var image:Image;
		private var frameNumber:uint;
		private var drawRect:Rectangle;
		private static var defaultPoint:Point = new Point(0, 0);
		private var animationDuration:Number;
		private var perFrameDuration:Number;
		private var totalFrames:uint;
		private var totalColumns:uint;
		private var currentStateTime:Number;
		private var playMode:uint;
		
		private var width:uint;
		private var height:uint;
		
		public static const PLAYMODE_NORMAL:uint = 0;
		public static const PLAYMODE_ABNORMAL:uint = 1; // This is looping :D
		
		public function Animation(srcBmpData:BitmapData, width:uint, height:uint, totalColumns:uint, totalFrames:uint, 
				animationDuration:Number, playMode:uint)  {
			this.srcBmpData = srcBmpData;
			this.width = width;
			this.height = height;
			modBmpData = new BitmapData(width, height);
			
			drawRect = new Rectangle(0, 0, width, height);
			modBmpData.copyPixels(srcBmpData, drawRect, defaultPoint);
			
			this.image = new Image(Texture.fromBitmapData(modBmpData));
			this.totalColumns = totalColumns;
			this.totalFrames = totalFrames;
			this.playMode = playMode;
			
			setAnimationDuration(animationDuration);
		}
		
		public function update(stateTime:Number): void
		{
			currentStateTime = stateTime % animationDuration;
			switch (playMode)
			{
				case PLAYMODE_NORMAL:
					if (stateTime < animationDuration) {
						frameNumber = currentStateTime / perFrameDuration;
					} else {
						// Just set to
						frameNumber = totalFrames - 1;
					}
					break;
					// Means looping
				case PLAYMODE_ABNORMAL:
					frameNumber = currentStateTime / perFrameDuration;
					break;
			}
			
			// Sets the rectangle to be copied from the source BitmapData
			drawRect.x = width * (uint) (frameNumber % totalColumns);
			drawRect.y = height * (uint) (frameNumber / totalColumns);
			
			// Clears the the container modified BitmapData
			modBmpData.fillRect(modBmpData.rect, 0x000000);
			
			// Copy the pixels based on the calculated rect
			modBmpData.copyPixels(srcBmpData, drawRect, defaultPoint);
			
			image.texture = Texture.fromBitmapData(modBmpData);
			
			//...
		//	trace("2: updating" + frameNumber);
		}
		
		public function setAnimationDuration(animationDuration:Number): void
		{
			this.animationDuration = animationDuration;
			perFrameDuration = animationDuration / totalFrames;
		}
		
	}

}