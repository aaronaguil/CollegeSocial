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
-- Table `Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Type` ;

CREATE TABLE IF NOT EXISTS `Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
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
  `Institution_id` INT NOT NULL,
  `Type_id` INT NOT NULL,
  `Condition_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Post_Institution1`
    FOREIGN KEY (`Institution_id`)
    REFERENCES `Institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Type1`
    FOREIGN KEY (`Type_id`)
    REFERENCES `Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Condition1`
    FOREIGN KEY (`Condition_id`)
    REFERENCES `Condition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Post_Institution1_idx` ON `Post` (`Institution_id` ASC);

CREATE INDEX `fk_Post_Type1_idx` ON `Post` (`Type_id` ASC);

CREATE INDEX `fk_Post_Condition1_idx` ON `Post` (`Condition_id` ASC);


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
  `Post_id` INT NOT NULL,
  `Course_id` INT NOT NULL,
  `Subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Book_Post1`
    FOREIGN KEY (`Post_id`)
    REFERENCES `Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_Course1`
    FOREIGN KEY (`Course_id`)
    REFERENCES `Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_Subject1`
    FOREIGN KEY (`Subject_id`)
    REFERENCES `Subject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_Post1_idx` ON `Book` (`Post_id` ASC);

CREATE INDEX `fk_Book_Course1_idx` ON `Book` (`Course_id` ASC);

CREATE INDEX `fk_Book_Subject1_idx` ON `Book` (`Subject_id` ASC);


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
-- Table `Notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Notification` ;

CREATE TABLE IF NOT EXISTS `Notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `read` TINYINT(1) NOT NULL,
  `message` VARCHAR(200) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `User_id` INT NOT NULL,
  `date_generated` DATETIME NOT NULL,
  `Message_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Notification_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notification_Message1`
    FOREIGN KEY (`Message_id`)
    REFERENCES `Message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Notification_User1_idx` ON `Notification` (`User_id` ASC);

CREATE INDEX `fk_Notification_Message1_idx` ON `Notification` (`Message_id` ASC);


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

