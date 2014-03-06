package model 
{
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Nickan
	 */
	public class SplashCannon extends Cannon {
		
		public function SplashCannon(texture:Texture, bullets:Array, x:Number, y:Number) {
			super(texture, bullets, x, y)
		}
		
		override protected function bulletFired(bullet:Bullet):void {
			
		}
		
	}

}