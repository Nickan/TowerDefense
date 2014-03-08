package framework1_0.finitestatemachine 
{
	/**
	 * ...
	 * @author Nickan
	 */
	public class EntityManager {
		private static var entities:Array = new Array()
		private static var counterId:int = -1
		
		public function EntityManager() { }
		
		/**
		 * Returns a new id for a BaseEntity
		 * @param	baseEntity
		 * @return
		 */
		public static function getNewId(baseEntity:BaseEntity):int {
			entities.push(baseEntity)
			return ++counterId
		}
		
		/**
		 * Deletes a BaseEntity from the EntityManager
		 * @param	int id
		 * @return
		 */
		public static function deleteEntity(id:int):Boolean {
			for (var index:int = 0; index < entities.length; ++index) {
				if (entities[index].getId() == id) {
					entities.splice(index, 1)
					return true
				}
			}
			return false
		}
		
		/**
		 * Returns a baseEntity based on its assigned ID
		 * @param	int id
		 * @return
		 */
		public static function getEntity(id:int):BaseEntity {
			for (var index:int = 0; index < entities.length; ++index) {
				if (entities[index].getId() == id) {
					return entities[index]
				}
			}
			return null
		}
		
	}

}