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
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel` (
  `id` char(6) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `check_personnel_gender` CHECK (((`gender` = _utf8mb4'M') or (`gender` = _utf8mb4'F') or (`gender` is null)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personnel`
--

LOCK TABLES `personnel` WRITE;
/*!40000 ALTER TABLE `personnel` DISABLE KEYS */;
INSERT INTO `personnel` VALUES ('DOC001','B','Tran Thi','F'),('DOC002','D','Nguyen Duc','M'),('DOC003','N','Yamada','M'),('DOC004','Trau','Nguyen Thi','F'),('DOC005','N','Tran Van','M'),('MAN001','A','Nguyen Van','M'),('MAN002','D','Nha Bach','F'),('MAN003','R','Nakamura','M'),('MAN004','Z','Tran Van','F'),('MAN005','Ba','Nguyen Thi','M'),('NUR001','A','Nguyen Van','F'),('NUR002','Ba','Thay Giao','M'),('NUR003','N','Takahashi','M'),('NUR004','A','Nguyen Van','F'),('NUR005','Nobita','Nobi','M'),('NUR006','B','Nguyen Van','F'),('NUR007','Bon','Thay Giao','M'),('NUR008','Satoshi',NULL,'M'),('NUR009','Shin','Nohara','F'),('NUR010','Nobi','Doraemon','M'),('STA001','A','Nguyen Van','M'),('STA002','Duan','Le','M'),('STA003','A','Takeshi','F'),('STA004','Truong','Nguyen Huu','F'),('STA005','Tin','Le Quang','M'),('STA006','Tho','Nguyen Minh','F'),('STA007','Tin','Ly Quang','M'),('VOL001','A','Nguyen Van','M'),('VOL002','T','Luong Van','F'),('VOL003','N','Honda','F'),('VOL004','B','Nguyen Van','M'),('VOL005','Binh','Nguyen Van','M');
/*!40000 ALTER TABLE `personnel` ENABLE KEYS */;
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
