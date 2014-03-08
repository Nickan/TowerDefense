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
	public class Animation {
		public var image:Image
		private var frameNumber:uint
		private var animationDuration:Number
		private var perFrameDuration:Number
		private var totalFrames:uint
		private var totalColumns:uint
		private var currentStateTime:Number
		private var playMode:uint
		
		public var width:uint
		public var height:uint
		
		private var frameTextures:Array = new Array()
		
		public static const PLAYMODE_NORMAL:uint = 0
		public static const PLAYMODE_LOOP:uint = 1 // This is looping :D
		
		public function Animation(srcBmpData:BitmapData, width:uint, height:uint, totalColumns:uint, totalFrames:uint, 
				animationDuration:Number, playMode:uint)  {
			this.width = width
			this.height = height

			this.image = new Image(Texture.fromBitmapData(new BitmapData(width, height)))
			image.pivotX = width / 2
			image.pivotY = height / 2
			
			this.totalColumns = totalColumns
			this.totalFrames = totalFrames
			this.playMode = playMode
			
			setAnimationDuration(animationDuration)
			createIndividualTextures(srcBmpData)
		}
		
		private function createIndividualTextures(srcBmpData:BitmapData):void {
			var modBmpData:BitmapData = new BitmapData(width, height)
			var drawRect:Rectangle = new Rectangle(0, 0, width, height)
			var defaultPoint:Point = new Point()
			
			modBmpData.copyPixels(srcBmpData, drawRect, defaultPoint)
			
			for (var frameNumber:uint = 0; frameNumber < totalFrames; ++frameNumber) {
				// Sets the rectangle to be copied from the source BitmapData
				drawRect.x = width * (uint) (frameNumber % totalColumns)
				drawRect.y = height * (uint) (frameNumber / totalColumns)
				
				// Clears the the container modified BitmapData
				modBmpData.fillRect(modBmpData.rect, 0x000000)
				
				// Copy the pixels based on the calculated rect
				modBmpData.copyPixels(srcBmpData, drawRect, defaultPoint)
				
				// I didn't know that fromBitmapData() creates a new instance of texture, my fault
				var frameTexture:Texture = Texture.fromBitmapData(modBmpData)
				frameTextures.push(frameTexture)
			}
		}
		
		public function update(x:Number, y:Number, stateTime:Number): void {
			currentStateTime = stateTime % animationDuration
			switch (playMode)
			{
				case PLAYMODE_NORMAL:
					if (stateTime < animationDuration) {
						frameNumber = (uint) (currentStateTime / perFrameDuration)
					} else {
						// Just set to
						frameNumber = totalFrames - 1
					}
					break;
					// Means looping
				case PLAYMODE_LOOP:
					frameNumber = (uint) (currentStateTime / perFrameDuration)
					break
			}
			
			image.texture = frameTextures[frameNumber]
			image.x = x
			image.y = y
		}
		
		public function setAnimationDuration(animationDuration:Number): void {
			this.animationDuration = animationDuration
			perFrameDuration = animationDuration / totalFrames
		}
		
	}

}