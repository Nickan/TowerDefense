package framework1_0.finitestatemachine 
{
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	/**
	 * I was trying to use template, but I assume that AS3 doesn't have that feature. Using cannon entity for now, but later
	 * I will change this to be flexible
	 * @author Nickan
	 */
	public class StateMachine {
		// Should be changed
		private var baseEntity:BaseEntity
		
		private var currentState:BaseState = null
		private var globalState:BaseState = null
		private var previousState:BaseState = null
		
		public function StateMachine(baseEntity:BaseEntity) {
			this.baseEntity = baseEntity
		}
		
		public function update(timeDelta:Number):void {
			if (currentState != null) {
				currentState.update(baseEntity, timeDelta)
			}
			
			if (globalState != null) {
				globalState.update(baseEntity, timeDelta)
			}
			
		}
		
		public function handleMessage(telegram:Telegram):Boolean {
			if (currentState.onMessage(telegram)) {
				return true
			}
			
			if (globalState.onMessage(telegram)) {
				return true
			}

			return false
		}
		
		public function changeState(state:BaseState):void {
			previousState = currentState
			
			if (currentState != null) {
				currentState.exit(baseEntity)
			}
			
			currentState = state
			currentState.start(baseEntity)
		}
		
	}

}