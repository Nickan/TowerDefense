package view.gamestate 
{
	/**
	 * Keeps the player's current money, zombie kills, current life, sounds, bgm, etc.
	 * @author Nickan
	 */
	public class GameSettings {
		public static var life:int = 20
		public static var money:int = 100
		public static var zombieKills:uint = 0
		
		public function GameSettings() { }
		
		public static function reset():void {
			life = 20
			money = 100
			zombieKills = 0
		}
		
	}

}