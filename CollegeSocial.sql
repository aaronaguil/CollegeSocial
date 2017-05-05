-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema TheCollegeSocialdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `TheCollegeSocialdb` ;

-- -----------------------------------------------------
-- Schema TheCollegeSocialdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TheCollegeSocialdb` DEFAULT CHARACTER SET utf8 ;
USE `TheCollegeSocialdb` ;

-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `major` VARCHAR(45) NOT NULL,
  `classification` VARCHAR(45) NOT NULL,
  `registration_date` VARCHAR(45) NOT NULL,
  `admin` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Type` ;

CREATE TABLE IF NOT EXISTS `Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Institution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Institution` ;

CREATE TABLE IF NOT EXISTS `Institution` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Condition` ;

CREATE TABLE IF NOT EXISTS `Condition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `condition` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Post` ;

CREATE TABLE IF NOT EXISTS `Post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `image` VARCHAR(45) NULL,
  `date` DATETIME NOT NULL,
  `Type_id` INT NOT NULL,
  `Institution_id` INT NOT NULL,
  `condition_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Post_Type1`
    FOREIGN KEY (`Type_id`)
    REFERENCES `Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Institution1`
    FOREIGN KEY (`Institution_id`)
    REFERENCES `Institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_condition1`
    FOREIGN KEY (`condition_id`)
    REFERENCES `Condition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Post_Type1_idx` ON `Post` (`Type_id` ASC);

CREATE INDEX `fk_Post_Institution1_idx` ON `Post` (`Institution_id` ASC);

CREATE INDEX `fk_Post_condition1_idx` ON `Post` (`condition_id` ASC);


-- -----------------------------------------------------
-- Table `Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course` ;

CREATE TABLE IF NOT EXISTS `Course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `instructor_first_name` VARCHAR(45) NULL,
  `instructor_last_name` VARCHAR(45) NULL,
  `course_code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Subject` ;

CREATE TABLE IF NOT EXISTS `Subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Book` ;

CREATE TABLE IF NOT EXISTS `Book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `edition` VARCHAR(45) NULL,
  `isbn` VARCHAR(45) NULL,
  `has_notes` INT NOT NULL,
  `Course_id` INT NOT NULL,
  `Post_id` INT NOT NULL,
  `Subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Book_Course`
    FOREIGN KEY (`Course_id`)
    REFERENCES `Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_Post1`
    FOREIGN KEY (`Post_id`)
    REFERENCES `Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_Subject1`
    FOREIGN KEY (`Subject_id`)
    REFERENCES `Subject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_Course_idx` ON `Book` (`Course_id` ASC);

CREATE INDEX `fk_Book_Post1_idx` ON `Book` (`Post_id` ASC);

CREATE INDEX `fk_Book_Subject1_idx` ON `Book` (`Subject_id` ASC);


-- -----------------------------------------------------
-- Table `Notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Notification` ;

CREATE TABLE IF NOT EXISTS `Notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `read` INT NOT NULL,
  `message` VARCHAR(200) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `User_id` INT NOT NULL,
  `date_generated` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Notification_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Notification_User1_idx` ON `Notification` (`User_id` ASC);


-- -----------------------------------------------------
-- Table `Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Message` ;

CREATE TABLE IF NOT EXISTS `Message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datetime` DATETIME NOT NULL,
  `message` VARCHAR(2000) NOT NULL,
  `user_sent` INT NOT NULL,
  `user_received` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Message_User2`
    FOREIGN KEY (`user_sent`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User1`
    FOREIGN KEY (`user_received`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Message_User2_idx` ON `Message` (`user_sent` ASC);

CREATE INDEX `fk_Message_User1_idx` ON `Message` (`user_received` ASC);


-- -----------------------------------------------------
-- Table `Blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blog` ;

CREATE TABLE IF NOT EXISTS `Blog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `subject` VARCHAR(45) NOT NULL,
  `body` VARCHAR(10000) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Group` ;

CREATE TABLE IF NOT EXISTS `Group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created` TINYINT(1) NOT NULL,
  `date_created` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User_Institution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User_Institution` ;

CREATE TABLE IF NOT EXISTS `User_Institution` (
  `User_id` INT NOT NULL,
  `Institution_id` INT NOT NULL,
  PRIMARY KEY (`User_id`, `Institution_id`),
  CONSTRAINT `fk_User_has_Institution_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Institution_Institution1`
    FOREIGN KEY (`Institution_id`)
    REFERENCES `Institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_has_Institution_Institution1_idx` ON `User_Institution` (`Institution_id` ASC);

CREATE INDEX `fk_User_has_Institution_User1_idx` ON `User_Institution` (`User_id` ASC);


-- -----------------------------------------------------
-- Table `Tutor_Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tutor_Info` ;

CREATE TABLE IF NOT EXISTS `Tutor_Info` (
  `id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `date_start` DATETIME NOT NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tutor_info_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tutor_info_User1_idx` ON `Tutor_Info` (`User_id` ASC);


-- -----------------------------------------------------
-- Table `Tutoring_Subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tutoring_Subject` ;

CREATE TABLE IF NOT EXISTS `Tutoring_Subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(45) NOT NULL,
  `rating` FLOAT NOT NULL,
  `rate` INT NOT NULL,
  `tutor_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Tutoring_subject_tutor_info1`
    FOREIGN KEY (`tutor_info_id`)
    REFERENCES `Tutor_Info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Tutoring_subject_tutor_info1_idx` ON `Tutoring_Subject` (`tutor_info_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
