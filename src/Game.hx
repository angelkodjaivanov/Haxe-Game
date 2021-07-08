// The main class of the game, which works with the user input and navigates him/her through the different menus
class Game {
	// Starts the game by printing the main menu from where the user can choose if he wants to:
	// Create new hero; Use an existing one; Read the game info; Exit the game;
	public static function run() {
		Sys.println("----Welcome to my game!----");
		var userHero = null;
		while (true) {
			// Prints the main menu with the four options
			printMainMenu();

			// Checking user input if valid
			var numberOfPossibleOptions = 4;
			var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);
			// Processing user input
			switch (userOption) {
				case 1:
					// Sends the user to create new character
					userHero = characterCreation();
				case 2:
					// Sends the user to choose from an existing character
					userHero = chooseCharacter();
				case 3:
					// Prints information about the game
					var gameRules:String = sys.io.File.getContent('game_rules.txt');
					Sys.println("\n_______________\n" + gameRules + "\n_______________\n");
					continue;
				case 4:
					// Exits the game
					Sys.println("Thank you for playing the game!");
					break;
			}
			// If the user has picked a hero or created a new one, sends him to the character menu, otherwise asks him to try again
			if (userHero != null) {
				characterMenu(userHero);
			} else {
				Sys.println("\n### You haven't picked a hero! ###");
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

		var name = InputValidation.checkNameIfValid(characters);

		// Asking the user to pick a class and checking for invalid input
		Sys.println("Choose your class:\n-> 1. Warrior\n-> 2. Mage\n-> 3. Ranger");
		var numberOfPossibleOptions = 3;
		var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);

		// Processing user response and creating a corresponding hero
		switch (userOption) {
			case 1:
				return new Warrior(name);
			case 2:
				return new Mage(name);
			case 3:
				return new Ranger(name);
		}

		return null;
	}

	// Lets the user to choose from an existing character
	public static function chooseCharacter():Hero {
		Sys.println("Choose your hero:");
		// Printing all the heroes that are available and selecting one chosen by the user
		var userHero = getHeroFromFile();
		return userHero;
	}

	// Prints the character menu and sends to the chosen option
	public static function characterMenu(userHero:Hero) {
		// Prints info about the hero and the 3 options that the user can choose from
		Sys.println("----Character Menu----\n" + userHero.getName() + " | Class: " + Type.getClassName(Type.getClass(userHero)) + " | Lv."
			+ Std.string(userHero.getLevel()) + " | Gold: " + Std.string(userHero.getGold()) + " | (Health: " + Std.string(userHero.getHealth())
			+ ", Damage: " + Std.string(userHero.getDamage()) + ", Mana:" + Std.string(userHero.getMana()) + ", Armor: " + Std.string(userHero.getArmor())
			+ ")\n" + "-> 1. Fight\n-> 2. Buy Items\n-> 3. Exit to Main Menu");

		// Checks input if valid
		var numberOfPossibleOptions = 3;
		var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);

		// Processes user input
		switch (userOption) {
			case 1:
				// Enters the fighting menu
				fight(userHero);
			case 2:
				// Opens the shop for buying items
				Shop.enter(userHero);
			case 3:
				// Exits the character, asks if the user wants to save it and returns to main menu
				exitCharacter(userHero);
		}
	}

	// Responsible for choosing whom the user wants to fight, another hero or a boss
	// After the battle returns to character menu
	public static function fight(userHero:Hero) {
		// Asking the user to choose an enemy: another hero or a boss and checking input if valid
		Sys.println("Do you want to fight another hero or a boss?\n" + "-> 1. Fight another hero\n-> 2. Fight a boss");
		var numberOfPossibleOptions = 2;
		var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);

		// Processes user input
		switch (userOption) {
			// If chosen 1, the user hero will fight another hero
			case 1:
				// Aks the user to choose an enemy and prints all the options
				Sys.println("Choose your enemy:");
				var enemyHero = getHeroFromFile();

				// Starts a battle between the user hero and the another one
				Battle.battle(userHero, enemyHero);
			// If chosen 2, starts a battle againts a boss
			case 2:
				do {
					// Asks for a boss level and creates the battle
					Sys.print("Enter a boss level: ");
					var level = Sys.stdin().readLine();
					if (Std.parseInt(level) != null && Std.parseInt(level) > 0 && Std.parseInt(level) <= 100) {
						Battle.battle(userHero, new Boss(Std.parseInt(level)));
						break;
					}
				} while (true);
		}

		// After the battle it returns the user to the character menu
		characterMenu(userHero);
	}

	// Exits the character asking before if the user wants to save it
	public static function exitCharacter(userHero:Hero) {
		// Asks the user if he wants to save it and checks if input is valid
		if (userHero != null) {
			Sys.print("Do you want to save your character? [y/n]");
			var userOption;
			do {
				userOption = Sys.stdin().readLine();
				if (userOption == "y" || userOption == "n") {
					break;
				} else {
					Sys.println("\n### Wrong input! ###\n");
				}
			} while (true);

				// If the answer is "y", then the hero will be saved to the data file
				// If such a hero already exits in the data file, the information will be overwritten
			if (userOption == "y") {
				userHero.saveHero();
			}
		}
	}

	// Prints the main menu
	public static function printMainMenu() {
		Sys.println("----Main Menu----\nChoose one of the options below by typing its number:\n"
			+ "-> 1. Create New Hero\n-> 2. Use An Existing Hero\n-> 3. Game Rules\n-> 4. Quit the game");
	}

	// Responsible for selecting a hero from the data file with all heroes
	public static function getHeroFromFile():Hero {
		// Reading the data file
		var characters = sys.io.File.getContent('data.txt').split("|||");
		if (characters.length == 1) {
			Sys.println("\n### No existing characters! ###\n");
			return null;
		}
		characters.pop();
		var index = 0;

		// Printing all available heroes
		while (index < characters.length) {
			var character = characters[index].split(" ");
			Sys.println(Std.string(index + 1) + ". " + "Name: " + character[0] + " lv." + character[2]);
			index += 1;
		}

		Sys.print("Enter a number between 1 and " + Std.string(characters.length) + ": ");

		// Checking the user input if valid
		var userOption;
		do {
			userOption = Sys.stdin().readLine();

			// If it is valid it creates a new hero with the same stats as the one chosen
			if (Std.parseInt(userOption) >= 1 && Std.parseInt(userOption) <= characters.length) {
				var character = characters[Std.parseInt(userOption) - 1].split(" ");
				var hero:Hero = null;
				// Checks the user class specified in the file and creates a hero from the same class
				switch (character[7]) {
					case "Warrior":
						hero = new Warrior(character[0]);
					case "Mage":
						hero = new Mage(character[0]);
					case "Ranger":
						hero = new Ranger(character[0]);
				}
				// Sets the stats specified in the data file to the hero
				hero.setStats(Std.parseInt(character[1]), Std.parseInt(character[2]), Std.parseInt(character[3]), Std.parseInt(character[4]),
					Std.parseInt(character[5]), Std.parseInt(character[6]));
				return hero;
			} else {
				Sys.println("\n### Wrong input! ###\n");
			}
		} while (true);
		return null;
	}
}