-- -----------------------------------------------------
-- Data for table `User`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (1, 'aaronaguil', 'aaron@test.com', 'aaronaguil', 'Aaron', 'Aguil', 'Finance', 'Senior', '2017-01-01 00:00:00', 1);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (2, 'danielbalazerro', 'daniel@test.com', 'danielbalazerro', 'Daniel', 'Balazerro', 'Engineering', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (3, 'stephenchiang', 'stephen@test.com', 'stephenchiang', 'Stephen', 'Chiang', 'Computer Science', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (4, 'seththomas', 'seth@test.com', 'seththomas', 'Seth', 'Thomas', 'Mechanical Engineering', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (5, 'denniscarr', 'dennis@test.com', 'denniscarr', 'Dennis', 'Carrasquillo', 'Physics', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (6, 'chandankumar', 'chandan@test.com', 'chandankumar', 'Chandan', 'Kumar', 'Biology', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (7, 'stefanfuller', 'stefan@test.com', 'stefanfuller', 'Stefan', 'Fuller', 'Chemistry', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (8, 'ehrenwilliamson', 'ehren@test.com', 'ehrenwilliamson', 'Ehren', 'Williamson', 'Information Technology', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (9, 'shaundashjin', 'shaun@test.com', 'shaundashjin', 'Shaun', 'Dashjin', 'Computer Science', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (10, 'mattgmur', 'matt@test.com', 'mattgmur', 'Matt', 'Gmur', 'Marketing', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (11, 'gregengler', 'greg@test.com', 'gregengler', 'Greg', 'Engler', 'History', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (12, 'gregtaylor', 'gregtaylor@test.com', 'gregtaylor', 'Greg', 'Taylor', 'Psychology', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (13, 'willroberts', 'will@test.com', 'willroberts', 'Will', 'Roberts', 'Art', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (14, 'benblodgett', 'ben@test.com', 'benblodgett', 'Ben', 'Blodgett', 'Finance', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (15, 'ryangrillow', 'ryan@test.com', 'ryangrillo', 'Ryan', 'Grillo', 'Math', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (16, 'paulpistorius', 'paul@test.com', 'paulpistorius', 'Paul', 'Pistorius', 'Mechanical Engineering', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (17, 'ericlee', 'eric@test.com', 'ericlee', 'Eric', 'Lee', 'Electrical Engineering', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (18, 'nancytran', 'nancy@test.com', 'nancytran', 'Nancy', 'Tran', 'Math', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (19, 'milesgrandin', 'miles@test.com', 'milesgrandin', 'Miles', 'Grandin', 'Law', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (20, 'sebastianhellsing', 'sebastian@test.com', 'sebastianhellsing', 'Sebastian', 'Hellsing', 'Information Technology', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (21, 'jacobwood', 'jacob@test.com', 'jacobwood', 'Jacob', 'Wood', 'Physics', 'Senior', '2017-01-01 00:00:00', 0);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `major`, `classification`, `registration_date`, `admin`) VALUES (22, 'michaelroschenwimmer', 'michael@tests.com', 'michaelroschenwimmer', 'Michael', 'Roschenwenwimmer', 'Chemistry', 'Senior', '2017-01-01 00:00:00', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Institution`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Institution` (`id`, `name`, `location`) VALUES (1, 'University of Denver', 'Denver');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Type`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Type` (`id`, `type`) VALUES (1, 'Book');
INSERT INTO `Type` (`id`, `type`) VALUES (2, 'Personal');
INSERT INTO `Type` (`id`, `type`) VALUES (3, 'Dorm/Housing');
INSERT INTO `Type` (`id`, `type`) VALUES (4, 'School');
INSERT INTO `Type` (`id`, `type`) VALUES (5, 'Miscellaneous');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Condition`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Condition` (`id`, `condition`) VALUES (1, 'Poor');
INSERT INTO `Condition` (`id`, `condition`) VALUES (2, 'Fair');
INSERT INTO `Condition` (`id`, `condition`) VALUES (3, 'Good');
INSERT INTO `Condition` (`id`, `condition`) VALUES (4, 'Excellent');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Post`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (1, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 20.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (2, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 20.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:02:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (3, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 20.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:03:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (4, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 20.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:04:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (5, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 20.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:05:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (6, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 19.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (7, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 19.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (8, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 19.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (9, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 19.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (10, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 19.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (11, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 18.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (12, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 18.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (13, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 18.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (14, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 18.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (15, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 18.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (16, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 17.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (17, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 17.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (18, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 17.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (19, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 17.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (20, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 17.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (21, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 16.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (22, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 16.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (23, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 16.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (24, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 16.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (25, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 16.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (26, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 15.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (27, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 15.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (28, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 15.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (29, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 15.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (30, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 15.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (31, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 14.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (32, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 14.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (33, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 14.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (34, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 14.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (35, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 14.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (36, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 13.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (37, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 13.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (38, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 13.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (39, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 13.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (40, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 13.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (41, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 12.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (42, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 12.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (43, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 12.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (44, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 12.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (45, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 12.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (46, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 11.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (47, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 11.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (48, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 11.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (49, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 11.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (50, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 11.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (51, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 10.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (52, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 10.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (53, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 10.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (54, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 10.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (55, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 10.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (56, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 9.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (57, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 9.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (58, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 9.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (59, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 9.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (60, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 9.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (61, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 8.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (62, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 8.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (63, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 8.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (64, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 8.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (65, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 8.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (66, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 7.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (67, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 7.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (68, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 7.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (69, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 7.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (70, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 7.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (71, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 6.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (72, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 6.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (73, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 6.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (74, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 6.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (75, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 6.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (76, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 5.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (77, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 5.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (78, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 5.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (79, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 5.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (80, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 5.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (81, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 4.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (82, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 4.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (83, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 4.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (84, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 4.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (85, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 4.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (86, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 3.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 1, 2);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (87, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 3.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 2, 3);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (88, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 3.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 3, 1);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (89, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 3.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 4, 4);
INSERT INTO `Post` (`id`, `title`, `description`, `price`, `image`, `date`, `Institution_id`, `Type_id`, `Condition_id`) VALUES (90, 'For Sale! Message me for details!', 'This is a really good deal! It is in great condition', 3.55, 'http://www.mobigame.top/wp-content/plugins/kentooz-socializer/images/default.jpg', '2017-01-01 01:01:00', 1, 5, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (1, 'CS101', 'James', 'Gosling', 'W101CS');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (2, 'CS201', 'James', 'Gosling', 'W210CS');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (3, 'MTH101', 'John', 'Prius', 'W101MTH');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (4, 'MTH201', 'John', 'Prius', 'W201MTH');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (5, 'BIO', 'Eric', 'Shin', 'W101BIO');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (6, 'BIO', 'Eric', 'Shin', 'W201BIO');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (7, 'HIST', 'Scott', 'Taylor', 'W101HIST');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (8, 'HIST', 'Scott', 'Taylor', 'W201HIST');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (9, 'ART', 'Janice', 'Sasaki', 'W101ART');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (10, 'ART', 'Janice', 'Sasaki', 'W201ART');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (11, 'ENGL', 'Ricky', 'Kwon', 'W101ENG');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (12, 'ENGL', 'Ricky', 'Kwon', 'W201ENG');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (13, 'FREN', 'Andrew', 'Brink', 'W101FREN');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (14, 'FREN', 'Andrew', 'Brink', 'W201FREN');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (15, 'JAP', 'Lauren', 'Matsumoto', 'W101JAP');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (16, 'JAP', 'Lauren', 'Matsumoto', 'W201JAP');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (17, 'PHY', 'Blake', 'Honda', 'W101PHY');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (18, 'PHY', 'Blake', 'Honda', 'W201PHY');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (19, 'CHM', 'Kimo', 'Kamiya', 'W101CHM');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (20, 'CHM', 'Kimo', 'Kamiya', 'W201CHM');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (21, 'COMM', 'Craig', 'Chang', 'W101COMM');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (22, 'COMM', 'Craig', 'Chang', 'W201COMM');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (23, 'BUS', 'Emma', 'Harper', 'W101BUS');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (24, 'BUS', 'Emma', 'Harper', 'W201BUS');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (25, 'MKT', 'Ethan', 'Carter', 'W101MKT');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (26, 'MKT', 'Ethan', 'Carter', 'W201MKT');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (27, 'FIN', 'Logan', 'Madison', 'W101FIN');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (28, 'FIN', 'Logan', 'Madison', 'W201FIN');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (29, 'PSY', 'Aubrey', 'Henry', 'W101PSY');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (30, 'PSY', 'Aubrey', 'Henry', 'W201PSY');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (31, 'SOC', 'William', 'Samson', 'W101SOC');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (32, 'SOC', 'William', 'Samson', 'W201SOC');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (33, 'IT', 'Michael', 'Smith', 'W101IT');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (34, 'IT', 'Michael', 'Smith', 'W201IT');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (35, 'ME', 'Alex', 'Jones', 'W101ME');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (36, 'ME', 'Alex', 'Jones', 'W201ME');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (37, 'EE', 'Dillon', 'Brown', 'W101EE');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (38, 'EE', 'Dillon', 'Brown', 'W201EE');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (39, 'CE', 'Riley', 'Davis', 'W101CE');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (40, 'CE', 'Riley', 'Davis', 'W201CE');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (41, 'SP', 'Grace', 'Anderson', 'W101SP');
INSERT INTO `Course` (`id`, `name`, `instructor_first_name`, `instructor_last_name`, `course_code`) VALUES (42, 'SP', 'Grace', 'Anderson', 'W201SP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Subject` (`id`, `name`) VALUES (1, 'Math');
INSERT INTO `Subject` (`id`, `name`) VALUES (2, 'Biology');
INSERT INTO `Subject` (`id`, `name`) VALUES (3, 'History');
INSERT INTO `Subject` (`id`, `name`) VALUES (4, 'Art');
INSERT INTO `Subject` (`id`, `name`) VALUES (5, 'English');
INSERT INTO `Subject` (`id`, `name`) VALUES (6, 'French');
INSERT INTO `Subject` (`id`, `name`) VALUES (7, 'Japanese');
INSERT INTO `Subject` (`id`, `name`) VALUES (8, 'Computer Science');
INSERT INTO `Subject` (`id`, `name`) VALUES (9, 'Physics');
INSERT INTO `Subject` (`id`, `name`) VALUES (10, 'Chemistry');
INSERT INTO `Subject` (`id`, `name`) VALUES (11, 'Communications');
INSERT INTO `Subject` (`id`, `name`) VALUES (12, 'Business');
INSERT INTO `Subject` (`id`, `name`) VALUES (13, 'Marketing');
INSERT INTO `Subject` (`id`, `name`) VALUES (14, 'Finance');
INSERT INTO `Subject` (`id`, `name`) VALUES (15, 'Psychology');
INSERT INTO `Subject` (`id`, `name`) VALUES (16, 'Sociology');
INSERT INTO `Subject` (`id`, `name`) VALUES (17, 'Information Technology');
INSERT INTO `Subject` (`id`, `name`) VALUES (18, 'Electrical Engineering');
INSERT INTO `Subject` (`id`, `name`) VALUES (19, 'Mechanical Engineering');
INSERT INTO `Subject` (`id`, `name`) VALUES (20, 'Computer Engineering');
INSERT INTO `Subject` (`id`, `name`) VALUES (21, 'Speech');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Message`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (1, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 2, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (2, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 2, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (3, '2017-01-01 01:04:00', 'we can meet at the campus center.', 2, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (4, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 2, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (5, '2017-01-01 01:07:00', 'see you soon!', 2, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (6, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 2);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (7, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 2);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (8, '2017-01-01 01:08:00', 'see ya!', 1, 2);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (9, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 3, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (10, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 3, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (11, '2017-01-01 01:04:00', 'we can meet at the campus center.', 3, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (12, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 3, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (13, '2017-01-01 01:07:00', 'see you soon!', 3, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (14, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 3);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (15, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 3);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (16, '2017-01-01 01:08:00', 'see ya!', 1, 3);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (17, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 4, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (18, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 4, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (19, '2017-01-01 01:04:00', 'we can meet at the campus center.', 4, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (20, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 4, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (21, '2017-01-01 01:07:00', 'see you soon!', 4, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (22, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 4);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (23, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 4);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (24, '2017-01-01 01:08:00', 'see ya!', 1, 4);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (25, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 5, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (26, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 5, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (27, '2017-01-01 01:04:00', 'we can meet at the campus center.', 5, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (28, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 5, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (29, '2017-01-01 01:07:00', 'see you soon!', 5, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (30, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 5);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (31, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 5);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (32, '2017-01-01 01:08:00', 'see ya!', 1, 5);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (33, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 6, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (34, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 6, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (35, '2017-01-01 01:04:00', 'we can meet at the campus center.', 6, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (36, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 6, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (37, '2017-01-01 01:07:00', 'see you soon!', 6, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (38, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 6);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (39, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 6);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (40, '2017-01-01 01:08:00', 'see ya!', 1, 6);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (41, '2017-01-01 00:00:00', 'Hey how are you. I am interested in buying your item. How much is it', 7, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (42, '2017-01-01 01:01:00', 'Great! would you like to meet up?', 7, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (43, '2017-01-01 01:04:00', 'we can meet at the campus center.', 7, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (44, '2017-01-01 01:06:00', 'ok. does 1pm sound good. I have a class right after so it wont be long. Thank you again! ', 7, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (45, '2017-01-01 01:07:00', 'see you soon!', 7, 1);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (46, '2017-01-01 01:00:00', 'Hi! its $20 but honestly i really want to get rid of it so I am willing to sell it for $15', 1, 7);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (47, '2017-01-01 01:05:00', 'yes, the campus center is great. I might have to leave shortly after', 1, 7);
INSERT INTO `Message` (`id`, `datetime`, `message`, `user_sent`, `user_received`) VALUES (48, '2017-01-01 01:08:00', 'see ya!', 1, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Notification`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Notification` (`id`, `read`, `message`, `type`, `User_id`, `date_generated`, `Message_id`) VALUES (1, 0, 'stephenchiang left you a message', 'message', 1, '2017-01-01 00:00:00', 9);
INSERT INTO `Notification` (`id`, `read`, `message`, `type`, `User_id`, `date_generated`, `Message_id`) VALUES (2, 0, 'stephenchiang left you a message', 'message', 1, '2017-01-01 00:00:00', 10);
INSERT INTO `Notification` (`id`, `read`, `message`, `type`, `User_id`, `date_generated`, `Message_id`) VALUES (3, 0, 'stephenchiang left you a message', 'message', 1, '2017-01-01 00:00:00', 11);
INSERT INTO `Notification` (`id`, `read`, `message`, `type`, `User_id`, `date_generated`, `Message_id`) VALUES (4, 0, 'stephenchiang left you a message', 'message', 1, '2017-01-01 00:00:00', 12);
INSERT INTO `Notification` (`id`, `read`, `message`, `type`, `User_id`, `date_generated`, `Message_id`) VALUES (5, 0, 'stephenchiang left you a message', 'message', 1, '2017-01-01 00:00:00', 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `User_Institution`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (1, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (2, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (3, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (4, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (5, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (6, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (7, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (8, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (9, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (10, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (11, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (12, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (13, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (14, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (15, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (16, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (17, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (18, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (19, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (20, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (21, 1);
INSERT INTO `User_Institution` (`User_id`, `Institution_id`) VALUES (22, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Tutor_Info`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (1, 'I am a great tutor.', '2017-01-01 00:00:00', 1);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (2, 'I am a great tutor.', '2017-01-01 00:00:00', 2);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (3, 'I am a great tutor.', '2017-01-01 00:00:00', 3);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (4, 'I am a great tutor.', '2017-01-01 00:00:00', 4);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (5, 'I am a great tutor.', '2017-01-01 00:00:00', 5);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (6, 'I am a great tutor.', '2017-01-01 00:00:00', 6);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (7, 'I am a great tutor.', '2017-01-01 00:00:00', 7);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (8, 'I am a great tutor.', '2017-01-01 00:00:00', 8);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (9, 'I am a great tutor.', '2017-01-01 00:00:00', 9);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (10, 'I am a great tutor.', '2017-01-01 00:00:00', 10);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (11, 'I am a great tutor.', '2017-01-01 00:00:00', 11);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (12, 'I am a great tutor.', '2017-01-01 00:00:00', 12);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (13, 'I am a great tutor.', '2017-01-01 00:00:00', 13);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (14, 'I am a great tutor.', '2017-01-01 00:00:00', 14);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (15, 'I am a great tutor.', '2017-01-01 00:00:00', 15);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (16, 'I am a great tutor.', '2017-01-01 00:00:00', 16);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (17, 'I am a great tutor.', '2017-01-01 00:00:00', 17);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (18, 'I am a great tutor.', '2017-01-01 00:00:00', 18);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (19, 'I am a great tutor.', '2017-01-01 00:00:00', 19);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (20, 'I am a great tutor.', '2017-01-01 00:00:00', 20);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (21, 'I am a great tutor.', '2017-01-01 00:00:00', 21);
INSERT INTO `Tutor_Info` (`id`, `description`, `date_start`, `User_id`) VALUES (22, 'I am a great tutor.', '2017-01-01 00:00:00', 22);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Tutoring_Subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `TheCollegeSocialdb`;
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (1, 'Algebra', 4.1, 25, 1);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (2, 'History', 4.2, 20, 1);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (3, 'Java', 4.0, 25, 1);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (4, 'Biology', 3.5, 15, 1);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (5, 'Chemistry', 4.5, 25, 1);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (6, 'Algebra', 4.1, 25, 2);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (7, 'History', 4.2, 20, 2);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (8, 'Java', 4.0, 25, 2);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (9, 'Biology', 3.5, 15, 2);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (10, 'Chemistry', 4.5, 25, 2);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (11, 'Algebra', 4.1, 25, 3);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (12, 'History', 4.2, 20, 3);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (13, 'Java', 4.0, 25, 3);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (14, 'Biology', 3.5, 15, 3);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (15, 'Chemistry', 4.5, 25, 3);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (16, 'Algebra', 4.1, 25, 4);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (17, 'History', 4.2, 20, 4);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (18, 'Java', 4.0, 25, 4);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (19, 'Biology', 3.5, 15, 4);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (20, 'Chemistry', 4.5, 25, 4);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (21, 'Algebra', 4.1, 25, 5);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (22, 'History', 4.2, 20, 5);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (23, 'Java', 4.0, 25, 5);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (24, 'Biology', 3.5, 15, 5);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (25, 'Chemistry', 4.5, 25, 5);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (26, 'Algebra', 4.1, 25, 6);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (27, 'History', 4.2, 20, 6);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (28, 'Java', 4.0, 25, 6);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (29, 'Biology', 3.5, 15, 6);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (30, 'Chemistry', 4.5, 25, 6);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (31, 'Algebra', 4.1, 25, 7);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (32, 'History', 4.2, 20, 7);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (33, 'Java', 4.0, 25, 7);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (34, 'Biology', 3.5, 15, 7);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (35, 'Chemistry', 4.5, 25, 7);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (36, 'Algebra', 4.1, 25, 8);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (37, 'History', 4.2, 20, 8);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (38, 'Java', 4.0, 25, 8);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (39, 'Biology', 3.5, 15, 8);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (40, 'Chemistry', 4.5, 25, 8);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (41, 'Algebra', 4.1, 25, 9);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (42, 'History', 4.2, 20, 9);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (43, 'Java', 4.0, 25, 9);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (44, 'Biology', 3.5, 15, 9);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (45, 'Chemistry', 4.5, 25, 9);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (46, 'Algebra', 4.1, 25, 10);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (47, 'History', 4.2, 20, 10);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (48, 'Java', 4.0, 25, 10);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (49, 'Biology', 3.5, 15, 10);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (50, 'Chemistry', 4.5, 25, 10);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (51, 'Algebra', 4.1, 25, 11);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (52, 'History', 4.2, 20, 11);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (53, 'Java', 4.0, 25, 11);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (54, 'Biology', 3.5, 15, 11);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (55, 'Chemistry', 4.5, 25, 11);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (56, 'Algebra', 4.1, 25, 12);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (57, 'History', 4.2, 20, 12);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (58, 'Java', 4.0, 25, 12);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (59, 'Biology', 3.5, 15, 12);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (60, 'Chemistry', 4.5, 25, 12);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (61, 'Algebra', 4.1, 25, 13);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (62, 'History', 4.2, 20, 13);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (63, 'Java', 4.0, 25, 13);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (64, 'Biology', 3.5, 15, 13);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (65, 'Chemistry', 4.5, 25, 13);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (66, 'Algebra', 4.1, 25, 14);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (67, 'History', 4.2, 20, 14);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (68, 'Java', 4.0, 25, 14);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (69, 'Biology', 3.5, 15, 14);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (70, 'Chemistry', 4.5, 25, 14);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (71, 'Algebra', 4.1, 25, 15);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (72, 'History', 4.2, 20, 15);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (73, 'Java', 4.0, 25, 15);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (74, 'Biology', 3.5, 15, 15);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (75, 'Chemistry', 4.5, 25, 15);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (76, 'Algebra', 4.1, 25, 16);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (77, 'History', 4.2, 20, 16);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (78, 'Java', 4.0, 25, 16);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (79, 'Biology', 3.5, 15, 16);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (80, 'Chemistry', 4.5, 25, 16);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (81, 'Algebra', 4.1, 25, 17);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (82, 'History', 4.2, 20, 17);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (83, 'Java', 4.0, 25, 17);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (84, 'Biology', 3.5, 15, 17);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (85, 'Chemistry', 4.5, 25, 17);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (86, 'Algebra', 4.1, 25, 18);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (87, 'History', 4.2, 20, 18);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (88, 'Java', 4.0, 25, 18);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (89, 'Biology', 3.5, 15, 18);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (90, 'Chemistry', 4.5, 25, 18);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (91, 'Algebra', 4.1, 25, 19);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (92, 'History', 4.2, 20, 19);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (93, 'Java', 4.0, 25, 19);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (94, 'Biology', 3.5, 15, 19);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (95, 'Chemistry', 4.5, 25, 19);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (96, 'Algebra', 4.1, 25, 20);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (97, 'History', 4.2, 20, 20);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (98, 'Java', 4.0, 25, 20);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (99, 'Biology', 3.5, 15, 20);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (100, 'Chemistry', 4.5, 25, 20);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (101, 'Algebra', 4.1, 25, 21);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (102, 'History', 4.2, 20, 21);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (103, 'Java', 4.0, 25, 21);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (104, 'Biology', 3.5, 15, 21);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (105, 'Chemistry', 4.5, 25, 21);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (106, 'Algebra', 4.1, 25, 22);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (107, 'History', 4.2, 20, 22);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (108, 'Java', 4.0, 25, 22);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (109, 'Biology', 3.5, 15, 22);
INSERT INTO `Tutoring_Subject` (`id`, `subject`, `rating`, `rate`, `tutor_info_id`) VALUES (110, 'Chemistry', 4.5, 25, 22);

COMMIT;

