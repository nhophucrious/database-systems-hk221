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
-- Table structure for table `treats`
--

DROP TABLE IF EXISTS `treats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treats` (
  `patient_id` char(6) NOT NULL,
  `med_id` char(6) NOT NULL,
  `doctor_id` char(6) NOT NULL,
  `result` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`patient_id`,`med_id`,`doctor_id`),
  KEY `treats_med_id_fk` (`med_id`),
  KEY `treats_doctor_id_fk` (`doctor_id`),
  CONSTRAINT `treats_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `treats_med_id_fk` FOREIGN KEY (`med_id`) REFERENCES `medication` (`id`),
  CONSTRAINT `treats_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treats`
--

LOCK TABLES `treats` WRITE;
/*!40000 ALTER TABLE `treats` DISABLE KEYS */;
INSERT INTO `treats` VALUES ('PAT001','MED001','DOC001','Normal'),('PAT001','MED002','DOC001','Normal'),('PAT001','MED003','DOC001','Normal'),('PAT002','MED001','DOC002','Normal'),('PAT002','MED004','DOC002','Normal'),('PAT002','MED005','DOC002','Normal'),('PAT003','MED002','DOC002','Normal'),('PAT004','MED001','DOC001','Normal'),('PAT004','MED005','DOC003','Serious'),('PAT005','MED002','DOC002','Serious'),('PAT005','MED003','DOC002','Serious'),('PAT005','MED004','DOC002','Normal'),('PAT006','MED001','DOC003','Normal'),('PAT006','MED005','DOC003','Normal'),('PAT007','MED002','DOC004','Normal'),('PAT007','MED003','DOC004','Normal'),('PAT008','MED004','DOC005','Normal'),('PAT008','MED005','DOC005','Normal'),('PAT009','MED001','DOC005','Serious'),('PAT009','MED002','DOC005','Serious'),('PAT010','MED003','DOC003','Serious'),('PAT010','MED004','DOC002','Normal'),('PAT010','MED005','DOC003','Normal'),('PAT011','MED001','DOC001','Normal'),('PAT011','MED002','DOC002','Normal'),('PAT011','MED003','DOC003','Normal');
/*!40000 ALTER TABLE `treats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-30 23:03:24
