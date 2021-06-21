// The Ranger class, subclass of Hero
class Ranger extends Hero {
	// Creates new Ranger with initial stats
	public function new(name) {
		super(name, 100, 35, 50, 15);
	}

	// Levels up the hero, adding stats based on the fact that it is a Ranger
	public override function levelUp():Void {
		this.level = this.level + 1;
		this.health += 10;
		this.damage += 10;
		this.mana += 5;
		this.armor += 5;
		this.xpNeeded = this.level;
	}
}
