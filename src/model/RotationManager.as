package model 
{
	/**
	 * ...
	 * @author Nickan
	 */
	public class RotationManager {
		public var doneRotating:Boolean;
		public var rotationSpeed:Number = 100.0;
		
		public function RotationManager() {
			
		}
	
		/**
		 * Returns a correct rotation in degrees from a given 2D vector
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function getCorrectRotation(x:Number, y:Number): Number {
			var rotation:Number = 0;
			var degToRad:Number = Math.PI / 180;
			var radToDeg:Number = 180 / Math.PI;
			
			var atanRotation:Number = Math.atan( y / x) * radToDeg;
			
			if (x >= 0) {
				rotation = atanRotation + 180;
			}
			
			return rotation * degToRad;
		}
		
		/**
		 * Returns a smooth rotation between the current rotation and target rotation (is that they called "interpolation"?). Should be passed in degrees
		 * @param	currentRotation
		 * @param	targetRotation
		 * @param	timeDelta
		 * @return
		 */
		public function getSmoothRotation(currentRotation:Number, targetRotation:Number, timeDelta:Number): Number {
			var radToDeg:Number = 180 / Math.PI;
			var degToRad:Number = Math.PI / 180;
			
			var incRotation:Number = rotationSpeed * timeDelta;
			
			var degCurrentRotation:Number = currentRotation * radToDeg;
			var degTargetRotation:Number = targetRotation * radToDeg;
			
			// Adjustment needed to visualize the rotation in my mind, as I think of rotation 0 to 360 degrees
			// So if the current rotation is negative, most likely the past 180 degrees will be -179 degrees until 0, just add
			// 360 degrees. 181 = -179 + 360, so on and so forth
			if (degCurrentRotation < 0) {
				degCurrentRotation = degCurrentRotation + 360;
			}
			
			///
//			trace("2: current rotation: " + degCurrentRotation + " target rotation: " + degTargetRotation);
			
			// See if there is needed smoothing to get target rotation
			
			var diffRotation:Number = degTargetRotation - degCurrentRotation;
			if (Math.abs(diffRotation) < incRotation) {
				return targetRotation;
			} else {
				
				// The current rotation is lower than the target rotation
				if (degCurrentRotation < degTargetRotation) {
					
					// The difference between is lower than 180
					if (diffRotation <= 180) {
						return (degCurrentRotation + incRotation) * degToRad;
					} else {
						// Higher
						return (degCurrentRotation - incRotation) * degToRad;
					}
					
				} else {
					
					// The current rotation is higher than the target rotation
					// The difference between is lower than 180
					if ( Math.abs(diffRotation) <= 180) {
						return (degCurrentRotation - incRotation) * degToRad;
					} else {
						// Higher
						return (degCurrentRotation + incRotation) * degToRad;
					}
				}
				
			}
		}
		
	}

}