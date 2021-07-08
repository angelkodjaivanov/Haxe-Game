class Battle {
	// Contsant variables used in the performing of the abilities(Stat boosts and mana costs of the abilities)
	private static inline var MIN_PLAYER_DAMAGE = 5;
	private static inline var MIN_BOSS_DAMAGE = 10;
	private static inline var BASIC_ABILITY_MANA_COST = 0;
	private static inline var WARRIOR_SECOND_ABILITY_MANA_COST = 30;
	private static inline var WARRIOR_THIRD_ABILITY_MANA_COST = 40;
	private static inline var MAGE_SECOND_ABILITY_MANA_COST = 100;
	private static inline var MAGE_THIRD_ABILITY_MANA_COST = 40;
	private static inline var RANGER_SECOND_ABILITY_MANA_COST = 40;
	private static inline var RANGER_THIRD_ABILITY_MANA_COST = 30;
	private static inline var HEALTH_BOOST = 20;
	private static inline var ARMOR_BOOST = 10;
	private static inline var DAMAGE_BOOST = 10;

	public static function battle(player:Hero, enemy:Entity) {
		// Prints the stats of the two heroes
		Sys.println("\nStats:");
		player.printStats();
		enemy.printStats();

		// Saves the initial stats of the user hero
		var damage = player.getDamage() - enemy.getArmor();
		var startingStats = [player.getHealth(), player.getDamage(), player.getMana(), player.getArmor()];

		// Checks if the user hero damage is less than 5, if it is - sets it to 5
		if (damage < MIN_PLAYER_DAMAGE) {
			damage = MIN_PLAYER_DAMAGE;
		}

		// Enters the battle
		while (true) {
			// Asks the user to choose from one of his abilities corresponding to its class
			Sys.println("Choose an ability:");
			switch (Type.getClassName(Type.getClass(player))) {
				// Abilities for warrior
				case "Warrior":
					Sys.println("1. Deal " + damage + " damage (" + BASIC_ABILITY_MANA_COST + " mana)");
					Sys.println("2. Increase health by " + Std.string(HEALTH_BOOST) + " * level for the rest of the battle ("
						+ Std.string(WARRIOR_SECOND_ABILITY_MANA_COST) + " mana)");
					Sys.println("3. Increase armor by " + Std.string(ARMOR_BOOST) + " * level for the rest of the battle ("
						+ Std.string(WARRIOR_THIRD_ABILITY_MANA_COST) + " mana)");
				// Abilities for mage
				case "Mage":
					Sys.println("1. Deal " + damage + " damage (" + Std.string(BASIC_ABILITY_MANA_COST) + " mana)");
					Sys.println("2. Heal yourself for half of your health (" + Std.string(MAGE_SECOND_ABILITY_MANA_COST) + " mana)");
					Sys.println("3. Incrase damage by " + Std.string(DAMAGE_BOOST) + " * level for the rest of the battle ("
						+ Std.string(MAGE_THIRD_ABILITY_MANA_COST) + "40 mana)");
				// Abilities for ranger
				case "Ranger":
					Sys.println("1. Deal " + damage + " damage (" + Std.string(BASIC_ABILITY_MANA_COST) + " mana)");
					Sys.println("2. Incrase damage by " + Std.string(DAMAGE_BOOST) + " * level for the rest of the battle ("
						+ Std.string(RANGER_SECOND_ABILITY_MANA_COST) + " mana)");
					Sys.println("3. Massive strike: " + (damage * 2) + " damage (" + Std.string(RANGER_THIRD_ABILITY_MANA_COST) + " mana)");
			}

			// Checks if user input is valid
			// Checks user input if valid
			var numberOfPossibleOptions = 3;
			var userOption = InputValidation.checkMenuInput(numberOfPossibleOptions);

			// Process user input
			switch (userOption) {
				case 1:
					// Doing every classs first ability
					enemy.removeHealth(damage);
				case 2:
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior second ability if enough mana
							if (player.getMana() >= WARRIOR_SECOND_ABILITY_MANA_COST) {
								player.addHealth(HEALTH_BOOST * player.getLevel());
								player.setMana(player.getMana() - WARRIOR_SECOND_ABILITY_MANA_COST);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage second ability if enough mana
							if (player.getMana() >= MAGE_SECOND_ABILITY_MANA_COST) {
								player.addHealth(Std.int(startingStats[0] / 2));
								player.setMana(player.getMana() - MAGE_SECOND_ABILITY_MANA_COST);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger second ability if enough mana
							if (player.getMana() >= RANGER_SECOND_ABILITY_MANA_COST) {
								player.addDamage(DAMAGE_BOOST * player.getLevel());
								player.setMana(player.getMana() - RANGER_SECOND_ABILITY_MANA_COST);
								damage = player.getDamage() - enemy.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < MIN_PLAYER_DAMAGE) {
									damage = MIN_PLAYER_DAMAGE;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
				case 3:
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior third ability if enough mana
							if (player.getMana() >= WARRIOR_THIRD_ABILITY_MANA_COST) {
								player.addArmor(ARMOR_BOOST * player.getLevel());
								player.setMana(player.getMana() - WARRIOR_THIRD_ABILITY_MANA_COST);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage third ability if enough mana
							if (player.getMana() >= MAGE_THIRD_ABILITY_MANA_COST) {
								player.addDamage(DAMAGE_BOOST * player.getLevel());
								player.setMana(player.getMana() - MAGE_THIRD_ABILITY_MANA_COST);
								damage = player.getDamage() - enemy.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < MIN_PLAYER_DAMAGE) {
									damage = MIN_PLAYER_DAMAGE;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger third ability if enough mana
							if (player.getMana() >= RANGER_THIRD_ABILITY_MANA_COST) {
								enemy.removeHealth(damage * 2);
								player.setMana(player.getMana() - RANGER_THIRD_ABILITY_MANA_COST);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
			}

			// Prints the stats again after the user has performed an ability
			Sys.println("\nAfter your turn:");
			player.printStats();
			enemy.printStats();

			// Checks if enemy is alive, if it not - ends tha battle
			if (!enemy.isAlive()) {
				Sys.println("Victory!");
				player.setStats(player.getGold(), player.getLevel(), startingStats[0], startingStats[1], startingStats[2], startingStats[3]);
				player.addGold(10 * enemy.getLevel());
				if (Type.getClassName(Type.getClass(enemy)) == "Boss") {
					player.setXpNeeded(player.getXpNeeded() - 1);
					if (player.getXpNeeded() == 0) {
						player.levelUp();
					}
				}
				break;
			}
			// Enemy attack
			var enemyDamage = enemy.getDamage() - player.getArmor();
			if (enemyDamage < MIN_BOSS_DAMAGE && Type.getClassName(Type.getClass(enemy)) == "Boss") {
				enemyDamage = MIN_BOSS_DAMAGE;
			} else if (enemyDamage < MIN_PLAYER_DAMAGE) {
				enemyDamage = MIN_PLAYER_DAMAGE;
			}

			player.removeHealth(enemyDamage);

			// Prints stats after the enemy attack
			Sys.println("\nAfter enemy turn:");
			player.printStats();
			enemy.printStats();

			// Checks if the user hero is alive, if it is not - ends the battle
			if (!player.isAlive()) {
				player.setStats(player.getGold(), player.getLevel(), startingStats[0], startingStats[1], startingStats[2], startingStats[3]);
				Sys.println("Defeat!");
				break;
			}
		}
	}
}
