package model.cannonstate 
{
	import framework1_0.finitestatemachine.BaseEntity;
	import framework1_0.finitestatemachine.BaseState;
	import framework1_0.finitestatemachine.messagingsystem.Telegram;
	import model.Bullet;
	import model.Cannon;
	
	/**
	 * ...
	 * @author Nickan
	 */
	public class IdleState implements BaseState {
		
		public function start(baseEntity:BaseEntity):void {
			
		}
		
		public function update(baseEntity:BaseEntity, timeDelta:Number):void {
			var cannon:Cannon = (Cannon) (baseEntity)
			
			cannon.numOfBulletFired = 0
			for (var index:uint = 0; index < cannon.bullets.length; ++index) {
				var bullet:Bullet = cannon.bullets[index]
				
				if (bullet.update) {		
					cannon.bulletUpdate(bullet, timeDelta)
					cannon.numOfBulletFired += 1
				}
				
			}
			
			if (cannon.numOfBulletFired == 0) {
				cannon.setTargetId(-1)
			}
		}
		
		public function exit(baseEntity:BaseEntity):void {
			
		}
		
		public function onMessage(telegram:Telegram):Boolean {
			return false
		}
	}

}