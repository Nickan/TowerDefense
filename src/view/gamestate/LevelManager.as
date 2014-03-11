package view.gamestate 
{
	/**
	 * Manages the zombie spawn
	 * @author Nickan
	 */
	public class LevelManager {
		private var gameLayer:GameLayer
		
		private var zombieSpawnNumber:uint = 0
		private var zombieSpawnLimit:uint = 50
		private var zombieSpawnTimer:Number = 0
		private var zombieSpawnInterval:Number = 2.0
		
		public function LevelManager(gameLayer:GameLayer) {
			this.gameLayer = gameLayer
		}
		
		public function update(timeDelta:Number):void {
			zombieSpawnUpdate(timeDelta)
		}
		
		private function zombieSpawnUpdate(timeDelta:Number):void {
			zombieSpawnTimer += timeDelta
			// Zombie spawn interval
			if (zombieSpawnTimer >= zombieSpawnInterval) {
				
				if (zombieSpawnNumber >= zombieSpawnLimit) {
					
				} else {
					spawnZombie()
					zombieSpawnTimer -= zombieSpawnInterval
					++zombieSpawnNumber
					
					//...
					trace("2:Zombie spawned: " + zombieSpawnNumber)
				}
			}
		}
		
		/**
		 * Randomly spawn a zombie
		 */
		private function spawnZombie():void {
			switch (zombieSpawnNumber % 9) {
			case 0:	gameLayer.addZombie(6, 0, gameLayer.path6_0)
				break
			case 1: gameLayer.addZombie(14, 0, gameLayer.path14_0)
				break
			case 2:	gameLayer.addZombie(21, 0, gameLayer.path21_0)
				break
			case 3:	gameLayer.addZombie(29, 0, gameLayer.path29_0)
				break
			case 4: gameLayer.addZombie(44, 0, gameLayer.path44_0)
				break
			case 5:	gameLayer.addZombie(50, 8, gameLayer.path50_8)
				break
			case 6:	gameLayer.addZombie(0, 8, gameLayer.path0_8)
				break
			case 7: gameLayer.addZombie(0, 23, gameLayer.path0_23)
				break
			case 8:	gameLayer.addZombie(50, 23, gameLayer.path50_23)
				break
			default:
				break
			}
		}
		
	}

}