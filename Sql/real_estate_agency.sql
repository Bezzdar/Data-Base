-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: real_estate_agency
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `full_name` text NOT NULL,
  `income_level` decimal(10,2) DEFAULT NULL,
  `gender` enum('мужской','женский') DEFAULT NULL,
  `psychological_profile` longtext,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `client_chk_1` CHECK ((`income_level` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientcontact`
--

DROP TABLE IF EXISTS `clientcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientcontact` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `contact_type` enum('email','телефон','telegram') DEFAULT NULL,
  `contact_value` text NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `clientcontact_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientcontact`
--

LOCK TABLES `clientcontact` WRITE;
/*!40000 ALTER TABLE `clientcontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientcontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `contract_id` int NOT NULL AUTO_INCREMENT,
  `deal_id` int DEFAULT NULL,
  `contract_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `contract_type` enum('аренда','купля-продажа') DEFAULT NULL,
  `contract_text` longtext NOT NULL,
  `total_price` decimal(12,2) DEFAULT NULL,
  `payment_type` enum('единовременно','ежемесячно') DEFAULT NULL,
  `contract_status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`contract_id`),
  KEY `deal_id` (`deal_id`),
  CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`deal_id`) REFERENCES `deal` (`deal_id`) ON DELETE CASCADE,
  CONSTRAINT `contract_chk_1` CHECK ((`total_price` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deal`
--

DROP TABLE IF EXISTS `deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deal` (
  `deal_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `realtor_id` int DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `deal_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `deal_type` enum('аренда','продажа') DEFAULT NULL,
  `deal_status` varchar(50) DEFAULT 'в процессе',
  PRIMARY KEY (`deal_id`),
  KEY `client_id` (`client_id`),
  KEY `realtor_id` (`realtor_id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `deal_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  CONSTRAINT `deal_ibfk_2` FOREIGN KEY (`realtor_id`) REFERENCES `realtor` (`realtor_id`),
  CONSTRAINT `deal_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deal`
--

LOCK TABLES `deal` WRITE;
/*!40000 ALTER TABLE `deal` DISABLE KEYS */;
/*!40000 ALTER TABLE `deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `address` text NOT NULL,
  `property_type` enum('квартира','дом','коммерческое','земля') DEFAULT NULL,
  `area_sq_m` decimal(10,2) DEFAULT NULL,
  `photo` longblob,
  `owner_type` enum('владелец','арендодатель') DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`property_id`),
  CONSTRAINT `property_chk_1` CHECK ((`area_sq_m` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realtor`
--

DROP TABLE IF EXISTS `realtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realtor` (
  `realtor_id` int NOT NULL AUTO_INCREMENT,
  `full_name` text NOT NULL,
  `experience_years` int DEFAULT NULL,
  `specialization` text,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`realtor_id`),
  CONSTRAINT `realtor_chk_1` CHECK ((`experience_years` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realtor`
--

LOCK TABLES `realtor` WRITE;
/*!40000 ALTER TABLE `realtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `realtor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-02  0:38:31
