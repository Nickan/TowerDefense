package view.gamestatelayers 
{
	import flash.geom.Point
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import framework1_0.GameSprite;
	import model.Cannon;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameLayerController  {
		public var gameLayer:GameLayer
		private var mapScroll:Boolean = false
		private var newCannon:Cannon = null
		
		public function GameLayerController(gameLayer:GameLayer)  {
			this.gameLayer = gameLayer;
			
			// Remove the delay of positioning of the camera
			gameLayer.camera.easing.x = 1;
			gameLayer.camera.easing.y = 1;
			
			gameLayer.stage.addEventListener(TouchEvent.TOUCH, onTouch);
			gameLayer.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
		}
		
		private function onTouch(e:TouchEvent): void {
			var touch:Touch = e.getTouch(gameLayer.stage);
			
			if (touch == null) {
				return
			}
			
			// Needed to correct the values for clicking detection
			if (touch.phase == TouchPhase.BEGAN) {
				touchDown(touch.globalX - gameLayer.x, touch.globalY - gameLayer.y)
			}
			
			if (touch.phase == TouchPhase.ENDED) {
				touchUp(touch.globalX - gameLayer.x, touch.globalY - gameLayer.y)
			}
			
			if (touch.phase == TouchPhase.MOVED) {
				touchMoved(touch)
			}
			
		}
	
		private function touchDown(touchX:Number, touchY:Number):void {
			purchasePanelButton(touchX, touchY)
		}
		
		private function purchasePanelButton(touchX:Number, touchY:Number):void {
			var firstRect:Rectangle = gameLayer.purchasePanel.getFirstRect()
			var secondRect:Rectangle = gameLayer.purchasePanel.getSecondRect()
			var thirdRect:Rectangle = gameLayer.purchasePanel.getThirdRect()
			
			// The purpose of return is to not process other checking when one is detected
			
			if (firstRect.contains(touchX - gameLayer.purchasePanel.x, touchY - gameLayer.purchasePanel.y) ) {
				//...
				trace("2:First")
				newCannon = gameLayer.newNormalCannon( (touchX - (touchX % 32)) / 32 , (touchY - (touchY % 32)) / 32 )
				mapScroll = false
				return
			} else if (secondRect.contains(touchX - gameLayer.purchasePanel.x, touchY - gameLayer.purchasePanel.y) ) {
				//...
				trace("2:Second")
				mapScroll = false
			} else if (thirdRect.contains(touchX - gameLayer.purchasePanel.x, touchY - gameLayer.purchasePanel.y) ) {
				//...
				trace("2:Third")
				mapScroll = false
			} else {
				mapScroll = true
			}
			
			var clickedCannon:Cannon = getClickedCannon(touchX, touchY)
			if (clickedCannon != null) {
				return
			} else {
				
			}
		}
		
		private function touchUp(touchX:Number, touchY:Number):void {
			var firstRect:Rectangle = gameLayer.purchasePanel.getFirstRect()
			
			if (firstRect.contains(touchX - gameLayer.purchasePanel.x, touchY - gameLayer.purchasePanel.y) ) {
				//...
				trace("2:Up")
			}
			
			if (newCannon != null) {
				gameLayer.addNormalCannon(newCannon)
				newCannon = null
			}
		}
		
		
		private function touchMoved(touch:Touch):void {
			if (mapScroll) {
				screenScroll(touch)
			} else {
				
				// Show the place of the new cannon if the user let go of the mouse
				if (newCannon != null) {
					var compensationX:Number = gameLayer.x % 32
					var compensationY:Number = gameLayer.y % 32
					
					newCannon.x = ((int) ( (touch.globalX - compensationX) / 32) * 32) + 16 - ((int) (gameLayer.x / 32) * 32)
					newCannon.y = ((int) ( (touch.globalY - compensationY) / 32) * 32) + 16 - ((int) (gameLayer.y / 32) * 32)
					
					gameLayer.setRangeIndicator(newCannon.x, newCannon.y, newCannon.range)
				}
			}
		}
		
		private function screenScroll(touch:Touch):void {
			// For scrolling of the map
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

			}
		}
		
		
		private function getClickedCannon(touchX:Number, touchY:Number): Cannon {
			var cannons:Array = gameLayer.normalCannons;
			for (var index:uint = 0; index < cannons.length; ++index) {
				var tempCannon:Cannon = cannons[index];
				
				if (tempCannon.bounds.contains(touchX, touchY)) {
					return tempCannon;
				}
			}
			
			return null;
		}
		
		
		// For testing...
		private var testScale:Number = 1.25
		private function keyDown(keyEvent:KeyboardEvent):void {
			/*
			if (keyEvent.keyCode == Keyboard.K) {
				testScale += 0.1
				//...
			//	trace("2:I love you so much, Kandie")
			}
			
			if (keyEvent.keyCode == Keyboard.M) {
				testScale -= 0.1
			}
			
			var img:GameSprite = gameLayer.purchasePanel.brokenNormalCannon
			
			if (keyEvent.keyCode == Keyboard.RIGHT) {
				img.setPosition(img.getX() + 2, img.getY())
			}
			
			if (keyEvent.keyCode == Keyboard.LEFT) {
				img.setPosition(img.getX() - 2, img.getY())
			}
			
			trace("2: " + img.getX() + ": " + img.getY())
			
			gameLayer.purchasePanel.brokenNormalCannon.setScale(testScale, testScale)
			*/
		}
		
	}

}