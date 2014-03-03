package model 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import framework1_0.GameSprite;
	import framework1_0.RotationManager;
	import starling.display.Sprite
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author Nickan
	 */
	public class PurchasePanel extends Sprite {
		
		{ // Board GameSprites
		private var topLeftCorner:GameSprite
		private var topRightCorner:GameSprite;
		
		private var bottomLeftCorner:GameSprite
		private var bottomRightCorner:GameSprite
		
		private var topSide_1:GameSprite
		private var topSide_2:GameSprite
		
		private var botSide_1:GameSprite
		private var botSide_2:GameSprite
		
		private var leftSide:GameSprite
		private var rightSide:GameSprite
		
		private var clearTile_1:GameSprite
		private var clearTile_2:GameSprite
		}
		
//		{ // Icon clickable GameSprites
		private var bagMoney:GameSprite
		
		private var firstGrid:GameSprite
		private var secondGrid:GameSprite
		private var thirdGrid:GameSprite
		
		private var norCan:GameSprite
		private var norCanBullet:GameSprite
		private var norCanBroken:GameSprite
		
		private var splashCan:GameSprite
		private var splashCanBullet:GameSprite
		private var splashCanBroken:GameSprite
		
		private var iceCan:GameSprite
		private var iceCanBullet:GameSprite
		private var iceCanBroken:GameSprite
		
		
//		}
		
		public function PurchasePanel(textureAtlas:TextureAtlas) {
			createPanelBoard(textureAtlas)
			initializeIcons(textureAtlas)
		}
		
		private function createPanelBoard(textureAtlas:TextureAtlas):void {
			topLeftCorner = new GameSprite(textureAtlas.getTexture("panelcorner"), 0, 0, 0)
			topRightCorner = new GameSprite(textureAtlas.getTexture("panelcorner"), 96, 0, 90)
			bottomLeftCorner = new GameSprite(textureAtlas.getTexture("panelcorner"), 0, 64, 270)
			bottomRightCorner = new GameSprite(textureAtlas.getTexture("panelcorner"), 96, 64, 180)
			
			
			topSide_1 = new GameSprite(textureAtlas.getTexture("panelside"), 32, 0, 0)
			topSide_2 = new GameSprite(textureAtlas.getTexture("panelside"), 64, 0, 0)
			
			botSide_1 = new GameSprite(textureAtlas.getTexture("panelside"), 32, 64, 180)
			botSide_2 = new GameSprite(textureAtlas.getTexture("panelside"), 64, 64, 180)
			
			leftSide = new GameSprite(textureAtlas.getTexture("panelside"), 0, 32, 270)
			rightSide = new GameSprite(textureAtlas.getTexture("panelside"), 96, 32, 90)
			
			clearTile_1 = new GameSprite(textureAtlas.getTexture("panelclear"), 32, 32, 0)
			clearTile_2 = new GameSprite(textureAtlas.getTexture("panelclear"), 64, 32, 0)
			
			addChild(topLeftCorner.image)
			addChild(topRightCorner.image)
			
			addChild(topSide_1.image)
			addChild(topSide_2.image)
			
			addChild(botSide_1.image)
			addChild(botSide_2.image)
			
			addChild(bottomLeftCorner.image)
			addChild(bottomRightCorner.image)
			
			addChild(leftSide.image)
			addChild(rightSide.image)
			
			addChild(clearTile_1.image)
			addChild(clearTile_2.image)
		}
		
		private function initializeIcons(textureAtlas:TextureAtlas):void {
			firstGrid = new GameSprite(textureAtlas.getTexture("square"), 8, 8)
			firstGrid.setScale(1.25, 1.25)
			
			secondGrid = new GameSprite(textureAtlas.getTexture("square"), 48, 8)
			secondGrid.setScale(1.25, 1.25)
			
			thirdGrid = new GameSprite(textureAtlas.getTexture("square"), 88, 8)
			thirdGrid.setScale(1.25, 1.25)
			
			bagMoney = new GameSprite(textureAtlas.getTexture("bagmoney"), secondGrid.getX() - 2, secondGrid.getY() - 2)
			bagMoney.setScale(0.75, 0.75)
			
			norCan = new GameSprite(textureAtlas.getTexture("normalcannon"))
			norCanBullet = new GameSprite(textureAtlas.getTexture("normalbullet"))
			norCanBroken = new GameSprite(textureAtlas.getTexture("normalcannonbroken"))

			splashCan = new GameSprite(textureAtlas.getTexture("splashcannon"), firstGrid.getX() + 4, firstGrid.getY() + 8)
			splashCanBullet = new GameSprite(textureAtlas.getTexture("splashbullet"), firstGrid.getX(), firstGrid.getY())
			splashCanBroken = new GameSprite(textureAtlas.getTexture("splashcannonbroken"))
			
			iceCan = new GameSprite(textureAtlas.getTexture("icecannon"), firstGrid.getX() + 4, firstGrid.getY() + 8)
			iceCanBullet = new GameSprite(textureAtlas.getTexture("icebullet"), firstGrid.getX(), firstGrid.getY())
			iceCanBroken = new GameSprite(textureAtlas.getTexture("icecannonbroken"))
			
			purchaseMode()
		}
		
		public function purchaseMode():void {
			clear()
			norCan.setPosition(firstGrid.getX() + 4, firstGrid.getY() + 8)
			norCan.setScale(1.0, 1.0)

			splashCan.setPosition(secondGrid.getX() + 4, secondGrid.getY() + 8)
			splashCan.setScale(1.0, 1.0)
			
			iceCan.setPosition(thirdGrid.getX() + 4, thirdGrid.getY() + 8)
			iceCan.setScale(1.0, 1.0)
			
			addChild(norCan.image)
			addChild(splashCan.image)
			addChild(iceCan.image)
			
			addGrids()
		}
		
		public function addNorCanOption():void {
			clear()
			norCan.setPosition(firstGrid.getX() + 4, firstGrid.getY() + 12)
			norCan.setScale(1.25, 1.25)
			
			norCanBullet.setPosition(firstGrid.getX(), firstGrid.getY())
			norCanBullet.setScale(1.25, 1.25)
			
			norCanBroken.setPosition(secondGrid.getX() + 4, secondGrid.getY() + 12)
			norCanBroken.setScale(1.25, 1.25)
			
			addChild(norCan.image)
			addChild(norCanBullet.image)
			addChild(norCanBroken.image)
			addChild(bagMoney.image)
			
			addGrids()
		}
		
		public function addSplashCanOption():void {
			clear()
			splashCan.setPosition(firstGrid.getX() + 4, firstGrid.getY() + 12)
			splashCan.setScale(1.25, 1.25)
			
			splashCanBullet.setPosition(firstGrid.getX(), firstGrid.getY())
			splashCanBullet.setScale(1.25, 1.25)
			
			splashCanBroken.setPosition(secondGrid.getX() + 4, secondGrid.getY() + 12)
			splashCanBroken.setScale(1.25, 1.25)
			
			addChild(splashCan.image)
			addChild(splashCanBullet.image)
			addChild(splashCanBroken.image)
			addChild(bagMoney.image)
			
			addGrids()
		}
		
		public function addIceCanOption():void {
			clear()
			iceCan.setPosition(firstGrid.getX() + 4, firstGrid.getY() + 12)
			iceCan.setScale(1.25, 1.25)
			
			iceCanBullet.setPosition(firstGrid.getX(), firstGrid.getY())
			iceCanBullet.setScale(1.25, 1.25)
			
			iceCanBroken.setPosition(secondGrid.getX() + 4, secondGrid.getY() + 12)
			iceCanBroken.setScale(1.25, 1.25)
			
			addChild(iceCan.image)
			addChild(iceCanBullet.image)
			addChild(iceCanBroken.image)
			addChild(bagMoney.image)
			
			addGrids()
		}
		
		private function addGrids():void {
			addChild(firstGrid.image)
			addChild(secondGrid.image)
			addChild(thirdGrid.image)
		}
		
		public function clear():void {
			removeChild(norCan.image)
			removeChild(norCanBullet.image)
			removeChild(norCanBroken.image)
			
			removeChild(splashCan.image)
			removeChild(splashCanBullet.image)
			removeChild(splashCanBroken.image)
			
			removeChild(iceCan.image)
			removeChild(iceCanBullet.image)
			removeChild(iceCanBroken.image)
			
			removeChild(bagMoney.image)
			
			removeChild(firstGrid.image)
			removeChild(secondGrid.image)
			removeChild(thirdGrid.image)
		}
		
		
		public function getFirstRect():Rectangle {
			return firstGrid.image.bounds
		}
		
		public function getSecondRect():Rectangle {
			return secondGrid.image.bounds
		}
		
		public function getThirdRect():Rectangle {
			return thirdGrid.image.bounds
		}
		
	}

}