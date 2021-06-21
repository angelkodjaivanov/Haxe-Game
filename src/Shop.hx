// The Shop class
class Shop {
	// Array containing all the items in the shop
	private var items:Array<Item>;

	// Constructor, which creates a new shop based on the hero level
	public function new(hero_level:Int) {
		this.items = [];
		this.items.push(new Item("Armor lv." + hero_level, "AllItem", 10 * hero_level, 0, 0, 5 * hero_level, 5 * hero_level));
		this.items.push(new Item("Sword lv." + hero_level, "WarriorItem", 0, 5 * hero_level, 0, 0, 10 * hero_level));
		this.items.push(new Item("Staff lv." + hero_level, "MageItem", 0, 5 * hero_level, 5, 0, 7 * hero_level));
		this.items.push(new Item("Bow lv." + hero_level, "RangerItem", 0, 5 * hero_level, 0, 0, 9 * hero_level));
	}

	// Return the items in the shop as an array
	public function getItems() {
		return this.items;
	}
}
