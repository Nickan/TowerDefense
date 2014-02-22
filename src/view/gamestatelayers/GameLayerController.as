package view.gamestatelayers 
{
	
	import flash.geom.Point;
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
		}
		
		public function onTouch(e:TouchEvent): void {
			var touch:Touch = e.getTouch(gameLayer.stage);
			
			if (touch == null)
				return;
			
			if (touch.phase == TouchPhase.MOVED) {
			//	trace("2:moved " + touch.globalX + ": " + touch.globalY);
				gameLayer.cameraPoint.x += (touch.previousGlobalX - touch.globalX);
				gameLayer.cameraPoint.y += (touch.previousGlobalY - touch.globalY);
			}
		}
		
	}

}