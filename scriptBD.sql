CREATE TABLE IF NOT EXISTS `jg`.`brands` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `jg`.`cars` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` VARCHAR(45) NULL DEFAULT NULL,
  `model` VARCHAR(45) NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  `color_id` INT NULL DEFAULT NULL,
  `brand_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cars_colors` (`color_id` ASC) VISIBLE,
  INDEX `fk_cars_brands` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_cars_brands`
    FOREIGN KEY (`brand_id`)
    REFERENCES `jg`.`brands` (`id`),
  CONSTRAINT `fk_cars_colors`
    FOREIGN KEY (`color_id`)
    REFERENCES `jg`.`colors` (`id`));

CREATE TABLE IF NOT EXISTS `jg`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `dni` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `jg`.`colors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `jg`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL DEFAULT NULL,
  `car_id` INT NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `client_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `client_id` (`client_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `car_id` (`car_id` ASC) VISIBLE,
  CONSTRAINT `sales_ibfk_1`
    FOREIGN KEY (`client_id`)
    REFERENCES `jg`.`clients` (`id`),
  CONSTRAINT `sales_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `jg`.`users` (`id`),
  CONSTRAINT `sales_ibfk_3`
    FOREIGN KEY (`car_id`)
    REFERENCES `jg`.`cars` (`id`));

CREATE TABLE IF NOT EXISTS `jg`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_UNIQUE` (`username` ASC) VISIBLE);

DELIMITER $$

DELIMITER $$
USE `jg`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `dashboard1`(cantSales INT) RETURNS json
    NO SQL
BEGIN
 DECLARE result JSON;

  -- Obtén las ventas para octubre, noviembre y diciembre
  SELECT
    JSON_ARRAY(
      JSON_OBJECT('month', 'october', 'value', 
                  CASE WHEN COUNT(CASE WHEN MONTH(date) = 10 THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN MONTH(date) = 10 THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN MONTH(date) = 10 THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN MONTH(date) = 10 THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),
      JSON_OBJECT('month', 'november', 'value', 
                  CASE WHEN COUNT(CASE WHEN MONTH(date) = 11 THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN MONTH(date) = 11 THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN MONTH(date) = 11 THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN MONTH(date) = 11 THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),
      JSON_OBJECT('month', 'december', 'value', 
                  CASE WHEN COUNT(CASE WHEN MONTH(date) = 12 THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN MONTH(date) = 12 THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN MONTH(date) = 12 THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN MONTH(date) = 12 THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END)
    ) INTO result
  FROM sales
  WHERE MONTH(date) IN (10, 11, 12);

  RETURN result;
END$$

DELIMITER ;

DELIMITER $$

DELIMITER $$
USE `jg`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `dashboard2`(cantSales INT) RETURNS json
    NO SQL
BEGIN
 DECLARE result JSON;
  SELECT
    JSON_ARRAY(
          JSON_OBJECT('vendedor', 'juan perez', 'value', 
                  CASE WHEN COUNT(CASE WHEN u.name = 'juan perez' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN u.name = 'juan perez' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN u.name = 'juan perez' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN u.name = 'juan perez' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),
      JSON_OBJECT('vendedor', 'jhon doe', 'value', 
                  CASE WHEN COUNT(CASE WHEN u.name = 'jhon doe' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN u.name = 'jhon doe' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN u.name = 'jhon doe' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN u.name = 'jhon doe' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),
      JSON_OBJECT('vendedor', 'carlos lopez', 'value', 
                  CASE WHEN COUNT(CASE WHEN u.name = 'carlos lopez' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN u.name = 'carlos lopez' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN u.name = 'carlos lopez' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN u.name = 'carlos lopez' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END)
    ) INTO result
  FROM sales s
  JOIN users u ON u.id = s.user_id;

  RETURN result;
END$$

DELIMITER ;

DELIMITER $$

DELIMITER $$
USE `jg`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `dashboard3`(cantSales INT) RETURNS json
    NO SQL
BEGIN
 DECLARE result JSON;
  SELECT
    JSON_ARRAY(
      JSON_OBJECT('marca', 'chevrolet', 'value', 
                  CASE WHEN COUNT(CASE WHEN brand.name = 'chevrolet' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN brand.name = 'chevrolet' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN brand.name = 'chevrolet' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN brand.name = 'chevrolet' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),
      JSON_OBJECT('marca', 'volkswagen', 'value', 
                  CASE WHEN COUNT(CASE WHEN brand.name = 'volkswagen' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN brand.name = 'volkswagen' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN brand.name = 'volkswagen' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN brand.name = 'volkswagen' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END),

     JSON_OBJECT('marca', 'mercedes', 'value', 
                  CASE WHEN COUNT(CASE WHEN brand.name = 'mercedes' THEN 1 END) > cantSales THEN 'Objetivo superado'
                       WHEN COUNT(CASE WHEN brand.name = 'mercedes' THEN 1 END) = cantSales THEN 'Objetivo cumplido'
                       ELSE 'Objetivo no cumplido' END,
                  'color', CASE WHEN COUNT(CASE WHEN brand.name = 'mercedes' THEN 1 END) > cantSales THEN 'green'
                                WHEN COUNT(CASE WHEN brand.name = 'mercedes' THEN 1 END) = cantSales THEN 'blue'
                                ELSE 'red' END)
    ) INTO result
  FROM sales s
  JOIN cars c ON c.id = s.car_id
  JOIN brands brand ON brand.id = c.brand_id;
  RETURN result;
END$$

DELIMITER ;