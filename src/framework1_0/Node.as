package framework1_0 
{
	/**
	 * Holds values for each node represented by tile
	 * @author Nickan
	 */
	public class Node  {
		
		public static const FREE:uint = 0;
		public static const OCCUPIED:uint = 0;

		public var type:uint;
		public var x:uint;
		public var y:uint;
		
		public var parentNode:Node;
		
		// I follow every convention here as much as I could.
		// My java version, I used movementCost for f, heuristic for h, I guess no reason for g, because if the tile is diagonally placed,
		// Just set to 14, the rest ramaining adjacent tiles are set to 10
		// But I was wrong, g cost is not just based on the position of the node from the checked node, it has to be added to
		// The current g cost accumulated, but still I get a correct result there, but here I will do the tutorial's algorithm
		public var f:uint;
		public var g:uint;
		public var h:uint;
		
		public function Node(x:uint, y:uint, type:uint = Node.FREE)  {
			this.x = x;
			this.y = y;
			this.type = type;
			this.parentNode = null;
			this.h = 0;
			this.f = 0;
			this.g = 0;
		}
		
		public function same(x:uint, y:uint): Boolean {
			return ( (this.x == x) && (this.y == y) ) ? true : false;
		}
		
	}

}