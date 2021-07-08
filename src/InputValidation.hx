class InputValidation {
	// Array of characters that cannot be used in the users name
	private static var forbiddenCharacters = [' ', '|'];

	// Responsible for checking if the user has entered a valid input in all of the menus in the game
	// A number of possible options is required and it checks if the user enter a number between 1 and the number of options in the menu
	public static function checkMenuInput(numberOfPossibleOptions:Int):Int {
		var userOption;
		do {
			userOption = Std.parseInt(Sys.stdin().readLine());
			if (userOption != null && (userOption >= 1 && userOption <= numberOfPossibleOptions)) {
				break;
			} else {
				Sys.println("\n### Wrong input! Enter a number between 1 and " + numberOfPossibleOptions + "! ###\n");
			}
		} while (true);

		return userOption;
	}

	// Checks if the user has enter a valid name(not already taken or containing forbidden characters)
	public static function checkNameIfValid(characters:Array<String>):String {
		var name:String = "";
		do {
			// Asks the user for a name
			Sys.print("Enter your name: ");
			name = Sys.stdin().readLine();
			var valid = true;

			// Checks if the name contains invalid characters
			var chIdx = 0;
			while (chIdx < name.length) {
				if (forbiddenCharacters.contains(name.charAt(chIdx))) {
					Sys.print("\n### Your name could not contain");
					for (forbiddenCh in forbiddenCharacters) {
						Sys.print(" \\'" + forbiddenCh + "'");
					}
					Sys.print(" ###\n");
					valid = false;
					break;
				}
				chIdx += 1;
			}

			if (!valid) {
				continue;
			}

			var index = 0;
			var heroExists = false;
			// Spliting the information and checking for the same name
			while (index < characters.length) {
				var character = characters[index].split(" ");
				if (character[0] == name) {
					heroExists = true;
					break;
				}
				index += 1;
			}

			if (heroExists) {
				Sys.println("\n### Name already taken! ###\n");
			} else {
				break;
			}
		} while (true);

		return name;
	}
}
