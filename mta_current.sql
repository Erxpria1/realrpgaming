-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: mta
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_details`
--

DROP TABLE IF EXISTS `account_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_details` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `lastlogin` datetime DEFAULT NULL,
  `warn_style` int(1) NOT NULL DEFAULT 1,
  `hiddenadmin` tinyint(3) unsigned DEFAULT 0,
  `adminjail` tinyint(3) unsigned DEFAULT 0,
  `adminjail_time` int(11) DEFAULT NULL,
  `adminjail_by` text DEFAULT NULL,
  `adminjail_reason` text DEFAULT NULL,
  `muted` tinyint(3) unsigned DEFAULT 0,
  `globalooc` tinyint(3) unsigned DEFAULT 1,
  `friendsmessage` varchar(255) NOT NULL DEFAULT 'Hi!',
  `adminjail_permanent` tinyint(3) unsigned DEFAULT 0,
  `adminreports` int(11) DEFAULT 0,
  `warns` tinyint(3) unsigned DEFAULT 0,
  `chatbubbles` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `adminnote` text DEFAULT NULL,
  `appstate` tinyint(1) DEFAULT 0,
  `appdatetime` datetime DEFAULT NULL,
  `appreason` longtext DEFAULT NULL,
  `help` int(1) NOT NULL DEFAULT 1,
  `adblocked` int(1) NOT NULL DEFAULT 0,
  `newsblocked` int(1) DEFAULT 0,
  `mtaserial` text DEFAULT NULL,
  `d_addiction` text DEFAULT NULL,
  `loginhash` varchar(64) DEFAULT NULL,
  `transfers` int(11) DEFAULT 0,
  `monitored` varchar(255) NOT NULL DEFAULT '',
  `autopark` int(1) NOT NULL DEFAULT 1,
  `forceUpdate` smallint(1) NOT NULL DEFAULT 0,
  `anotes` text DEFAULT NULL,
  `oldAdminRank` int(11) DEFAULT 0,
  `suspensionTime` bigint(20) DEFAULT NULL,
  `car_license` int(1) NOT NULL DEFAULT 0,
  `adminreports_saved` int(3) DEFAULT 0,
  `cpa_earned` double DEFAULT 0,
  `electionsvoted` int(11) NOT NULL DEFAULT 0,
  `serial_whitelist_cap` int(2) NOT NULL DEFAULT 2,
  `max_characters` int(10) unsigned NOT NULL DEFAULT 30,
  `remember_token` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_details`
--

