// The Boss class
class Boss implements Entity {
	private var health:Int;
	private var damage:Int;
	private var armor:Int;
	private var level:Int;

	// Constructor that instantiates a boss based on a given level
	public function new(level:Int) {
		this.level = level;
		this.health = 15 * level;
		this.damage = 10 * level;
		this.armor = 5 * level;
	}

	// Returns the health of the boss
	public function getHealth():Int {
		return this.health;
	}

	// Removes health from the boss
	public function removeHealth(removeHealth:Int) {
		this.health = this.health - removeHealth;
	}

	// Returns the damage of the boss
	public function getDamage():Int {
		return this.damage;
	}

	// Returns the armor of the boss
	public function getArmor():Int {
		return this.armor;
	}

	// Returns the level of the boss
	public function getLevel():Int {
		return this.level;
	}

	// Checks if the boss is alive
	public function isAlive():Bool {
		return this.health > 0;
	}

	// Prints all the stats of the boss
	public function printStats():Void {
		Sys.println("Boss: lv." + this.level + " Health: " + this.health + " (" + this.damage + ", " + this.armor + ")");
	}
}
