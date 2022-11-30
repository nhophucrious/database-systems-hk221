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
-- Table structure for table `test_info`
--

DROP TABLE IF EXISTS `test_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_info` (
  `test_conductor_id` char(6) NOT NULL,
  `patient_id` char(6) NOT NULL,
  `test_date` date NOT NULL,
  `Qtest_res` char(1) DEFAULT NULL,
  `Qtest_ct` int DEFAULT NULL,
  `PCR_res` char(1) DEFAULT NULL,
  `PCR_ct` int DEFAULT NULL,
  `Respiratory_rate` int DEFAULT NULL,
  `SPO2` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`test_conductor_id`,`patient_id`,`test_date`),
  KEY `patient_id_fk` (`patient_id`),
  CONSTRAINT `patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `test_conductor_id_fk` FOREIGN KEY (`test_conductor_id`) REFERENCES `test_conductor` (`id`),
  CONSTRAINT `check_test` CHECK ((((`PCR_res` = _utf8mb4'T') or (`PCR_res` = _utf8mb4'F') or (`PCR_res` is null)) and ((`Qtest_res` = _utf8mb4'T') or (`Qtest_res` = _utf8mb4'F') or (`Qtest_res` is null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_info`
--

LOCK TABLES `test_info` WRITE;
/*!40000 ALTER TABLE `test_info` DISABLE KEYS */;
INSERT INTO `test_info` VALUES ('NUR007','PAT002','2021-11-10','T',36,'T',35,23,99.12),('NUR008','PAT001','2020-04-03','F',NULL,'F',NULL,20,97.88),('NUR008','PAT003','2020-06-30','F',NULL,'F',NULL,25,50.14),('NUR008','PAT004','2021-04-03','T',50,'T',40,19,97.88),('NUR008','PAT007','2020-07-05','F',NULL,'F',NULL,18,98.34),('NUR008','PAT009','2020-02-06','F',NULL,'F',NULL,21,50.78),('NUR009','PAT011','2021-09-01','F',NULL,'F',NULL,22,89.78),('NUR009','PAT011','2021-09-12','F',NULL,'F',NULL,22,89.78),('STA002','PAT008','2021-04-03','F',NULL,'F',NULL,19,97.54),('STA003','PAT005','2021-04-03','T',40,'T',32,17,86.34),('STA003','PAT010','2021-08-03','T',34,'T',33,21,96.34),('VOL005','PAT006','2020-09-02','F',NULL,'F',NULL,23,50.88);
/*!40000 ALTER TABLE `test_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-30 23:03:25
