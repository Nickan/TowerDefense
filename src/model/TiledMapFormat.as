package model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.TiledMap.Tile;
	/**
	 * Should be passed to the TiledMap class to be able the TiledMap to draw edited tiles on the screen.
	 * Still a messy class, though I read somewhere that  there is existing frameworks that handles it, 
	 * I chose to make my own, as I am more interested of learning the ActionScript.
	 * @author Nickan
	 */
	public class TiledMapFormat 
	{
		private var tileType:Array;
		private var tileId:Array;
		private static const totalTileId:uint = 12;
		public static const colNumId:uint = 8;
		
		public var tiledMapArray:Array;
		
		public var mapWidth:uint;
		public var mapHeight:uint;
		public var tileWidth:uint;
		public var tileHeight:uint;
		
		public function TiledMapFormat(tileWidth:uint = 32, tileHeight:uint = 32) 
		{
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			
			loadTileType();
		}
		
		/**
		 * Should create and write a tile type of the tile here, should make a tileId in the loadTileId() to be able to work properly
		 */
		private function loadTileType(): void {
			// 0 = Walkable, 1 = unwalkable
			tileType = new Array();
			// Column number		0 1  2 3 4  5 6  7  8 9 10 1112 1314 15 1617 1819 202122 2324
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));	// 0
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 1
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 2
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 3
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 4
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 5
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 6
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 7
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 8
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));	// 9
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 10
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 11
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 12
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 13
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 14
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 15
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 16
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 17
			tileType.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 18
			
			this.mapWidth = tileType[0].length;
			this.mapHeight = tileType.length;

			loadTileId();
			loadDefaultTiledMapValues();
			loadSetTiledMapValues();
		}
		
		/**
		 * Should create and write the tile id based on the BitmapData address, like the loadTileType(), it should create a
		 * tileType in that function
		 */
		private function loadTileId(): void {
			// Accessing the tile Id based on the position of the tile in the BitmapData being passed in the TiledMap Class
			// The formula is in the loadSetTiledMapValues
			
			tileId = new Array();
			// Column number		0 1  2 3 4  5 6  7  8 9 10 1112 1314 15 1617 1819 202122 2324
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 0
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 1
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 2
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 3
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 4
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 5
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 6
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 7
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 8
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 9
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 10
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 11
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 12
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 13
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 14
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 15
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 16
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 17
			tileId.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)); // 18
			
		}
		
		private function loadDefaultTiledMapValues(): void {
			tiledMapArray = new Array();
			for (var row:uint = 0; row < mapHeight; row++) {
				tiledMapArray.push(new Array());
				for (var col:uint = 0; col < mapWidth; col++) {
					tiledMapArray[row].push(new Tile(col * tileWidth, row * tileHeight));
				}
			}
		}
		
		private function loadSetTiledMapValues(): void {
			for (var row:uint = 0; row < mapHeight; row++) {
				for (var col:uint = 0; col < mapWidth; col++) {
					var tileType:uint = tileType[row][col];
					var tileId:uint = tileId[row][col];
					tiledMapArray[row][col].setValues(tileType, tileId, new Point(col * tileWidth, row * tileHeight),
					// The address in the BitmapData which is determined by the tileId from loadTileId()
					new Rectangle(tileWidth * (tileId % colNumId), tileHeight * (uint) (tileId / colNumId), tileWidth, tileHeight));
				}
			}
		}

		
	}

}