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
-- Table structure for table `patient_symptom`
--

DROP TABLE IF EXISTS `patient_symptom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_symptom` (
  `patient_id` char(6) NOT NULL,
  `s_date` date NOT NULL,
  `symptom` char(50) NOT NULL,
  PRIMARY KEY (`patient_id`,`s_date`,`symptom`),
  CONSTRAINT `patient_symptom_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_symptom`
--

LOCK TABLES `patient_symptom` WRITE;
/*!40000 ALTER TABLE `patient_symptom` DISABLE KEYS */;
INSERT INTO `patient_symptom` VALUES ('PAT001','2022-05-16','shortness of breath'),('PAT001','2022-06-06','chest pain'),('PAT001','2022-06-06','fever'),('PAT002','2022-06-08','loss of speech'),('PAT002','2022-08-08','shortness of breath'),('PAT004','2022-08-10','chest pain'),('PAT005','2022-08-12','shortness of breath'),('PAT006','2022-08-24','chest pain'),('PAT008','2021-12-09','tiredness'),('PAT008','2021-12-13','loss of smell'),('PAT008','2022-01-31','fever'),('PAT008','2022-09-17','loss of movement'),('PAT009','2022-02-03','cough'),('PAT009','2022-02-11','discolouration of fingers'),('PAT009','2022-02-25','headache'),('PAT010','2022-03-07','rash on skin'),('PAT010','2022-03-18','discolouration of toes'),('PAT010','2022-03-24','fever'),('PAT011','2022-04-10','sore throat'),('PAT011','2022-04-12','dry cough'),('PAT011','2022-04-18','tiredness'),('PAT011','2022-04-19','headache');
/*!40000 ALTER TABLE `patient_symptom` ENABLE KEYS */;
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
