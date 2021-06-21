// The main class of the game, which works with the user input and navigates him/her through the different menus
class Game {
	// Starts the game by printing the main menu from where the user can choose if he wants to:
	// Create new hero; Use an existing one; Read the game info; Exit the game;
	public static function run() {
		Sys.println("----Welcome to my game!----");
		var user_hero = null;
		while (true) {
			// Prints the main menu with the four options
			printMainMenu();

			// Checking user input if valid
			var user_option;
			do {
				user_option = Sys.stdin().readLine();
				if (user_option == "1" || user_option == "2" || user_option == "3" || user_option == "4") {
					break;
				} else {
					Sys.println("Wrong input! Enter a number between 1 and 4!");
				}
			} while (true);

				// Processing user input
			switch (user_option) {
				case "1":
					// Sends the user to create new character
					user_hero = characterCreation();
				case "2":
					// Send the user to choose from an existing character
					user_hero = chooseCharacter();
				case "3":
					// Prints information about the game
					var gameRules:String = sys.io.File.getContent('game_rules.txt');
					Sys.println("\n_______________\n" + gameRules + "\n_______________\n");
					continue;
				case "4":
					// Exits the game
					Sys.println("Thank you for playing the game!");
					break;
			}
			// If the user has picked a hero or created a new one, sends him to the character menu, otherwise asks him to try again
			if (user_hero != null) {
				characterMenu(user_hero);
			} else {
				Sys.println("You haven't picked a hero!");
				continue;
			}
		}
	}

	// Creating new character
	public static function characterCreation():Hero {
		// Reading the data file
		var characters = sys.io.File.getContent('data.txt').split("|||");
		if (characters.length != 1) {
			characters.pop();
		}
		var name = "";

		// Asking for username and checking if such a name already exists
		do {
			Sys.print("Enter your name: ");
			name = Sys.stdin().readLine();
			var index = 0;
			var hero_exists = false;
			// Spliting the information from the data file and checking for same name
			while (index < characters.length) {
				var character = characters[index].split(" ");
				if (character[0] == name) {
					hero_exists = true;
					break;
				}
				index += 1;
			}

			if (hero_exists) {
				Sys.println("Name already taken!");
			} else {
				break;
			}
		} while (true);
			// Asking the user to pick a class and checking for invalid input
		Sys.println("Choose your class:\n-> 1. Warrior\n-> 2. Mage\n-> 3. Ranger");
		var user_option;
		do {
			user_option = Sys.stdin().readLine();
			if (user_option == "1" || user_option == "2" || user_option == "3") {
				break;
			} else {
				Sys.println("Wrong input! Enter a number between 1 and 3!");
			}
		} while (true);

			// Processing user response and creating a corresponding hero
		switch (user_option) {
			case "1":
				return new Warrior(name);
			case "2":
				return new Mage(name);
			case "3":
				return new Ranger(name);
		}

		return null;
	}

	// Lets the user to choose from an existing character
	public static function chooseCharacter():Hero {
		// Reading the data file
		var characters = sys.io.File.getContent('data.txt').split("|||");
		if (characters.length == 1) {
			Sys.println("No existing characters!");
			return null;
		}
		characters.pop();
		var index = 0;

		// Printing all the heroes that are available
		Sys.println("Choose your hero:");

		while (index < characters.length) {
			var character = characters[index].split(" ");
			Sys.println(Std.string(index + 1) + ". " + "Name: " + character[0] + " lv." + character[2]);
			index += 1;
		}

		Sys.print("Enter a number between 1 and " + Std.string(characters.length) + ": ");

		// Checking the user input if valid
		var user_option;
		do {
			user_option = Sys.stdin().readLine();

			// If it is valid it creates a new hero with the same stats as the one chosen
			if (Std.parseInt(user_option) >= 1 && Std.parseInt(user_option) <= characters.length) {
				var character = characters[Std.parseInt(user_option) - 1].split(" ");
				var user_hero:Hero = null;
				// Checks the user class specified in the file and creates a hero from the same class
				switch (character[7]) {
					case "Warrior":
						user_hero = new Warrior(character[0]);
					case "Mage":
						user_hero = new Mage(character[0]);
					case "Ranger":
						user_hero = new Ranger(character[0]);
				}
				if (user_hero != null) {
					user_hero.setGold(Std.parseInt(character[1]));
					user_hero.setLevel(Std.parseInt(character[2]));
					user_hero.setHealth(Std.parseInt(character[3]));
					user_hero.setDamage(Std.parseInt(character[4]));
					user_hero.setMana(Std.parseInt(character[5]));
					user_hero.setArmor(Std.parseInt(character[6]));
					return user_hero;
				} else {
					break;
				}
			} else {
				Sys.println("Wrong input!");
			}
		} while (true);
		return null;
	}

