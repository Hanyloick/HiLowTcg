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
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `role` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`id`));

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
INSERT INTO `user` (`id`, `username`, `email`, `password`, `create_time`, `role`, `enabled`) VALUES (1, 'test', 'test@test.com', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', NULL, 'Admin', 1);

COMMIT;

