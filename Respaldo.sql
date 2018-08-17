CREATE DATABASE  IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	5.7.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `idUsuario` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` char(60) NOT NULL,
  `rol` varchar(7) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `fechaAlta` datetime NOT NULL,
  `fechaModificacion` datetime DEFAULT NULL,
  `fechaBaja` datetime DEFAULT NULL,
  `estado` char(1) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'rbruno','$2b$12$YLHR0MSDqNFYVEFvs1ACm.lB.K0LJoZSBhG7M1mmqOFr8uC84E7gy','usuario','ricardo','bruno','rbruno@gmail.com','2018-08-17 19:43:39',NULL,NULL,'A');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'test'
--

--
-- Dumping routines for database 'test'
--
/*!50003 DROP PROCEDURE IF EXISTS `auth_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `auth_login`(uUsername VARCHAR(20))
PROC: BEGIN

     DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	 BEGIN
		GET DIAGNOSTICS CONDITION 1
        @c1 = RETURNED_SQLSTATE, @c2 = MESSAGE_TEXT;
		SELECT 0 AS codigo, CONCAT('Error numero: ',@c1,'. Descripcion: ',@c2)AS mensaje;
		ROLLBACK;
	 END;
    /*    
	IF NOT EXISTS (SELECT idUsuario FROM Usuario WHERE username = uUsername) THEN
		SELECT 0 as codigo, 'El usuario no existe' mensaje;
        LEAVE PROC;
	END IF;
    
	IF ((SELECT estado FROM usuarios WHERE usuario = uUsuario) = 'B') THEN
		SELECT 0 as codigo, 'El usuario esta dado de baja' mensaje;
        LEAVE PROC;
	END IF;
	*/
	IF NOT EXISTS (SELECT idUsuario FROM Usuarios WHERE usuario=uUsuario AND estado='A')
    THEN
		SELECT 0 as codigo, 'Usuario inexistente en el sistema' mensaje;
        LEAVE PROC;
	ELSE 
		SELECT 1 as codigo, 'Ingreso Correcto' mensaje;
		SELECT idUsuario, username, `password`, rol, nombre, apellido, mail FROM Usuario WHERE username=uUsername;
        LEAVE PROC;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuario_dame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_dame`(uIdUsuario INT)
PROC: BEGIN

	IF NOT EXISTS (SELECT idUsuario FROM Usuario WHERE idUsuario = uIdUsuario AND estado='A') THEN
		SELECT 0 as codigo, 'El Usuario no existe o esta dado de baja' mensaje;
        LEAVE PROC;
	END IF;
    
    SELECT 1 AS codigo, 'OK' AS mensaje;
    SELECT idUsuario,username,rol,nombre,apellido,mail,fechaAlta,fechaModificacion,fechaBaja FROM Usuario WHERE idUsuario = uIdUsuario;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuario_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_listar`()
