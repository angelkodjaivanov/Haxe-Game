// The Mage class, subclass of Hero
class Mage extends Hero {
	// Initial stats of the mage
	private static inline var INITIAL_HEALTH = 100;
	private static inline var INITIAL_DAMAGE = 25;
	private static inline var INITIAL_MANA = 70;
	private static inline var INITIAL_ARMOR = 10;

	// Boost of the stats per level up
	private static inline var HEALTH_BOOST_PER_LEVEL = 10;
	private static inline var DAMAGE_BOOST_PER_LEVEL = 5;
	private static inline var MANA_BOOST_PER_LEVEL = 10;
	private static inline var ARMOR_BOOST_PER_LEVEL = 4;

	// Creates new Mage with initial stats
	public function new(name:String) {
		super(name, INITIAL_HEALTH, INITIAL_DAMAGE, INITIAL_MANA, INITIAL_ARMOR);
	}

	// Levels up the hero, adding stats based on the fact that it is a Mage
	public override function levelUp():Void {
		this.level = this.level + 1;
		this.health += HEALTH_BOOST_PER_LEVEL;
		this.damage += DAMAGE_BOOST_PER_LEVEL;
		this.mana += MANA_BOOST_PER_LEVEL;
		this.armor += ARMOR_BOOST_PER_LEVEL;
		this.xpNeeded = this.level;
	}
}
