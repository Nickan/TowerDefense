package framework1_0.TiledMap 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Contains variables to ease the setting up of the TiledMap class
	 * @author Nickan
	 */
	public class Tile 
	{
		public static const WALKABLE:uint = 0;
		public static const UNWALKABLE:uint = 1;
		
		public var tileType:uint;
		public var tileId:uint;
		public var point:Point;
		public var rect:Rectangle;
		
		public function Tile(tileType:uint = 0, tileId:uint = 0, point:Point = null)
		{
				this.point = point;
				this.tileType = tileType;
				this.tileId = tileId;
		}
		
		public function setValues(tileType:uint, tileId:uint, point:Point, rect:Rectangle): void
		{
			this.tileType = tileType;
			this.tileId = tileId;
			this.point = point;
			this.rect = rect;
		}

	}

}