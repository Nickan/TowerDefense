package framework1_0 
{
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	/**
	 * Same as the Image class, but the x and y position doesn't have to be changed when setting the pivot(origin).
	 * So far, I still haven't encountered the need why should I the rotation of the image not to be in its center.
	 * @author Nickan
	 */
	public class GameSprite {
		public var image:Image
		private var width:Number
		private var height:Number
		
		public function GameSprite(texture:Texture, x:Number = 0, y:Number = 0, rotation:Number = 0) {
			image = new Image(texture)

			// Set the rotation in its center
			image.pivotX = image.width / 2
			image.pivotY = image.height / 2
			image.x = x + image.width / 2
			image.y = y + image.height / 2
			width = image.width
			height = image.height
			setPosition(x, y);
			setRotation(rotation);
		}
		
		public function setPosition(x:Number, y:Number):void {
			image.x = x + width / 2
			image.y = y + height / 2
		}
		
		public function getX():Number {
			return image.x - width / 2
		}
		
		public function getY():Number {
			return image.y - height / 2
		}
		
		public function setRotation(rotation:Number):void {
			image.rotation = rotation * RotationManager.DEG_TO_RAD
		}
		
		public function getRotation():Number {
			return RotationManager.getDegreeRotation(image.rotation);
		}
		
		public function setScale(scaleX:Number, scaleY:Number):void {
			image.scaleX = scaleX
			image.scaleY = scaleY
		}
		
	}

}