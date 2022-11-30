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
-- Table structure for table `patient_address`
--

DROP TABLE IF EXISTS `patient_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_address` (
  `patient_id` char(6) NOT NULL,
  `p_address` char(60) NOT NULL,
  PRIMARY KEY (`patient_id`,`p_address`),
  CONSTRAINT `patient_address_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_address`
--

LOCK TABLES `patient_address` WRITE;
/*!40000 ALTER TABLE `patient_address` DISABLE KEYS */;
INSERT INTO `patient_address` VALUES ('PAT001','Bien Hoa City, Dong Nai Province'),('PAT002','268 Ly Thuong Kiet Str, HCM City'),('PAT003','67 Tran Hung Dao Str, HCM City'),('PAT004','127 Tran Quoc Toan Str, HCM City'),('PAT005','635 Ly Thuong Kiet Str, HCM City'),('PAT006','36 Nguyen Tri Phuong Str, HCM City'),('PAT007','23 Hai Ba Truong Str, HCM City'),('PAT008','33 Dinh Tien Hoang Str, HCM City'),('PAT009','29 Phu Dong Str, HCM City'),('PAT010','99 Ngo Quyen Str, HCM City'),('PAT011','94 Au Co Str, HCM City'),('PAT012','42 Tu Xuong'),('PAT013','39/7 AmaQuang'),('PAT014','69 Piers Morgan, Crying City');
/*!40000 ALTER TABLE `patient_address` ENABLE KEYS */;
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
