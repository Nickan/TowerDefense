package framework1_0 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Nickan
	 */
	public class Game 
	{
		private  var canvasBd:BitmapData;
		public var canvasBitmap:Bitmap;
		
		private var screen:Screen;
		
		public function Game(width:uint, height:uint) 
		{
			trace("Game Created");
			canvasBd = new BitmapData(width, height, false, 0x000000);
			canvasBitmap = new Bitmap(canvasBd);
		}
		
		public function Update():void
		{
			if (screen != null) {
				screen.Update();
				screen.Render(canvasBd);
			}
		}
		
		public function SetScreen(screen:Screen):void
		{
			this.screen = screen;
		}
		
	}

}