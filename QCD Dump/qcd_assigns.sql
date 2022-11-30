-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: qcd
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assigns`
--

DROP TABLE IF EXISTS `assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assigns` (
  `patient_id` char(6) NOT NULL,
  `assignor_id` char(6) DEFAULT NULL,
  `building` char(6) DEFAULT NULL,
  `floor_no` int DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `assigns_assignor_id_fk` (`assignor_id`),
  KEY `assigns_room_fk` (`building`,`floor_no`,`room_no`),
  CONSTRAINT `assigns_assignor_id_fk` FOREIGN KEY (`assignor_id`) REFERENCES `supporting_personnel` (`id`),
  CONSTRAINT `assigns_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `assigns_room_fk` FOREIGN KEY (`building`, `floor_no`, `room_no`) REFERENCES `room` (`building`, `floor_no`, `room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigns`
--

LOCK TABLES `assigns` WRITE;
/*!40000 ALTER TABLE `assigns` DISABLE KEYS */;
INSERT INTO `assigns` VALUES ('PAT001','STA001','B12',1,101),('PAT002','STA002','B12',1,101),('PAT003','STA003','B12',2,200),('PAT004','STA003','C10',3,308),('PAT005','STA003','B12',1,102),('PAT006','STA005','A04',4,405),('PAT007','STA006','A04',4,407),('PAT008','STA007','B12',1,103),('PAT009','STA004','B12',1,102),('PAT010','STA002','C10',3,308),('PAT011','STA005','D08',5,509);
/*!40000 ALTER TABLE `assigns` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-30 23:03:26
