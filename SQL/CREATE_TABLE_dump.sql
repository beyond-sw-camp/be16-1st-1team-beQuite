/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: producekbo
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `allstar`
--

DROP TABLE IF EXISTS `allstar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `allstar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` enum('UPCOMING','OPEN','CLOSED') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `allstar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allstar`
--

LOCK TABLES `allstar` WRITE;
/*!40000 ALTER TABLE `allstar` DISABLE KEYS */;
/*!40000 ALTER TABLE `allstar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allstarcandidate`
--

DROP TABLE IF EXISTS `allstarcandidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `allstarcandidate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `allstar_id` bigint(20) NOT NULL,
  `player_id` bigint(20) NOT NULL,
  `candidate_position` enum('포수','1루수','2루수','3루수','유격수','좌익수','중견수','우익수','선발투수','불펜투수') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `allstar_id` (`allstar_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `allstarcandidate_ibfk_1` FOREIGN KEY (`allstar_id`) REFERENCES `allstar` (`id`),
  CONSTRAINT `allstarcandidate_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allstarcandidate`
--

LOCK TABLES `allstarcandidate` WRITE;
/*!40000 ALTER TABLE `allstarcandidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `allstarcandidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allstarvote`
--

DROP TABLE IF EXISTS `allstarvote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `allstarvote` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `allstar_id` bigint(20) NOT NULL,
  `allstarCandidate_id` bigint(20) NOT NULL,
  `vote_timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `포수이름` varchar(30) NOT NULL,
  `1루수이름` varchar(30) NOT NULL,
  `2루수이름` varchar(30) NOT NULL,
  `3루수이름` varchar(30) NOT NULL,
  `유격수이름` varchar(30) NOT NULL,
  `좌익수이름` varchar(30) NOT NULL,
  `중견수이름` varchar(30) NOT NULL,
  `우익수이름` varchar(30) NOT NULL,
  `선발투수이름` varchar(30) NOT NULL,
  `불페투수이름` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `allstar_id` (`allstar_id`),
  KEY `allstarCandidate_id` (`allstarCandidate_id`),
  CONSTRAINT `allstarvote_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `allstarvote_ibfk_2` FOREIGN KEY (`allstar_id`) REFERENCES `allstar` (`id`),
  CONSTRAINT `allstarvote_ibfk_3` FOREIGN KEY (`allstarCandidate_id`) REFERENCES `allstarcandidate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allstarvote`
--

LOCK TABLES `allstarvote` WRITE;
/*!40000 ALTER TABLE `allstarvote` DISABLE KEYS */;
/*!40000 ALTER TABLE `allstarvote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batter`
--

DROP TABLE IF EXISTS `batter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batterPosition_id` bigint(20) NOT NULL,
  `batterStats_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `batterPosition_id` (`batterPosition_id`),
  KEY `batterStats_id` (`batterStats_id`),
  CONSTRAINT `batter_ibfk_1` FOREIGN KEY (`batterPosition_id`) REFERENCES `batterposition` (`id`),
  CONSTRAINT `batter_ibfk_2` FOREIGN KEY (`batterStats_id`) REFERENCES `batterstats` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batter`
--

LOCK TABLES `batter` WRITE;
/*!40000 ALTER TABLE `batter` DISABLE KEYS */;
/*!40000 ALTER TABLE `batter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batterposition`
--

DROP TABLE IF EXISTS `batterposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batterposition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `positioned_id` bigint(20) NOT NULL,
  `batterPosition` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `positioned_id` (`positioned_id`),
  CONSTRAINT `batterposition_ibfk_1` FOREIGN KEY (`positioned_id`) REFERENCES `positioned` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batterposition`
--

LOCK TABLES `batterposition` WRITE;
/*!40000 ALTER TABLE `batterposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `batterposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batterstats`
--

DROP TABLE IF EXISTS `batterstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batterstats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AVG` decimal(4,3) DEFAULT NULL,
  `G` int(11) NOT NULL,
  `PA` int(11) DEFAULT NULL,
  `AB` int(11) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `H` int(11) DEFAULT NULL,
  `2B` int(11) DEFAULT NULL,
  `3B` int(11) DEFAULT NULL,
  `HR` int(11) DEFAULT NULL,
  `TB` int(11) DEFAULT NULL,
  `RBI` int(11) DEFAULT NULL,
  `SAC` int(11) DEFAULT NULL,
  `SF` int(11) DEFAULT NULL,
  `BB` int(11) DEFAULT NULL,
  `IBB` int(11) DEFAULT NULL,
  `HBP` int(11) DEFAULT NULL,
  `SO` int(11) DEFAULT NULL,
  `GDP` int(11) DEFAULT NULL,
  `SLG` decimal(4,3) DEFAULT NULL,
  `OBP` decimal(4,3) DEFAULT NULL,
  `MH` int(11) DEFAULT NULL,
  `RISP` decimal(4,3) DEFAULT NULL,
  `ops` decimal(4,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batterstats`
--

LOCK TABLES `batterstats` WRITE;
/*!40000 ALTER TABLE `batterstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `batterstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batterstatsfilter`
--

DROP TABLE IF EXISTS `batterstatsfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batterstatsfilter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batter_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `createAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `batter_id` (`batter_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `batterstatsfilter_ibfk_1` FOREIGN KEY (`batter_id`) REFERENCES `batter` (`id`),
  CONSTRAINT `batterstatsfilter_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batterstatsfilter`
--

LOCK TABLES `batterstatsfilter` WRITE;
/*!40000 ALTER TABLE `batterstatsfilter` DISABLE KEYS */;
/*!40000 ALTER TABLE `batterstatsfilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batterstatsfiltercondition`
--

DROP TABLE IF EXISTS `batterstatsfiltercondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batterstatsfiltercondition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batterStatsFilter_id` bigint(20) NOT NULL,
  `statColName` varchar(20) NOT NULL,
  `operator` enum('=','!=','>','<','>=','<=') DEFAULT NULL,
  `value` varchar(20) NOT NULL,
  `valueType` enum('int','float','string') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `batterStatsFilter_id` (`batterStatsFilter_id`),
  CONSTRAINT `batterstatsfiltercondition_ibfk_1` FOREIGN KEY (`batterStatsFilter_id`) REFERENCES `batterstatsfilter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batterstatsfiltercondition`
--

LOCK TABLES `batterstatsfiltercondition` WRITE;
/*!40000 ALTER TABLE `batterstatsfiltercondition` DISABLE KEYS */;
/*!40000 ALTER TABLE `batterstatsfiltercondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanteam`
--

DROP TABLE IF EXISTS `fanteam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fanteam` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `has_fanTeam` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fanteam_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanteam`
--

LOCK TABLES `fanteam` WRITE;
/*!40000 ALTER TABLE `fanteam` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanteam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanteammember`
--

DROP TABLE IF EXISTS `fanteammember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fanteammember` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `players_id` bigint(20) NOT NULL,
  `fanteam_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_players_fanteam` (`players_id`,`fanteam_id`),
  KEY `fanteam_id` (`fanteam_id`),
  CONSTRAINT `fanteammember_ibfk_1` FOREIGN KEY (`players_id`) REFERENCES `players` (`id`),
  CONSTRAINT `fanteammember_ibfk_2` FOREIGN KEY (`fanteam_id`) REFERENCES `fanteam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanteammember`
--

LOCK TABLES `fanteammember` WRITE;
/*!40000 ALTER TABLE `fanteammember` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanteammember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritelist`
--

DROP TABLE IF EXISTS `favoritelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritelist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `favoritelist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritelist`
--

LOCK TABLES `favoritelist` WRITE;
/*!40000 ALTER TABLE `favoritelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoriteplayers`
--

DROP TABLE IF EXISTS `favoriteplayers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoriteplayers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `players_id` bigint(20) NOT NULL,
  `favoriteList_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `players_id` (`players_id`),
  KEY `favoriteList_id` (`favoriteList_id`),
  CONSTRAINT `favoriteplayers_ibfk_1` FOREIGN KEY (`players_id`) REFERENCES `players` (`id`),
  CONSTRAINT `favoriteplayers_ibfk_2` FOREIGN KEY (`favoriteList_id`) REFERENCES `favoritelist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoriteplayers`
--

LOCK TABLES `favoriteplayers` WRITE;
/*!40000 ALTER TABLE `favoriteplayers` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoriteplayers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leagueteam`
--

DROP TABLE IF EXISTS `leagueteam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `leagueteam` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `region` varchar(30) NOT NULL,
  `stadium` varchar(50) NOT NULL,
  `foundedYear` year(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagueteam`
--

LOCK TABLES `leagueteam` WRITE;
/*!40000 ALTER TABLE `leagueteam` DISABLE KEYS */;
/*!40000 ALTER TABLE `leagueteam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitcher`
--

DROP TABLE IF EXISTS `pitcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitcher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pitcherPosition_id` bigint(20) NOT NULL,
  `pitcherStats_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pitcherPosition_id` (`pitcherPosition_id`),
  KEY `pitcherStats_id` (`pitcherStats_id`),
  CONSTRAINT `pitcher_ibfk_1` FOREIGN KEY (`pitcherPosition_id`) REFERENCES `pitcherposition` (`id`),
  CONSTRAINT `pitcher_ibfk_2` FOREIGN KEY (`pitcherStats_id`) REFERENCES `pitcherstats` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitcher`
--

LOCK TABLES `pitcher` WRITE;
/*!40000 ALTER TABLE `pitcher` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitcherposition`
--

DROP TABLE IF EXISTS `pitcherposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitcherposition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `positioned_id` bigint(20) NOT NULL,
  `pitcherposition` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `positioned_id` (`positioned_id`),
  CONSTRAINT `pitcherposition_ibfk_1` FOREIGN KEY (`positioned_id`) REFERENCES `positioned` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitcherposition`
--

LOCK TABLES `pitcherposition` WRITE;
/*!40000 ALTER TABLE `pitcherposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitcherposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitcherstats`
--

DROP TABLE IF EXISTS `pitcherstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitcherstats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ERA` decimal(4,3) NOT NULL,
  `G` int(11) NOT NULL,
  `W` int(11) DEFAULT NULL,
  `L` int(11) DEFAULT NULL,
  `SV` int(11) DEFAULT NULL,
  `HLD` int(11) DEFAULT NULL,
  `WLCT` decimal(4,3) DEFAULT NULL,
  `IP` varchar(10) DEFAULT NULL,
  `H` int(11) DEFAULT NULL,
  `HR` int(11) DEFAULT NULL,
  `BB` int(11) DEFAULT NULL,
  `HBP` int(11) DEFAULT NULL,
  `SO` int(11) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `ER` int(11) DEFAULT NULL,
  `WHIP` varchar(10) DEFAULT NULL,
  `CG` int(11) DEFAULT NULL,
  `SHO` int(11) DEFAULT NULL,
  `QS` int(11) DEFAULT NULL,
  `BSV` int(11) DEFAULT NULL,
  `TBF` int(11) DEFAULT NULL,
  `NP` int(11) DEFAULT NULL,
  `AVG` decimal(4,3) DEFAULT NULL,
  `2B` int(11) DEFAULT NULL,
  `3B` int(11) DEFAULT NULL,
  `SAC` int(11) DEFAULT NULL,
  `SF` int(11) DEFAULT NULL,
  `IBB` int(11) DEFAULT NULL,
  `WP` int(11) DEFAULT NULL,
  `BK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitcherstats`
--

LOCK TABLES `pitcherstats` WRITE;
/*!40000 ALTER TABLE `pitcherstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitcherstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitcherstatsfilter`
--

DROP TABLE IF EXISTS `pitcherstatsfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitcherstatsfilter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pitcher_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `createAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pitcher_id` (`pitcher_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `pitcherstatsfilter_ibfk_1` FOREIGN KEY (`pitcher_id`) REFERENCES `pitcher` (`id`),
  CONSTRAINT `pitcherstatsfilter_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitcherstatsfilter`
--

LOCK TABLES `pitcherstatsfilter` WRITE;
/*!40000 ALTER TABLE `pitcherstatsfilter` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitcherstatsfilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitcherstatsfiltercondition`
--

DROP TABLE IF EXISTS `pitcherstatsfiltercondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitcherstatsfiltercondition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pitcherStatsFilter_id` bigint(20) NOT NULL,
  `statColName` varchar(20) NOT NULL,
  `operator` enum('=','!=','>','<','>=','<=') DEFAULT NULL,
  `value` varchar(20) NOT NULL,
  `valueType` enum('int','float','string') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pitcherStatsFilter_id` (`pitcherStatsFilter_id`),
  CONSTRAINT `pitcherstatsfiltercondition_ibfk_1` FOREIGN KEY (`pitcherStatsFilter_id`) REFERENCES `pitcherstatsfilter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitcherstatsfiltercondition`
--

LOCK TABLES `pitcherstatsfiltercondition` WRITE;
/*!40000 ALTER TABLE `pitcherstatsfiltercondition` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitcherstatsfiltercondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `leagueTeam_id` bigint(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `vote` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `leagueTeam_id` (`leagueTeam_id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`leagueTeam_id`) REFERENCES `leagueteam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positioned`
--

DROP TABLE IF EXISTS `positioned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `positioned` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `players_id` bigint(20) NOT NULL,
  `name` enum('batter','pitcher') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `players_id` (`players_id`),
  CONSTRAINT `positioned_ibfk_1` FOREIGN KEY (`players_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positioned`
--

LOCK TABLES `positioned` WRITE;
/*!40000 ALTER TABLE `positioned` DISABLE KEYS */;
/*!40000 ALTER TABLE `positioned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statbookmark`
--

DROP TABLE IF EXISTS `statbookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `statbookmark` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `player_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `statbookmark_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `statbookmark_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statbookmark`
--

LOCK TABLES `statbookmark` WRITE;
/*!40000 ALTER TABLE `statbookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `statbookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `leagueTeam_id` bigint(20) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `leagueTeam_id` (`leagueTeam_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`leagueTeam_id`) REFERENCES `leagueteam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-08 17:02:11
