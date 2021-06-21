// The Hero class
class Hero {
	private var name:String;
	private var health:Int;
	private var damage:Int;
	private var mana:Int;
	private var armor:Int;
	private var level:Int;
	private var gold:Int;
	private var xpNeeded:Int;

	// Creates new Hero with stats that are based on the subclass
	public function new(name, health, damage, mana, armor) {
		this.name = name;
		this.health = health;
		this.damage = damage;
		this.mana = mana;
		this.armor = armor;
		this.level = 1;
		this.gold = 0;
		this.xpNeeded = 1;
	}

	// Returns the name of the hero
	public function getName():String {
		return this.name;
	}

	// Sets the name of the hero
	public function setName(name):Void {
		this.name = name;
	}

	// Returns the health of the hero
	public function getHealth():Int {
		return this.health;
	}

	// Sets the health of the hero
	public function setHealth(health):Void {
		this.health = health;
	}

	// Add health to the current health of the hero
	public function addHealth(addHealth):Void {
		this.health = this.health + addHealth;
	}

	// Removes health from the hero
	public function removeHealth(removeHealth):Void {
		this.health = this.health - removeHealth;
	}

	// Returns the damage of the hero
	public function getDamage():Int {
		return this.damage;
	}

	// Sets the damage of the hero
	public function setDamage(damage):Void {
		this.damage = damage;
	}

	// Adds damage to the current damage of the hero
	public function addDamage(addDamage):Void {
		this.damage = this.damage + addDamage;
	}

	// Returns the mana of the hero
	public function getMana():Int {
		return this.mana;
	}

	// Sets the mana of the hero
	public function setMana(mana):Void {
		this.mana = mana;
	}

	// Adds mana to the current mana of the hero
	public function addMana(addMana):Void {
		this.mana = this.mana + addMana;
	}

	// Removes mana from the hero
	public function removeMana(removeMana):Void {
		this.mana = this.mana - removeMana;
	}

	// Returns the armor of the hero
	public function getArmor():Int {
		return this.armor;
	}

	// Sets the armor of the hero
	public function setArmor(armor):Void {
		this.armor = armor;
	}

	// Adds armor to the current armor of the hero
	public function addArmor(addArmor):Void {
		this.armor = this.armor + addArmor;
	}

	// Returns the level of the hero
	public function getLevel():Int {
		return this.level;
	}

	// Checks if the hero is alive
	public function isAlive():Bool {
		return this.health > 0;
	}

	// Returns the gold of the hero
	public function getGold():Int {
		return this.gold;
	}

	// Adds gold to the current amount
	public function addGold(addGold):Void {
		this.gold += addGold;
	}

	// Sets the gold of the hero
	public function setGold(gold):Void {
		this.gold = gold;
	}

	// Levels up the hero and setting the required xp for the next level
	public function levelUp():Void {
		this.level += 1;
		this.xpNeeded = this.level;
	}

	// Sets the level of the hero
	public function setLevel(level):Void {
		this.level = level;
	}

	// Returns the xp needed for the next level
	public function getXpNeeded():Int {
		return this.xpNeeded;
	}

	// Sets the xp needed for the next level
	public function setXpNeeded(xpNeeded):Void {
		this.xpNeeded = xpNeeded;
	}
}
