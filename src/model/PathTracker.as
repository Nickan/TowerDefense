package model 
{
	import flash.geom.Point;
	import framework1_0.Node;
	import framework1_0.RotationManager;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class PathTracker  {
		private var pathList:Array
		private var zombie:Zombie;
		
		private var moveIndicator:Point = new Point();
		private var previousPos:Point = new Point();
		private var traveledPos:Point = new Point();
		
		private var movingX:Boolean = false;
		private var movingY:Boolean = false;
		
		private var currentPoint:Point;
		private var pixelUnit:uint = 32;
		
		private var rotationSpeed:Number = 100;
		
		public function PathTracker(zombie:Zombie)  {
			this.zombie = zombie;
			this.currentPoint = new Point(zombie.x, zombie.y);
		}
		
		public function move(timeDelta:Number, speed:Number): void {
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
				
				if (pathList.length > 0) {
					setMovement();
				}
			}
			
			var currentRotation:Number = RotationManager.getDegreeRotation(zombie.currentAnimation.image.rotation);
			var targetRotation:Number = RotationManager.getViewRotation(moveIndicator.x, moveIndicator.y);
			zombie.currentAnimation.image.rotation = RotationManager.getSmoothRotation(currentRotation, targetRotation, 
																	rotationSpeed * timeDelta) * RotationManager.DEG_TO_RAD;
		}
		
		/**
		 * Clones the pathList given
		 * @param	pathList
		 */
		public function trackPathList(pathList:Array): void {
			this.pathList = pathList.concat()
			setMovement();
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