-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tcgdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tcgdb` ;

-- -----------------------------------------------------
-- Schema tcgdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tcgdb` DEFAULT CHARACTER SET utf8 ;
USE `tcgdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(3000) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `role` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card` ;

CREATE TABLE IF NOT EXISTS `card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `attack_power` INT NOT NULL,
  `rarity` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group` ;

CREATE TABLE IF NOT EXISTS `user_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  `parent_message` INT NULL,
  `user_group_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user2_idx` (`user_id` ASC),
  INDEX `fk_message_message1_idx` (`parent_message` ASC),
  INDEX `fk_message_user_group1_idx` (`user_group_id` ASC),
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_message1`
    FOREIGN KEY (`parent_message`)
    REFERENCES `message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user_group1`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trade` ;

CREATE TABLE IF NOT EXISTS `trade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `accepted` TINYINT NULL,
  `user1_id` INT NOT NULL,
  `user2_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trade_user_idx` (`user1_id` ASC),
  INDEX `fk_trade_user1_idx` (`user2_id` ASC),
  CONSTRAINT `fk_trade_user`
    FOREIGN KEY (`user1_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_user1`
    FOREIGN KEY (`user2_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trade_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trade_item` ;

CREATE TABLE IF NOT EXISTS `trade_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trade_id` INT NOT NULL,
  `card_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trade_item_trade1_idx` (`trade_id` ASC),
  INDEX `fk_trade_item_card1_idx` (`card_id` ASC),
  INDEX `fk_trade_item_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_trade_item_trade1`
    FOREIGN KEY (`trade_id`)
    REFERENCES `trade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_item_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_item_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_group_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group_members` ;

CREATE TABLE IF NOT EXISTS `user_group_members` (
  `user_group_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_group_id`, `user_id`),
  INDEX `fk_user_group_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_user_group_has_user_user_group1_idx` (`user_group_id` ASC),
  CONSTRAINT `fk_user_group_has_user_user_group1`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `completed` TINYINT NULL,
  `player_1` INT NOT NULL,
  `player_2` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_user1_idx` (`player_1` ASC),
  INDEX `fk_game_user2_idx` (`player_2` ASC),
  CONSTRAINT `fk_game_user1`
    FOREIGN KEY (`player_1`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_user2`
    FOREIGN KEY (`player_2`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `move`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `move` ;

CREATE TABLE IF NOT EXISTS `move` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `game_id` INT NOT NULL,
  `card_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_move_game1_idx` (`game_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_move_card1_idx` (`card_id` ASC),
  INDEX `fk_move_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_move_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_move_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_move_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lootbox`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lootbox` ;

CREATE TABLE IF NOT EXISTS `lootbox` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `tier` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_lootbox`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_lootbox` ;

CREATE TABLE IF NOT EXISTS `user_lootbox` (
  `lootbox_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_lootbox_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_lootbox_has_user_lootbox1_idx` (`lootbox_id` ASC),
  PRIMARY KEY (`lootbox_id`, `user_id`),
  CONSTRAINT `fk_lootbox_has_user_lootbox1`
    FOREIGN KEY (`lootbox_id`)
    REFERENCES `lootbox` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lootbox_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_deck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_deck` ;

CREATE TABLE IF NOT EXISTS `user_deck` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  `card_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_deck_card1_idx` (`card_id` ASC),
  INDEX `fk_user_deck_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_deck_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_deck_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lootbox_rewards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lootbox_rewards` ;

CREATE TABLE IF NOT EXISTS `lootbox_rewards` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lootbox_id` INT NOT NULL,
  `card_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `fk_lootbox_rewards_lootbox1_idx` (`lootbox_id` ASC),
  INDEX `fk_lootbox_rewards_card1_idx` (`card_id` ASC),
  CONSTRAINT `fk_lootbox_rewards_lootbox1`
    FOREIGN KEY (`lootbox_id`)
    REFERENCES `lootbox` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lootbox_rewards_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS tcg;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'tcg' IDENTIFIED BY 'tcg';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'tcg';
GRANT SELECT, INSERT, TRIGGER ON TABLE * TO 'tcg';
GRANT SELECT ON TABLE * TO 'tcg';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `user` (`id`, `username`, `email`, `password`, `created_at`, `role`, `enabled`) VALUES (1, 'test', 'test@test.com', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', NULL, 'ADMIN', 1);
INSERT INTO `user` (`id`, `username`, `email`, `password`, `created_at`, `role`, `enabled`) VALUES (2, 'test2', 'test2@test.com', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', NULL, 'BASIC', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `card`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `card` (`id`, `name`, `attack_power`, `rarity`) VALUES (1, 'testcard1', 1, NULL);
INSERT INTO `card` (`id`, `name`, `attack_power`, `rarity`) VALUES (2, 'testcard2', 2, NULL);
INSERT INTO `card` (`id`, `name`, `attack_power`, `rarity`) VALUES (3, 'testcard3', 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `user_group` (`id`, `type`, `description`) VALUES (1, 'testgroup', 'testing');

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `message` (`id`, `content`, `created_at`, `updated_at`, `user_id`, `parent_message`, `user_group_id`) VALUES (1, 'testing', NULL, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trade`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `trade` (`id`, `accepted`, `user1_id`, `user2_id`) VALUES (1, 0, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trade_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `trade_item` (`id`, `trade_id`, `card_id`, `user_id`) VALUES (1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_group_members`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `user_group_members` (`user_group_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `game` (`id`, `completed`, `player_1`, `player_2`) VALUES (1, 1, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `move`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `move` (`id`, `game_id`, `card_id`, `user_id`) VALUES (1, 1, 1, 1);
INSERT INTO `move` (`id`, `game_id`, `card_id`, `user_id`) VALUES (2, 1, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lootbox`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `lootbox` (`id`, `name`, `tier`) VALUES (1, 'testbox', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_lootbox`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `user_lootbox` (`lootbox_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_deck`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (1, 3, 1, 1);
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (2, 5, 2, 1);
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (3, 2, 3, 1);
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (4, 5, 1, 2);
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (5, 6, 2, 2);
INSERT INTO `user_deck` (`id`, `quantity`, `card_id`, `user_id`) VALUES (6, 2, 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lootbox_rewards`
-- -----------------------------------------------------
START TRANSACTION;
USE `tcgdb`;
INSERT INTO `lootbox_rewards` (`id`, `lootbox_id`, `card_id`, `quantity`) VALUES (1, 1, 1, 2);
INSERT INTO `lootbox_rewards` (`id`, `lootbox_id`, `card_id`, `quantity`) VALUES (2, 1, 2, 3);
INSERT INTO `lootbox_rewards` (`id`, `lootbox_id`, `card_id`, `quantity`) VALUES (3, 1, 3, 4);

COMMIT;

