package framework1_0.finitestatemachine 
{
	import flash.geom.Rectangle;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	/**
	 * Temporary ancestor for the use of FSM
	 * @author Nickan
	 */
	public class BaseEntity {
		protected var id:int
		protected var bounds:Rectangle
		
		public function BaseEntity(bounds:Rectangle) {
			this.bounds = bounds
			this.id = EntityManager.getNewId(this)
		}
		
		public function handleTelegram(telegram:Telegram):Boolean {
			return false
		}
		
		public function getId():int {
			return id
		}
		
		public function getBounds():Rectangle {
			return bounds
		}
		
	}

}