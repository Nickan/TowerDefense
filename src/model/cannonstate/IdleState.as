package model.cannonstate 
{
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.BaseState;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class IdleState implements BaseState {
		
		public function start(baseEntity:BaseEntity):void {
			
		}
		
		public function update(baseEntity:BaseEntity, timeDelta:Number):void {
			
		}
		
		public function exit(baseEntity:BaseEntity):void {
			
		}
		
		public function onMessage(telegram:Telegram):Boolean {
			return false
		}
	}

}