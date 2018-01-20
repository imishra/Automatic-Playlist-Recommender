-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema apr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema apr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `apr` DEFAULT CHARACTER SET utf8 ;
USE `apr` ;

-- -----------------------------------------------------
-- Table `apr`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apr`.`users` (
  `user_name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(40) NOT NULL,
  `last_name` VARCHAR(40) NOT NULL,
  `sex` CHAR(6) NOT NULL,
  `street_address` VARCHAR(40) NOT NULL,
  `city` VARCHAR(40) NOT NULL,
  `country` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`user_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `apr`.`credentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apr`.`credentials` (
  `user_name` VARCHAR(30) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`user_name`),
  CONSTRAINT `credentials_ibfk_1`
    FOREIGN KEY (`user_name`)
    REFERENCES `apr`.`users` (`user_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `apr`.`user_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apr`.`user_history` (
  `user_name` VARCHAR(30) NOT NULL,
  `track_name` VARCHAR(100) NOT NULL,
  `listen_count` INT(10) NOT NULL,
  PRIMARY KEY (`user_name`, `track_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `apr`.`user_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apr`.`user_info` (
  `id` VARCHAR(30) NOT NULL,
  `gender` VARCHAR(100) NOT NULL,
  `age` INT(10) NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  `registered` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
