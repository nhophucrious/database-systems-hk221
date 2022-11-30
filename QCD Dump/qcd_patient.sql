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
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` char(6) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `id_number` varchar(12) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `caretaker_id` char(6) DEFAULT NULL,
  `administrator_id` char(6) DEFAULT NULL,
  `is_warning` varchar(1) DEFAULT NULL,
  `is_high_risk` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caretaker_id_fk` (`caretaker_id`),
  KEY `administrator_id_fk` (`administrator_id`),
  CONSTRAINT `administrator_id_fk` FOREIGN KEY (`administrator_id`) REFERENCES `supporting_personnel` (`id`) ON DELETE SET NULL,
  CONSTRAINT `caretaker_id_fk` FOREIGN KEY (`caretaker_id`) REFERENCES `supporting_personnel` (`id`) ON DELETE SET NULL,
  CONSTRAINT `check_patient_condition` CHECK ((((`is_warning` = _utf8mb4'T') or (`is_warning` = _utf8mb4'F') or (`is_warning` is null)) and ((`is_high_risk` = _utf8mb4'T') or (`is_high_risk` = _utf8mb4'F') or (`is_high_risk` is null)))),
  CONSTRAINT `check_patient_gender` CHECK (((`gender` = _utf8mb4'M') or (`gender` = _utf8mb4'F') or (`gender` is null)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('PAT001','Peter','Tran','323692071','M','NUR001','STA001','F','F'),('PAT002','Ben','Parker','573723683','F','NUR002','STA002','F','T'),('PAT003','Cuc','Nguyen Bach','871238978','F','NUR003','STA003','T','T'),('PAT004','Duy','Le The','882772739','M','NUR005','STA005','F','F'),('PAT005','Thai','Truong Quang','183934678','F','NUR004','STA006','F','F'),('PAT006','A','Nguyen Van','723972033','F','NUR006','STA007','T','T'),('PAT007','B','Tran Van','913797193','M','NUR008','STA004','F','F'),('PAT008','A','Nguyen Van','742810139','M','NUR009','STA002','F','F'),('PAT009','C','Le Thi','816387793','F','NUR007','STA003','T','F'),('PAT010','D','Bui Trong','183834678','M','NUR001','STA001','F','F'),('PAT011','T','Ly Van','813781731','F','NUR002','STA002','F','T'),('PAT012','Phuc','Nguyen','064185718248','M','NUR001','STA001','F','F'),('PAT013','Hien','Nguyen','712095098129','M','NUR001','STA001','F','F'),('PAT014','Cristiano','Ronaldo','064124875129','F','NUR001','STA001','F','F');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
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
