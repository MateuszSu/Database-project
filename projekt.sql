-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `project` ;

-- -----------------------------------------------------
-- Table `project`.`dawkowanie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`dawkowanie` (
  `id_dawki` INT NOT NULL,
  `id_pacjenta` INT NOT NULL,
  `nazwa_leku` VARCHAR(255) NOT NULL,
  `dawka` VARCHAR(255) NOT NULL,
  `dzien` DATE NOT NULL,
  PRIMARY KEY (`id_dawki`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`oddzialy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`oddzialy` (
  `id_oddzialu` INT NOT NULL,
  `nazwa_oddzialu` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_oddzialu`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`odwiedziny`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`odwiedziny` (
  `nr_odwiedzin` INT NOT NULL,
  `imie` VARCHAR(255) NULL DEFAULT NULL,
  `nazwisko` VARCHAR(255) NOT NULL,
  `data_odwiedzin` DATE NOT NULL,
  `id_oddzialu` INT NULL DEFAULT NULL,
  PRIMARY KEY (`nr_odwiedzin`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`pacjenci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`pacjenci` (
  `id_pacjenta` INT NOT NULL,
  `imie` VARCHAR(255) NOT NULL,
  `nazwisko` VARCHAR(255) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `nr_pokoju` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_pacjenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`pokoje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`pokoje` (
  `nr_pokoju` INT NOT NULL,
  `id_oddzialu` INT NOT NULL,
  `liczba_lozek` INT NULL DEFAULT NULL,
  `liczba_pacjentow` INT NULL DEFAULT NULL,
  `typ_pokoju` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nr_pokoju`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`pracownicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`pracownicy` (
  `id_pracownika` INT NOT NULL,
  `id_stanowiska` INT NOT NULL,
  `id_oddziału` INT NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(255) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `wyplata` INT NOT NULL,
  PRIMARY KEY (`id_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`stanowiska`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`stanowiska` (
  `id_stanowiska` INT NOT NULL,
  `nazwa_stanowiska` VARCHAR(255) NOT NULL,
  `specjalizacja` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_stanowiska`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`zabiegi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`zabiegi` (
  `id_zabiegu` INT NOT NULL,
  `id_pracownika` INT NOT NULL,
  `id_pacjenta` INT NOT NULL,
  `rodzaj_zabiegu` VARCHAR(255) NOT NULL,
  `termin` DATE NULL DEFAULT NULL,
  `nr_pokoju` INT NOT NULL,
  PRIMARY KEY (`id_zabiegu`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project`.`zaopatrzenie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`zaopatrzenie` (
  `id_zaopatrzenia` INT NOT NULL,
  `id_oddzialu` INT NOT NULL,
  `nazwa` VARCHAR(255) NOT NULL,
  `ilosc` INT NOT NULL,
  PRIMARY KEY (`id_zaopatrzenia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `project` ;

-- -----------------------------------------------------
-- Placeholder table for view `project`.`dzienne dawki`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`dzienne dawki` (`Imię` INT, `Nazwisko` INT, `Numer Pokoju` INT, `Nazwa Leku` INT, `Dawkowanie` INT, `Data` INT);

-- -----------------------------------------------------
-- Placeholder table for view `project`.`lekarze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`lekarze` (`Imię Pracownika` INT, `Nazwisko Pracownika` INT, `Pokój Zabiegowy` INT, `Rodzaj Zabiegu` INT, `Termin Zabiegu` INT, `Imię Pacjenta` INT, `Nazwisko Pacjenta` INT, `Pokój Pacjenta` INT);

-- -----------------------------------------------------
-- Placeholder table for view `project`.`pielegniarka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`pielegniarka` (`Imię` INT, `Nazwisko` INT, `Numer Pokoju` INT);

-- -----------------------------------------------------
-- Placeholder table for view `project`.`procent odwiedzajacych`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`procent odwiedzajacych` (`Nazwa Oddzialu` INT, `Procent odwiedzających` INT);

-- -----------------------------------------------------
-- Placeholder table for view `project`.`wolne lozka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`wolne lozka` (`Wolne Łóżka` INT, `Numer pokoju` INT, `Nazwa Oddziału` INT);

-- -----------------------------------------------------
-- function srednia_oddzialy
-- -----------------------------------------------------

DELIMITER $$
USE `project`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `srednia_oddzialy`(
	id INT
) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE SREDNIA FLOAT;
	SET SREDNIA = (SELECT COUNT(*) FROM odwiedziny WHERE id_oddzialu = id)/(SELECT COUNT(*) FROM odwiedziny);
    
RETURN SREDNIA;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function srednia_odwiedzajacych_na_oddziale
-- -----------------------------------------------------

DELIMITER $$
USE `project`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `srednia_odwiedzajacych_na_oddziale`(
	id INT
) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE SREDNIA FLOAT;
	SET SREDNIA = (SELECT COUNT(*) FROM odwiedziny WHERE id_oddzialu = id)/(SELECT COUNT(*) FROM odwiedziny);
    
RETURN SREDNIA;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ten_sam_oddzial
-- -----------------------------------------------------

DELIMITER $$
USE `project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ten_sam_oddzial`(
	nazw VARCHAR(255)
)
BEGIN
SELECT nazwisko,data_odwiedzin
    FROM odwiedziny
    where data_odwiedzin=(select data_odwiedzin from odwiedziny where nazwisko=nazw);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure zaplanowane_zabiegi
-- -----------------------------------------------------

DELIMITER $$
USE `project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zaplanowane_zabiegi`(
	nazw VARCHAR(255)
)
BEGIN
	SELECT 
        `pacjenci`.`imie` AS `imie`,
        `pacjenci`.`nazwisko` AS `nazwisko`,
        `zabiegi`.`rodzaj_zabiegu` AS `rodzaj_zabiegu`,
        `zabiegi`.`termin` AS `termin`
    FROM
        (`pacjenci`
        JOIN `zabiegi` ON ((`pacjenci`.`id_pacjenta` = `zabiegi`.`id_pacjenta`)))
	WHERE pacjenci.nazwisko=nazw
    order by termin asc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `project`.`dzienne dawki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`dzienne dawki`;
USE `project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project`.`dzienne dawki` AS select `project`.`pacjenci`.`imie` AS `Imię`,`project`.`pacjenci`.`nazwisko` AS `Nazwisko`,`project`.`pacjenci`.`nr_pokoju` AS `Numer Pokoju`,`project`.`dawkowanie`.`nazwa_leku` AS `Nazwa Leku`,`project`.`dawkowanie`.`dawka` AS `Dawkowanie`,`project`.`dawkowanie`.`dzien` AS `Data` from (`project`.`pacjenci` join `project`.`dawkowanie` on((`project`.`pacjenci`.`id_pacjenta` = `project`.`dawkowanie`.`id_pacjenta`))) order by `project`.`dawkowanie`.`dzien`;

-- -----------------------------------------------------
-- View `project`.`lekarze`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`lekarze`;
USE `project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project`.`lekarze` AS select `pr`.`imie` AS `Imię Pracownika`,`pr`.`nazwisko` AS `Nazwisko Pracownika`,`z`.`nr_pokoju` AS `Pokój Zabiegowy`,`z`.`rodzaj_zabiegu` AS `Rodzaj Zabiegu`,`z`.`termin` AS `Termin Zabiegu`,`pa`.`imie` AS `Imię Pacjenta`,`pa`.`nazwisko` AS `Nazwisko Pacjenta`,`pa`.`nr_pokoju` AS `Pokój Pacjenta` from ((`project`.`pracownicy` `pr` join `project`.`zabiegi` `z` on((`pr`.`id_pracownika` = `z`.`id_pracownika`))) join `project`.`pacjenci` `pa` on((`z`.`id_pacjenta` = `pa`.`id_pacjenta`)));

-- -----------------------------------------------------
-- View `project`.`pielegniarka`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`pielegniarka`;
USE `project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project`.`pielegniarka` AS select `project`.`pacjenci`.`imie` AS `Imię`,`project`.`pacjenci`.`nazwisko` AS `Nazwisko`,`project`.`pacjenci`.`nr_pokoju` AS `Numer Pokoju` from `project`.`pacjenci`;

-- -----------------------------------------------------
-- View `project`.`procent odwiedzajacych`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`procent odwiedzajacych`;
USE `project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project`.`procent odwiedzajacych` AS select `project`.`oddzialy`.`nazwa_oddzialu` AS `Nazwa Oddzialu`,round((`SREDNIA_ODDZIALY`(`project`.`oddzialy`.`id_oddzialu`) * 100),1) AS `Procent odwiedzających` from `project`.`oddzialy`;

-- -----------------------------------------------------
-- View `project`.`wolne lozka`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project`.`wolne lozka`;
USE `project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project`.`wolne lozka` AS select (`project`.`pokoje`.`liczba_lozek` - `project`.`pokoje`.`liczba_pacjentow`) AS `Wolne Łóżka`,`project`.`pokoje`.`nr_pokoju` AS `Numer pokoju`,`project`.`oddzialy`.`nazwa_oddzialu` AS `Nazwa Oddziału` from (`project`.`pokoje` join `project`.`oddzialy` on((`project`.`pokoje`.`id_oddzialu` = `project`.`oddzialy`.`id_oddzialu`))) order by `project`.`oddzialy`.`nazwa_oddzialu`;
USE `project`;

DELIMITER $$
USE `project`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `project`.`dawkowanie_AFTER_INSERT`
AFTER INSERT ON `project`.`dawkowanie`
FOR EACH ROW
BEGIN
	DELETE FROM DAWKOWANIE WHERE SYSDATE>DAWKOWANIE.DZIEN;
END$$

USE `project`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `project`.`pacjenci_AFTER_DELETE`
AFTER DELETE ON `project`.`pacjenci`
FOR EACH ROW
BEGIN
	update pokoje
    set liczba_pacjentow=liczba_pacjentow-1
    where nr_pokoju=old.nr_pokoju;
END$$

USE `project`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `project`.`pacjenci_AFTER_INSERT`
AFTER INSERT ON `project`.`pacjenci`
FOR EACH ROW
BEGIN
	UPDATE pokoje 
	SET liczba_pacjentow = liczba_pacjentow + 1
	WHERE nr_pokoju = NEW.nr_pokoju;
END$$

USE `project`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `project`.`pacjenci_BEFORE_INSERT`
BEFORE INSERT ON `project`.`pacjenci`
FOR EACH ROW
BEGIN
	if (select liczba_lozek-liczba_pacjentow from pokoje where nr_pokoju=new.nr_pokoju)=0
    then 
		set new.id_pacjenta = NULL;
		signal sqlstate '45001' set message_text = 'Pokoj jest juz pełny';
    end if;
END$$

USE `project`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `project`.`zabiegi_BEFORE_INSERT`
BEFORE INSERT ON `project`.`zabiegi`
FOR EACH ROW
BEGIN
    IF termin = NEW.termin AND nr_pokoju = NEW.nr_pokoju
    then 
		signal sqlstate '45000' set message_text = 'Podany termin jest niedostępny';
		set new.id_zabiegu=NULL;
    end if;
END$$


DELIMITER ;

INSERT INTO `oddzialy` VALUES (1,'Kardiochirurgia'),(2,'Laryngologia'),(3,'Anestezjologia'),(4,'Wewnętrzny'),(5,'SOR'),(6,'Ginekologia'),(7,'Nefrologia'),(8,'Neurologia'),(9,'Chirurgia ogólna'),(10,'Pediatria');
INSERT INTO `dawkowanie` VALUES (140,10,'Madopar 125mg','3x','2022-11-27'),(458,5,'Ibuprom 50mg','2x','2021-06-01'),(769,1,'Abraxan 10mg','3x','2022-10-15'),(860,7,'Famogast 10mg','4x','2022-08-17'),(876,8,'Gadovist 600mg','1x','2022-08-11'),(1297,4,'Aspiryna 100mg','1x','2022-05-21'),(1611,3,'Daktarin (krem)','2x','2022-07-08'),(2250,2,'Acard 100mg','2x','2022-11-30'),(2758,9,'Ibufen 100mg','2x','2022-10-12'),(3503,6,'Dekristol 500mg','1x','2022-10-01');
INSERT INTO `odwiedziny` VALUES (17,NULL,'Sokołowski','2022-03-18',4),(135,'Amelia','Maciejewska','2022-01-15',2),(136,'Maciek','Kot','2022-01-15',2),(221,'Henryk','Górecki','2022-01-29',3),(307,NULL,'Jakubowski','2022-02-07',7),(315,NULL,'Jasiński','2022-03-14',1),(361,'Karolina','Rutkowska','2022-01-02',3),(474,NULL,'Szewczyk','2022-02-12',8),(475,NULL,'Kwiatkowska','2022-02-06',10),(934,NULL,'Malinowska','2022-03-05',5),(954,NULL,'Lewandowski','2022-03-05',2);
INSERT INTO `pacjenci` VALUES (1,'Bartosz','Zalewski','26656867156','9'),(2,'Krystyna','Wiśniewska','47845693879','8'),(3,'Jarosław','Jakubowski','83495119840','7'),(4,'Paweł','Gajewski','87150446381','6'),(5,'Dominika','Wasilewska','37934640138','5'),(6,'Franciszek','Kubiak','49164444652','4'),(7,'Ireneusz','Cieślak','24881843957','3'),(8,'Fryderyk','Witkowski','79452812077','5'),(9,'Radosław','Andrzejewski','46638831716','4'),(10,'Mirosław','Malinowski','19286991421','3'),(11,'Mateusz','Suryś','47382920163','3'),(12,'Igor','Stalmach','23421234213','11'),(13,'Maciek','Rak','79459112077','2'),(14,'Maciek','Gnat','26256867356','2');
INSERT INTO `pokoje` VALUES (1,1,3,0,'pok. pacjent.'),(2,2,5,2,'pok. pacjent.'),(3,8,3,3,'pok. pacjent.'),(4,5,3,2,'pok. pacjent.'),(5,7,3,2,'pok. pacjent.'),(6,4,4,1,'pok. pacjent.'),(7,5,2,1,'pok. pacjent.'),(8,4,3,1,'pok. pacjent.'),(9,2,3,1,'pok. pacjent.'),(10,1,6,0,'pobór krwi'),(11,10,3,1,'pok. pacjent.'),(12,3,3,0,'pok. pacjent.'),(13,5,1,0,'zabiegowy'),(14,6,1,0,'zabiegowy');
INSERT INTO `pracownicy` VALUES (1,8,1,'Marek','Zieliński','11121022946',4310),(2,10,5,'Oliwia','Malinowska','63626757279',12500),(3,2,2,'Marlena','Głowacka','32934931461',9350),(4,4,5,'Honorata','Kaczmarczyk','75372651598',10400),(5,5,1,'Celina','Jankowska','56218317012',12100),(6,7,2,'Cezary','Baran','36328358198',8800),(7,3,3,'Michał','Szewczyk','38874506868',9400),(8,10,6,'Norbert','Jakubowski','95392302961',10200),(9,2,1,'Edward','Sobczak','46360978309',11000),(10,9,3,'Iwona','Malinowska','39308901745',9000);
INSERT INTO `stanowiska` VALUES (1,'Anestezjolog',NULL),(2,'Chirurg','Naczyniowy'),(3,'Chirurg','Plastyczny'),(4,'Dermatolog',NULL),(5,'Endokrynolog',NULL),(6,'Hematolog',NULL),(7,'Kardiochirurg',NULL),(8,'Neurochirurg',NULL),(9,'Nefrolog',NULL),(10,'Okulista',NULL);
INSERT INTO `zabiegi` VALUES (12,5,2,'MRI','2022-06-10',13),(15,5,6,'Ortop.','2022-10-11',14),(40,1,3,'MRI','2022-11-30',14),(43,10,1,'Rentgen lewej ręki','2022-09-20',14),(44,6,7,'Artroskopia','2022-07-19',13),(46,9,10,'Diagnostyka','2022-11-12',14),(63,2,4,'Chemioterapia','2022-06-20',13),(65,4,5,'Zabieg chir.','2022-06-13',14),(89,7,9,'MRI','2022-07-30',13),(92,8,8,'Gastroskopia','2022-11-05',13);
INSERT INTO `zaopatrzenie` VALUES (12,4,'Dekristol 500mg',9),(27,10,'Bandaże 10x12cm',201),(32,5,'Igły do strzykawek 2599',5701),(109,4,'Materac do łóżek 190x100cm',14),(169,1,'Materac do łóżek 190x100cm',14),(234,8,'Fartuchy pielęg. M',70),(243,2,'Materac do łóżek 190x100cm',14),(350,5,'Paracetamol 50mg',140),(355,7,'Ibufen 100mg',71),(366,4,'Probówka 50g 120',150),(401,5,'Materac do łóżek 190x100cm',14),(434,6,'Rękawiczki nitrylowe UNISEX',760),(456,5,'Ibuprom 50mg',12),(459,1,'Abraxan 10mg',65),(467,3,'Gadovist 600mg',87),(982,2,'Famogast 10mg',32),(1284,8,'Aspiryna 100mg',12),(4789,2,'Acard 100mg',54),(5032,3,'Daktarin (krem)',35);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
