package framework1_0.finitestatemachine 
{
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	/**
	 * Temporary ancestor for the use of FSM
	 * @author Nickan
	 */
	public class BaseEntity {
		private var id:int
		
		public function BaseEntity() {
			this.id = EntityManager.getNewId(this)
		}
		
		public function handleTelegram(telegram:Telegram):Boolean {
			return false
		}
		
		public function getId():int {
			return id
		}
		
	}

}