LOCK TABLES `account_details` WRITE;
/*!40000 ALTER TABLE `account_details` DISABLE KEYS */;
INSERT INTO `account_details` VALUES (1,'2026-02-17 12:23:48',1,0,0,NULL,NULL,NULL,0,1,'Hi!',0,100,0,1,NULL,3,NULL,NULL,1,0,0,'0361FA2EC22A9A9624BD5FD577E03D71',NULL,NULL,0,'',1,0,NULL,0,NULL,0,100,0,0,2,30,''),(2,'2026-02-17 09:23:07',1,0,0,NULL,NULL,NULL,0,1,'Hi!',0,100,0,1,NULL,3,NULL,NULL,1,0,0,'D51213B5D2C3EDD5555BB34774212C42',NULL,NULL,0,'',1,0,NULL,0,NULL,0,100,0,0,2,30,'');
/*!40000 ALTER TABLE `account_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_settings`
--

DROP TABLE IF EXISTS `account_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`,`name`),
  KEY `id_idx` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_settings`
--

LOCK TABLES `account_settings` WRITE;
/*!40000 ALTER TABLE `account_settings` DISABLE KEYS */;
INSERT INTO `account_settings` VALUES (2,'duty_admin','1'),(1,'duty_admin','0'),(2,'graphic_motionblur','0');
/*!40000 ALTER TABLE `account_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_teleports`
--

DROP TABLE IF EXISTS `admin_teleports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_teleports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_value` text NOT NULL COMMENT '/gotoplace #v',
  `location_description` text DEFAULT NULL,
  `location_creator` int(10) NOT NULL COMMENT 'User ID',
  `posX` float(10,6) NOT NULL DEFAULT 0.000000,
  `posY` float(10,6) NOT NULL DEFAULT 0.000000,
  `posZ` float(10,6) NOT NULL DEFAULT 0.000000,
  `rot` float(10,6) NOT NULL DEFAULT 0.000000 COMMENT 'rotation',
  `int` int(6) NOT NULL DEFAULT 0 COMMENT 'interior',
  `dim` int(6) NOT NULL DEFAULT 0 COMMENT 'dimension',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NAMEUNI` (`location_value`(100))
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='/tps manager';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_teleports`
--

LOCK TABLES `admin_teleports` WRITE;
/*!40000 ALTER TABLE `admin_teleports` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_teleports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminhistory`
--

DROP TABLE IF EXISTS `adminhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminhistory` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user` int(10) NOT NULL,
  `user_char` int(11) DEFAULT 0,
  `admin` int(10) DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `action` tinyint(3) NOT NULL DEFAULT 6,
  `duration` int(10) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adminhistory_user_ea155d8a_uniq` (`user`),
  KEY `adminhistory_user_char_c1d4310b_uniq` (`user_char`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminhistory`
--

LOCK TABLES `adminhistory` WRITE;
/*!40000 ALTER TABLE `adminhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisements`
--

DROP TABLE IF EXISTS `advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advertisements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `advertisement` varchar(200) NOT NULL,
  `start` int(11) NOT NULL,
  `expiry` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `section` int(11) NOT NULL,
  `faction` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisements`
--

LOCK TABLES `advertisements` WRITE;
/*!40000 ALTER TABLE `advertisements` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apb`
--

DROP TABLE IF EXISTS `apb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `doneby` int(11) NOT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apb`
--

LOCK TABLES `apb` WRITE;
/*!40000 ALTER TABLE `apb` DISABLE KEYS */;
/*!40000 ALTER TABLE `apb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant` int(11) NOT NULL DEFAULT 0,
  `dateposted` timestamp NOT NULL DEFAULT current_timestamp(),
  `datereviewed` datetime DEFAULT NULL,
  `reviewer` int(11) NOT NULL DEFAULT 0,
  `note` varchar(500) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `question1` varchar(500) DEFAULT NULL,
  `question2` varchar(500) DEFAULT NULL,
  `question3` varchar(500) DEFAULT NULL,
  `question4` varchar(500) DEFAULT NULL,
  `answer1` varchar(500) DEFAULT NULL,
  `answer2` varchar(500) DEFAULT NULL,
  `answer3` varchar(500) DEFAULT NULL,
  `answer4` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications_questions`
--

DROP TABLE IF EXISTS `applications_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications_questions` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `question` text DEFAULT NULL,
  `answer1` text DEFAULT NULL,
  `answer2` text DEFAULT NULL,
  `answer3` text DEFAULT NULL,
  `key` tinyint(1) NOT NULL DEFAULT 1,
  `createdBy` int(8) NOT NULL DEFAULT 0,
  `updatedBy` int(8) NOT NULL DEFAULT 0,
  `createDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updateDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `part` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications_questions`
--

LOCK TABLES `applications_questions` WRITE;
/*!40000 ALTER TABLE `applications_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `applications_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atm_cards`
--

DROP TABLE IF EXISTS `atm_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atm_cards` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `card_owner` int(11) DEFAULT NULL,
  `card_number` text DEFAULT NULL,
  `card_pin` varchar(4) NOT NULL DEFAULT '0000',
  `card_locked` tinyint(1) NOT NULL DEFAULT 0,
  `card_type` tinyint(1) NOT NULL DEFAULT 1,
  `limit_type` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `card_id_UNIQUE` (`card_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atm_cards`
--

LOCK TABLES `atm_cards` WRITE;
/*!40000 ALTER TABLE `atm_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `atm_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atms`
--

DROP TABLE IF EXISTS `atms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` decimal(10,6) DEFAULT 0.000000,
  `y` decimal(10,6) DEFAULT 0.000000,
  `z` decimal(10,6) DEFAULT 0.000000,
  `rotation` decimal(10,6) DEFAULT 0.000000,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `deposit` tinyint(3) unsigned DEFAULT 0,
  `limit` int(10) unsigned DEFAULT 5000,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atms`
--

LOCK TABLES `atms` WRITE;
/*!40000 ALTER TABLE `atms` DISABLE KEYS */;
/*!40000 ALTER TABLE `atms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `book` text DEFAULT NULL,
  `readOnly` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='This is used for the book system. // Chaos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `character_settings`
--

DROP TABLE IF EXISTS `character_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_settings`
--

LOCK TABLES `character_settings` WRITE;
/*!40000 ALTER TABLE `character_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charactername` varchar(255) DEFAULT NULL,
  `account` int(11) DEFAULT 0,
  `x` float DEFAULT 1169.73,
  `y` float DEFAULT -1413.91,
  `z` float DEFAULT 13.48,
  `rotation` float DEFAULT 359.388,
  `interior_id` int(5) DEFAULT 0,
  `dimension_id` int(5) DEFAULT 0,
  `health` float DEFAULT 100,
  `armor` float DEFAULT 0,
  `skin` int(3) DEFAULT 264,
  `money` bigint(20) DEFAULT 500,
  `gender` int(1) DEFAULT 0,
  `cuffed` int(11) DEFAULT 0,
  `duty` int(3) DEFAULT 0,
  `fightstyle` int(2) DEFAULT 4,
  `pdjail` int(1) DEFAULT 0,
  `pdjail_time` int(11) DEFAULT 0,
  `cked` int(1) DEFAULT 0,
  `lastarea` varchar(255) DEFAULT NULL,
  `age` int(3) DEFAULT 18,
  `skincolor` int(1) DEFAULT 0,
  `weight` int(3) DEFAULT 180,
  `height` int(3) DEFAULT 180,
  `description` text DEFAULT NULL,
  `deaths` int(11) DEFAULT 0,
  `faction_leader` int(1) DEFAULT 0,
  `fingerprint` varchar(255) DEFAULT NULL,
  `casualskin` int(3) DEFAULT 0,
  `bankmoney` bigint(20) DEFAULT 1000,
  `car_license` int(1) DEFAULT 0,
  `bike_license` int(1) DEFAULT 0,
  `pilot_license` int(1) DEFAULT 0,
  `fish_license` int(1) DEFAULT 0,
  `boat_license` int(1) DEFAULT 0,
  `gun_license` int(1) DEFAULT 0,
  `gun2_license` int(1) DEFAULT 0,
  `tag` int(3) DEFAULT 1,
  `hoursplayed` int(11) DEFAULT 0,
  `pdjail_station` int(1) DEFAULT 0,
  `timeinserver` int(2) DEFAULT 0,
  `restrainedobj` int(11) DEFAULT 0,
  `restrainedby` int(11) DEFAULT 0,
  `dutyskin` int(3) DEFAULT -1,
  `fish` int(10) unsigned NOT NULL DEFAULT 0,
  `blindfold` tinyint(4) NOT NULL DEFAULT 0,
  `lang1` tinyint(2) DEFAULT 1,
  `lang1skill` tinyint(3) DEFAULT 100,
  `lang2` tinyint(2) DEFAULT 0,
  `lang2skill` tinyint(3) DEFAULT 0,
  `lang3` tinyint(2) DEFAULT 0,
  `lang3skill` tinyint(3) DEFAULT 0,
  `currlang` tinyint(1) DEFAULT 1,
  `lastlogin` datetime DEFAULT NULL,
  `creationdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `election_candidate` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `election_canvote` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `election_votedfor` int(10) unsigned NOT NULL DEFAULT 0,
  `marriedto` int(10) unsigned NOT NULL DEFAULT 0,
  `photos` int(10) unsigned NOT NULL DEFAULT 0,
  `maxvehicles` int(4) unsigned NOT NULL DEFAULT 5,
  `ck_info` varchar(500) DEFAULT NULL,
  `alcohollevel` float NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `recovery` int(1) DEFAULT 0,
  `recoverytime` bigint(20) DEFAULT NULL,
  `walkingstyle` int(3) NOT NULL DEFAULT 0,
  `job` int(3) NOT NULL DEFAULT 0,
  `day` tinyint(2) NOT NULL DEFAULT 1,
  `month` tinyint(2) NOT NULL DEFAULT 1,
  `maxinteriors` int(4) NOT NULL DEFAULT 10,
  `clothingid` int(10) unsigned DEFAULT NULL,
  `death_date` datetime DEFAULT NULL,
  `max_clothes` int(10) unsigned NOT NULL DEFAULT 3,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (1,'Taylor_Jakson',1,350.754,-1781.97,5.35408,144.283,0,0,49,0,7,500,0,0,0,4,0,0,0,'Santa Maria Beach, Los Santos',16,0,50,150,'',0,0,'EEBEE9E46C7227AF50C792FF56AB82F2',0,1534,0,0,0,0,0,0,0,1,2,0,68,0,0,-1,0,0,1,100,0,0,0,0,1,'2026-02-17 12:23:48','2026-02-17 15:05:40',0,0,0,0,0,5,NULL,0,1,0,NULL,128,0,1,1,10,NULL,NULL,3,'2010-01-01'),(2,'Kerem_I',2,1088.66,-1435.77,52.8501,342.968,0,0,95,0,23,500,0,0,0,4,0,0,0,'Market, Los Santos',16,1,50,150,'',0,0,'131C6DB43386CD8131716E612C031A49',0,1000,0,0,0,0,0,0,0,1,0,0,47,0,0,-1,0,0,24,100,0,0,0,0,1,'2026-02-17 09:23:07','2026-02-17 15:06:06',0,0,0,0,0,5,NULL,0,1,0,NULL,65,0,1,1,10,NULL,NULL,3,'2010-01-01');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters_faction`
--

DROP TABLE IF EXISTS `characters_faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters_faction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `faction_id` int(11) NOT NULL,
  `faction_rank` int(11) NOT NULL,
  `faction_leader` int(11) NOT NULL,
  `faction_phone` int(11) DEFAULT NULL,
  `faction_perks` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters_faction`
--

LOCK TABLES `characters_faction` WRITE;
/*!40000 ALTER TABLE `characters_faction` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters_faction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothing`
--

DROP TABLE IF EXISTS `clothing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clothing` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `skin` int(11) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'A set of clean clothes.',
  `price` int(11) unsigned NOT NULL DEFAULT 50,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `creator_char` int(10) NOT NULL DEFAULT 0,
  `for_sale_until` datetime DEFAULT NULL,
  `distribution` int(1) unsigned NOT NULL DEFAULT 0,
  `manufactured_date` datetime DEFAULT NULL,
  `sold` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothing`
--

LOCK TABLES `clothing` WRITE;
/*!40000 ALTER TABLE `clothing` DISABLE KEYS */;
/*!40000 ALTER TABLE `clothing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commands`
--

DROP TABLE IF EXISTS `commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` text DEFAULT NULL,
  `hotkey` text DEFAULT NULL,
  `explanation` text DEFAULT NULL,
  `permission` int(3) NOT NULL DEFAULT 0,
  `category` int(2) NOT NULL DEFAULT 1,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Saves all info about all kinds of supported commands and con';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commands`
--

LOCK TABLES `commands` WRITE;
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dancers`
--

DROP TABLE IF EXISTS `dancers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dancers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotation` float NOT NULL,
  `skin` smallint(5) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `interior` int(10) unsigned NOT NULL,
  `dimension` int(10) unsigned NOT NULL,
  `offset` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dancers`
--

LOCK TABLES `dancers` WRITE;
/*!40000 ALTER TABLE `dancers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dancers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dog_users`
--

DROP TABLE IF EXISTS `dog_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dog_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charactername` varchar(45) NOT NULL,
  `attack` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dog_users`
--

LOCK TABLES `dog_users` WRITE;
/*!40000 ALTER TABLE `dog_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `dog_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_purchases`
--

DROP TABLE IF EXISTS `don_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `don_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `cost` int(11) DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `account` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_purchases`
--

LOCK TABLES `don_purchases` WRITE;
/*!40000 ALTER TABLE `don_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `don_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donators`
--

DROP TABLE IF EXISTS `donators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `charID` int(11) NOT NULL DEFAULT -1,
  `perkID` int(4) NOT NULL,
  `perkValue` varchar(10) NOT NULL DEFAULT '1',
  `expirationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donators`
--

LOCK TABLES `donators` WRITE;
/*!40000 ALTER TABLE `donators` DISABLE KEYS */;
/*!40000 ALTER TABLE `donators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_allowed`
--

DROP TABLE IF EXISTS `duty_allowed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_allowed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faction` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `itemValue` varchar(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Used for an admin allow list.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_allowed`
--

LOCK TABLES `duty_allowed` WRITE;
/*!40000 ALTER TABLE `duty_allowed` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_allowed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_custom`
--

DROP TABLE IF EXISTS `duty_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factionid` int(11) NOT NULL,
  `name` text NOT NULL,
  `skins` text NOT NULL,
  `locations` text NOT NULL,
  `items` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Used for custom duties.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_custom`
--

LOCK TABLES `duty_custom` WRITE;
/*!40000 ALTER TABLE `duty_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duty_locations`
--

DROP TABLE IF EXISTS `duty_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duty_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factionid` int(11) NOT NULL,
  `name` text NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `z` int(11) DEFAULT NULL,
  `radius` int(11) DEFAULT NULL,
  `dimension` int(11) DEFAULT 0,
  `interior` int(11) DEFAULT 0,
  `vehicleid` int(11) DEFAULT NULL,
  `model` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Used for custom duty locations.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duty_locations`
--

LOCK TABLES `duty_locations` WRITE;
/*!40000 ALTER TABLE `duty_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elections`
--

DROP TABLE IF EXISTS `elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `electionsname` varchar(45) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `elections_UNIQUE` (`electionsname`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elections`
--

LOCK TABLES `elections` WRITE;
/*!40000 ALTER TABLE `elections` DISABLE KEYS */;
/*!40000 ALTER TABLE `elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elevators`
--

DROP TABLE IF EXISTS `elevators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elevators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` decimal(10,6) DEFAULT 0.000000,
  `y` decimal(10,6) DEFAULT 0.000000,
  `z` decimal(10,6) DEFAULT 0.000000,
  `tpx` decimal(10,6) DEFAULT 0.000000,
  `tpy` decimal(10,6) DEFAULT 0.000000,
  `tpz` decimal(10,6) DEFAULT 0.000000,
  `dimensionwithin` int(5) DEFAULT 0,
  `interiorwithin` int(5) DEFAULT 0,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `car` tinyint(3) unsigned DEFAULT 0,
  `disabled` tinyint(3) unsigned DEFAULT 0,
  `rot` decimal(10,6) DEFAULT 0.000000,
  `tprot` decimal(10,6) DEFAULT 0.000000,
  `oneway` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elevators`
--

LOCK TABLES `elevators` WRITE;
/*!40000 ALTER TABLE `elevators` DISABLE KEYS */;
/*!40000 ALTER TABLE `elevators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailaccounts`
--

DROP TABLE IF EXISTS `emailaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailaccounts`
--

LOCK TABLES `emailaccounts` WRITE;
/*!40000 ALTER TABLE `emailaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `sender` text DEFAULT NULL,
  `receiver` text DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `message` text DEFAULT NULL,
  `inbox` int(1) NOT NULL DEFAULT 0,
  `outbox` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faa_registry`
--

DROP TABLE IF EXISTS `faa_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faa_registry` (
  `codeid` int(11) NOT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `condition` varchar(45) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  PRIMARY KEY (`codeid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faa_registry`
--

LOCK TABLES `faa_registry` WRITE;
/*!40000 ALTER TABLE `faa_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `faa_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faction_ranks`
--

DROP TABLE IF EXISTS `faction_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faction_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faction_id` int(11) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `isLeader` int(11) NOT NULL DEFAULT 0,
  `wage` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faction_ranks`
--

LOCK TABLES `faction_ranks` WRITE;
/*!40000 ALTER TABLE `faction_ranks` DISABLE KEYS */;
/*!40000 ALTER TABLE `faction_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factions`
--

DROP TABLE IF EXISTS `factions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `bankbalance` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `rank_order` text DEFAULT NULL,
  `motd` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fnote` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `max_interiors` int(11) unsigned NOT NULL DEFAULT 20,
  `max_vehicles` int(11) unsigned NOT NULL DEFAULT 40,
  `free_custom_ints` tinyint(1) unsigned DEFAULT 0,
  `free_custom_skins` tinyint(1) unsigned DEFAULT 0,
  `before_tax_value` int(6) NOT NULL DEFAULT 0,
  `before_wage_charge` int(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factions`
--

LOCK TABLES `factions` WRITE;
/*!40000 ALTER TABLE `factions` DISABLE KEYS */;
/*!40000 ALTER TABLE `factions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uploaded_by` int(11) DEFAULT NULL,
  `file` mediumblob NOT NULL,
  `file_type` varchar(64) NOT NULL,
  `file_size` int(10) unsigned NOT NULL,
  `dateline` datetime NOT NULL DEFAULT current_timestamp(),
  `connected_interior` int(11) DEFAULT NULL COMMENT 'The purpose of this field is to auto delete file record on interior delete.',
  `avatar_for_account` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `connected_interior_UNIQUE` (`connected_interior`),
  UNIQUE KEY `avatar_for_account_UNIQUE` (`avatar_for_account`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Store file up to 21MB per record / By Maxime / Consult with him if you''re unsure of something.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `force_apps`
--

DROP TABLE IF EXISTS `force_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `force_apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` int(11) DEFAULT NULL,
  `forceapp_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC COMMENT='Save forceapped players information to keep them from resubm';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `force_apps`
--

LOCK TABLES `force_apps` WRITE;
/*!40000 ALTER TABLE `force_apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `force_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `account_id` int(10) unsigned NOT NULL,
  `friend_account_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`account_id`,`friend_account_id`),
  UNIQUE KEY `friends_account_id_friend_account_id_unique` (`account_id`,`friend_account_id`),
  KEY `friends_friend_account_id_accounts_foreign` (`friend_account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fuelpeds`
--

DROP TABLE IF EXISTS `fuelpeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fuelpeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotZ` float NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `skin` int(3) DEFAULT 50,
  `name` varchar(50) NOT NULL,
  `deletedBy` int(11) DEFAULT 0,
  `shop_link` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fuelpeds`
--

LOCK TABLES `fuelpeds` WRITE;
/*!40000 ALTER TABLE `fuelpeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `fuelpeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gates`
--

DROP TABLE IF EXISTS `gates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `objectID` int(11) NOT NULL,
  `startX` float NOT NULL,
  `startY` float NOT NULL,
  `startZ` float NOT NULL,
  `startRX` float NOT NULL,
  `startRY` float NOT NULL,
  `startRZ` float NOT NULL,
  `endX` float NOT NULL,
  `endY` float NOT NULL,
  `endZ` float NOT NULL,
  `endRX` float NOT NULL,
  `endRY` float NOT NULL,
  `endRZ` float NOT NULL,
  `gateType` tinyint(3) unsigned NOT NULL,
  `autocloseTime` int(4) NOT NULL,
  `movementTime` int(4) NOT NULL,
  `objectDimension` int(11) NOT NULL,
  `objectInterior` int(11) NOT NULL,
  `gateSecurityParameters` text DEFAULT NULL,
  `creator` varchar(50) NOT NULL DEFAULT '',
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminNote` varchar(300) NOT NULL DEFAULT '',
  `triggerDistance` float DEFAULT NULL,
  `triggerDistanceVehicle` float DEFAULT NULL,
  `sound` varchar(50) DEFAULT 'metalgate',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gates`
--

LOCK TABLES `gates` WRITE;
/*!40000 ALTER TABLE `gates` DISABLE KEYS */;
/*!40000 ALTER TABLE `gates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_diagnose`
--

DROP TABLE IF EXISTS `health_diagnose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `health_diagnose` (
  `uniqueID` int(11) DEFAULT NULL,
  `int_diagnose` varchar(255) DEFAULT NULL,
  `ext_diagnose` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_diagnose`
--

LOCK TABLES `health_diagnose` WRITE;
/*!40000 ALTER TABLE `health_diagnose` DISABLE KEYS */;
/*!40000 ALTER TABLE `health_diagnose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance_data`
--

DROP TABLE IF EXISTS `insurance_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_data` (
  `policyid` int(11) NOT NULL AUTO_INCREMENT,
  `customername` varchar(45) NOT NULL,
  `vehicleid` int(11) NOT NULL,
  `protection` varchar(45) NOT NULL,
  `deductible` int(11) NOT NULL,
  `date` date NOT NULL,
  `claims` float NOT NULL,
  `cashout` float NOT NULL,
  `premium` int(11) NOT NULL,
  `insurancefaction` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`policyid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_data`
--

LOCK TABLES `insurance_data` WRITE;
/*!40000 ALTER TABLE `insurance_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurance_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance_factions`
--

DROP TABLE IF EXISTS `insurance_factions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_factions` (
  `factionID` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `gen_maxi` float NOT NULL DEFAULT 0.005,
  `news` text DEFAULT NULL,
  `subscription` text DEFAULT NULL,
  PRIMARY KEY (`factionID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_factions`
--

LOCK TABLES `insurance_factions` WRITE;
/*!40000 ALTER TABLE `insurance_factions` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurance_factions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interior_business`
--

DROP TABLE IF EXISTS `interior_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interior_business` (
  `intID` int(11) NOT NULL,
  `businessNote` varchar(101) NOT NULL DEFAULT 'Welcome to our business!',
  PRIMARY KEY (`intID`),
  UNIQUE KEY `intID_UNIQUE` (`intID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Saves info about businesses - Maxime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interior_business`
--

LOCK TABLES `interior_business` WRITE;
/*!40000 ALTER TABLE `interior_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `interior_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interior_logs`
--

DROP TABLE IF EXISTS `interior_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interior_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `intID` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `actor` int(11) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_interior` (`intID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores all admin actions on interiors - Monitored by Interio';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interior_logs`
--

LOCK TABLES `interior_logs` WRITE;
/*!40000 ALTER TABLE `interior_logs` DISABLE KEYS */;
INSERT INTO `interior_logs` VALUES (1,'2026-02-17 20:10:43',1,'Entered',1),(2,'2026-02-17 20:10:43',1,'gotohouse',1),(3,'2026-02-17 20:10:44',1,'Entered',1),(4,'2026-02-17 20:10:44',1,'gotohouse',1),(5,'2026-02-17 20:10:50',1,'Entered',1),(6,'2026-02-17 20:12:17',1,'Entered',1),(7,'2026-02-17 20:12:17',1,'gotohouse',1);
/*!40000 ALTER TABLE `interior_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interior_notes`
--

DROP TABLE IF EXISTS `interior_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interior_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intid` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `note` varchar(500) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interior_notes`
--

LOCK TABLES `interior_notes` WRITE;
/*!40000 ALTER TABLE `interior_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `interior_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interior_textures`
--

DROP TABLE IF EXISTS `interior_textures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interior_textures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interior` int(11) NOT NULL,
  `texture` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `rotation` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interior_textures`
--

LOCK TABLES `interior_textures` WRITE;
/*!40000 ALTER TABLE `interior_textures` DISABLE KEYS */;
/*!40000 ALTER TABLE `interior_textures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interiors`
--

DROP TABLE IF EXISTS `interiors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interiors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT 0,
  `y` float DEFAULT 0,
  `z` float DEFAULT 0,
  `type` int(1) DEFAULT 0,
  `owner` int(11) DEFAULT -1,
  `locked` int(1) DEFAULT 0,
  `cost` int(11) DEFAULT 0,
  `name` text DEFAULT NULL,
  `interior` int(5) DEFAULT 0,
  `interiorx` float DEFAULT 0,
  `interiory` float DEFAULT 0,
  `interiorz` float DEFAULT 0,
  `dimensionwithin` int(5) DEFAULT 0,
  `interiorwithin` int(5) DEFAULT 0,
  `angle` float DEFAULT 0,
  `angleexit` float DEFAULT 0,
  `supplies` text DEFAULT NULL,
  `safepositionX` float DEFAULT NULL,
  `safepositionY` float DEFAULT NULL,
  `safepositionZ` float DEFAULT NULL,
  `safepositionRZ` float DEFAULT NULL,
  `disabled` tinyint(3) unsigned DEFAULT 0,
  `lastused` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` varchar(45) NOT NULL DEFAULT '0',
  `deletedDate` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL DEFAULT current_timestamp(),
  `creator` varchar(45) DEFAULT NULL,
  `isLightOn` tinyint(4) NOT NULL DEFAULT 0,
  `keypad_lock` int(11) DEFAULT NULL,
  `keypad_lock_pw` varchar(32) DEFAULT NULL,
  `keypad_lock_auto` tinyint(1) DEFAULT NULL,
  `faction` int(11) DEFAULT 0,
  `protected_until` datetime DEFAULT NULL,
  `furniture` int(1) NOT NULL DEFAULT 1,
  `interior_id` int(11) DEFAULT NULL,
  `tokenUsed` int(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interiors`
--

LOCK TABLES `interiors` WRITE;
/*!40000 ALTER TABLE `interiors` DISABLE KEYS */;
INSERT INTO `interiors` VALUES (1,1171.5,-1413.5,13.5,0,-1,0,25000,'Baslangic Evi',1,223.2,1287.08,10.82,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,'2026-02-17 12:12:17','0',NULL,'2026-02-17 11:28:34',NULL,0,NULL,NULL,NULL,0,NULL,1,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `interiors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ippc_airline_pilots`
--

DROP TABLE IF EXISTS `ippc_airline_pilots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ippc_airline_pilots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `airline` int(11) NOT NULL,
  `character` int(11) NOT NULL,
  `leader` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ippc_airline_pilots`
--

LOCK TABLES `ippc_airline_pilots` WRITE;
/*!40000 ALTER TABLE `ippc_airline_pilots` DISABLE KEYS */;
/*!40000 ALTER TABLE `ippc_airline_pilots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ippc_airlines`
--

DROP TABLE IF EXISTS `ippc_airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ippc_airlines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ippc_airlines`
--

LOCK TABLES `ippc_airlines` WRITE;
/*!40000 ALTER TABLE `ippc_airlines` DISABLE KEYS */;
/*!40000 ALTER TABLE `ippc_airlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ippc_flights`
--

DROP TABLE IF EXISTS `ippc_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ippc_flights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `callsign` varchar(50) NOT NULL,
  `adep` varchar(50) NOT NULL,
  `ades` varchar(50) NOT NULL,
  `etd` datetime NOT NULL,
  `eta` datetime DEFAULT NULL,
  `vin` int(11) NOT NULL,
  `pilot1` int(11) DEFAULT NULL,
  `pilot2` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `airline` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `tickets` tinyint(1) NOT NULL,
  `seats1` int(3) DEFAULT NULL,
  `seats2` int(3) DEFAULT NULL,
  `seats3` int(3) DEFAULT NULL,
  `price1` int(3) DEFAULT NULL,
  `price2` int(3) DEFAULT NULL,
  `price3` int(3) DEFAULT NULL,
  `submitter` int(11) NOT NULL,
  `submitted` datetime NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ippc_flights`
--

LOCK TABLES `ippc_flights` WRITE;
/*!40000 ALTER TABLE `ippc_flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `ippc_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `index` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL,
  `owner` int(10) unsigned NOT NULL,
  `itemID` int(10) NOT NULL,
  `itemValue` varchar(255) NOT NULL,
  `protected` int(100) NOT NULL DEFAULT 0,
  `metadata` text DEFAULT NULL COMMENT 'additional data for the item that can be edited per individual item, JSON',
  PRIMARY KEY (`index`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,1,1,16,'7',0,'[ [ ] ]'),(2,1,1,17,'1',0,'[ [ ] ]'),(3,1,1,262,'1',0,'[ [ ] ]'),(4,1,1,263,'1',0,'[ [ ] ]'),(5,1,1,152,'Taylor_Jakson;Male;January 1st, 2010;EEBEE9E46C7227AF50C792FF56AB82F2',0,'[ [ ] ]'),(6,1,1,160,'1',0,'[ [ ] ]'),(7,1,1,2,'736239',0,'[ [ ] ]'),(30,1,1,134,'500',0,'[ [ ] ]'),(9,1,2,16,'23',0,'[ [ ] ]'),(10,1,2,17,'1',0,'[ [ ] ]'),(11,1,2,262,'1',0,'[ [ ] ]'),(12,1,2,263,'1',0,'[ [ ] ]'),(13,1,2,152,'Kerem_I;Male;January 1st, 2010;131C6DB43386CD8131716E612C031A49',0,'[ [ ] ]'),(14,1,2,160,'1',0,'[ [ ] ]'),(15,1,2,2,'591007',0,'[ [ ] ]'),(23,1,2,134,'500',0,'[ [ ] ]');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jailed`
--

DROP TABLE IF EXISTS `jailed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jailed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `charactername` text NOT NULL,
  `jail_time` bigint(12) NOT NULL,
  `jail_time_online` int(10) NOT NULL DEFAULT 0,
  `convictionDate` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedBy` text NOT NULL,
  `charges` text NOT NULL,
  `cell` text NOT NULL,
  `fine` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jailed`
--

LOCK TABLES `jailed` WRITE;
/*!40000 ALTER TABLE `jailed` DISABLE KEYS */;
/*!40000 ALTER TABLE `jailed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `jobID` int(11) NOT NULL DEFAULT 0,
  `jobCharID` int(11) NOT NULL DEFAULT -1,
  `jobLevel` int(11) NOT NULL DEFAULT 1,
  `jobProgress` int(11) NOT NULL DEFAULT 0,
  `jobTruckingRuns` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC COMMENT='Saves job info, skill level and progress - Maxime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs_trucker_orders`
--

DROP TABLE IF EXISTS `jobs_trucker_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs_trucker_orders` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `orderX` float NOT NULL DEFAULT 0,
  `orderY` float NOT NULL DEFAULT 0,
  `orderZ` float NOT NULL DEFAULT 0,
  `orderName` text NOT NULL,
  `orderInterior` int(11) NOT NULL DEFAULT 0,
  `orderSupplies` text DEFAULT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Saves info about customer orders to create markers for truck';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs_trucker_orders`
--

LOCK TABLES `jobs_trucker_orders` WRITE;
/*!40000 ALTER TABLE `jobs_trucker_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs_trucker_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leo_impound_lot`
--

DROP TABLE IF EXISTS `leo_impound_lot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leo_impound_lot` (
  `lane` int(11) NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `int` float NOT NULL,
  `dim` float NOT NULL,
  `faction` int(11) NOT NULL,
  `veh` int(11) NOT NULL DEFAULT 0,
  `fine` int(11) NOT NULL DEFAULT 0,
  `release_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`lane`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leo_impound_lot`
--

LOCK TABLES `leo_impound_lot` WRITE;
/*!40000 ALTER TABLE `leo_impound_lot` DISABLE KEYS */;
/*!40000 ALTER TABLE `leo_impound_lot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lift_floors`
--

DROP TABLE IF EXISTS `lift_floors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lift_floors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lift` int(11) NOT NULL,
  `x` float(10,6) DEFAULT 0.000000,
  `y` float(10,6) DEFAULT 0.000000,
  `z` float(10,6) DEFAULT 0.000000,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `floor` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lift_floors`
--

LOCK TABLES `lift_floors` WRITE;
/*!40000 ALTER TABLE `lift_floors` DISABLE KEYS */;
/*!40000 ALTER TABLE `lift_floors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lifts`
--

DROP TABLE IF EXISTS `lifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lifts`
--

LOCK TABLES `lifts` WRITE;
/*!40000 ALTER TABLE `lifts` DISABLE KEYS */;
/*!40000 ALTER TABLE `lifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lottery`
--

DROP TABLE IF EXISTS `lottery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lottery` (
  `characterid` int(255) NOT NULL,
  `ticketnumber` int(3) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lottery`
--

LOCK TABLES `lottery` WRITE;
/*!40000 ALTER TABLE `lottery` DISABLE KEYS */;
/*!40000 ALTER TABLE `lottery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `preview` text NOT NULL,
  `purposes` text NOT NULL,
  `used_by` text NOT NULL,
  `reasons` text NOT NULL,
  `approved` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `uploader` int(10) unsigned NOT NULL,
  `type` varchar(45) NOT NULL DEFAULT 'exterior',
  `upload_date` datetime NOT NULL DEFAULT current_timestamp(),
  `reviewer` int(10) unsigned DEFAULT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maps`
--

LOCK TABLES `maps` WRITE;
/*!40000 ALTER TABLE `maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maps_objects`
--

DROP TABLE IF EXISTS `maps_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maps_objects` (
  `index` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `map_id` int(10) unsigned NOT NULL,
  `id` text DEFAULT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) DEFAULT NULL,
  `collisions` tinyint(1) DEFAULT NULL,
  `breakable` tinyint(1) DEFAULT NULL,
  `radius` double unsigned DEFAULT NULL,
  `model` int(10) unsigned NOT NULL,
  `lodModel` int(10) unsigned DEFAULT NULL,
  `posX` double NOT NULL,
  `posY` double NOT NULL,
  `posZ` double NOT NULL,
  `rotX` double NOT NULL,
  `rotY` double NOT NULL,
  `rotZ` double NOT NULL,
  `doublesided` tinyint(1) unsigned DEFAULT NULL,
  `scale` double unsigned DEFAULT NULL,
  `alpha` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`index`),
  UNIQUE KEY `index_UNIQUE` (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maps_objects`
--

LOCK TABLES `maps_objects` WRITE;
/*!40000 ALTER TABLE `maps_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `maps_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_apb`
--

DROP TABLE IF EXISTS `mdc_apb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_apb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_involved` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `doneby` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `organization` varchar(10) NOT NULL DEFAULT 'LSPD',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_apb`
--

LOCK TABLES `mdc_apb` WRITE;
/*!40000 ALTER TABLE `mdc_apb` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_apb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_calls`
--

DROP TABLE IF EXISTS `mdc_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caller` varchar(50) NOT NULL,
  `number` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_calls`
--

LOCK TABLES `mdc_calls` WRITE;
/*!40000 ALTER TABLE `mdc_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_crimes`
--

DROP TABLE IF EXISTS `mdc_crimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_crimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crime` varchar(255) NOT NULL,
  `punishment` varchar(255) NOT NULL,
  `character` int(11) NOT NULL,
  `officer` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_crimes`
--

LOCK TABLES `mdc_crimes` WRITE;
/*!40000 ALTER TABLE `mdc_crimes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_crimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_criminals`
--

DROP TABLE IF EXISTS `mdc_criminals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_criminals` (
  `character` int(11) NOT NULL,
  `dob` varchar(10) NOT NULL DEFAULT 'mm/dd/yyyy',
  `ethnicity` varchar(50) NOT NULL DEFAULT 'Unknown',
  `phone` varchar(10) NOT NULL DEFAULT 'Unknown',
  `occupation` varchar(50) NOT NULL DEFAULT 'Unknown',
  `address` varchar(50) NOT NULL DEFAULT 'Unknown',
  `photo` int(11) NOT NULL DEFAULT -1,
  `details` text DEFAULT 'None.',
  `created_by` int(11) NOT NULL DEFAULT 0,
  `wanted` int(11) NOT NULL DEFAULT 0,
  `wanted_by` int(11) NOT NULL DEFAULT 0,
  `wanted_details` varchar(255) DEFAULT NULL,
  `pilot_details` varchar(255) DEFAULT NULL,
  UNIQUE KEY `name` (`character`),
  KEY `phone` (`phone`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_criminals`
--

LOCK TABLES `mdc_criminals` WRITE;
/*!40000 ALTER TABLE `mdc_criminals` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_criminals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_dmv`
--

DROP TABLE IF EXISTS `mdc_dmv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_dmv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vehicle` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  UNIQUE KEY `entryid` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_dmv`
--

LOCK TABLES `mdc_dmv` WRITE;
/*!40000 ALTER TABLE `mdc_dmv` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_dmv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_faa_events`
--

DROP TABLE IF EXISTS `mdc_faa_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_faa_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crime` varchar(255) NOT NULL,
  `punishment` varchar(255) NOT NULL,
  `character` int(11) NOT NULL,
  `officer` varchar(100) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_faa_events`
--

LOCK TABLES `mdc_faa_events` WRITE;
/*!40000 ALTER TABLE `mdc_faa_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_faa_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_faa_licenses`
--

DROP TABLE IF EXISTS `mdc_faa_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_faa_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `license` int(2) NOT NULL,
  `value` int(4) DEFAULT NULL,
  `officer` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_faa_licenses`
--

LOCK TABLES `mdc_faa_licenses` WRITE;
/*!40000 ALTER TABLE `mdc_faa_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_faa_licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_groups`
--

DROP TABLE IF EXISTS `mdc_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_groups` (
  `faction_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `haveMdcInAllVehicles` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeeWarrants` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeeCalls` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canAddAPB` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeeVehicles` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeeProperties` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeeLicenses` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `canSeePilotStuff` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `impound_can_see` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `settingUsernameFormat` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`faction_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `faction_id_UNIQUE` (`faction_id`),
  KEY `idx_idx` (`faction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='User group''s permissions based on factions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_groups`
--

LOCK TABLES `mdc_groups` WRITE;
/*!40000 ALTER TABLE `mdc_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_impounds`
--

DROP TABLE IF EXISTS `mdc_impounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_impounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `veh` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `reporter` text DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_impounds`
--

LOCK TABLES `mdc_impounds` WRITE;
/*!40000 ALTER TABLE `mdc_impounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_impounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_users`
--

DROP TABLE IF EXISTS `mdc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(11) unsigned NOT NULL,
  `level` int(11) unsigned NOT NULL,
  `organization` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_users`
--

LOCK TABLES `mdc_users` WRITE;
/*!40000 ALTER TABLE `mdc_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdc_users_old`
--

DROP TABLE IF EXISTS `mdc_users_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdc_users_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(30) NOT NULL,
  `pass` varchar(60) NOT NULL,
  `level` int(11) NOT NULL,
  `organization` varchar(30) NOT NULL DEFAULT 'LSPD',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdc_users_old`
--

LOCK TABLES `mdc_users_old` WRITE;
/*!40000 ALTER TABLE `mdc_users_old` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdc_users_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(45) DEFAULT NULL,
  `migration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`resource`,`migration`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'interior_system',1),(2,'interior_system',2),(3,'interior_system',3),(4,'mdc',1),(5,'npc',1),(6,'vehicle_manager',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_payments`
--

DROP TABLE IF EXISTS `mobile_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_payments` (
  `payment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sender_phone` varchar(45) NOT NULL,
  `operator` varchar(45) DEFAULT 'N/A',
  `country` varchar(45) DEFAULT 'N/A',
  `game_coin` int(11) unsigned NOT NULL DEFAULT 0,
  `account` int(11) unsigned NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'USD',
  `cost` double NOT NULL DEFAULT 0,
  `revenue` double NOT NULL DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `transaction_id` varchar(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `payment_id_UNIQUE` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_payments`
--

LOCK TABLES `mobile_payments` WRITE;
/*!40000 ALTER TABLE `mobile_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motd_read`
--

DROP TABLE IF EXISTS `motd_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motd_read` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motdid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Note down everyone that read and dismissed the motd.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motd_read`
--

LOCK TABLES `motd_read` WRITE;
/*!40000 ALTER TABLE `motd_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `motd_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motds`
--

DROP TABLE IF EXISTS `motds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `content` text NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `expiration_date` datetime DEFAULT NULL,
  `author` int(11) DEFAULT NULL,
  `dismissable` tinyint(1) NOT NULL DEFAULT 1,
  `audiences` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motds`
--

LOCK TABLES `motds` WRITE;
/*!40000 ALTER TABLE `motds` DISABLE KEYS */;
/*!40000 ALTER TABLE `motds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'other',
  PRIMARY KEY (`id`),
  KEY `notification_user` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(6) NOT NULL DEFAULT 0,
  `posX` float(12,7) NOT NULL DEFAULT 0.0000000,
  `posY` float(12,7) NOT NULL DEFAULT 0.0000000,
  `posZ` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotX` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotY` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotZ` float(12,7) NOT NULL DEFAULT 0.0000000,
  `interior` int(5) NOT NULL,
  `dimension` int(5) NOT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `solid` int(1) NOT NULL DEFAULT 1,
  `doublesided` int(1) NOT NULL DEFAULT 0,
  `scale` float(12,7) DEFAULT NULL,
  `breakable` int(1) NOT NULL DEFAULT 0,
  `alpha` int(11) NOT NULL DEFAULT 255,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online_sessions`
--

DROP TABLE IF EXISTS `online_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `online_sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff` int(10) unsigned NOT NULL,
  `minutes_online` int(10) unsigned NOT NULL DEFAULT 0,
  `minutes_duty` int(10) unsigned NOT NULL DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_sessions`
--

LOCK TABLES `online_sessions` WRITE;
/*!40000 ALTER TABLE `online_sessions` DISABLE KEYS */;
INSERT INTO `online_sessions` VALUES (1,2,5,4,'2026-02-17 07:10:09'),(2,1,5,4,'2026-02-17 07:10:17'),(3,2,5,5,'2026-02-17 07:15:09'),(4,1,5,0,'2026-02-17 07:15:17'),(5,2,5,5,'2026-02-17 07:24:14'),(6,1,5,0,'2026-02-17 07:24:53'),(7,2,5,5,'2026-02-17 07:29:14'),(8,1,5,0,'2026-02-17 07:29:53'),(9,2,5,5,'2026-02-17 07:34:14'),(10,1,5,0,'2026-02-17 07:34:53'),(11,2,5,5,'2026-02-17 07:39:14'),(12,1,5,0,'2026-02-17 07:39:53'),(13,2,5,5,'2026-02-17 07:44:14'),(14,1,5,0,'2026-02-17 07:44:53'),(15,2,5,2,'2026-02-17 07:49:14'),(16,1,5,0,'2026-02-17 07:49:54'),(17,2,5,0,'2026-02-17 07:54:14'),(18,1,5,0,'2026-02-17 07:54:54'),(19,2,5,0,'2026-02-17 07:59:14'),(20,1,5,0,'2026-02-17 07:59:54'),(21,2,5,0,'2026-02-17 08:04:14'),(22,1,5,2,'2026-02-17 08:04:54'),(23,2,5,0,'2026-02-17 08:09:14'),(24,1,5,5,'2026-02-17 08:09:54'),(25,2,5,0,'2026-02-17 08:14:14'),(26,2,5,0,'2026-02-17 08:19:14'),(27,1,5,5,'2026-02-17 08:21:06'),(28,2,5,0,'2026-02-17 08:24:14'),(29,1,5,5,'2026-02-17 08:26:06'),(30,2,5,0,'2026-02-17 08:29:14'),(31,1,5,5,'2026-02-17 08:31:06'),(32,2,5,0,'2026-02-17 08:34:14'),(33,1,5,5,'2026-02-17 08:36:06'),(34,1,5,5,'2026-02-17 08:44:34'),(35,2,5,5,'2026-02-17 08:45:45'),(36,2,5,5,'2026-02-17 08:50:45'),(37,1,5,5,'2026-02-17 08:59:27'),(38,1,5,5,'2026-02-17 09:04:27'),(39,1,5,5,'2026-02-17 09:09:27'),(40,1,5,1,'2026-02-17 09:14:28'),(41,1,5,0,'2026-02-17 09:19:28'),(42,1,5,0,'2026-02-17 09:24:28'),(43,1,5,0,'2026-02-17 09:29:28'),(44,1,5,0,'2026-02-17 10:44:47'),(45,1,5,0,'2026-02-17 10:49:47'),(46,1,5,0,'2026-02-17 10:54:47'),(47,1,5,0,'2026-02-17 11:22:07'),(48,1,5,0,'2026-02-17 11:42:15'),(49,1,5,0,'2026-02-17 11:50:53'),(50,1,5,0,'2026-02-17 11:55:53'),(51,1,5,0,'2026-02-17 12:03:47'),(52,1,5,0,'2026-02-17 12:08:48'),(53,1,5,0,'2026-02-17 12:13:48'),(54,1,5,0,'2026-02-17 12:18:48'),(55,1,5,0,'2026-02-17 12:23:48');
/*!40000 ALTER TABLE `online_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paynspray`
--

DROP TABLE IF EXISTS `paynspray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paynspray` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` decimal(10,6) DEFAULT 0.000000,
  `y` decimal(10,6) DEFAULT 0.000000,
  `z` decimal(10,6) DEFAULT 0.000000,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paynspray`
--

LOCK TABLES `paynspray` WRITE;
/*!40000 ALTER TABLE `paynspray` DISABLE KEYS */;
/*!40000 ALTER TABLE `paynspray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pd_tickets`
--

DROP TABLE IF EXISTS `pd_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pd_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehid` int(11) NOT NULL,
  `reason` text NOT NULL,
  `amount` int(11) NOT NULL,
  `issuer` int(11) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pd_tickets`
--

LOCK TABLES `pd_tickets` WRITE;
/*!40000 ALTER TABLE `pd_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `pd_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peds`
--

DROP TABLE IF EXISTS `peds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `behaviour` int(3) DEFAULT 1,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotation` float NOT NULL,
  `interior` int(5) NOT NULL,
  `dimension` int(5) NOT NULL,
  `skin` int(1) DEFAULT NULL,
  `money` bigint(20) NOT NULL DEFAULT 0,
  `gender` int(1) DEFAULT NULL,
  `stats` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `owner_type` int(1) NOT NULL DEFAULT 0,
  `owner` int(11) DEFAULT NULL,
  `animation` varchar(255) DEFAULT NULL,
  `synced` tinyint(1) NOT NULL DEFAULT 0,
  `nametag` tinyint(1) NOT NULL DEFAULT 1,
  `frozen` tinyint(1) NOT NULL DEFAULT 0,
  `comment` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peds`
--

LOCK TABLES `peds` WRITE;
/*!40000 ALTER TABLE `peds` DISABLE KEYS */;
/*!40000 ALTER TABLE `peds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_contacts`
--

DROP TABLE IF EXISTS `phone_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` bigint(50) NOT NULL,
  `entryName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `entryNumber` varchar(50) NOT NULL,
  `entryEmail` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `entryAddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `entryFavorited` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_contacts`
--

LOCK TABLES `phone_contacts` WRITE;
/*!40000 ALTER TABLE `phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_history`
--

DROP TABLE IF EXISTS `phone_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(50) NOT NULL,
  `to` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 1,
  `date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `private` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_history`
--

LOCK TABLES `phone_history` WRITE;
/*!40000 ALTER TABLE `phone_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_sms`
--

DROP TABLE IF EXISTS `phone_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(50) NOT NULL,
  `to` varchar(50) NOT NULL,
  `content` varchar(200) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `viewed` tinyint(1) NOT NULL DEFAULT 0,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_sms`
--

LOCK TABLES `phone_sms` WRITE;
/*!40000 ALTER TABLE `phone_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones` (
  `phonenumber` int(9) NOT NULL,
  `turnedon` smallint(1) NOT NULL DEFAULT 1,
  `secretnumber` smallint(1) NOT NULL DEFAULT 0,
  `phonebook` varchar(40) NOT NULL DEFAULT '0',
  `ringtone` smallint(1) NOT NULL DEFAULT 3,
  `contact_limit` int(5) NOT NULL DEFAULT 50,
  `boughtby` int(11) NOT NULL DEFAULT -1,
  `bought_date` datetime NOT NULL DEFAULT current_timestamp(),
  `sms_tone` smallint(1) NOT NULL DEFAULT 7,
  `keypress_tone` smallint(1) NOT NULL DEFAULT 1,
  `tone_volume` smallint(2) NOT NULL DEFAULT 10,
  PRIMARY KEY (`phonenumber`),
  UNIQUE KEY `phonenumber_UNIQUE` (`phonenumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
INSERT INTO `phones` VALUES (736239,1,0,'0',3,50,-1,'2026-02-17 08:07:19',7,1,10);
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilot_notams`
--

DROP TABLE IF EXISTS `pilot_notams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilot_notams` (
  `id` int(11) NOT NULL,
  `information` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilot_notams`
--

LOCK TABLES `pilot_notams` WRITE;
/*!40000 ALTER TABLE `pilot_notams` DISABLE KEYS */;
/*!40000 ALTER TABLE `pilot_notams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicphones`
--

DROP TABLE IF EXISTS `publicphones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publicphones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `dimension` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicphones`
--

LOCK TABLES `publicphones` WRITE;
/*!40000 ALTER TABLE `publicphones` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicphones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radio_stations`
--

DROP TABLE IF EXISTS `radio_stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radio_stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_name` text DEFAULT NULL,
  `source` text DEFAULT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `register_date` datetime DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `order` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Dynamic radio stations.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radio_stations`
--

LOCK TABLES `radio_stations` WRITE;
/*!40000 ALTER TABLE `radio_stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `radio_stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramps`
--

DROP TABLE IF EXISTS `ramps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramps` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `position` text DEFAULT NULL,
  `interior` int(2) DEFAULT NULL,
  `dimension` int(2) DEFAULT NULL,
  `rotation` int(5) DEFAULT NULL,
  `creator` text DEFAULT NULL,
  `liftposition` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramps`
--

LOCK TABLES `ramps` WRITE;
/*!40000 ALTER TABLE `ramps` DISABLE KEYS */;
/*!40000 ALTER TABLE `ramps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `handler` int(11) NOT NULL,
  `reporter` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restricted_freqs`
--

DROP TABLE IF EXISTS `restricted_freqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restricted_freqs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `frequency` text DEFAULT NULL,
  `limitedto` int(5) DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricted_freqs`
--

LOCK TABLES `restricted_freqs` WRITE;
/*!40000 ALTER TABLE `restricted_freqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `restricted_freqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sapt_destinations`
--

DROP TABLE IF EXISTS `sapt_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sapt_destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `destinationID` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sapt_destinations`
--

LOCK TABLES `sapt_destinations` WRITE;
/*!40000 ALTER TABLE `sapt_destinations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sapt_destinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sapt_locations`
--

DROP TABLE IF EXISTS `sapt_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sapt_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route` int(11) NOT NULL,
  `stopID` int(11) NOT NULL,
  `name` text NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sapt_locations`
--

LOCK TABLES `sapt_locations` WRITE;
/*!40000 ALTER TABLE `sapt_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sapt_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sapt_routes`
--

DROP TABLE IF EXISTS `sapt_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sapt_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line` int(11) NOT NULL,
  `route` int(11) NOT NULL,
  `destination` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sapt_routes`
--

LOCK TABLES `sapt_routes` WRITE;
/*!40000 ALTER TABLE `sapt_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sapt_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serial_whitelist`
--

DROP TABLE IF EXISTS `serial_whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `serial` varchar(32) NOT NULL,
  `creation_date` datetime DEFAULT current_timestamp(),
  `last_login_ip` varchar(15) DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `serial_whitelist_userid_4b8e2882_uniq` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serial_whitelist`
--

LOCK TABLES `serial_whitelist` WRITE;
/*!40000 ALTER TABLE `serial_whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `serial_whitelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'tax','15'),(2,'incometax','10'),(3,'lottery','0'),(4,'lotteryNumber','18');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sfia_pilots`
--

DROP TABLE IF EXISTS `sfia_pilots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sfia_pilots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charactername` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sfia_pilots`
--

LOCK TABLES `sfia_pilots` WRITE;
/*!40000 ALTER TABLE `sfia_pilots` DISABLE KEYS */;
/*!40000 ALTER TABLE `sfia_pilots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_contacts_info`
--

DROP TABLE IF EXISTS `shop_contacts_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_contacts_info` (
  `npcID` int(11) NOT NULL,
  `sOwner` varchar(255) DEFAULT NULL,
  `sPhone` varchar(255) DEFAULT NULL,
  `sEmail` varchar(255) DEFAULT NULL,
  `sForum` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`npcID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Saves data about business''s owners in shop system - MAXIME';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_contacts_info`
--

LOCK TABLES `shop_contacts_info` WRITE;
/*!40000 ALTER TABLE `shop_contacts_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_contacts_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_products`
--

DROP TABLE IF EXISTS `shop_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_products` (
  `npcID` int(11) DEFAULT NULL,
  `pItemID` int(11) DEFAULT NULL,
  `pItemValue` varchar(500) DEFAULT NULL,
  `pMetadata` text DEFAULT NULL,
  `pDesc` varchar(500) DEFAULT NULL,
  `pPrice` int(11) DEFAULT NULL,
  `pDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `pQuantity` int(11) NOT NULL DEFAULT 1,
  `pSetQuantity` int(11) NOT NULL DEFAULT 1,
  `pRestockInterval` int(11) DEFAULT 0,
  `pRestockedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`pID`),
  UNIQUE KEY `pID_UNIQUE` (`pID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Saves on-sale products from players, business system by Maxi';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_products`
--

LOCK TABLES `shop_products` WRITE;
/*!40000 ALTER TABLE `shop_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT 0,
  `y` float DEFAULT 0,
  `z` float DEFAULT 0,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `shoptype` tinyint(4) DEFAULT 0,
  `rotationz` float NOT NULL DEFAULT 0,
  `skin` varchar(50) DEFAULT NULL,
  `sPendingWage` int(11) NOT NULL DEFAULT 0,
  `sIncome` bigint(20) NOT NULL DEFAULT 0,
  `sCapacity` int(11) NOT NULL DEFAULT 10,
  `sSales` varchar(5000) NOT NULL DEFAULT '',
  `pedName` varchar(255) DEFAULT NULL,
  `faction_belong` int(11) NOT NULL DEFAULT 0,
  `faction_access` tinyint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speedcams`
--

DROP TABLE IF EXISTS `speedcams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `speedcams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float(11,7) NOT NULL DEFAULT 0.0000000,
  `y` float(11,7) NOT NULL DEFAULT 0.0000000,
  `z` float(11,7) NOT NULL DEFAULT 0.0000000,
  `interior` int(3) NOT NULL DEFAULT 0 COMMENT 'Stores the location of the pernament speedcams',
  `dimension` int(5) NOT NULL DEFAULT 0,
  `maxspeed` int(4) NOT NULL DEFAULT 120,
  `radius` int(4) NOT NULL DEFAULT 2,
  `enabled` smallint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speedcams`
--

LOCK TABLES `speedcams` WRITE;
/*!40000 ALTER TABLE `speedcams` DISABLE KEYS */;
/*!40000 ALTER TABLE `speedcams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speedingviolations`
--

DROP TABLE IF EXISTS `speedingviolations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `speedingviolations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carID` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `speed` int(5) NOT NULL,
  `area` varchar(50) NOT NULL,
  `personVisible` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speedingviolations`
--

LOCK TABLES `speedingviolations` WRITE;
/*!40000 ALTER TABLE `speedingviolations` DISABLE KEYS */;
/*!40000 ALTER TABLE `speedingviolations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_changelogs`
--

DROP TABLE IF EXISTS `staff_changelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_changelogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `from_rank` int(11) NOT NULL,
  `to_rank` int(11) DEFAULT NULL,
  `by` int(11) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Maxime 2015.01.08';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_changelogs`
--

LOCK TABLES `staff_changelogs` WRITE;
/*!40000 ALTER TABLE `staff_changelogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_changelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` decimal(10,6) DEFAULT NULL,
  `y` decimal(10,6) DEFAULT NULL,
  `z` decimal(10,6) DEFAULT NULL,
  `interior` int(5) DEFAULT NULL,
  `dimension` int(5) DEFAULT NULL,
  `rx` decimal(10,6) DEFAULT NULL,
  `ry` decimal(10,6) DEFAULT NULL,
  `rz` decimal(10,6) DEFAULT NULL,
  `modelid` int(5) DEFAULT NULL,
  `creationdate` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tempinteriors`
--

DROP TABLE IF EXISTS `tempinteriors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tempinteriors` (
  `id` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `interior` int(5) NOT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `uploaded_at` datetime NOT NULL,
  `amount_paid` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tempinteriors`
--

LOCK TABLES `tempinteriors` WRITE;
/*!40000 ALTER TABLE `tempinteriors` DISABLE KEYS */;
/*!40000 ALTER TABLE `tempinteriors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tempobjects`
--

DROP TABLE IF EXISTS `tempobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tempobjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(6) NOT NULL DEFAULT 0,
  `posX` float(12,7) NOT NULL DEFAULT 0.0000000,
  `posY` float(12,7) NOT NULL DEFAULT 0.0000000,
  `posZ` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotX` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotY` float(12,7) NOT NULL DEFAULT 0.0000000,
  `rotZ` float(12,7) NOT NULL DEFAULT 0.0000000,
  `interior` int(5) NOT NULL,
  `dimension` int(5) NOT NULL,
  `solid` int(1) NOT NULL DEFAULT 1,
  `doublesided` int(1) NOT NULL DEFAULT 0,
  `scale` float(12,7) NOT NULL DEFAULT 1.0000000,
  `breakable` int(1) NOT NULL DEFAULT 0,
  `alpha` tinyint(3) unsigned NOT NULL DEFAULT 255,
  PRIMARY KEY (`id`),
  KEY `dimension` (`dimension`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tempobjects`
--

LOCK TABLES `tempobjects` WRITE;
/*!40000 ALTER TABLE `tempobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `tempobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textures_animated`
--

DROP TABLE IF EXISTS `textures_animated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textures_animated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `frames` text NOT NULL,
  `speed` int(4) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textures_animated`
--

LOCK TABLES `textures_animated` WRITE;
/*!40000 ALTER TABLE `textures_animated` DISABLE KEYS */;
/*!40000 ALTER TABLE `textures_animated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `towstats`
--

DROP TABLE IF EXISTS `towstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `towstats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character` int(11) NOT NULL,
  `vehicle` int(11) DEFAULT NULL,
  `vehicle_plate` varchar(8) DEFAULT NULL COMMENT 'vehicle plate at the time of towing, if any',
  `date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'date of towing',
  PRIMARY KEY (`id`),
  KEY `character_idx` (`character`),
  KEY `vehicle_idx` (`vehicle`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Detailed information for TTR leaders who towed what and when';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `towstats`
--

LOCK TABLES `towstats` WRITE;
/*!40000 ALTER TABLE `towstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `towstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_auctions`
--

DROP TABLE IF EXISTS `vehicle_auctions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_auctions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `advertisement_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `starting_bid` int(11) NOT NULL,
  `minimum_increase` int(11) NOT NULL,
  `current_bid` int(11) DEFAULT NULL,
  `current_bidder_id` int(11) DEFAULT NULL COMMENT 'Character ID of current bidder.',
  `buyout` int(11) NOT NULL,
  `expiry` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_by_faction` int(11) DEFAULT NULL COMMENT 'Filled in when the vehicle belongs to a faction.',
  `awaiting_key_pickup` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'When the auction is completed, but the buyer has not picked up the car yet',
  PRIMARY KEY (`id`),
  KEY `vehicle_auctions_advertisement_id_index` (`advertisement_id`),
  KEY `vehicle_auctions_expiry_awaiting_key_pickup_index` (`expiry`,`awaiting_key_pickup`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_auctions`
--

LOCK TABLES `vehicle_auctions` WRITE;
/*!40000 ALTER TABLE `vehicle_auctions` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_auctions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_logs`
--

DROP TABLE IF EXISTS `vehicle_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vehID` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `actor` int(11) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_vehicle` (`vehID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores all admin actions on vehicles - Monitored by Vehicle ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_logs`
--

LOCK TABLES `vehicle_logs` WRITE;
/*!40000 ALTER TABLE `vehicle_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_notes`
--

DROP TABLE IF EXISTS `vehicle_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehid` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `note` varchar(500) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_notes`
--

LOCK TABLES `vehicle_notes` WRITE;
/*!40000 ALTER TABLE `vehicle_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(3) DEFAULT 0,
  `x` decimal(10,6) DEFAULT 0.000000,
  `y` decimal(10,6) DEFAULT 0.000000,
  `z` decimal(10,6) DEFAULT 0.000000,
  `rotx` decimal(10,6) DEFAULT 0.000000,
  `roty` decimal(10,6) DEFAULT 0.000000,
  `rotz` decimal(10,6) DEFAULT 0.000000,
  `currx` decimal(10,6) DEFAULT 0.000000,
  `curry` decimal(10,6) DEFAULT 0.000000,
  `currz` decimal(10,6) DEFAULT 0.000000,
  `currrx` decimal(10,6) DEFAULT 0.000000,
  `currry` decimal(10,6) DEFAULT 0.000000,
  `currrz` decimal(10,6) NOT NULL DEFAULT 0.000000,
  `fuel` int(3) DEFAULT 100,
  `engine` int(1) DEFAULT 0,
  `locked` int(1) DEFAULT 0,
  `lights` int(1) DEFAULT 0,
  `sirens` int(1) DEFAULT 0,
  `paintjob` int(11) DEFAULT 0,
  `hp` float DEFAULT 1000,
  `color1` varchar(50) DEFAULT '0',
  `color2` varchar(50) DEFAULT '0',
  `color3` varchar(50) DEFAULT NULL,
  `color4` varchar(50) DEFAULT NULL,
  `plate` text DEFAULT NULL,
  `faction` int(11) DEFAULT -1,
  `owner` int(11) DEFAULT -1,
  `job` int(11) DEFAULT -1,
  `tintedwindows` int(1) DEFAULT 0,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `currdimension` int(5) DEFAULT 0,
  `currinterior` int(5) DEFAULT 0,
  `enginebroke` int(1) DEFAULT 0,
  `items` text DEFAULT NULL,
  `itemvalues` text DEFAULT NULL,
  `Impounded` int(3) DEFAULT 0,
  `handbrake` int(1) DEFAULT 0,
  `safepositionX` float DEFAULT NULL,
  `safepositionY` float DEFAULT NULL,
  `safepositionZ` float DEFAULT NULL,
  `safepositionRZ` float DEFAULT NULL,
  `upgrades` varchar(150) DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]',
  `wheelStates` varchar(30) DEFAULT '[ [ 0, 0, 0, 0 ] ]',
  `panelStates` varchar(40) DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]',
  `doorStates` varchar(30) DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ] ]',
  `odometer` int(15) DEFAULT 0,
  `headlights` varchar(30) DEFAULT '[ [ 255, 255, 255 ] ]',
  `variant1` int(3) DEFAULT NULL,
  `variant2` int(3) DEFAULT NULL,
  `descriptionadmin` varchar(300) DEFAULT NULL,
  `description1` varchar(300) NOT NULL DEFAULT '',
  `description2` varchar(300) NOT NULL DEFAULT '',
  `description3` varchar(300) NOT NULL DEFAULT '',
  `description4` varchar(300) NOT NULL DEFAULT '',
  `description5` varchar(300) NOT NULL DEFAULT '',
  `suspensionLowerLimit` float DEFAULT NULL,
  `driveType` char(5) DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `deletedDate` datetime DEFAULT NULL,
  `chopped` tinyint(4) NOT NULL DEFAULT 0,
  `stolen` tinyint(4) NOT NULL DEFAULT 0,
  `lastUsed` datetime NOT NULL DEFAULT current_timestamp(),
  `creationDate` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `trackingdevice` varchar(255) DEFAULT NULL,
  `registered` int(2) NOT NULL DEFAULT 1,
  `show_plate` int(2) NOT NULL DEFAULT 1,
  `show_vin` int(2) NOT NULL DEFAULT 1,
  `paintjob_url` varchar(255) DEFAULT NULL,
  `vehicle_shop_id` int(11) DEFAULT NULL,
  `bulletproof` tinyint(4) NOT NULL DEFAULT 0,
  `textures` varchar(300) NOT NULL DEFAULT '[ [ ] ]',
  `business` int(11) NOT NULL DEFAULT -1,
  `protected_until` datetime DEFAULT NULL,
  `tokenUsed` int(1) NOT NULL DEFAULT 0,
  `settings` varchar(500) DEFAULT NULL,
  `hotwired` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,560,1544.700000,-1672.400000,13.500000,0.000000,0.000000,90.000000,1544.700000,-1672.400000,13.500000,0.000000,0.000000,0.000000,100,0,0,0,0,0,1000,'[[255,255,255]]','[[255,255,255]]','[[255,255,255]]','[[255,255,255]]',NULL,-1,-1,-1,0,0,0,0,0,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,'[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]','[[0,0,0,0]]','[[0,0,0,0,0,0,0]]','[[0,0,0,0,0,0]]',0,'[[255,255,255]]',NULL,NULL,NULL,'Sultan','','','','',NULL,NULL,0,NULL,0,0,'2026-02-17 12:13:54',NULL,NULL,NULL,1,1,1,NULL,NULL,0,'[[]]',-1,NULL,0,NULL,0);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_custom`
--

DROP TABLE IF EXISTS `vehicles_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `handling` varchar(1000) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tax` int(11) DEFAULT NULL,
  `createdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 0,
  `updatedate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `doortype` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_custom`
--

LOCK TABLES `vehicles_custom` WRITE;
/*!40000 ALTER TABLE `vehicles_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_shop`
--

DROP TABLE IF EXISTS `vehicles_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehmtamodel` int(11) DEFAULT 0,
  `vehbrand` varchar(255) DEFAULT NULL,
  `vehmodel` varchar(500) DEFAULT NULL,
  `vehyear` int(11) DEFAULT 2014,
  `vehprice` int(11) DEFAULT 0,
  `vehtax` int(11) DEFAULT 0,
  `createdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 0,
  `updatedate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 0,
  `notes` varchar(500) DEFAULT NULL,
  `handling` varchar(1000) DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 1000,
  `enabled` int(1) NOT NULL DEFAULT 0,
  `spawnto` tinyint(2) NOT NULL DEFAULT 0,
  `doortype` tinyint(4) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `spawn_rate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_shop`
--

LOCK TABLES `vehicles_shop` WRITE;
/*!40000 ALTER TABLE `vehicles_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiretransfers`
--

DROP TABLE IF EXISTS `wiretransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiretransfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` int(11) DEFAULT 0,
  `to` int(11) DEFAULT 0,
  `amount` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` int(11) NOT NULL,
  `from_card` varchar(45) DEFAULT NULL,
  `to_card` varchar(45) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiretransfers`
--

LOCK TABLES `wiretransfers` WRITE;
/*!40000 ALTER TABLE `wiretransfers` DISABLE KEYS */;
INSERT INTO `wiretransfers` VALUES (1,-17,1,63,'BANKINTEREST','2026-02-17 17:00:49',12,NULL,NULL,NULL),(2,-3,1,200,'STATEBENEFITS','2026-02-17 17:00:49',6,NULL,NULL,NULL),(3,-17,1,71,'BANKINTEREST','2026-02-17 20:00:24',12,NULL,NULL,NULL),(4,-3,1,200,'STATEBENEFITS','2026-02-17 20:00:24',6,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wiretransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worlditems`
--

DROP TABLE IF EXISTS `worlditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worlditems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) DEFAULT 0,
  `itemvalue` text DEFAULT NULL,
  `x` float DEFAULT 0,
  `y` float DEFAULT 0,
  `z` float DEFAULT 0,
  `dimension` int(5) DEFAULT 0,
  `interior` int(5) DEFAULT 0,
  `creationdate` datetime DEFAULT NULL,
  `rx` float DEFAULT 0,
  `ry` float DEFAULT 0,
  `rz` float DEFAULT 0,
  `creator` int(10) unsigned DEFAULT 0,
  `protected` int(100) NOT NULL DEFAULT 0,
  `perm_use` int(2) NOT NULL DEFAULT 1,
  `perm_move` int(2) NOT NULL DEFAULT 1,
  `perm_pickup` int(2) NOT NULL DEFAULT 1,
  `perm_use_data` text DEFAULT NULL,
  `perm_move_data` text DEFAULT NULL,
  `perm_pickup_data` text DEFAULT NULL,
  `useExactValues` int(1) NOT NULL DEFAULT 0,
  `metadata` text DEFAULT NULL COMMENT 'additional data for the item that can be edited per individual item, JSON',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worlditems`
--

LOCK TABLES `worlditems` WRITE;
/*!40000 ALTER TABLE `worlditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `worlditems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worlditems_data`
--

DROP TABLE IF EXISTS `worlditems_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worlditems_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xitem_idx` (`item`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worlditems_data`
--

LOCK TABLES `worlditems_data` WRITE;
/*!40000 ALTER TABLE `worlditems_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `worlditems_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-18  2:07:44