	// Prints the character menu and sends to the chosen options
	public static function characterMenu(user_hero) { // Prints info about the hero and the 3 options that the user can choose from
		Sys.println("----Character Menu----\n" + user_hero.getName() + " | Class: " + Type.getClassName(Type.getClass(user_hero)) + " | Lv."
			+ Std.string(user_hero.getLevel()) + " | Gold: " + Std.string(user_hero.getGold()) + " | (Health: " + Std.string(user_hero.getHealth())
			+ ", Damage: " + Std.string(user_hero.getDamage()) + ", Mana:" + Std.string(user_hero.getMana()) + ", Armor: " + Std.string(user_hero.getArmor())
			+ ")\n" + "-> 1. Fight\n-> 2. Buy Items\n-> 3. Exit to Main Menu");

		// Checks input if valid
		var user_option;
		do {
			user_option = Sys.stdin().readLine();
			if (user_option == "1" || user_option == "2" || user_option == "3") {
				break;
			} else {
				Sys.println("Wrong input! Enter a number between 1 and 3!");
			}
		} while (true);

			// Processes user input
		switch (user_option) {
			case "1":
				// Enters the fighting menu
				fight(user_hero);
			case "2":
				// Opens the shop for buying items
				openShop(user_hero);
			case "3":
				// Exits the character, asks if the user wants to save it and returns to main menu
				exitCharacter(user_hero);
		}
	}

	// Responsible for choosing whom the user wants to fight, another hero or a boss
	// After the battle returns to character menu
	public static function fight(user_hero) {
		// Asking the user to choose an enemy: another hero or a boss
		Sys.println("Do you want to fight another hero or a boss?\n" + "-> 1. Fight another hero\n-> 2. Fight a boss");

		// Checks if input is valid
		var user_option;
		do {
			user_option = Sys.stdin().readLine();
			if (user_option == "1" || user_option == "2") {
				break;
			} else {
				Sys.println("Wrong input! Enter a number between 1 and 2!");
			}
		} while (true);

			// Processes user input
		switch (user_option) {
			// If chosen 1, the user hero will fight another hero
			case "1":
				// Reads the enemies from the data file
				var enemies = sys.io.File.getContent('data.txt').split("|||");
				if (enemies.length == 1) {
					Sys.println("No existing enemies!");
				} else {
					enemies.pop();
					var index = 0;

					// Aks the user to choose an enemy and prints all the options
					Sys.println("Choose your enemy:");

					while (index < enemies.length) {
						var enemy = enemies[index].split(" ");
						Sys.println(Std.string(index + 1) + ". " + "Name: " + enemy[0] + " lv." + enemy[2]);
						index += 1;
					}

					Sys.print("Enter a number between 1 and " + Std.string(enemies.length) + ": ");

					// Checks if user input is valid
					var user_option;
					do {
						user_option = Sys.stdin().readLine();
						// If the input is valid, starts a battle between the user hero and the another one
						if (Std.parseInt(user_option) >= 1 && Std.parseInt(user_option) <= enemies.length) {
							var character = enemies[Std.parseInt(user_option) - 1].split(" ");
							var enemy_hero:Hero = null;
							// Checks the enemy class specified in the file and creates a hero from the same class
							switch (character[7]) {
								case "Warrior":
									enemy_hero = new Warrior(character[0]);
								case "Mage":
									enemy_hero = new Mage(character[0]);
								case "Ranger":
									enemy_hero = new Ranger(character[0]);
							}
							if (enemy_hero != null) {
								enemy_hero.setGold(Std.parseInt(character[1]));
								enemy_hero.setLevel(Std.parseInt(character[2]));
								enemy_hero.setHealth(Std.parseInt(character[3]));
								enemy_hero.setDamage(Std.parseInt(character[4]));
								enemy_hero.setMana(Std.parseInt(character[5]));
								enemy_hero.setArmor(Std.parseInt(character[6]));
								// Starts a battle between the user hero and the another on
								Battle.OneVsOne(user_hero, enemy_hero);
								break;
							} else {
								break;
							}
						} else {
							Sys.println("Wrong input!");
						}
					} while (true);
				}
			// If chosen 2, start a battle againts a boss
			case "2":
				do {
					// Asks for a boss level
					Sys.print("Enter a boss level: ");
					var level = Sys.stdin().readLine();
					if (Std.parseInt(level) != null && Std.parseInt(level) > 0 && Std.parseInt(level) <= 100) {
						Battle.OneVsBoss(user_hero, new Boss(Std.parseInt(level)));
						break;
					}
				} while (true);
		}
		// After the battle it returns to character menu
		characterMenu(user_hero);
	}

