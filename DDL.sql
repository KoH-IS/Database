-- NOTEN QUE LA INSTANCIA DE BASE DE DATOA SE LLAMA "mydb"
-----------------------------------------------------------

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Disciplinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disciplinas` (
  `idDisciplinas` INT NOT NULL AUTO_INCREMENT,
  `NombreDsiciplina` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDisciplinas`),
  UNIQUE INDEX `idDisciplinas_UNIQUE` (`idDisciplinas` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrenadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrenadores` (
  `idEntrenadores` INT NOT NULL AUTO_INCREMENT,
  `NombreEntrenador` VARCHAR(45) NOT NULL,
  `ApellidoPaternoEntrenador` VARCHAR(45) NOT NULL,
  `ApellidoMaternoEntrenador` VARCHAR(45) NOT NULL,
  `DisciplinaEntrenador` INT NOT NULL,
  PRIMARY KEY (`idEntrenadores`),
  UNIQUE INDEX `idEntrenadores_UNIQUE` (`idEntrenadores` ASC) VISIBLE,
  INDEX `DisciplinaEntrenador_idx` (`DisciplinaEntrenador` ASC) VISIBLE,
  CONSTRAINT `DisciplinaEntrenador`
    FOREIGN KEY (`DisciplinaEntrenador`)
    REFERENCES `mydb`.`Disciplinas` (`idDisciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Competidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Competidores` (
  `idCompetidores` INT NOT NULL AUTO_INCREMENT,
  `NombreCompetidor` VARCHAR(45) NOT NULL,
  `ApellidoPaternoCompetidor` VARCHAR(45) NOT NULL,
  `ApellidoMaternoCompetidor` VARCHAR(45) NOT NULL,
  `CompetenciaCompetidor` INT NOT NULL,
  `EntrenadorCompetidor` INT NOT NULL,
  PRIMARY KEY (`idCompetidores`),
  UNIQUE INDEX `idCompetidores_UNIQUE` (`idCompetidores` ASC) VISIBLE,
  INDEX `DisciplinaCompetidor_idx` (`CompetenciaCompetidor` ASC) VISIBLE,
  INDEX `EntrenadorCompetidor_idx` (`EntrenadorCompetidor` ASC) VISIBLE,
  CONSTRAINT `DisciplinaCompetidor`
    FOREIGN KEY (`CompetenciaCompetidor`)
    REFERENCES `mydb`.`Disciplinas` (`idDisciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EntrenadorCompetidor`
    FOREIGN KEY (`EntrenadorCompetidor`)
    REFERENCES `mydb`.`Entrenadores` (`idEntrenadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jueces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jueces` (
  `idJueces` INT NOT NULL AUTO_INCREMENT,
  `NombreJuez` VARCHAR(45) NOT NULL,
  `ApellidoPaternoJuez` VARCHAR(45) NOT NULL,
  `ApellidoMaternoJuez` VARCHAR(45) NOT NULL,
  `AddressJuez` VARCHAR(45) NULL,
  PRIMARY KEY (`idJueces`),
  UNIQUE INDEX `idJueces_UNIQUE` (`idJueces` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Administradores` (
  `idAdministradores` INT NOT NULL AUTO_INCREMENT,
  `NombreAdmin` VARCHAR(45) NOT NULL,
  `ApellidoPaternoAdmin` VARCHAR(45) NOT NULL,
  `ApellidoMaternoAdmin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdministradores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `e-Mail` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Rol` INT NOT NULL,
  `ClaveForanea` INT NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  UNIQUE INDEX `e-Mail_UNIQUE` (`e-Mail` ASC) VISIBLE,
  INDEX `ClaveForanea_idx` (`ClaveForanea` ASC) VISIBLE,
  CONSTRAINT `ClaveForaneaAdmin`
    FOREIGN KEY (`ClaveForanea`)
    REFERENCES `mydb`.`Administradores` (`idAdministradores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ClaveForaneaCompetidor`
    FOREIGN KEY (`ClaveForanea`)
    REFERENCES `mydb`.`Competidores` (`idCompetidores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ClaveForaneaJueces`
    FOREIGN KEY (`ClaveForanea`)
    REFERENCES `mydb`.`Jueces` (`idJueces`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ClaveForaneaEntrenadores`
    FOREIGN KEY (`ClaveForanea`)
    REFERENCES `mydb`.`Entrenadores` (`idEntrenadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