PROC: BEGIN
	
    /* 
    En caso de querer filtrar la vista por fecha, se deberia hacer el control de q la fecha sea valida por ejemplo.
    y en caso de que no, hacer un SELECT 0 as codigo BLABLA as mensaje;
    LEAVE PROC;
    EJ:*/
    /*
    IF NOT EXISTS (SELECT idUsuario FROM Usuario WHERE idUsuario = 2000) THEN
		SELECT 0 AS codigo, 'No existe el usuario' AS mensaje;
		LEAVE PROC;
	END IF;
	*/
    
		SELECT 1 AS codigo, 'OK' AS mensaje;
		 SELECT idUsuario,username,rol,nombre,apellido,mail,fechaAlta,fechaModificacion,fechaBaja FROM Usuario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuario_modificar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_modificar`(uIdUsuario INT, uUsername VARCHAR(20),uPassword CHAR(60),
uNombre VARCHAR(45), uApellido VARCHAR(45), uMail VARCHAR(45))
PROC: BEGIN

	-- Manejo de errores exception
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@c1 = RETURNED_SQLSTATE, @c2 = MESSAGE_TEXT;
		SELECT -1 AS codigo, CONCAT('Error numero: ',@c1,'. Descripcion: ',@c2)AS mensaje;
		ROLLBACK;
	END;
    
	IF (uIdUsuario IS NULL OR uIdUsuario = 0) THEN
		SELECT 0 as codigo, 'Identificador de usuario inexistente' mensaje;
        LEAVE PROC;
	END IF;
	IF (uUsername IS NULL OR uUsername = '') THEN
		SELECT 0 as codigo, 'Debe ingresar un nombre de usuario.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uPassword IS NULL OR uPassword = '') THEN
		SELECT 0 as codigo, 'Debe ingresar una contraseña.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uNombre IS NULL OR uNombre = '') THEN
		SELECT 0 as codigo, 'Debe ingresar el nombre del usuario.' mensaje;
        LEAVE PROC;
	END IF;
	IF (uApellido IS NULL OR uApellido = '') THEN
		SELECT 0 as codigo, 'Debe ingresar el apellido del usuario.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uMail IS NULL OR uMail = '') THEN
		SELECT 0 as codigo, 'Debe ingresar una direccion de correo electronico' mensaje;
        LEAVE PROC;
	END IF;
    
    IF NOT EXISTS (SELECT idUsuario FROM Usuario WHERE idUsuario=uIdUsuario) THEN
		SELECT 0 as codigo, 'El usuario no existe' mensaje;
        LEAVE PROC;
	END IF;
    
    
    -- Control parametros existentes unicos
	IF (SELECT idUsuario FROM Usuario WHERE mail=uMail AND estado='A') <> uIdUsuario THEN
		SELECT 0 as codigo, 'El mail ya se encuentra en uso' mensaje;
        LEAVE PROC;
	END IF;
    SET uUsername = LCASE(uUsername);
    IF (SELECT idUsuario FROM Usuario WHERE username=uUsername AND estado='A') <> uIdUsuario THEN
		SELECT 0 as codigo, 'El nombre de usuario ya se encuentra en uso' mensaje;
        LEAVE PROC;
	END IF;
    
	START TRANSACTION;
		UPDATE Usuario 
        SET 
			username = uUsername,
            `password` = uPassword,
			nombre=uNombre,
            apellido = uApellido,
            mail = uMail,
            fechaModificacion = NOW()
        WHERE idUsuario=uIdUsuario;
		SELECT 1 AS codigo, 'Usuario modificado con exito.' AS mensaje;
        SELECT uIdUsuario AS idUsuario;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuario_nuevo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_nuevo`(uUsername VARCHAR(20),uPassword CHAR(60),
uNombre VARCHAR(45), uApellido VARCHAR(45), uMail VARCHAR(45))
PROC: BEGIN

	DECLARE uIdUsuario INT;
    -- Manejo de errores
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	 BEGIN
		GET DIAGNOSTICS CONDITION 1
        @c1 = RETURNED_SQLSTATE, @c2 = MESSAGE_TEXT;
		SELECT -1 AS codigo, CONCAT('Error numero: ',@c1,'. Descripcion: ',@c2)AS mensaje;
		ROLLBACK;
	 END;
        
    IF (uUsername IS NULL OR uUsername = '') THEN
		SELECT 0 as codigo, 'Debe ingresar un nombre de usuario.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uPassword IS NULL OR uPassword = '') THEN
		SELECT 0 as codigo, 'Debe ingresar una contraseña.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uNombre IS NULL OR uNombre = '') THEN
		SELECT 0 as codigo, 'Debe ingresar el nombre del usuario.' mensaje;
        LEAVE PROC;
	END IF;
	IF (uApellido IS NULL OR uApellido = '') THEN
		SELECT 0 as codigo, 'Debe ingresar el apellido del usuario.' mensaje;
        LEAVE PROC;
	END IF;
    IF (uMail IS NULL OR uMail = '') THEN
		SELECT 0 as codigo, 'Debe ingresar una direccion de correo electronico' mensaje;
        LEAVE PROC;
	END IF;
    
    
	IF EXISTS (SELECT mail FROM Usuario WHERE mail=uMail AND estado='A') THEN
		SELECT 0 as codigo, 'El mail ya se encuentra en uso' mensaje;
        LEAVE PROC;
	END IF;
    SET uUsername = LCASE(uUsername);
    IF EXISTS (SELECT username FROM Usuario WHERE username=uUsername AND estado='A') THEN
		SELECT 0 as codigo, 'El nombre de usuario ya se encuentra en uso' mensaje;
        LEAVE PROC;
	END IF;
    
    START TRANSACTION;
		SET uIdUsuario = 1 + (SELECT COALESCE(MAX(idUsuario),0) FROM Usuario);
		INSERT INTO Usuario VALUES (uIdUsuario,uUsername,uPassword,'usuario',uNombre,uApellido,uMail,NOW(),null,null,'A');
		SELECT 1 AS codigo, 'Usuario creado exitosamente' mensaje;
        SELECT uIdUsuario AS idUsuario;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-17 20:00:12
