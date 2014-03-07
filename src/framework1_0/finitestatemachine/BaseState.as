package framework1_0.finitestatemachine 
{
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	/**
	 * ...
	 * @author Nickan
	 */
	public interface BaseState {
		
		function start(baseEntity:BaseEntity):void
		
		function update(baseEntity:BaseEntity, timeDelta:Number):void
		
		function exit(baseEntity:BaseEntity):void
		
		function onMessage(telegram:Telegram):Boolean
	}

}