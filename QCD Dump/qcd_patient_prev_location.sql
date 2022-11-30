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
-- Table structure for table `patient_prev_location`
--

DROP TABLE IF EXISTS `patient_prev_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_prev_location` (
  `patient_id` char(6) NOT NULL,
  `prev_location` char(60) NOT NULL,
  PRIMARY KEY (`patient_id`,`prev_location`),
  CONSTRAINT `patient_prevloc_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_prev_location`
--

LOCK TABLES `patient_prev_location` WRITE;
/*!40000 ALTER TABLE `patient_prev_location` DISABLE KEYS */;
INSERT INTO `patient_prev_location` VALUES ('PAT001','Bach Khoa Dormitory'),('PAT002','Bach Khoa University'),('PAT003','23 Tran Hung Dao Str, HCM City'),('PAT004','University of Economics'),('PAT005','Ly Thuong Kiet Co.op Mart'),('PAT006','Tu Du Hospital'),('PAT007','Tien Giang Province'),('PAT008','United State'),('PAT009','Bach Khoa Dormitory'),('PAT010','56 Nguyen Trai Str, HCM City'),('PAT011','6 Ly Tu Trong Str, HCM City'),('PAT012','Gia Dinh Highschool'),('PAT013','Da Nang'),('PAT014','Manchester, UK');
/*!40000 ALTER TABLE `patient_prev_location` ENABLE KEYS */;
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
