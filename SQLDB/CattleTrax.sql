-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: cattletrax
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal` (
  `animal_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `herd_id` int(11) DEFAULT NULL,
  `pasture_id` int(11) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `a_type` varchar(45) DEFAULT 'cow',
  PRIMARY KEY (`animal_id`),
  UNIQUE KEY `animal_id_UNIQUE` (`animal_id`),
  UNIQUE KEY `tag_id_UNIQUE` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is the root of all more specific cow tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (12345,11111,NULL,NULL,NULL,'cow');
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bull`
--

DROP TABLE IF EXISTS `bull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bull` (
  `bull_id` int(11) NOT NULL,
  `castrated` varchar(3) NOT NULL,
  `num_sired` int(11) DEFAULT NULL,
  `bull_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`bull_id`),
  UNIQUE KEY `bull_id_UNIQUE` (`bull_id`),
  KEY `animal_id_idx` (`bull_id`),
  CONSTRAINT `bull_id` FOREIGN KEY (`bull_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bull`
--

LOCK TABLES `bull` WRITE;
/*!40000 ALTER TABLE `bull` DISABLE KEYS */;
/*!40000 ALTER TABLE `bull` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calf`
--

DROP TABLE IF EXISTS `calf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calf` (
  `calf_id` int(11) NOT NULL,
  `sex` varchar(7) DEFAULT NULL,
  `birth_weight` double DEFAULT NULL,
  `body_index` int(11) DEFAULT NULL,
  `wean_weight` double DEFAULT NULL,
  `ween_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`calf_id`),
  UNIQUE KEY `calf_id_UNIQUE` (`calf_id`),
  CONSTRAINT `calf_id` FOREIGN KEY (`calf_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='					';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calf`
--

LOCK TABLES `calf` WRITE;
/*!40000 ALTER TABLE `calf` DISABLE KEYS */;
/*!40000 ALTER TABLE `calf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cow`
--

DROP TABLE IF EXISTS `cow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cow` (
  `cow_id` int(11) NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `first_year` binary(1) DEFAULT NULL,
  `pregnant` binary(1) DEFAULT NULL,
  `calving_cond` varchar(45) DEFAULT NULL,
  `calving_ease` int(11) DEFAULT NULL,
  `calf_bonding` int(11) DEFAULT NULL,
  PRIMARY KEY (`cow_id`),
  UNIQUE KEY `cow_id_UNIQUE` (`cow_id`),
  CONSTRAINT `cow_id` FOREIGN KEY (`cow_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cow`
--

LOCK TABLES `cow` WRITE;
/*!40000 ALTER TABLE `cow` DISABLE KEYS */;
INSERT INTO `cow` VALUES (12345,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farm`
--

DROP TABLE IF EXISTS `farm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm` (
  `farm_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `num_pastures` int(11) DEFAULT '1',
  `num_animals` int(11) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  PRIMARY KEY (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farm`
--

LOCK TABLES `farm` WRITE;
/*!40000 ALTER TABLE `farm` DISABLE KEYS */;
/*!40000 ALTER TABLE `farm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feeder`
--

DROP TABLE IF EXISTS `feeder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feeder` (
  `ref_id` int(11) NOT NULL,
  `num_visits` int(11) DEFAULT NULL,
  `last_visit_date` datetime DEFAULT NULL,
  PRIMARY KEY (`ref_id`),
  UNIQUE KEY `animal_id_UNIQUE` (`ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds values for the total number of times an animal was recorded at the feeder and the date and time of the last recording.  ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feeder`
--

LOCK TABLES `feeder` WRITE;
/*!40000 ALTER TABLE `feeder` DISABLE KEYS */;
INSERT INTO `feeder` VALUES (1234,1,'2017-02-22 19:41:55'),(5432,1,'2017-02-22 19:42:13'),(12345,NULL,NULL),(54321,1,'2017-02-20 19:35:37'),(99999,2,'2017-02-20 19:47:21'),(111222,4,'2017-02-22 20:22:04');
/*!40000 ALTER TABLE `feeder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geofence`
--

DROP TABLE IF EXISTS `geofence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geofence` (
  `geofence_id` int(11) NOT NULL,
  `fence_data` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`geofence_id`),
  UNIQUE KEY `geofence_id_UNIQUE` (`geofence_id`),
  CONSTRAINT `geofence_id` FOREIGN KEY (`geofence_id`) REFERENCES `pasture` (`pasture_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='						';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geofence`
--

LOCK TABLES `geofence` WRITE;
/*!40000 ALTER TABLE `geofence` DISABLE KEYS */;
/*!40000 ALTER TABLE `geofence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herd`
--

DROP TABLE IF EXISTS `herd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `herd` (
  `herd_id` int(11) NOT NULL,
  `pasture_id` int(11) DEFAULT NULL,
  `total_count` int(11) DEFAULT NULL,
  `bull_count` int(11) DEFAULT NULL,
  `calf_count` int(11) DEFAULT NULL,
  `pregnant_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`herd_id`),
  UNIQUE KEY `pasture_id_UNIQUE` (`pasture_id`),
  CONSTRAINT `pasture_id` FOREIGN KEY (`pasture_id`) REFERENCES `pasture` (`pasture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herd`
--

LOCK TABLES `herd` WRITE;
/*!40000 ALTER TABLE `herd` DISABLE KEYS */;
/*!40000 ALTER TABLE `herd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pasture`
--

DROP TABLE IF EXISTS `pasture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pasture` (
  `pasture_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pasture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasture`
--

LOCK TABLES `pasture` WRITE;
/*!40000 ALTER TABLE `pasture` DISABLE KEYS */;
/*!40000 ALTER TABLE `pasture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `farm_id_idx` (`farm_id`),
  CONSTRAINT `farm_id` FOREIGN KEY (`farm_id`) REFERENCES `farm` (`farm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines`
--

DROP TABLE IF EXISTS `vaccines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccines` (
  `vaccine_id` int(11) NOT NULL,
  `vaccine` varchar(45) DEFAULT NULL,
  `date_admin` datetime DEFAULT NULL,
  `date_req` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines`
--

LOCK TABLES `vaccines` WRITE;
/*!40000 ALTER TABLE `vaccines` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vitals`
--

DROP TABLE IF EXISTS `vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vitals` (
  `animal_id` int(11) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `sire_id` int(11) DEFAULT NULL,
  `dame_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vitals`
--

LOCK TABLES `vitals` WRITE;
/*!40000 ALTER TABLE `vitals` DISABLE KEYS */;
INSERT INTO `vitals` VALUES (99887,2,260.4,NULL,NULL),(434343,1,123.4,NULL,NULL),(767676,7,450.8,NULL,NULL),(12345,2,1023.4,NULL,NULL);
/*!40000 ALTER TABLE `vitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cattletrax'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_animal`(animal_id INT, 
							   tag_id INT, 
                               a_type VARCHAR(45))
BEGIN
	INSERT INTO animal (animal_id, tag_id, a_type)
    VALUES
    (animal_id, tag_id, a_type);
    IF(a_type = "bull") THEN
		INSERT INTO bull (bull_id) Values (animal_id);
	ELSEIF(a_type = "calf") THEN
		INSERT INTO calf (calf_id) Values (animal_id);
	ELSEIF(a_type = "cow") THEN
		INSERT INTO cow (cow_id) Values(animal_id);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_bull` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_bull`(bull_id int, tag_id int, weight double, 
							age int, castrated varchar(3))
BEGIN
	INSERT INTO animal (animal_id, tag_id)
		VALUES (bull_id, tag_id);
	INSERT INTO vitals (animal_id, weight, age)
		VALUES (bull_id, weight, age);
	INSERT INTO bull (bull_id, castrated)
		VALUES (bull_id, castrated);	
	INSERT INTO feeder(ref_id)
		VALUES(bull_id);
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_calf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_calf`(calf_id int, tag_id int, weight double,
							 age int, sex varchar(7))
BEGIN
	INSERT INTO animal (animal_id, tag_id)
		VALUES (calf_id, tag_id);
	INSERT INTO vitals (animal_id, weight, age)
		VALUES (calf_id, weight, age);
	INSERT INTO calf (calf_id, sex)
		VALUES (calf_id, sex);
	INSERT INTO feeder(ref_id)
		VALUES(calf_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_cow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_cow`(cow_id int, tag_id int, weight double, 
							age int)
BEGIN

	INSERT INTO animal (animal_id, tag_id)
		VALUES (cow_id, tag_id);
	INSERT INTO vitals (animal_id, weight, age)
		VALUES (cow_id, weight, age);
	INSERT INTO cow (cow_id)
		VALUES (cow_id);
	INSERT INTO feeder(ref_id)
		VALUES (cow_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-27 13:47:15
