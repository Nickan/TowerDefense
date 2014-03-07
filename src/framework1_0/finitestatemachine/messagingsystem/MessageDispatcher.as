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
			if (dispatchTime <= 0) {
				sendMessage(new Telegram(senderId, receiverId, dispatchTime, msg, extraInfo));
			} else {
				telegrams.add(new Telegram(senderId, receiverId, dispatchTime, msg, extraInfo));
			}
		}
		
		private static function dischargeTelegram(telegram:Telegram):void {
			var baseEntity:BaseEntity = EntityManager.getEntity(telegram.receiverId)
			
			// Find and delete the telegram if found
			for (var index:int = 0; index < telegrams.length; ++index) {
				if (telegrams[index] == telegram) {
					telegrams.splice(index, 1)
				}
			}
		}
		
	}

}