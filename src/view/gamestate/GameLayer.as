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
	import framework1_0.finitestatemachine.messagingsystem.Message;
	import framework1_0.finitestatemachine.messagingsystem.MessageDispatcher;
	import framework1_0.Node;
	import framework1_0.RotationManager;
	import model.Bullet;
	import model.Cannon;
	import model.SplashCannon;
	import model.Map;
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
		
		
		public var normalCannons:Array
		public var splashCannons:Array
		public var iceCannons:Array
		
		private var zombies:Array;
		
		{ // Images
		[Embed(source="../../../assets/images.png")]
		private var BitmapAtlas:Class;
		private var bitmapAtlas:Bitmap = new BitmapAtlas();
		
		[Embed(source="../../../assets/images.xml", mimeType="application/octet-stream")]
		private var BitmapAtlasXml:Class;
	
		private var textureAtlas:TextureAtlas;
		
		[Embed(source="../../../assets/allanimations.png")]
		private var AllBmp:Class;
		private var allBmp:Bitmap = new AllBmp();
		}
		
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
		
		public var purchasePanel:PurchasePanel
		public var purchasePanelPos:Point = new Point(320, 480)
		
		// It is CPU intensive to set the range of the circle range indicator, so if the range set is just the same as before,
		// there is no point setting it up again
		private var rangeIndicatorValue:Number
		
		private var zombieSpawnNumber:uint = 0
		private var zombieSpawnLimit:uint = 50
		private var zombieSpawnTimer:Number = 0
		private var zombieSpawnInterval:Number = 2.0
		
		public function GameLayer(camera:StarlingCamera)  {
			super();
			this.camera = camera;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(): void {
			initializeBackground()
			initializeRangeIndicator()
			
			bitmapAtlas = new BitmapAtlas()
			
			textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmapAtlas), XML(new BitmapAtlasXml()))
			
			normalCannons = new Array()
			splashCannons = new Array()
			iceCannons = new Array()
			zombies = new Array();
			
			pathFinder.ignoreNodeList = map.getIgnoredNodeList();
		//	for (var num:uint = 0; num < 10; ++num) {
				addZombie(6, 0);
		//	}
			
			
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
			
			// Set it out of screen
			rangeIndicator.x = -250
			rangeIndicator.y = -250
			
			addChild(rangeIndicator);
		}
		
		public function update(timeDelta:Number): void {
			if (timeDelta > 100 / 6 * 30)
				return;
				
			zombieSpawnTimer += timeDelta
			// Zombie spawn interval
			if (zombieSpawnTimer >= zombieSpawnInterval) {
				
				if (zombieSpawnNumber >= zombieSpawnLimit) {
					
				} else {
					addZombie(6, 0)
					zombieSpawnTimer -= zombieSpawnInterval
					++zombieSpawnNumber
				}
			}
			
			for (var index:uint = 0; index < zombies.length; ++index) {
				var zombie:Zombie = zombies[index];
				if (zombie.life > 0) {
				
					zombie.update(timeDelta);
				} else {
					removeZombie(zombie)
					break;
				}
			}
			
			updateNormalCannons(timeDelta)
			updateSplashCannons(timeDelta)
			updateIceCannons(timeDelta)
			
			this.x = 400 - cameraPoint.x;
			this.y = 300 - cameraPoint.y;	
			
			// Not scrolling
			purchasePanel.x = purchasePanelPos.x - this.x
			purchasePanel.y = purchasePanelPos.y - this.y
			camera.update();
			
			MessageDispatcher.update(timeDelta)
		}
		
		private function updateNormalCannons(timeDelta:Number):void {
			for (var index:uint = 0; index < normalCannons.length; ++index) {
				var norCannon:Cannon = normalCannons[index];
				
				for (var zomIndex:uint = 0; zomIndex < zombies.length; ++zomIndex) {
					var zombie:Zombie = zombies[zomIndex]
					// If the cannon doesn't have a target, then check for the potential target that is in range
					if (norCannon.getTargetId() == -1) {
						if (norCannon.isInRange(zombie.getBounds())) {
							norCannon.setTargetId(zombie.getId())
						}
					}
				}
				

				norCannon.update(timeDelta);
				updateBulletsOnScreen(norCannon.bullets);
			}
		}
		
		private function updateSplashCannons(timeDelta:Number):void {
			for (var index:uint = 0; index < splashCannons.length; ++index) {
				var splashCannon:SplashCannon = splashCannons[index];

				for (var zomIndex:uint = 0; zomIndex < zombies.length; ++zomIndex) {
					var zombie:Zombie = zombies[zomIndex]
					// If the cannon doesn't have a target, then check for the potential target that is in range
					if (splashCannon.getTargetId() == -1) {
						if (splashCannon.isInRange(zombie.getBounds())) {
							splashCannon.setTargetId(zombie.getId())
						}
					}
				}
				
				splashCannon.update(timeDelta)
				if (splashCannon.isBulletHitTheGround()) {
					splashBulletHitTheGround(splashCannon)
				}
				updateBulletsOnScreen(splashCannon.bullets);
			}
		}
		
		private function splashBulletHitTheGround(splashCannon:SplashCannon):void {
			
			// Loop through all of the zombie, not so wise, to be changed later if I have time
			for (var index:uint = 0; index < zombies.length; ++index) {
				var zombie:Zombie = zombies[index]
				var zomBounds:Rectangle = zombie.getBounds()
				if (isInRange(splashCannon.getTargetArea().x, splashCannon.getTargetArea().y, 
						zomBounds.x + zomBounds.width / 2, zomBounds.y + zomBounds.height / 2, splashCannon.blastRadius) ) {
					//...
					trace("2:Boom!")
				}
				
			}
		}
		
		private function updateIceCannons(timeDelta:Number):void {
			for (var index:uint = 0; index < iceCannons.length; ++index) {
				var iceCannon:SplashCannon = iceCannons[index];
				
				for (var zomIndex:uint = 0; zomIndex < zombies.length; ++zomIndex) {
					var zombie:Zombie = zombies[zomIndex]
					// If the cannon doesn't have a target, then check for the potential target that is in range
					if (iceCannon.getTargetId() == -1) {
						if (iceCannon.isInRange(zombie.getBounds())) {
							iceCannon.setTargetId(zombie.getId())
						}
					}
				}

				iceCannon.update(timeDelta);
				if (iceCannon.isBulletHitTheGround()) {
					iceBulletHitTheGround(iceCannon)
				}
				updateBulletsOnScreen(iceCannon.bullets);

			}
		}
		
		private function iceBulletHitTheGround(splashCannon:SplashCannon):void {
			
			// Loop through all of the zombie, not so wise, to be changed later if I have time
			for (var index:uint = 0; index < zombies.length; ++index) {
				var zombie:Zombie = zombies[index]
				var zomBounds:Rectangle = zombie.getBounds()
				if (isInRange(splashCannon.getTargetArea().x, splashCannon.getTargetArea().y, 
						zomBounds.x + zomBounds.width / 2, zomBounds.y + zomBounds.height / 2, splashCannon.blastRadius) ) {
					//...
					trace("2:Slow!")
					MessageDispatcher.dispatchTelegram(splashCannon.getId(), zombie.getId(), Message.SLOWED, 0, splashCannon.slowScale)
				}
				
			}
		}
		
		
		
		private function updateBulletsOnScreen(bullets:Array):void {
			for (var num:uint = 0; num < bullets.length; ++num) {
				var bullet:Bullet = bullets[num];
					
				if (bullet.needToBeAddedOnScreen) {
					bullet.needToBeAddedOnScreen = false;
					addChild(bullet);
				}
				
				// Also means that the bullet has hit the ground, but normal cannon also uses this
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
			addChild(newCannon.image);
			
			return newCannon
		}
		
		public function addNormalCannon(cannon:Cannon):void {
			normalCannons.push(cannon)
		}
		
		public function removeNormalCannon(cannon:Cannon):void {
			removeChild(cannon.image)
			removeCannonFromArray(cannon, normalCannons)
		}
		
		public function newSplashCannon(tileX:Number, tileY:Number):Cannon {
			var bullets:Array = new Array();
			
			// Three bullets for now
			bullets.push(new Bullet(textureAtlas.getTexture("splashbullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("splashbullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("splashbullet")));
			var newCannon:Cannon = new SplashCannon(textureAtlas.getTexture("splashcannon"), bullets, (tileX * 32) + 16, (tileY * 32) + 16);
			addChild(newCannon.image);
			
			return newCannon
		}
		
		public function addSplashCannon(cannon:Cannon):void {
			splashCannons.push(cannon)
		}
		
		public function removeSplashCannon(cannon:Cannon):void {
			removeChild(cannon.image)
			removeCannonFromArray(cannon, splashCannons)
		}
		
		public function newIceCannon(tileX:Number, tileY:Number):Cannon {
			var bullets:Array = new Array();
			
			// Three bullets for now
			bullets.push(new Bullet(textureAtlas.getTexture("icebullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("icebullet")));
			bullets.push(new Bullet(textureAtlas.getTexture("icebullet")));
			
			var newCannon:Cannon = new SplashCannon(textureAtlas.getTexture("icecannon"), bullets, (tileX * 32) + 16, (tileY * 32) + 16);
			addChild(newCannon.image);
			
			return newCannon
		}
		
		public function addIceCannon(cannon:Cannon):void {
			iceCannons.push(cannon)
		}
		
		public function removeIceCannon(cannon:Cannon):void {
			removeChild(cannon.image)
			removeCannonFromArray(cannon, iceCannons)
		}
		
		private function addZombie(tileX:Number, tileY:Number):void {
			var aniRect:Rectangle = new Rectangle(0, 128, 480, 32)
			var walkingBmpData:BitmapData = new BitmapData(480, 32)
			walkingBmpData.copyPixels(allBmp.bitmapData, aniRect, new Point())
			
			// Changed to the freezing frameset
			var freezeRect:Rectangle = new Rectangle(0, 160, 480, 32)
			var freezingBmpData:BitmapData = new BitmapData(480, 32)
			freezingBmpData.copyPixels(allBmp.bitmapData, freezeRect, new Point())
			
			var newZombie:Zombie = new Zombie(walkingBmpData, freezingBmpData, this, 32, 32, 15, 15, 1.0, Animation.PLAYMODE_LOOP);
			newZombie.x = tileX * 32;
			newZombie.y = tileY * 32;
			zombies.push(newZombie);

			// To be changed later if needed
			
			var list:Array = pathFinder.getShortestPath(tileX, tileY, 0, 8);
			
			for (var index:uint = 0; index < list.length; ++index) {
		//		trace("2:path: " + list[index].x + ": " + list[index].y);
			}
			
			newZombie.pathTracker.trackPathList(list);
		}
		
		private function removeZombie(zombie:Zombie):void {
			removeChild(zombie.getImage())
			removeChild(zombie.lifeBar)
			for (var index:uint = 0; index < zombies.length; ++index) {
				if (zombies[index] == zombie) {
					zombies.splice(index, 1)
					break
				}
			}
		}
		
		
		public function setRangeIndicator(x:Number, y:Number, range:Number):void {
			if (rangeIndicatorValue != range) {
				rangeIndicator.setRadius(range)
				rangeIndicatorValue = range
			}

			rangeIndicator.x = x - rangeIndicator.width / 2;
			rangeIndicator.y = y - rangeIndicator.height / 2;
		}
		
		
		public function removeCannonFromArray(cannon:Cannon, cannonList:Array):Boolean {
			for (var index:int = 0; index < cannonList.length; ++index) {
				if (cannonList[index] == cannon) {
					cannonList.splice(index, 1)
					return true
				}
			}
			return false
		}
		
		
		public function isInRange(x1:Number, y1:Number, x2:Number, y2:Number, range:Number): Boolean {
			var distX:Number = x1 - x2
			var distY:Number = y1 - y2
			var dist:Number = distX * distX + distY * distY

			if (dist < range * range) {
				return true
			}
			return false
		}
		
	}

}