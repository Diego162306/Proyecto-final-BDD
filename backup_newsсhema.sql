-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: newschema
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Administrador`
--

DROP TABLE IF EXISTS `Administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrador` (
  `idAdministrador` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  PRIMARY KEY (`idAdministrador`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `Administrador_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrador`
--

LOCK TABLES `Administrador` WRITE;
/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
INSERT INTO `Administrador` VALUES (1,1);
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cancha`
--

DROP TABLE IF EXISTS `Cancha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cancha` (
  `idCancha` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento') NOT NULL,
  `tipo` enum('6','7') NOT NULL,
  `idAdministrador` int DEFAULT NULL,
  PRIMARY KEY (`idCancha`),
  KEY `idAdministrador` (`idAdministrador`),
  CONSTRAINT `Cancha_ibfk_1` FOREIGN KEY (`idAdministrador`) REFERENCES `Administrador` (`idAdministrador`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cancha`
--

LOCK TABLES `Cancha` WRITE;
/*!40000 ALTER TABLE `Cancha` DISABLE KEYS */;
INSERT INTO `Cancha` VALUES (1,'Cancha 1',18.00,'Disponible','6',1),(2,'Cancha 2',22.00,'Ocupada','7',1),(3,'Cancha 3',22.00,'Disponible','7',NULL),(4,'Cancha 4',18.00,'Disponible','6',NULL),(5,'Cancha 5',22.00,'Disponible','7',NULL),(6,'Soy gay',25.00,'Disponible','7',NULL);
/*!40000 ALTER TABLE `Cancha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cancha_Horario`
--

DROP TABLE IF EXISTS `Cancha_Horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cancha_Horario` (
  `idCancha_Horario` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `idCancha` int DEFAULT NULL,
  `idHorario` int DEFAULT NULL,
  PRIMARY KEY (`idCancha_Horario`),
  KEY `idCancha` (`idCancha`),
  KEY `idHorario` (`idHorario`),
  CONSTRAINT `Cancha_Horario_ibfk_1` FOREIGN KEY (`idCancha`) REFERENCES `Cancha` (`idCancha`),
  CONSTRAINT `Cancha_Horario_ibfk_2` FOREIGN KEY (`idHorario`) REFERENCES `Horario` (`idHorario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cancha_Horario`
--

LOCK TABLES `Cancha_Horario` WRITE;
/*!40000 ALTER TABLE `Cancha_Horario` DISABLE KEYS */;
INSERT INTO `Cancha_Horario` VALUES (1,'2023-10-15','14:00:00','15:00:00',1,2);
/*!40000 ALTER TABLE `Cancha_Horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `Cliente_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (3,1),(1,2),(2,4);
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estadistica`
--

DROP TABLE IF EXISTS `Estadistica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estadistica` (
  `nroEstadistica` int NOT NULL AUTO_INCREMENT,
  `horarioMasSolicitado` time DEFAULT NULL,
  `canchaMasSolicitada` varchar(50) DEFAULT NULL,
  `idReporte` int DEFAULT NULL,
  PRIMARY KEY (`nroEstadistica`),
  KEY `idReporte` (`idReporte`),
  CONSTRAINT `Estadistica_ibfk_1` FOREIGN KEY (`idReporte`) REFERENCES `Reporte` (`nroReporte`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estadistica`
--

LOCK TABLES `Estadistica` WRITE;
/*!40000 ALTER TABLE `Estadistica` DISABLE KEYS */;
INSERT INTO `Estadistica` VALUES (1,'14:00:00','Cancha 1',1);
/*!40000 ALTER TABLE `Estadistica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Horario`
--

DROP TABLE IF EXISTS `Horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Horario` (
  `idHorario` int NOT NULL AUTO_INCREMENT,
  `estadoHorario` enum('Disponible','Ocupado') NOT NULL,
  `rangoHorario_inicio` datetime NOT NULL,
  `rangoHorario_final` datetime NOT NULL,
  `idReserva` int DEFAULT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `idReserva` (`idReserva`),
  CONSTRAINT `Horario_ibfk_1` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Horario`
--

LOCK TABLES `Horario` WRITE;
/*!40000 ALTER TABLE `Horario` DISABLE KEYS */;
INSERT INTO `Horario` VALUES (2,'Ocupado','2023-10-15 14:00:00','2023-10-15 15:00:00',3);
/*!40000 ALTER TABLE `Horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mantenimiento`
--

DROP TABLE IF EXISTS `Mantenimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mantenimiento` (
  `idMantenimiento` int NOT NULL AUTO_INCREMENT,
  `fechaMantenimiento` date NOT NULL,
  `descripcion` text,
  `estadoCancha` enum('En Mantenimiento','Disponible') NOT NULL,
  `idCancha` int DEFAULT NULL,
  PRIMARY KEY (`idMantenimiento`),
  KEY `idCancha` (`idCancha`),
  CONSTRAINT `Mantenimiento_ibfk_1` FOREIGN KEY (`idCancha`) REFERENCES `Cancha` (`idCancha`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mantenimiento`
--

LOCK TABLES `Mantenimiento` WRITE;
/*!40000 ALTER TABLE `Mantenimiento` DISABLE KEYS */;
INSERT INTO `Mantenimiento` VALUES (1,'2023-10-12','Cambio de red en arco','En Mantenimiento',2);
/*!40000 ALTER TABLE `Mantenimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reporte`
--

DROP TABLE IF EXISTS `Reporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reporte` (
  `nroReporte` int NOT NULL AUTO_INCREMENT,
  `contenido` text,
  `fechaGeneracion` datetime NOT NULL,
  `idUser` int DEFAULT NULL,
  PRIMARY KEY (`nroReporte`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `Reporte_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reporte`
--

LOCK TABLES `Reporte` WRITE;
/*!40000 ALTER TABLE `Reporte` DISABLE KEYS */;
INSERT INTO `Reporte` VALUES (1,'Reporte de mantenimiento de Cancha 2','2023-10-12 09:00:00',1);
/*!40000 ALTER TABLE `Reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserva`
--

DROP TABLE IF EXISTS `Reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reserva` (
  `idReserva` int NOT NULL AUTO_INCREMENT,
  `fechaUso` date NOT NULL,
  `horaUso` time NOT NULL,
  `comprobanteReserva` varchar(50) DEFAULT NULL,
  `fechaReserva` datetime NOT NULL,
  `idCliente` int DEFAULT NULL,
  `idCancha` int DEFAULT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `Reserva_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva`
--

LOCK TABLES `Reserva` WRITE;
/*!40000 ALTER TABLE `Reserva` DISABLE KEYS */;
INSERT INTO `Reserva` VALUES (3,'2023-10-16','16:00:00','RES67890','2023-10-11 11:00:00',1,NULL),(7,'2025-02-08','15:00:00','016c808b-e525-45f5-ba43-57d26681395a','2025-02-07 09:14:52',1,1),(8,'2025-02-08','14:00:00','10b12f1d-c53f-46c5-ab7a-847063c83bae','2025-02-07 09:18:50',2,5),(9,'2025-02-08','14:08:00','7a87d299-43f1-44c4-baf0-0659d874c556','2025-02-07 12:42:27',3,3),(10,'2025-02-09','15:37:00','ae13302d-7965-4475-9111-59e2cba22c4e','2025-02-07 13:37:59',3,1),(11,'2025-02-11','10:54:00','25df88ac-36bb-4078-ba1c-7f4d91a669f6','2025-02-10 09:17:13',1,3);
/*!40000 ALTER TABLE `Reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono_movil` char(10) NOT NULL,
  `telefono_convencional` char(8) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','cliente') NOT NULL DEFAULT 'cliente',
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'Joel','Tapia','0939630451','02234567','joeltapia@gmail.com','joel123','cliente'),(2,'Juan','Matailo','0998765432','02234568','matailoveintimilla@gmail.com','12345js','cliente'),(3,'Jxel','Pinta','0939630445','02234577','admin@gmail.com','jxel117','admin'),(4,'Ariel','Tandazo','0965235847','0000000','arieltanr@gmail.com','ariel123','cliente'),(5,'Diego','Riofrio','0994098836','2673568','juanveintimilla14@gamil.com','160623j','cliente'),(6,'Eber','Guayllas','0994098836','2673568','eber@gmail.com','1234','cliente');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-10 11:18:02
