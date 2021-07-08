// The Hero class, implements Entity
class Hero implements Entity {
	private var name:String;
	private var health:Int;
	private var damage:Int;
	private var mana:Int;
	private var armor:Int;
	private var level:Int;
	private var gold:Int;
	private var xpNeeded:Int;

	// Creates new Hero with stats that are based on the subclass
	public function new(name:String, health:Int, damage:Int, mana:Int, armor:Int) {
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
	public function setName(name:String):Void {
		this.name = name;
	}

	// Returns the health of the hero
	public function getHealth():Int {
		return this.health;
	}

	// Sets the health of the hero
	public function setHealth(health:Int):Void {
		this.health = health;
	}

	// Add health to the current health of the hero
	public function addHealth(addHealth:Int):Void {
		this.health = this.health + addHealth;
	}

	// Removes health from the hero
	public function removeHealth(removeHealth:Int):Void {
		this.health = this.health - removeHealth;
	}

	// Returns the damage of the hero
	public function getDamage():Int {
		return this.damage;
	}

	// Sets the damage of the hero
	public function setDamage(damage:Int):Void {
		this.damage = damage;
	}

	// Adds damage to the current damage of the hero
	public function addDamage(addDamage:Int):Void {
		this.damage = this.damage + addDamage;
	}

	// Returns the mana of the hero
	public function getMana():Int {
		return this.mana;
	}

	// Sets the mana of the hero
	public function setMana(mana:Int):Void {
		this.mana = mana;
	}

	// Adds mana to the current mana of the hero
	public function addMana(addMana:Int):Void {
		this.mana = this.mana + addMana;
	}

	// Removes mana from the hero
	public function removeMana(removeMana:Int):Void {
		this.mana = this.mana - removeMana;
	}

	// Returns the armor of the hero
	public function getArmor():Int {
		return this.armor;
	}

	// Sets the armor of the hero
	public function setArmor(armor:Int):Void {
		this.armor = armor;
	}

	// Adds armor to the current armor of the hero
	public function addArmor(addArmor:Int):Void {
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
	public function addGold(addGold:Int):Void {
		this.gold += addGold;
	}

	// Sets the gold of the hero
	public function setGold(gold:Int):Void {
		this.gold = gold;
	}

	// Levels up the hero and setting the required xp for the next level
	public function levelUp():Void {
		this.level += 1;
		this.xpNeeded = this.level;
	}

	// Sets the level of the hero
	public function setLevel(level:Int):Void {
		this.level = level;
	}

	// Returns the xp needed for the next level
	public function getXpNeeded():Int {
		return this.xpNeeded;
	}

	// Sets the xp needed for the next level
	public function setXpNeeded(xpNeeded:Int):Void {
		this.xpNeeded = xpNeeded;
	}

	// Prints all the stats of the entity
	public function printStats():Void {
		Sys.println(this.name + ": lv." + Std.string(this.level) + " Health: " + Std.string(this.health) + " (" + Std.string(this.damage) + ", "
			+ Std.string(this.mana) + ", " + Std.string(this.armor) + ")");
	}

	// Gets the information that will be used for saving the hero
	public function getSaveHeroInfo():String {
		return Std.string(this.getName()) + " " + Std.string(this.gold) + " " + Std.string(this.level) + " " + Std.string(this.health) + " "
			+ Std.string(this.damage) + " " + Std.string(this.mana) + " " + Std.string(this.armor) + " " + Type.getClassName(Type.getClass(this));
	}

	// Saves the hero in the datafile
	public function saveHero():Void {
		var characters = sys.io.File.getContent('data.txt').split("|||");
		characters.pop();
		var index = 0;

		// Checks if hero exists and if it does overwrites the information
		var hero_exists = false;
		while (index < characters.length) {
			var character = characters[index].split(" ");
			if (this.getName() == character[0]) {
				hero_exists = true;
				characters[index] = this.getSaveHeroInfo();
				break;
			}
			index += 1;
		}

		// If hero doesn't exist it appends the new one at the end of the file
		if (!hero_exists) {
			var heroSave = this.getSaveHeroInfo() + "|||";
			var output = sys.io.File.append('data.txt', false);
			output.writeString(heroSave);
			output.close();
			// If hero exists, stores the new information about the hero
		} else {
			var content:String = "";
			index = 0;
			while (index < characters.length) {
				content += (characters[index] + "|||");
				index += 1;
			}
			sys.io.File.saveContent('data.txt', content);
		}
		Sys.println("Hero saved!");
	}

	// Sets all the stats of the hero
	public function setStats(gold:Int, level:Int, health:Int, damage:Int, mana:Int, armor:Int):Void {
		this.gold = gold;
		this.level = level;
		this.health = health;
		this.damage = damage;
		this.mana = mana;
		this.armor = armor;
	}
}
