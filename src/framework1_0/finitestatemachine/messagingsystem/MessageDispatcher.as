package framework1_0.finitestatemachine.messagingsystem 
{
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.EntityManager;
	/**
	 * 
	 * @author Nickan
	 */
	public class MessageDispatcher {
		private static var telegrams:Array = new Array()
		
		public function MessageDispatcher() { }
		
		public static function update(timeDelta:Number):void {
			for (var index:int = 0; index < telegrams.length; ++index) {
				var telegram:Telegram = telegrams[index]
				telegram.dispatchTime -= timeDelta
				
				if (telegram.dispatchTime <= 0) {
					dischargeTelegram(telegram)
					break
				}
			}
		}
		
		public static function dispatchTelegram(senderId:int, receiverId:int, message:int, dispatchTime:Number, extraInfo:Object):void {
			var telegram:Telegram = new Telegram(senderId, receiverId, message, dispatchTime, extraInfo)
			// Creating new instance in push() is not working, should create address first before passing it
			telegrams.push(telegram)
			
			if (dispatchTime <= 0) {
				dischargeTelegram(telegram)
			}
		}
		
		private static function dischargeTelegram(telegram:Telegram):void {
			var baseEntity:BaseEntity = EntityManager.getEntity(telegram.receiverId)

			// Make sure the telegram is handled, else discharge it again
			if (baseEntity.handleTelegram(telegram)) {
				
				// Find and delete the telegram if found
				for (var index:int = 0; index < telegrams.length; ++index) {
					if (telegrams[index] == telegram) {
						telegrams.splice(index, 1)
					}
				}
			}
			
		}
		
	}

}