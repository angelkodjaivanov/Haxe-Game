// The Item class
class Item {
	private var name:String;
	private var type:String;
	private var addHealth:Int;
	private var addDamage:Int;
	private var addMana:Int;
	private var addArmor:Int;
	private var itemLevel:Int;
	private var price:Int;

	// Constructor
	public function new(name:String, type:String, addHealth:Int, addDamage:Int, addMana:Int, addArmor:Int, price:Int) {
		this.name = name;
		this.type = type;
		this.addHealth = addHealth;
		this.addDamage = addDamage;
		this.addMana = addMana;
		this.addArmor = addArmor;
		this.price = price;
	}

	// Returns the value of name
	public function getName():String {
		return this.name;
	}

	// Returns the type of the item
	public function getType():String {
		return this.type;
	}

	// Returns the health that the item provides
	public function getAddHealth():Int {
		return this.addHealth;
	}

	// Returns the damage that the item provides
	public function getAddDamage():Int {
		return this.addDamage;
	}

	// Returns the mana that the item provides
	public function getAddMana():Int {
		return this.addMana;
	}

	// Returns the armor that the item provides
	public function getAddArmor():Int {
		return this.addArmor;
	}

	// Returns the item level
	public function getItemLevel():Int {
		return this.itemLevel;
	}

	// Returns the price of the item
	public function getPrice():Int {
		return this.price;
	}
}
