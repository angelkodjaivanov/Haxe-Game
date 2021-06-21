// The warrior class, subclass of Hero
class Warrior extends Hero {
	// Creates new Warrior with initial stats
	public function new(name) {
		super(name, 100, 30, 50, 20);
	}

	// Levels up the hero, adding stats based on the fact that it is a warrior
	public override function levelUp():Void {
		this.level = this.level + 1;
		this.health += 15;
		this.damage += 5;
		this.mana += 5;
		this.armor += 10;
		this.xpNeeded = this.level;
	}
}
