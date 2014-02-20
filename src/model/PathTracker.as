package model 
{
	import flash.geom.Point;
	import framework1_0.Node;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class PathTracker  {
		private var pathList:Array = null;
		private var zombie:Zombie;
		
		private var moveIndicator:Point = new Point();
		private var previousPos:Point = new Point();
		private var traveledPos:Point = new Point();
		
		private var movingX:Boolean = false;
		private var movingY:Boolean = false;
		
		private var speed:Number = 32;
		
		private var currentPoint:Point;
		private var pixelUnit:uint = 32;
		
		private var rotationManager:RotationManager;
		
		public function PathTracker(zombie:Zombie)  {
			this.zombie = zombie;
			this.currentPoint = new Point(zombie.x, zombie.y);
			this.rotationManager = new RotationManager();
		}
		
		public function move(timeDelta:Number): void {
			zombie.x += moveIndicator.x * (speed * timeDelta);
			zombie.y += moveIndicator.y * (speed * timeDelta);
			
			// Stop moving x when one unit is reached
			if ( Math.abs(zombie.x - currentPoint.x) >= pixelUnit) {
				moveIndicator.x = 0;
				zombie.x = Math.round(zombie.x / pixelUnit) * pixelUnit;
			}
			
			if ( Math.abs(zombie.y - currentPoint.y) >= pixelUnit) {
				moveIndicator.y = 0;
				zombie.y = Math.round(zombie.y / pixelUnit) * pixelUnit;
			}
			
			if (moveIndicator.x == 0 && moveIndicator.y == 0) {
				
				if (pathList != null) {
					if (pathList.length > 0) {
						setMovement();
					//	rotate();
					}
				}
			}
			rotate();
			
			var rotation:Number = zombie.animation.image.rotation;
			zombie.animation.image.rotation = rotationManager.getSmoothRotation(rotation, 
									rotationManager.getCorrectRotation(moveIndicator.x, moveIndicator.y), timeDelta);
			
		
			var radToDeg:Number = 180 / Math.PI;
			var degToRad:Number = Math.PI / 180;
		//	zombie.animation.image.rotation =  degToRad * 270;
			//...
			trace("2:rotation: " + zombie.animation.image.rotation * radToDeg );
		//	trace("2:rotation: " + rotation);
		
			
		}
		
		public function trackPathList(pathList:Array): void {
			this.pathList = pathList;
			setMovement();
		}
		
		
		private var rot:Number = 0;
		private function rotate(): void {
			var rotationAdjustment:Number = 0;
			var degToRad:Number = Math.PI / 180;
			if (moveIndicator.x > 0) {
				rotationAdjustment = degToRad * 180;
			}
			
			//zombie.animation.image.rotation = Math.atan( -moveIndicator.y / moveIndicator.x) + rotationAdjustment;
			
		//	zombie.animation.image.rotation = rotationManager.getCorrectRotation(moveIndicator.x, moveIndicator.y) * degToRad;
			
			var radToDeg:Number = 180 / Math.PI;
			++rot;
			
		//	trace("2: rotation: " + zombie.animation.image.rotation * radToDeg);
		//	trace("2: rotation: " + rot);
		//	var rotation = zombie.animation.image.rotation;
		//	rotation = rotationManager.getAtanSmoothRotation(rotation, rotationManager.getCorrectRotation(moveIndicator.x, moveIndicator.y), timeDelta);
		}
		
		private function setMovement(): void {
			currentPoint.x = zombie.x;
			currentPoint.y = zombie.y;
			
			var nextNode:Node = pathList.pop();
			moveIndicator.x = nextNode.x - (currentPoint.x / 32);
			moveIndicator.y = nextNode.y - (currentPoint.y / 32);
		}
		
	}

}