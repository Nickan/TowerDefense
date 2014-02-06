package framework1_0 
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public interface Screen 
	{
		public function Screen(game:Game);
		function Update():void;
		function Render(canvasBd:BitmapData):void;
	}
	
}