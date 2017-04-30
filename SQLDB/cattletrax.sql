-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: cattletrax
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.2

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
  `animal_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  `herd_id` int(11) DEFAULT '0',
  `pasture_id` int(11) DEFAULT '0',
  `farm_id` int(11) DEFAULT '0',
  `a_type` varchar(45) DEFAULT 'cow',
  `rfid` bigint(20) DEFAULT NULL,
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
INSERT INTO `animal` VALUES (2000,15449,5,3,0,'cow',NULL),(6632,86632,10,10,0,'cow',NULL),(93494,66632,1,3,0,'cow',NULL),(785584,33625,1,2,0,'calf',NULL),(995645,424564,4,2,0,'bull',NULL),(6325526395874125,1632594856201458,2,2,0,'cow',NULL);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bull`
--

DROP TABLE IF EXISTS `bull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bull` (
  `bull_id` bigint(20) NOT NULL,
  `castrated` tinyint(1) DEFAULT '1',
  `num_sired` int(11) DEFAULT '0',
  `bull_index` int(11) DEFAULT '0',
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
INSERT INTO `bull` VALUES (995645,1,42,42);
/*!40000 ALTER TABLE `bull` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calf`
--

DROP TABLE IF EXISTS `calf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calf` (
  `calf_id` bigint(20) NOT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `birth_weight` double DEFAULT '0',
  `body_index` int(11) DEFAULT '0',
  `wean_weight` double DEFAULT '0',
  `wean_index` int(11) DEFAULT '0',
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
INSERT INTO `calf` VALUES (785584,'M',67.8,54,54.4,34);
/*!40000 ALTER TABLE `calf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cow`
--

DROP TABLE IF EXISTS `cow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cow` (
  `cow_id` bigint(20) NOT NULL,
  `due_date` date DEFAULT NULL,
  `first_year` binary(1) DEFAULT '1',
  `pregnant` binary(1) DEFAULT '1',
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
INSERT INTO `cow` VALUES (2000,'1969-12-31','1','1',NULL,NULL,NULL),(6632,'1969-12-31','1','1',NULL,NULL,NULL),(93494,NULL,'1','1',NULL,NULL,NULL),(6325526395874125,'1969-12-31','1','1',NULL,NULL,NULL);
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
  `ref_id` bigint(20) NOT NULL,
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
INSERT INTO `feeder` VALUES (555,1,'2017-03-16 21:03:49'),(1234,1,'2017-02-22 19:41:55'),(3333,3333,'2017-04-17 15:21:18'),(4343,1,'2017-03-16 23:23:09'),(5432,1,'2017-02-22 19:42:13'),(6543,NULL,NULL),(12345,NULL,NULL),(22222,1,'2017-03-21 10:40:00'),(54321,1,'2017-02-20 19:35:37'),(77777,NULL,NULL),(88888,NULL,NULL),(99999,2,'2017-02-20 19:47:21'),(111222,4,'2017-02-22 20:22:04'),(112233,NULL,NULL),(999999,NULL,NULL),(14141414,1,'2017-04-21 23:16:01');
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
  `date_req` datetime DEFAULT NULL,
  `need_vacc` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines`
--

LOCK TABLES `vaccines` WRITE;
/*!40000 ALTER TABLE `vaccines` DISABLE KEYS */;
INSERT INTO `vaccines` VALUES (1111,'test vaccine',NULL,'2017-04-09 14:27:27',1),(2222,'test vaccine',NULL,'2017-04-09 14:27:53',1),(3333,'test vaccine',NULL,'2017-04-09 14:28:00',1);
/*!40000 ALTER TABLE `vaccines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vitals`
--

DROP TABLE IF EXISTS `vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vitals` (
  `vital_id` bigint(20) NOT NULL,
  `weight` double DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `medical_cond` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vital_id`),
  CONSTRAINT `vital_id` FOREIGN KEY (`vital_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vitals`
--

LOCK TABLES `vitals` WRITE;
/*!40000 ALTER TABLE `vitals` DISABLE KEYS */;
INSERT INTO `vitals` VALUES (2000,1400,'2017-08-08','Super Sayian'),(6632,1000,'2017-04-24',NULL),(93494,1500,'2017-04-24','Suspected BVD'),(785584,65,'2017-04-05','savage'),(995645,967.35,'2016-11-12','aloof'),(6325526395874125,1500,'2017-04-24','Suspected Mastitis');
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_bull`(in tag bigint(20), animal bigint(20), wei double, herd int, past int, db date, med_cond varchar(255), cast tinyint(1), num_sire int, bull_ind int)
begin insert into animal(tag_id, animal_id, herd_id, pasture_id, a_type) values(tag, animal, herd, past, 'bull'); insert into bull(bull_id, castrated, num_sired, bull_index) values(animal, cast, num_sire, bull_ind); insert into vitals(vital_id, weight, DOB, medical_cond) values(animal, wei, db, med_cond); end ;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_calf`(in tag bigint(20), animal bigint(20), wei double, herd int, past int, db date, med_cond varchar(255), b_weight double, se varchar(1), bod_ind int, w_weight double, w_index int)
begin insert into animal(tag_id, animal_id, herd_id, pasture_id, a_type) values (tag, animal, herd, past, 'calf'); insert into vitals(vital_id, weight, DOB, medical_cond) values (animal, wei, db, med_cond); insert into calf(calf_id, sex, birth_weight, body_index, wean_weight, wean_index) values (animal, se, b_weight, bod_ind, w_weight, w_index); end ;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_cow`(in tag bigint(20), animal bigint(20), wei double, herd int, past int, db datetime, med_cond varchar(255), due_d datetime, preg tinyint(1))
begin
insert into animal(tag_id, animal_id, herd_id, pasture_id)
values(tag, animal, herd, past);
insert into cow(cow_id, pregnant, due_date)
values(animal, preg, due_d);
insert into vitals(vital_id, weight, DOB, medical_cond)
values (animal, wei, db, med_cond);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckVaccDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckVaccDate`()
begin
update vaccines set need_vacc = case when date_req >= NOW() - interval 30 day then 1 else 0 end;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_cow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_cow`(in new_animal bigint(20), tag bigint(20), animal bigint(20), herd int, past int, wei double, db datetime, med_cond varchar(255), due_d datetime, preg tinyint(1))
begin update vitals set weight = wei, DOB = db, medical_cond = med_cond where vital_id = animal; update cow set pregnant = preg, due_date = due_d where cow_id = animal; update animal set herd_id = herd, pasture_id = past, tag_id = tag where animal_id = animal; update animal set animal_id = new_animal where animal_id = animal; end ;;
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

-- Dump completed on 2017-04-26 13:37:04
