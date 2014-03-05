package framework1_0 
{
	/**
	 * Handles a common rotation operations that I need for creating this tower defense
	 * @author Nickan
	 */
	public class RotationManager {
		public static const RAD_TO_DEG:Number = 180 / Math.PI;
		public static const DEG_TO_RAD:Number = Math.PI / 180;
		
		public function RotationManager() { }
	
		/**
		 * Returns a degrees from 0 - 360 from a passed direction vector
		 * @param	x
		 * @param	y
		 * @return
		 */
		public static function getViewRotation(x:Number, y:Number): Number {
			var compensationRotation:Number = 0;
			
			var atanRotation:Number = Math.atan( y / x) * RAD_TO_DEG;
			
			// The coordinates is in the middle to the right
			if (x >= 0) {
				compensationRotation = 180;
			} else {
				// Left side
				// Bottom
				if (y > 0) {
					compensationRotation = 360;
				}
			}
			
			return (atanRotation + compensationRotation);
		}
		
		/**
		 * Returns a smooth rotation in degrees between the current rotation and target rotation (is that they called "interpolation"?)
		 * @param	currentRotation
		 * @param	targetRotation
		 * @param	timeDelta
		 * @return
		 */
		public static function getSmoothRotation(currentRotation:Number, targetRotation:Number, rotationSpeed:Number): Number {
			// See if there is needed smoothing to get target rotation			
			var diffRotation:Number = targetRotation - currentRotation;
			if (Math.abs(diffRotation) < rotationSpeed) {
				return targetRotation;
			} else {
				
				// The current rotation is lower than the target rotation
				if (currentRotation < targetRotation) {
					
					// The difference between is lower than 180
					if (diffRotation <= 180) {
						
						return (currentRotation += rotationSpeed);
					} else {
						// Higher
						
						return (currentRotation -= rotationSpeed);
					}
					
				} else {
					
					// The current rotation is higher than the target rotation
					// The difference between is lower than 180
					if ( Math.abs(diffRotation) <= 180) {
						return currentRotation -= rotationSpeed;
					} else {
						// Higher
						return (currentRotation += rotationSpeed);
					}
				}
				
			}
		}
		
		/**
		 * Returns a rotation easily for human to visualize. After 180, the Math.atan() produces - 179, 
		 * so adding 360 will likely to make it readable
		 * @param	atanRadRotation
		 * @return
		 */
		public static function getDegreeRotation(atanRadRotation:Number): Number {
			var rotation:Number = atanRadRotation * RAD_TO_DEG;
			if (rotation < 0) {
				rotation = rotation + 360;
			}
			return rotation;
		}
	}

}
