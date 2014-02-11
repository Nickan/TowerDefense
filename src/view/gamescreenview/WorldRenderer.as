package view.gamescreenview
{
	import flash.display.Bitmap;
	import starling.textures.TextureAtlas;
	
	import citrus.core.starling.StarlingState;
	import flash.display.BitmapData;
	import starling.textures.Texture;
	
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class WorldRenderer
	{
	//	[Embed(source="../../../assets/allgameimages.png")]
	//	private var SourceImage:Class;
	//	private var imgBmp:Bitmap = new SourceImage();
		[Embed(source="../../../assets/tiledmap.png")]
		private var TiledMapImage:Class;
	
		[Embed(source="../../../assets/tiledmap.tmx", mimeType="application/octet-stream")]
		private var TiledMap:Class;
		
		[Embed(source="../../../assets/tiledmap.xml")]
		private var TiledMapXML:Class;
		
		public function WorldRenderer()
		{
			
		}
		
		public function initialize(): void
		{
			var mapAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new TiledMapImage()), XML(new TiledMapXML()));	
			ObjectMakerStarling.FromTiledMap(XML(new TiledMap()), mapAtlas);
		}
	
	}

}