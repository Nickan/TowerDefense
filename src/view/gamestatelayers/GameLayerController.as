package view.gamestatelayers 
{
	
	import flash.geom.Point;
	import model.Cannon;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameLayerController  {
		public var gameLayer:GameLayer;
		
		private var previousTouch:Point;
		
		public function GameLayerController(gameLayer:GameLayer)  {
			this.gameLayer = gameLayer;
			this.previousTouch = new Point();
			
			// Remove the delay of positioning of the camera
			gameLayer.camera.easing.x = 1;
			gameLayer.camera.easing.y = 1;
			
			gameLayer.stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function onTouch(e:TouchEvent): void {
			var touch:Touch = e.getTouch(gameLayer.stage);
			
			if (touch == null)
				return;
			
			if (touch.phase == TouchPhase.MOVED) {
				var camPoint:Point = gameLayer.cameraPoint;
				camPoint.x += (touch.previousGlobalX - touch.globalX);
				camPoint.y += (touch.previousGlobalY - touch.globalY);
				
				// Limiting the scrolling of mouse
				if (camPoint.x < 400) {
					camPoint.x = 400;
				}
				
				if (camPoint.y < 300) {
					camPoint.y = 300;
				}
				
			//	trace("2:camPoint: " + camPoint.x);
			}
			
			
			if (touch.phase == TouchPhase.BEGAN) {
			//	var cannon:Cannon = getClickedCannon(touch.globalX, touch.globalY);
			//	gameLayer.setRangeIndicator(cannon.x, cannon.y, cannon.range);
				gameLayer.addNormalCannon( (uint) ((touch.globalX - gameLayer.x) / 32), (uint) ((touch.globalY - gameLayer.y) / 32));
			}
			
			
		}
		
		
		private function getClickedCannon(touchX:Number, touchY:Number): Cannon {
			var cannons:Array = gameLayer.normalCannons;
			for (var index:uint = 0; index < cannons.length; ++index) {
				var tempCannon:Cannon = cannons[index];
				
				if (tempCannon.bounds.contains(touchX - gameLayer.x, touchY - gameLayer.y)) {
					return tempCannon;
				}
			}
			
			return null;
		}
		
	}

}