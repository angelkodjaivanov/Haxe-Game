// The Shop class
class Shop {
	// Shop items stats boost
	private static inline var ARMOR_HEALTH_BOOST = 10;
	private static inline var ARMOR_ARMOR_BOOST = 5;
	private static inline var SWORD_DAMAGE_BOOST = 5;
	private static inline var STAFF_DAMAGE_BOOST = 5;
	private static inline var STAFF_MANA_BOOST = 5;
	private static inline var BOW_DAMAGE_BOOST = 5;

	// Items cost per level
	private static inline var ARMOR_COST = 5;
	private static inline var SWORD_COST = 10;
	private static inline var STAFF_COST = 7;
	private static inline var BOW_COST = 9;

	// Array containing all the items in the shop
	private var items:Array<Item>;

	// Constructor, which creates a new shop based on the hero level
	public function new(heroLevel:Int) {
		this.items = [];
		this.items.push(new Item("Armor lv." + heroLevel, "AllItem", ARMOR_HEALTH_BOOST * heroLevel, 0, 0, ARMOR_ARMOR_BOOST * heroLevel,
			ARMOR_COST * heroLevel));
		this.items.push(new Item("Sword lv." + heroLevel, "WarriorItem", 0, SWORD_DAMAGE_BOOST * heroLevel, 0, 0, SWORD_COST * heroLevel));
		this.items.push(new Item("Staff lv." + heroLevel, "MageItem", 0, STAFF_DAMAGE_BOOST * heroLevel, STAFF_MANA_BOOST, 0, STAFF_COST * heroLevel));
		this.items.push(new Item("Bow lv." + heroLevel, "RangerItem", 0, BOW_DAMAGE_BOOST * heroLevel, 0, 0, BOW_COST * heroLevel));
	}

	public static function enter(userHero:Hero) {
		var shop = new Shop(userHero.getLevel());
		shop.printItems();
		Sys.println("5. Back to character menu");

		// Cheks user input if valid
		var numberOfPossibleOptions = 5;
		var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);

		// If 5 chosen, returns user to character menu
		if (userOption == 5) {
			Game.characterMenu(userHero);
		}

		// If a shop was successfully created sends the user to menu from where he/she could buy items
		if (shop != null) {
			shop.buyItem(userHero, userOption);
		}
	}

	// Lists all the items in the shop
	public function printItems():Void {
		Sys.println("----Shop----\nChoose an item to buy:");
		var index = 1;
		for (item in this.items) {
			Sys.println(index + ". " + item.getName() + " (Health: " + item.getAddHealth() + ", Damage: " + item.getAddDamage() + ", Mana: "
				+ item.getAddMana() + ", Armor: " + item.getAddArmor() + ")" + " Price: " + item.getPrice());
			index += 1;
		}
	}

	// Asks the user to choose an item
	public function buyItem(userHero:Hero, userOption:Int) {
		if (Type.getClassName(Type.getClass(userHero)) + "Item" == this.items[userOption - 1].getType()
			|| this.items[userOption - 1].getType() == "AllItem") {
			// If the item could be bought by that class and the hero has enough money, the items stats are added to the hero
			if (userHero.getGold() >= this.items[userOption - 1].getPrice()) {
				userHero.addHealth(this.items[userOption - 1].getAddHealth());
				userHero.addDamage(this.items[userOption - 1].getAddDamage());
				userHero.addMana(this.items[userOption - 1].getAddMana());
				userHero.addArmor(this.items[userOption - 1].getAddArmor());

				// The hero gold is reduced by the price of the item
				userHero.setGold(userHero.getGold() - this.items[userOption - 1].getPrice());

				Sys.println("Item bought");
				Game.characterMenu(userHero);
			} else {
				Sys.println("\n### You don't have enough gold ###\n");
				enter(userHero);
			}
		} else {
			Sys.println("\n### You can't buy this item ###\n");
			enter(userHero);
		}
	}
}
