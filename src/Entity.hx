// The Entity interface
interface Entity {
	// Returns the health of the entity
	public function getHealth():Int;

	// Removes health from the entity
	public function removeHealth(removeHealth:Int):Void;

	// Retruns the damage of the entity
	public function getDamage():Int;

	// Returns the armor of the entity
	public function getArmor():Int;

	// Returns the level of the entity
	public function getLevel():Int;

	// Checks if the entity is still alive
	public function isAlive():Bool;

	// Prints all the stats of the entity
	public function printStats():Void;
}
