class Battle {
	// First type of battle: user hero vs another hero
	public static function OneVsOne(player:Hero, enemy:Hero):Void {
		// Prints the stats of the two heroes
		Sys.println("\nStats:");
		Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", " + player.getMana()
			+ ", " + player.getArmor() + ")");
		Sys.println(enemy.getName() + ": lv." + enemy.getLevel() + " Health: " + enemy.getHealth() + " (" + enemy.getDamage() + ", " + enemy.getMana()
			+ ", " + enemy.getArmor() + ")");

		// Saves the initial stats of the user hero
		var damage = player.getDamage() - enemy.getArmor();
		var startingHealth = player.getHealth();
		var startingDamage = player.getDamage();
		var startingMana = player.getMana();
		var startingArmor = player.getArmor();

		// Checks if the user hero damage is less than 5, if it is - sets it to 5
		if (damage < 5) {
			damage = 5;
		}

		// Enters the battle
		while (true) {
			// Asks the user to choose from one of his abilities corresponding to its class
			Sys.println("Choose an ability:");
			switch (Type.getClassName(Type.getClass(player))) {
				// Abilities for warrior
				case "Warrior":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Increase health by 20 * level for the rest of the battle (30 mana)");
					Sys.println("3. Increase armor by 10 * level for the rest of the battle (40 mana)");
				// Abilities for mage
				case "Mage":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Heal yourself for half of your health (100 mana)");
					Sys.println("3. Incrase damage by 10 * level for the rest of the battle (40 mana)");
				// Abilities for ranger
				case "Ranger":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Incrase damage by 10 * level for the rest of the battle (40 mana)");
					Sys.println("3. Massive strike: " + (damage * 2) + " damage (30 mana)");
			}

			// Checks if user input is valid
			var user_option;
			do {
				user_option = Sys.stdin().readLine();
				if (user_option == "1" || user_option == "2" || user_option == "3") {
					break;
				} else {
					Sys.println("\n### Wrong input! Enter a number between 1 and 3! ###\n");
				}
			} while (true);

				// Process user input
			switch (user_option) {
				case "1":
					// Doing every classs first ability
					enemy.removeHealth(damage);
				case "2":
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior second ability if enough mana
							if (player.getMana() >= 30) {
								player.addHealth(20 * player.getLevel());
								player.setMana(player.getMana() - 30);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage second ability if enough mana
							if (player.getMana() >= 100) {
								player.addHealth(Std.int(startingHealth / 2));
								player.setMana(player.getMana() - 100);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger second ability if enough mana
							if (player.getMana() >= 40) {
								player.addDamage(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
								damage = player.getDamage() - enemy.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < 5) {
									damage = 5;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
				case "3":
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior third ability if enough mana
							if (player.getMana() >= 40) {
								player.addArmor(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage third ability if enough mana
							if (player.getMana() >= 40) {
								player.addDamage(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
								damage = player.getDamage() - enemy.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < 5) {
									damage = 5;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger third ability if enough mana
							if (player.getMana() >= 30) {
								enemy.removeHealth(damage * 2);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
			}

			// Prints the stats again after the user has performed an ability
			Sys.println("\nAfter your turn:");
			Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", "
				+ player.getMana() + ", " + player.getArmor() + ")");
			Sys.println(enemy.getName() + ": lv." + enemy.getLevel() + " Health: " + enemy.getHealth() + " (" + enemy.getDamage() + ", " + enemy.getMana()
				+ ", " + enemy.getArmor() + ")");

			// Checks if enemy is alive, if it not - ends tha battle
			if (!enemy.isAlive()) {
				Sys.println("Victory!");
				player.setHealth(startingHealth);
				player.setDamage(startingDamage);
				player.setMana(startingMana);
				player.setArmor(startingArmor);
				player.addGold(10 * enemy.getLevel());
				break;
			}
			// Enemy attack
			var enemyDamage = enemy.getDamage() - player.getArmor();
			if (enemyDamage < 5) {
				enemyDamage = 5;
			}
			player.removeHealth(enemyDamage);

			// Prints stats after the enemy attack
			Sys.println("\nAfter enemy turn:");
			Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", "
				+ player.getMana() + ", " + player.getArmor() + ")");
			Sys.println(enemy.getName() + ": lv." + enemy.getLevel() + " Health: " + enemy.getHealth() + " (" + enemy.getDamage() + ", " + enemy.getMana()
				+ ", " + enemy.getArmor() + ")");

			// Checks if the user hero is alive, if it is not - ends the battle
			if (!player.isAlive()) {
				Sys.println("Defeat!");
				player.setHealth(startingHealth);
				player.setDamage(startingDamage);
				player.setMana(startingMana);
				player.setArmor(startingArmor);
				break;
			}
		}
	}

	// Second type of battle - user hero vs a boss
	public static function OneVsBoss(player:Hero, boss:Boss):Void {
		// Prints the stats of the user hero and the boss
		Sys.println("\nStats:");
		Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", " + player.getMana()
			+ ", " + player.getArmor() + ")");
		Sys.println("Boss: lv." + boss.getLevel() + " Health: " + boss.getHealth() + " (" + boss.getDamage() + ", " + boss.getArmor() + ")");

		// Saves the initial stat of the user hero
		var damage = player.getDamage() - boss.getArmor();
		var startingHealth = player.getHealth();
		var startingDamage = player.getDamage();
		var startingMana = player.getMana();
		var startingArmor = player.getArmor();
		if (damage < 5) {
			damage = 5;
		}
		// Enters the battle
		while (true) {
			// Asks the user to choose from one of his abilities corresponding to its class
			Sys.println("Choose an ability:");
			switch (Type.getClassName(Type.getClass(player))) {
				// Abilities for warrior
				case "Warrior":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Increase health by 20 * level for the rest of the battle (30 mana)");
					Sys.println("3. Increase armor by 10 * level for the rest of the battle (40 mana)");
				// Abilities for mage
				case "Mage":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Heal yourself for half of your health (100 mana)");
					Sys.println("3. Incrase damage by 10 * level for the rest of the battle (40 mana)");
				// Abilities for ranger
				case "Ranger":
					Sys.println("1. Deal " + damage + " damage (0 mana)");
					Sys.println("2. Incrase damage by 10 * level for the rest of the battle (40 mana)");
					Sys.println("3. Massive strike: " + (damage * 2) + " damage (30 mana)");
			}

			// checks if the user input is valid
			var user_option;
			do {
				user_option = Sys.stdin().readLine();
				if (user_option == "1" || user_option == "2" || user_option == "3") {
					break;
				} else {
					Sys.println("\n### Wrong input! Enter a number between 1 and 3! ###\n");
				}
			} while (true);

				// Process user input
			switch (user_option) {
				case "1":
					// Doing every classs first ability
					boss.removeHealth(damage);
				case "2":
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior second ability if enough mana
							if (player.getMana() >= 30) {
								player.addHealth(20 * player.getLevel());
								player.setMana(player.getMana() - 30);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage second ability if enough mana
							if (player.getMana() >= 100) {
								player.addHealth(Std.int(startingHealth / 2));
								player.setMana(player.getMana() - 100);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger second ability if enough mana
							if (player.getMana() >= 40) {
								player.addDamage(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
								damage = player.getDamage() - boss.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < 5) {
									damage = 5;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
				case "3":
					switch (Type.getClassName(Type.getClass(player))) {
						case "Warrior":
							// Doing warrior third ability if enough mana
							if (player.getMana() >= 40) {
								player.addArmor(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Mage":
							// Doing mage third ability if enough mana
							if (player.getMana() >= 40) {
								player.addDamage(10 * player.getLevel());
								player.setMana(player.getMana() - 40);
								damage = player.getDamage() - boss.getArmor();
								// Checks if the user hero damage is less than 5, if it is - sets it to 5
								if (damage < 5) {
									damage = 5;
								}
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
						case "Ranger":
							// Doing ranger third ability if enough mana
							if (player.getMana() >= 30) {
								boss.removeHealth(damage * 2);
							} else {
								Sys.println("\n### Not enough mana! ###\n");
								continue;
							}
					}
			}

			// Prints the stats after the user hero has performed an ability
			Sys.println("\nAfter your turn:");
			Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", "
				+ player.getMana() + ", " + player.getArmor() + ")");
			Sys.println("Boss: lv." + boss.getLevel() + " Health: " + boss.getHealth() + " (" + boss.getDamage() + ", " + boss.getArmor() + ")");

			// Chekcs if the boss is alive, if it is not gives xp and gold to the user and exits the battle
			if (!boss.isAlive()) {
				Sys.println("Victory!");
				player.setHealth(startingHealth);
				player.setDamage(startingDamage);
				player.setMana(startingMana);
				player.setArmor(startingArmor);
				player.addGold(5 * boss.getLevel());
				player.setXpNeeded(player.getXpNeeded() - 1);
				if (player.getXpNeeded() == 0) {
					player.levelUp();
				}

				break;
			}

			// Perforems the attack of the boss
			var bossDamage = boss.getDamage() - player.getArmor();
			if (bossDamage < 10) {
				bossDamage = 10;
			}
			player.removeHealth(bossDamage);

			// Prints the stats after the boss attack
			Sys.println("\nAfter enemy turn:");
			Sys.println(player.getName() + ": lv." + player.getLevel() + " Health: " + player.getHealth() + " (" + player.getDamage() + ", "
				+ player.getMana() + ", " + player.getArmor() + ")");
			Sys.println("Boss: lv." + boss.getLevel() + " Health: " + boss.getHealth() + " (" + boss.getDamage() + ", " + boss.getArmor() + ")");

			// Checks if the user is alive, if it is not - exits the battle
			if (!player.isAlive()) {
				Sys.println("Defeat!");
				player.setHealth(startingHealth);
				player.setDamage(startingDamage);
				player.setMana(startingMana);
				player.setArmor(startingArmor);
				break;
			}
		}
	}
}
