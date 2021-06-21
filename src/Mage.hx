// The Mage class, subclass of Hero
class Mage extends Hero {
	// Creates new Mage with initial stats
	public function new(name) {
		super(name, 100, 25, 70, 10);
	}

	// Levels up the hero, adding stats based on the fact that it is a Mage
	public override function levelUp():Void {
		this.level = this.level + 1;
		this.health += 10;
		this.damage += 5;
		this.mana += 10;
		this.armor += 4;
		this.xpNeeded = this.level;
	}
}
