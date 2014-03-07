package framework1_0.finitestatemachine.messagingsystem 
{
	/**
	 * 
	 * @author Nickan
	 */
	public class Telegram {
		public var senderId:int
		public var receiverId:int
		public var message:int
		public var dispatchTime:Number
		public var extraInfo:Object
		
		public function Telegram(senderId:int, receiverId:int, message:int, dispatchTime:Number, extraInfo:Object) {
			this.senderId = senderId
			this.receiverId = receiverId
			this.message = message
			this.dispatchTime = dispatchTime
			this.extraInfo = extraInfo
		}
		
	}

}