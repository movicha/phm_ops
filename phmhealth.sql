SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `phmhealth` DEFAULT CHARACTER SET utf8 ;
USE `phmhealth` ;

-- -----------------------------------------------------
-- Table `phmhealth`.`activity_codes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`activity_codes` (
  `activity_code_id` INT(11) NOT NULL ,
  `code` VARCHAR(500) NULL DEFAULT NULL ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  PRIMARY KEY (`activity_code_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`address` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `street_1` VARCHAR(150) NULL DEFAULT NULL ,
  `street_2` VARCHAR(150) NULL DEFAULT NULL ,
  `street_3` VARCHAR(150) NULL DEFAULT NULL ,
  `city` VARCHAR(45) NULL DEFAULT NULL ,
  `state` VARCHAR(45) NULL DEFAULT NULL ,
  `country` VARCHAR(45) NULL DEFAULT NULL ,
  `zip` VARCHAR(45) NULL DEFAULT NULL ,
  `position` VARCHAR(45) NULL DEFAULT NULL ,
  `Elevation` VARCHAR(45) NULL DEFAULT NULL ,
  `Geosphereradius` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`agency`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`agency` (
  `ID` INT(11) NOT NULL ,
  `Address_ID` INT(11) NULL DEFAULT NULL ,
  `Name` VARCHAR(150) NULL DEFAULT NULL ,
  `Size` INT(11) NULL DEFAULT NULL ,
  `Sign_Up_Date` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) ,
  INDEX `Address_Id_idx` (`Address_ID` ASC) ,
  CONSTRAINT `AddressID`
    FOREIGN KEY (`Address_ID` )
    REFERENCES `phmhealth`.`address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`agency_certificate`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`agency_certificate` (
  `AgencyID` INT(11) NOT NULL ,
  `Certification` VARCHAR(45) NOT NULL ,
  `ValidForm` DATETIME NULL DEFAULT NULL ,
  `ValidTo` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`AgencyID`, `Certification`) ,
  INDEX `AgencyID_idx` (`AgencyID` ASC) ,
  CONSTRAINT `Agency_ID`
    FOREIGN KEY (`AgencyID` )
    REFERENCES `phmhealth`.`agency` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`user_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`user_types` (
  `Id` INT(11) NOT NULL ,
  `Type` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`user` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `User_type_id` INT(11) NULL DEFAULT NULL ,
  `First_Name` VARCHAR(60) NULL DEFAULT NULL ,
  `Last_Name` VARCHAR(60) NULL DEFAULT NULL ,
  `Address_Id` INT(11) NULL DEFAULT NULL ,
  `username` VARCHAR(45) NULL DEFAULT NULL ,
  `email` VARCHAR(500) NULL DEFAULT NULL ,
  `password` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) ,
  INDEX `user_type_id_idx` (`User_type_id` ASC) ,
  INDEX `Address_Id_idx` (`Address_Id` ASC) ,
  CONSTRAINT `Address_Id`
    FOREIGN KEY (`Address_Id` )
    REFERENCES `phmhealth`.`address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_type_id`
    FOREIGN KEY (`User_type_id` )
    REFERENCES `phmhealth`.`user_types` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`agency_users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`agency_users` (
  `AgencyID` INT(11) NOT NULL ,
  `user_id` INT(11) NOT NULL ,
  PRIMARY KEY (`AgencyID`, `user_id`) ,
  INDEX `user_id_idx` (`user_id` ASC) ,
  INDEX `AgencyID_idx` (`AgencyID` ASC) ,
  CONSTRAINT `AgencyID`
    FOREIGN KEY (`AgencyID` )
    REFERENCES `phmhealth`.`agency` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userid`
    FOREIGN KEY (`user_id` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`devices_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`devices_types` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT ,
  `Type` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`devices` (
  `Device_Unique_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Device_ID` VARCHAR(500) NULL DEFAULT NULL ,
  `Device_Type_Id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`Device_Unique_ID`) ,
  UNIQUE INDEX `ID_UNIQUE` (`Device_Unique_ID` ASC) ,
  INDEX `devicetypeID_idx` (`Device_Type_Id` ASC) ,
  CONSTRAINT `devicetypeID`
    FOREIGN KEY (`Device_Type_Id` )
    REFERENCES `phmhealth`.`devices_types` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`provider_schedule`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`provider_schedule` (
  `schedule_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `schedule_time` INT(11) NULL DEFAULT NULL ,
  `schedule_duration` INT(11) NULL DEFAULT '0' ,
  `min_start` INT(11) NULL DEFAULT '0' ,
  `max_start` INT(11) NULL DEFAULT '0' ,
  PRIMARY KEY (`schedule_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`visit`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`visit` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Visit_Started` INT(20) NULL DEFAULT '0' ,
  `Visit_Completed` INT(20) NULL DEFAULT '0' ,
  `Description` VARCHAR(2000) NULL DEFAULT NULL ,
  `visitduration` INT(11) NULL DEFAULT '0' ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`patient_panel`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`patient_panel` (
  `panel_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `patient_id` INT(11) NULL DEFAULT NULL ,
  `provider_id` INT(11) NULL DEFAULT NULL ,
  `visit_id` INT(11) NULL DEFAULT NULL ,
  `schedule_id` INT(11) NULL DEFAULT NULL ,
  `address_id` INT(11) NULL DEFAULT '0' ,
  PRIMARY KEY (`panel_id`) ,
  INDEX `visit_id_idx` (`visit_id` ASC) ,
  INDEX `schedule_id_idx` (`schedule_id` ASC) ,
  INDEX `provider_idx` (`provider_id` ASC) ,
  CONSTRAINT `provider`
    FOREIGN KEY (`provider_id` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `schedule`
    FOREIGN KEY (`schedule_id` )
    REFERENCES `phmhealth`.`provider_schedule` (`schedule_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `visit`
    FOREIGN KEY (`visit_id` )
    REFERENCES `phmhealth`.`visit` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`patient_users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`patient_users` (
  `patient_id` INT(11) NOT NULL ,
  `user_id` INT(11) NOT NULL ,
  `authorization_request` DATETIME NULL DEFAULT NULL ,
  `approved` BIT(1) NULL DEFAULT b'1' ,
  `approved_method` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`patient_id`, `user_id`) ,
  INDEX `userid_idx` (`user_id` ASC) ,
  CONSTRAINT `patient_users_ibfk_1`
    FOREIGN KEY (`user_id` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`play_evolutions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`play_evolutions` (
  `id` INT(11) NOT NULL ,
  `hash` VARCHAR(255) NOT NULL ,
  `applied_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `apply_script` TEXT NULL DEFAULT NULL ,
  `revert_script` TEXT NULL DEFAULT NULL ,
  `state` VARCHAR(255) NULL DEFAULT NULL ,
  `last_problem` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`user_access_log`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`user_access_log` (
  `user_id` INT(11) NOT NULL ,
  `device_id` INT(11) NOT NULL ,
  `accesstime` DATETIME NOT NULL ,
  `lat` FLOAT NULL DEFAULT NULL ,
  `Lng` FLOAT NULL DEFAULT NULL ,
  PRIMARY KEY (`accesstime`, `user_id`, `device_id`) ,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) ,
  UNIQUE INDEX `device_id_UNIQUE` (`device_id` ASC) ,
  INDEX `device_id_idx` (`device_id` ASC) ,
  CONSTRAINT `user_access_log_ibfk_1`
    FOREIGN KEY (`user_id` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_access_log_ibfk_2`
    FOREIGN KEY (`device_id` )
    REFERENCES `phmhealth`.`devices` (`Device_Unique_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`user_devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`user_devices` (
  `user_id` INT(11) NOT NULL ,
  `device_id` INT(11) NOT NULL ,
  PRIMARY KEY (`user_id`, `device_id`) ,
  INDEX `userid_idx` (`user_id` ASC) ,
  INDEX `deviceid_idx` (`device_id` ASC) ,
  CONSTRAINT `user_devices_ibfk_1`
    FOREIGN KEY (`user_id` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_devices_ibfk_2`
    FOREIGN KEY (`device_id` )
    REFERENCES `phmhealth`.`devices` (`Device_Unique_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phmhealth`.`visit_notes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `phmhealth`.`visit_notes` (
  `Visit_ID` INT(11) NOT NULL ,
  `User_ID` INT(11) NOT NULL ,
  `Note_Date` DATETIME NOT NULL ,
  `Note` VARCHAR(5000) NULL DEFAULT NULL ,
  PRIMARY KEY (`Visit_ID`, `User_ID`, `Note_Date`) ,
  INDEX `VisitID_idx` (`Visit_ID` ASC) ,
  INDEX `UserID_idx` (`User_ID` ASC) ,
  CONSTRAINT `VisitID`
    FOREIGN KEY (`Visit_ID` )
    REFERENCES `phmhealth`.`visit` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `visit_notes_ibfk_1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `phmhealth`.`user` (`ID` )
    ON DELETE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `phmhealth` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
