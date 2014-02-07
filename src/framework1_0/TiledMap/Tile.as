package framework1_0.TiledMap 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nickan
	 */
	public class Tile 
	{
		public static const WALKABLE:uint = 0;
		public static const UNWALKABLE:uint = 1;
		
		public var tileType:uint;
		
		public var point:Point;
		
		public function Tile(point:Point, tileType:uint = 0)
		{
				this.point = point;
				this.tileType = tileType;
		}
		
		
		
	}

}