	// Opens the shop, listing all the available items
	public static function openShop(user_hero) {
		var shop = new Shop(user_hero.getLevel());

		// Asks the user to choose an item and lists them all
		Sys.println("----Shop----\nChoose an item to buy:");
		var index = 1;
		for (item in shop.getItems()) {
			Sys.println(index + ". " + item.getName() + " (Health: " + item.getAddHealth() + ", Damage: " + item.getAddDamage() + ", Mana: "
				+ item.getAddMana() + ", Armor: " + item.getAddArmor() + ")" + " Price: " + item.getPrice());
			index += 1;
		}
		Sys.println("5. Back to character menu");

		// Cheks user input if valid
		var user_option;
		do {
			user_option = Sys.stdin().readLine();
			if (user_option == "1" || user_option == "2" || user_option == "3" || user_option == "4" || user_option == "5") {
				break;
			} else {
				Sys.println("Wrong input! Enter a number between 1 and 5!");
			}
		} while (true);

			// If 5 chosen, returns user to character menu
		if (user_option == "5") {
			characterMenu(user_hero);
		}
		// Otherwise if the user hero has enough gold, it adds the item stats to the user hero
		else {
			if (Type.getClassName(Type.getClass(user_hero)) + "Item" == shop.getItems()[Std.parseInt(user_option) - 1].getType()
				|| shop.getItems()[Std.parseInt(user_option) - 1].getType() == "AllItem") {
				if (user_hero.getGold() >= shop.getItems()[Std.parseInt(user_option) - 1].getPrice()) {
					user_hero.addHealth(shop.getItems()[Std.parseInt(user_option) - 1].getAddHealth());
					user_hero.addDamage(shop.getItems()[Std.parseInt(user_option) - 1].getAddDamage());
					user_hero.addMana(shop.getItems()[Std.parseInt(user_option) - 1].getAddMana());
					user_hero.addArmor(shop.getItems()[Std.parseInt(user_option) - 1].getAddArmor());

					user_hero.setGold(user_hero.getGold() - shop.getItems()[Std.parseInt(user_option) - 1].getPrice());

					Sys.println("Item bought");

					characterMenu(user_hero);
				} else {
					Sys.println("\n### You don't have enough gold ###\n");
					openShop(user_hero);
				}
			} else {
				Sys.println("\n### You can't buy this item ###\n");
				openShop(user_hero);
			}
		}
	}

	// Exits the character asking before that if the user wants to save it
	public static function exitCharacter(user_hero) {
		// Asks the user if he wants to save it and checks if input is valid
		if (user_hero != null) {
			Sys.print("Do you want to save your character? [y/n]");
			var user_option;
			do {
				user_option = Sys.stdin().readLine();
				if (user_option == "y" || user_option == "n") {
					break;
				} else {
					Sys.println("Wrong input!");
				}
			} while (true);

				// If the answer is "y", them the hero will be saved to the data file
				// If such a hero already exits in the data file, the information will be overwritten
			if (user_option == "y") {
				var characters = sys.io.File.getContent('data.txt').split("|||");
				characters.pop();
				var index = 0;

				// Checks if hero exists and if it does overwrites the information
				var hero_exists = false;
				while (index < characters.length) {
					var character = characters[index].split(" ");
					if (user_hero.getName() == character[0]) {
						hero_exists = true;
						characters[index] = user_hero.getName() + " " + Std.string(user_hero.getGold()) + " " + Std.string(user_hero.getLevel()) + " "
							+ Std.string(user_hero.getHealth()) + " " + Std.string(user_hero.getDamage()) + " " + Std.string(user_hero.getMana()) + " "
							+ Std.string(user_hero.getArmor()) + " " + Type.getClassName(Type.getClass(user_hero));
						break;
					}
					index += 1;
				}

				// If hero doesn't exist it appends the new one at the end of the file
				if (!hero_exists) {
					var hero_save:String = user_hero.getName() + " " + Std.string(user_hero.getGold()) + " " + Std.string(user_hero.getLevel()) + " "
						+ Std.string(user_hero.getHealth()) + " " + Std.string(user_hero.getDamage()) + " " + Std.string(user_hero.getMana()) + " "
						+ Std.string(user_hero.getArmor());
					hero_save += (" " + Type.getClassName(Type.getClass(user_hero)) + "|||");
					var output = sys.io.File.append('data.txt', false);
					output.writeString(hero_save);
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
		}
	}

	// Prints the main menu
	public static function printMainMenu() {
		Sys.println("----Main Menu----\nChoose one of the options below by typing its number:\n"
			+ "-> 1. Create New Hero\n-> 2. Use An Existing Hero\n-> 3. Game Rules\n-> 4. Quit the game");
	}
}
