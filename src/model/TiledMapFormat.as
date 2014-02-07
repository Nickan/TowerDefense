package model 
{
	/**
	 * ...
	 * @author Nickan
	 */
	public class TiledMapFormat 
	{
		public var array:Array;
		public var tileId:Array;
		public static const totalTileId:uint = 12;
		public static const colNum:uint = 8;
		
		public function TiledMapFormat() 
		{
			createMap();
		}
		
		private function createMap(): void
		{
			array = new Array();
			// Column number		0 1  2 3 4  5 6  7  8 9 10 1112 1314 15
			array.push(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
			
			tileId = new Array();
			// Column number		0 1  2 3 4  5 6  7  8 9 10 1112 1314 15
			tileId.push(new Array(0, 1, 2, 3, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
		}
		
	}

}