package view.menustate 
{
	import citrus.core.starling.StarlingState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import framework1_0.Animation;
	import framework1_0.RectangleImage;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import view.gamestate.GameState;
	/**
	 * ...
	 * @author Nickan
	 */
	public class MenuState extends StarlingState {
		public var main:Main
		
		[Embed(source="../../../assets/allmenuimages.png")]
		private var AllMenuBitmap:Class
		private var allMenuBitmap:Bitmap = new AllMenuBitmap()
		
		private var titleImage:Image
		private var startImage:Image
		private var exitImage:Image
		private var aniCursor:Animation
		private var aniCursorStatetime:Number = 0
		
		private var showAniCursorOnStart:Boolean = false
		private var showAniCursorOnExit:Boolean = false
		
		public function MenuState(main:Main) {
			super()
			this.main = main
			addEventListener(Event.ADDED_TO_STAGE, onAdded)
		}
		
		override public function initialize():void {
			super.initialize()
		}
		
		private function onAdded():void {
			var titleRect:Rectangle = new Rectangle(0, 96, 384, 192)
			var tempBmpData:BitmapData = new BitmapData(titleRect.width, titleRect.height)
			tempBmpData.copyPixels(allMenuBitmap.bitmapData, titleRect, new Point())
			titleImage = new Image(Texture.fromBitmapData(tempBmpData))
			
			titleImage.x = 400 - titleImage.width / 2
			titleImage.y = 300 - titleImage.height / 1.5
			
			var playRect:Rectangle = new Rectangle(10, 80, 43, 13)
			tempBmpData = new BitmapData(playRect.width, playRect.height)
			tempBmpData.copyPixels(allMenuBitmap.bitmapData, playRect, new Point())
			startImage = new Image(Texture.fromBitmapData(tempBmpData))
			startImage.x = 400 - startImage.width / 2
			startImage.y = titleImage.y + titleImage.height + 35
			
			var exitRect:Rectangle = new Rectangle(60, 80, 43, 13)
			tempBmpData = new BitmapData(exitRect.width, exitRect.height)
			tempBmpData.copyPixels(allMenuBitmap.bitmapData, exitRect, new Point())
			exitImage = new Image(Texture.fromBitmapData(tempBmpData))
			exitImage.x = 400 - startImage.width / 2
			exitImage.y = titleImage.y + titleImage.height + 70
			
			
			var aniCursorRect:Rectangle = new Rectangle(0, 0, 800, 80)
			tempBmpData = new BitmapData(aniCursorRect.width, aniCursorRect.height)
			tempBmpData.copyPixels(allMenuBitmap.bitmapData, aniCursorRect, new Point())
			aniCursor = new Animation(tempBmpData, 80, 80, 10, 10, 0.5, Animation.PLAYMODE_LOOP)
			
			addChild(aniCursor.image)
			addChild(titleImage)
			addChild(startImage)
			addChild(exitImage)
			
			aniCursor.image.scaleY = 0.5
			
			startImage.stage.addEventListener(TouchEvent.TOUCH, onTouch)
		}
		
		private function onTouch(touchEvent:TouchEvent):void {
			var touch:Touch = touchEvent.getTouch(stage)
			
			if (touch == null) {
				return
			}
			
			if (touch.phase == TouchPhase.BEGAN) {
				if (startImage.bounds.contains(touch.globalX, touch.globalY)) {
					showAniCursorOnStart = true
					main.state = new GameState()
					this.destroy()
				} else if (exitImage.bounds.contains(touch.globalX, touch.globalY)) {
					showAniCursorOnExit = true
				} else {
					showAniCursorOnExit = false
					showAniCursorOnStart = false
				}
				
			}
			
			if (touch.phase == TouchPhase.ENDED) {
				if (startImage.bounds.contains(touch.globalX, touch.globalY)) {
					
				} else if (exitImage.bounds.contains(touch.globalX, touch.globalY)) {
					
				} else {
					
				}
				showAniCursorOnExit = false
				showAniCursorOnStart = false
			}
			
		}
		
		override public function update(timeDelta:Number):void {
			aniCursorStatetime += timeDelta
			
			var aniCursorX:Number = -100
			var aniCursorY:Number = -100
			if (showAniCursorOnStart) {
				aniCursorX = 400
				aniCursorY = titleImage.y + titleImage.height + 35 + (startImage.height / 2)
			} else if (showAniCursorOnExit) {
				aniCursorX = 400
				aniCursorY = titleImage.y + titleImage.height + 70 + (exitImage.height / 2)
			}
			
			aniCursor.update(aniCursorX, aniCursorY , aniCursorStatetime)
			
			camera.update()
		}
		
	}

}