package framework1_0 
{
	/**
	 * My pathfinder version in ActionScript, mostly copied from my java version, there are still a lot of testing to do, 
	 * like setting some nodes to be occupied(blocked path), but there are some type of nodes that is only hard to travel, 
	 * so this pathfinder is still far from being complete
	 * @author Nickan
	 */
	public class AstarPathFinder  {
		public var tileWidth:uint;
		public var tileHeight:uint;
		
		/* The node maps where should the walkable and unwalkable tiles should be addressed*/
		private var nodeMap:Array;
		
		/* Potentially to be included in the closed list */
		private var openList:Array
		
		/* List of nodes that are having a least movement cost from the starting node to goal node */
		private var closedList:Array;
		
		/* List of nodes to be ignored when pathfinding */
		public var ignoreNodeList:Array;
		
		public var enableDiagonalMove:Boolean = false;
		
		//...
		public var adjacentNodes:Array = new Array()
		
		public function AstarPathFinder(tileWidth:uint, tileHeight:uint)  {
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			
			createNodeMap();
			ignoreNodeList = new Array();
		}
		
		private function createNodeMap(): void {
			nodeMap = new Array();
			for (var height:uint = 0; height <= tileHeight; ++height) {
				nodeMap.push(new Array());
				for (var width:uint = 0; width <= tileWidth; ++width) {
					nodeMap[height].push(new Node(width, height, Node.FREE));
				}
			}
		}
		
		public function getShortestPath(startX:uint, startY:uint, goalX:uint, goalY:uint) : Array {
			setHeuristics(nodeMap[goalY][goalX]);
			nullifyParents();		
			
			var loop:uint = 0;
			var loopLimit:uint = 300;
			
			var closedList:Array = new Array();
			
			var beingCheckedNode:Node = nodeMap[startY][startX];
			
			/* Potentially to be included in the closed list */
			openList = new Array();
			while (true) {
			
				// Get all the free nodes, including those in the open list, but don't belong in the closed list
				closedList.push(beingCheckedNode)
				var adjacentNodes:Array = getAdjacentFreeNodes(beingCheckedNode, closedList);

				analyzeAdjacentNodes(beingCheckedNode, adjacentNodes);
				
				// Get the next next that has the lowest f cost from the adjacent nodes
				var nextCheckNode:Node = getLowestHcostNode(adjacentNodes);
				
				if (nextCheckNode == null) {
					nextCheckNode = getLowestHcostNode(openList);
				}
				
				for (var i:uint = 0; i < openList.length; ++i) {
					if (nextCheckNode.same(openList[i].x, openList[i].y) ) {
						openList.splice(i, 1);
					}
				}

				if (nextCheckNode.same(goalX, goalY)) {
					trace("2:found! "  + loop);
					break;
				}
				
				beingCheckedNode = nextCheckNode;
				
				++loop;
				if (loop > loopLimit) {
				//	trace("2: Loop break: " + loop);
					break;
				}
			}
			
			return trackParentNode(startX, startY, goalX, goalY);
		}
		
		private function getLowestHcostNode(list:Array): Node {
			var hCost:uint = uint.MAX_VALUE;
			var lowestHcostNode:Node = null;
			
			for (var index:uint = 0; index < list.length; ++index) {
				var tempNode:Node = list[index];
				
				// If the tempNode being analyzed has the lower f cost compare to the current registed f cost
				// Then save the address of that node to compare against the remaining nodes in the list
				if (tempNode.h < hCost) {
					hCost = tempNode.h;
					lowestHcostNode = tempNode;
				}
			}
			
			return lowestHcostNode;
		}
		
		/**
		 * Returns the list of nodes adjacent to the node, excluding the node from the closedList and the occupied node
		 * @param	node
		 * @return
		 */
		private function getAdjacentFreeNodes(node:Node, closedList:Array): Array {
			// Clearing the adjacent node
			adjacentNodes.splice(0, adjacentNodes.length)
			
			var startX:int = node.x - 1;
			var startY:int = node.y - 1;
			
			for (var x:uint = 0; x < 3; ++x) {
				for (var y:uint = 0; y < 3; ++y) {
					
					// Don't include the passed node
					if (x == 1 && y == 1) 
						continue;
					
					// Limits of the node map
					if ( (startX + x >= 0 && startX + x < tileWidth) &&
						(startY + y >= 0 && startY + y < tileHeight) ) {
						
						var tempNode:Node = nodeMap[startY + y][startX + x];
						
						// Is node free and not belong in the closed list
						if ( tempNode.type == Node.FREE &&  !isInArray(tempNode, closedList)  && !isInArray(tempNode, ignoreNodeList) ) {
							
							if (enableDiagonalMove) {
								adjacentNodes.push(tempNode);
							} else {
								if (!isPlacedDiagonally(node, tempNode) ) {
									adjacentNodes.push(tempNode);
								}
							}
							
						}
					}
					
				}
			}
			
			return adjacentNodes;
		}
		
		private function isInArray(node:Node, nodeList:Array): Boolean {
			for (var index:uint = 0; index < nodeList.length; ++index) {
				if ( nodeList[index].same(node.x, node.y) ) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Analyze and performs needed operation based on the property of the individual adjacent node;
		 * @param	beingCheckedNode
		 * @param	adjacentNodes
		 */
		private function analyzeAdjacentNodes(beingCheckedNode:Node, adjacentNodes:Array): void {
			for (var index:uint = 0; index < adjacentNodes.length; ++index) {
				var adjNode:Node = adjacentNodes[index];
				
				var g:uint;
				// The node is not in the open list, set their f cost. Cost of h will be plus 14 if diagonally placed to the
				// being checked node, plus 10 to vertically and horizontally placed
				if (!isInArray(adjNode, openList) ) {
					openList.push(nodeMap[adjNode.y][adjNode.x]);

					// Set their parent node
					adjNode.parentNode = beingCheckedNode
					
					// If the beingCheckedNode is diagonally placed, it has to add 14 to the g cost of the adjacent node
					// Otherwise 10
					g = (isPlacedDiagonally(beingCheckedNode, adjNode)) ? 14 : 10;
					adjNode.g = g + beingCheckedNode.g;
					adjNode.f = adjNode.g + adjNode.h;
				} else {
					// The tempNode is in the open list, check if the g cost to move to the tempNode from the being checked node
					// is lower than the tempNode's current g cost from the starting node, then change its parent to the being
					// Cheched node and recalculate its g cost
					g = (isPlacedDiagonally(beingCheckedNode, adjNode)) ? 14 : 10;
					if (beingCheckedNode.g + g < adjNode.g) {
						
						if (enableDiagonalMove) {
							if (!isPlacedDiagonally(beingCheckedNode, adjNode) ) {
								adjNode.g = beingCheckedNode.g + g;
								adjNode.f = adjNode.g + adjNode.h;
								adjNode.parentNode = beingCheckedNode;
							}
						} else {
							adjNode.g = beingCheckedNode.g + g;
							adjNode.f = adjNode.g + adjNode.h;
							adjNode.parentNode = beingCheckedNode;
						}
					}
				}
			}
		}
		
		private function trackParentNode(startX:uint, startY:uint, goalX:uint, goalY:uint): Array {
			var shortestPath:Array = new Array();
			
			// Add the starting node
			shortestPath.push(nodeMap[goalY][goalX]);
			
			var lastNode:Node = nodeMap[goalY][goalX];
			
			// Loop until the parent is null
			while (true) {
				var parentNode:Node = lastNode.parentNode;
				
				if (parentNode != null) {
					
					// Don't include the starting node
					if (parentNode.same(startX, startY)) {
						break;
					}
					
					shortestPath.push(parentNode);
					lastNode = parentNode;
				} else {
					break;
				}
			}
			
			return shortestPath;
		}
		

		private function setHeuristics(goalNode:Node): void {
			for (var y:uint = 0; y <= tileHeight; ++y) {
				for (var x:uint = 0; x <= tileWidth; ++x) {
					nodeMap[y][x].h = getHeuristic(x, y, goalNode);
				}
			}
		}
		
		private function nullifyParents(): void {
			for (var y:uint = 0; y < tileHeight; ++y) {
				for (var x:uint = 0; x < tileWidth; ++x) {
					nodeMap[y][x].parentNode = null;
				}
			}
		}
		
		private function getHeuristic(tileX:uint, tileY:uint, goalNode:Node): uint {
			return Math.abs(tileX - goalNode.x) + Math.abs(tileY - goalNode.y);
		}
		
		/**
		 * Returns if the two adjacent nodes if placed diagonally from each other, but make sure that they are really adjacent to each other
		 * @param	basedNode
		 * @param	testNode
		 * @return
		 */
		private function isPlacedDiagonally(basedNode:Node, testNode:Node): Boolean {
			return ( (basedNode.x != testNode.x) && (basedNode.y != testNode.y) ) ? true : false;
		}
		
		private function clear(): void {
			for (var height:uint = 0; height < tileHeight; ++height) {
				for (var width:uint = 0; width < tileWidth; ++width) {
					nodeMap[height][width].type = Node.FREE;
				}
			}
		}
		
	}

}