package view.gamestate 
{
	import citrus.utils.objectmakers.ObjectMakerStarling;
	import citrus.view.starlingview.StarlingCamera;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.Animation;
	import framework1_0.AstarPathFinder;
	import framework1_0.Circle;
	import framework1_0.Node;
	import framework1_0.RotationManager;
	import model.Bullet;
	import model.Cannon;
	import model.Map;
	import model.PurchasePanel;
	import model.Zombie;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class GameLayer extends Sprite {
		public var normalCannons:Array;
		
		private var zombies:Array;
		
		[Embed(source="../../../assets/images.png")]
		private var BitmapAtlas:Class;
		private var bitmapAtlas:Bitmap = new BitmapAtlas();
		
		[Embed(source="../../../assets/images.xml", mimeType="application/octet-stream")]
		private var BitmapAtlasXml:Class;
	
		private var textureAtlas:TextureAtlas;
		
		[Embed(source="../../../assets/allanimations.png")]
		private var AllBmp:Class;
		private var allBmp:Bitmap = new AllBmp();
		
		{	// The background
		[Embed(source="../../../assets/tiledmap.png")]
		private var TiledMapImage:Class;
		
		[Embed(source="../../../assets/tiledmap.tmx", mimeType="application/octet-stream")]
		private var TiledMapTmx:Class;
		
		[Embed(source="../../../assets/tiledmap.xml", mimeType="application/octet-stream")]
		private var TiledMapXml:Class;
		}
		
		
		private var pathFinder:AstarPathFinder = new AstarPathFinder(48, 38);
		private var map:Map = new Map();
		
		public var cameraPoint:Point;
		private var gameLayerController:GameLayerController;
		public var camera:StarlingCamera;
		
		private var rangeIndicator:Circle;
		
		public var purchasePanel:PurchasePanel;
		public var purchasePanelPos:Point = new Point(320, 480)
		
		public function GameLayer(camera:StarlingCamera)  {
			super();
			this.camera = camera;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(): void {
			initializeBackground();
			initializeRangeIndicator();
			
			bitmapAtlas = new BitmapAtlas()
			
			textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmapAtlas), XML(new BitmapAtlasXml()));
			
			normalCannons = new Array();
			zombies = new Array();
			
			addZombie(6, 0);
			
			cameraPoint = new Point(400, 300);
			camera.setUp(cameraPoint);
			gameLayerController = new GameLayerController(this);
			
			purchasePanel = new PurchasePanel(textureAtlas);
			addChild(purchasePanel);
			purchasePanel.x = 256 - (cameraPoint.x - 400);
			purchasePanel.y = 256 - (cameraPoint.y - 300);
		}
		
		private function initializeBackground(): void {
			var tiledMapAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new TiledMapImage()), XML(new TiledMapXml()));
			ObjectMakerStarling.FromTiledMap(XML(new TiledMapTmx()), tiledMapAtlas);
		}
		
		private function initializeRangeIndicator():void {
			rangeIndicator = new Circle(256, 256, 250, 0);
			rangeIndicator.setOutline(0xFFFFFF, 0, 0);
			rangeIndicator.setFill(0x00FF00, 0.1);
			rangeIndicator.setRadius(100);
		//	rangeIndicator.x = rangeIndicator.x - rangeIndicator.width / 2 + 16;
		//	rangeIndicator.y = rangeIndicator.y - rangeIndicator.height / 2 + 16;
			// Set it out of screen
			rangeIndicator.x = -250
			rangeIndicator.y = -250
			
			addChild(rangeIndicator);
		}
		
		public function update(timeDelta:Number): void {
			if (timeDelta > 100 / 6 * 30)
				return;
			
			for (var index:uint = 0; index < zombies.length; ++index) {
				var zombie:Zombie = zombies[index];
				zombie.update(timeDelta);
				updateNormalCannons(zombie, timeDelta);
				
				
				// Testing the range of the cannon
			//	normalCannons[0].isInRange(zombie);
				
			}
			
			this.x = 400 - cameraPoint.x;
			this.y = 300 - cameraPoint.y;	
			
			// Not scrolling
			purchasePanel.x = purchasePanelPos.x - this.x
			purchasePanel.y = purchasePanelPos.y - this.y
			camera.update();
		}
		
		private function updateNormalCannons(zombie:Zombie, timeDelta:Number):void {
			for (var index:uint = 0; index < normalCannons.length; ++index) {
				var norCannon:Cannon = normalCannons[index];
				
				// If the cannon doesn't have a target, then check for the potential target that is in range
				if (norCannon.targetZombie == null) {
					if (norCannon.isInRange(zombie)) {
						norCannon.targetZombie = zombie;
					}
					
					// Go to the next cannon if this operation is done
					continue;
				}

				norCannon.update(timeDelta);
				updateBulletsOnScreen(norCannon.bullets);
			}
		}
		
		
		private function updateBulletsOnScreen(bullets:Array):void {
			for (var num:uint = 0; num < bullets.length; ++num) {
				var bullet:Bullet = bullets[num];
					
				if (bullet.needToBeAddedOnScreen) {
					bullet.needToBeAddedOnScreen = false;
					addChild(bullet);
				}
					
				if (bullet.needToBeRemovedOnScreen) {
					bullet.needToBeRemovedOnScreen = false;
					removeChild(bullet);
				}
			}
		}
		
		
		public function newNormalCannon(tileX:Number, tileY:Number):Cannon {
			var bullets:Array = new Array();
			
			// Three bullets for now
			bullets.push(new Bullet(textureAtlas.getTexture("normalbullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("normalbullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("normalbullet")));
			var newCannon:Cannon = new Cannon(textureAtlas.getTexture("normalcannon"), bullets, (tileX * 32) + 16, (tileY * 32) + 16);
			addChild(newCannon);
			
			return newCannon
		}
		
		public function addNormalCannon(cannon:Cannon):void {
			normalCannons.push(cannon)
		}
		
		private function addZombie(tileX:Number, tileY:Number):void {
			var aniRect:Rectangle = new Rectangle(0, 128, 480, 32);
			var zomAniBmpData:BitmapData = new BitmapData(480, 32); 
			zomAniBmpData.copyPixels(allBmp.bitmapData, aniRect, new Point());
			
			var newZombie:Zombie = new Zombie(zomAniBmpData, 32, 32, 15, 15, 1.0, Animation.PLAYMODE_ABNORMAL);
			newZombie.x = tileX * 32;
			newZombie.y = tileY * 32;
			addChild(newZombie.getImage());
			zombies.push(newZombie);
			
			// To be changed later if needed
			pathFinder.ignoreNodeList = map.getIgnoredNodeList();
			var list:Array = pathFinder.getShortestPath(tileX, tileY, 0, 8);
			
			for (var index:uint = 0; index < list.length; ++index) {
				trace("2:path: " + list[index].x + ": " + list[index].y);
			}
			
			newZombie.pathTracker.trackPathList(list);
		}
		
		public function setRangeIndicator(x:Number, y:Number, range:Number):void {
			rangeIndicator.setRadius(range);
			rangeIndicator.x = x - rangeIndicator.width / 2;
			rangeIndicator.y = y - rangeIndicator.height / 2;
		}
		
		
	}

}