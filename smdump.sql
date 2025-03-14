CREATE DATABASE  IF NOT EXISTS `socialmedia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `socialmedia`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: socialmedia
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_likes` (
  `username` varchar(255) NOT NULL,
  `comment_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `userlikescomment` varchar(255) NOT NULL,
  PRIMARY KEY (`username`,`comment_id`),
  KEY `comment_id` (`comment_id`),
  KEY `userlikescomment` (`userlikescomment`),
  CONSTRAINT `comment_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_likes_ibfk_3` FOREIGN KEY (`userlikescomment`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_likes`
--

LOCK TABLES `comment_likes` WRITE;
/*!40000 ALTER TABLE `comment_likes` DISABLE KEYS */;
INSERT INTO `comment_likes` VALUES ('alice_smith',2,'2023-12-09 07:09:20','bob_jones'),('bob_jones',3,'2023-12-09 07:09:20','emma_white'),('emma_white',4,'2023-12-09 07:09:20','ryan_miller'),('jessica_taylor',10,'2023-12-09 07:09:20','john_doe'),('kevin_jenkins',7,'2023-12-09 07:09:20','olivia_green'),('michael_black',9,'2023-12-09 07:09:20','jessica_taylor'),('olivia_green',8,'2023-12-09 07:09:20','michael_black'),('ryan_miller',5,'2023-12-09 07:09:20','sara_brown'),('sara_brown',6,'2023-12-09 07:09:20','kevin_jenkins');
/*!40000 ALTER TABLE `comment_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL,
  `comment_text` varchar(255) NOT NULL,
  `post_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`,`username`),
  KEY `fk_post_id_comments` (`post_id`),
  KEY `fk_username_comments` (`username`),
  KEY `idx_comment_id` (`comment_id`),
  CONSTRAINT `fk_post_id_comments` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_username_comments` FOREIGN KEY (`username`) REFERENCES `post` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (2,'Amazing view!',2,'bob_jones','2023-12-09 07:09:20'),(3,'Great shot!',3,'emma_white','2023-12-09 07:09:20'),(4,'Beautiful scenery!',4,'ryan_miller','2023-12-09 07:09:20'),(5,'Love it!',5,'sara_brown','2023-12-09 07:09:20'),(6,'So peaceful!',6,'kevin_jenkins','2023-12-09 07:09:20'),(7,'Urban vibes!',7,'olivia_green','2023-12-09 07:09:20'),(8,'Stunning!',8,'michael_black','2023-12-09 07:09:20'),(9,'Awesome video!',9,'jessica_taylor','2023-12-09 07:09:20'),(10,'Fantastic!',10,'john_doe','2023-12-09 07:09:20'),(11,'Great photo!',1,'alice_smith','2023-12-09 07:09:26');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_comment_insert` BEFORE INSERT ON `comments` FOR EACH ROW BEGIN
    IF LENGTH(NEW.comment_text) > 255 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Comment text exceeds the maximum length of 255 characters.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `login_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'john.doe@example.com','password123','2023-12-09 07:09:20'),(2,'alice.smith@example.com','pass456','2023-12-09 07:09:20'),(3,'bob.jones@example.com','secret789','2023-12-09 07:09:20'),(4,'emma.white@example.com','securePassword','2023-12-09 07:09:20'),(5,'ryan.miller@example.com','strongPass','2023-12-09 07:09:20'),(6,'sara.brown@example.com','password321','2023-12-09 07:09:20'),(7,'kevin.jenkins@example.com','passWord123','2023-12-09 07:09:20'),(8,'olivia.green@example.com','securePass123','2023-12-09 07:09:20'),(9,'michael.black@example.com','password987','2023-12-09 07:09:20'),(10,'jessica.taylor@example.com','pass456','2023-12-09 07:09:20'),(11,'new_user@example.com','new_password123','2023-12-09 07:09:26'),(12,'new_user@example.com','new_password123','2023-12-09 07:09:26');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`post_id`),
  KEY `idx_post_id` (`post_id`),
  CONSTRAINT `fk_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_chk_1` CHECK ((`size` < 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (2,'alice_smith','photo2.jpg',NULL,'Exploring Nature','Forest',6.2,'2023-12-09 07:09:20'),(3,'bob_jones','photo3.jpg',NULL,'City Lights','City',4.5,'2023-12-09 07:09:20'),(4,'emma_white','photo4.jpg',NULL,'Countryside Serenity','Countryside',7.1,'2023-12-09 07:09:20'),(10,'jessica_taylor','photo10.jpg',NULL,'Cityscape Beauty','City',5.6,'2023-12-09 07:09:20'),(11,'john_doe','new_photo.jpg',NULL,'Exciting Adventure','Mountain',7.8,'2023-12-09 07:09:26'),(7,'kevin_jenkins','photo7.jpg',NULL,'Urban Exploration','City',5.4,'2023-12-09 07:09:20'),(9,'michael_black','photo9.jpg','video2.mp4','Chasing Waterfalls','Waterfall',7.5,'2023-12-09 07:09:20'),(8,'olivia_green','photo8.jpg',NULL,'Sunrise at the Peak','Mountain',9,'2023-12-09 07:09:20'),(5,'ryan_miller','photo5.jpg','video1.mp4','Adventures Await','Mountains',8.3,'2023-12-09 07:09:20'),(6,'sara_brown','photo6.jpg',NULL,'Relaxing by the Lake','Lake',6.9,'2023-12-09 07:09:20');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_post_insert` BEFORE INSERT ON `post` FOR EACH ROW SET NEW.created_at = IFNULL(NEW.created_at, NOW()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_likes` (
  `username` varchar(255) NOT NULL,
  `post_id` int NOT NULL,
  `user_likes` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`post_id`,`user_likes`),
  KEY `user_likes` (`user_likes`),
  CONSTRAINT `post_likes_ibfk_1` FOREIGN KEY (`username`, `post_id`) REFERENCES `post` (`username`, `post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_likes_ibfk_2` FOREIGN KEY (`user_likes`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_likes`
--

LOCK TABLES `post_likes` WRITE;
/*!40000 ALTER TABLE `post_likes` DISABLE KEYS */;
INSERT INTO `post_likes` VALUES ('alice_smith',2,'john_doe','2023-12-09 07:09:20'),('alice_smith',2,'ryan_miller','2023-12-09 07:09:26'),('bob_jones',3,'alice_smith','2023-12-09 07:09:20'),('emma_white',4,'john_doe','2023-12-09 07:09:20'),('jessica_taylor',10,'kevin_jenkins','2023-12-09 07:09:20'),('kevin_jenkins',7,'ryan_miller','2023-12-09 07:09:20'),('michael_black',9,'john_doe','2023-12-09 07:09:20'),('olivia_green',8,'jessica_taylor','2023-12-09 07:09:20'),('ryan_miller',5,'sara_brown','2023-12-09 07:09:20'),('sara_brown',6,'alice_smith','2023-12-09 07:09:20');
/*!40000 ALTER TABLE `post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userfollows`
--

DROP TABLE IF EXISTS `userfollows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userfollows` (
  `follower_id` varchar(255) NOT NULL,
  `followee_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follower_id`,`followee_id`),
  KEY `followee_id` (`followee_id`),
  CONSTRAINT `userfollows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userfollows_ibfk_2` FOREIGN KEY (`followee_id`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfollows`
--

LOCK TABLES `userfollows` WRITE;
/*!40000 ALTER TABLE `userfollows` DISABLE KEYS */;
INSERT INTO `userfollows` VALUES ('alice_smith','bob_jones','2023-12-09 07:09:20'),('bob_jones','emma_white','2023-12-09 07:09:20'),('emma_white','ryan_miller','2023-12-09 07:09:20'),('jessica_taylor','john_doe','2023-12-09 07:09:20'),('kevin_jenkins','olivia_green','2023-12-09 07:09:20'),('michael_black','jessica_taylor','2023-12-09 07:09:20'),('olivia_green','michael_black','2023-12-09 07:09:20'),('ryan_miller','sara_brown','2023-12-09 07:09:20'),('sara_brown','kevin_jenkins','2023-12-09 07:09:20');
/*!40000 ALTER TABLE `userfollows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `profile_photo_url` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dob` date DEFAULT NULL,
  `login_id` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `login_id` (`login_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`login_id`) REFERENCES `login` (`login_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('alice_smith','profile2.jpg','Hello, I am Alice Smith','2023-12-09 07:09:20','1988-11-25',2),('bob_jones','profile3.jpg','Hey there, I am Bob Jones','2023-12-09 07:09:20','1995-03-10',3),('emma_white','profile4.jpg','Greetings! I am Emma White','2023-12-09 07:09:20','1992-08-30',4),('jessica_taylor','profile10.jpg','Hello, I am Jessica Taylor','2023-12-09 07:09:20','1996-04-03',10),('john_doe','new_profile.jpg','Updated bio','2023-12-09 07:09:20','1990-05-15',1),('kevin_jenkins','profile7.jpg','Hey there, I am Kevin Jenkins','2023-12-09 07:09:20','1993-07-05',7),('michael_black','profile9.jpg','Hi, I am Michael Black','2023-12-09 07:09:20','1989-09-22',9),('new_user','new_profile.jpg','Hello, I am a new user','2023-12-09 07:09:26','1995-01-01',11),('new_user2','new_profile.jpg','Hello, I am a new user','2023-12-09 07:09:26','1995-01-01',12),('olivia_green','profile8.jpg','Greetings! I am Olivia Green','2023-12-09 07:09:20','1991-12-18',8),('ryan_miller','profile5.jpg','Hi, I am Ryan Miller','2023-12-09 07:09:20','1987-06-12',5),('sara_brown','profile6.jpg','Hello, I am Sara Brown','2023-12-09 07:09:20','1998-02-28',6);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'socialmedia'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `archive_old_posts` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `archive_old_posts` ON SCHEDULE EVERY 1 DAY STARTS '2023-12-09 02:12:33' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO archived_posts
    SELECT * FROM post
    WHERE created_at < NOW() - INTERVAL 365 DAY;

    DELETE FROM post
    WHERE created_at < NOW() - INTERVAL 365 DAY;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `update_user_activity` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `update_user_activity` ON SCHEDULE EVERY 1 DAY STARTS '2023-12-09 02:12:30' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE users
    SET last_activity = NOW();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'socialmedia'
--
/*!50003 DROP FUNCTION IF EXISTS `GetCommentLikesCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCommentLikesCount`(
    p_comment_id INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE likes_count INT;

    -- Count the number of likes for the comment
    SELECT COUNT(*) INTO likes_count
    FROM comment_likes
    WHERE comment_id = p_comment_id;

    RETURN likes_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetFollowersCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetFollowersCount`(user_id VARCHAR(255)) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE followers_count INT;

    SELECT COUNT(*) INTO followers_count
    FROM userfollows
    WHERE followee_id = user_id;

    RETURN followers_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetPostLikesCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPostLikesCount`(p_post_id INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE likes_count INT;

    SELECT COUNT(*) INTO likes_count
    FROM post_likes
    WHERE post_id = p_post_id;

    RETURN likes_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `IsUserFollowing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `IsUserFollowing`(
    p_follower_id VARCHAR(255),
    p_followee_id VARCHAR(255)
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE is_following BOOLEAN;

    -- Check if there is a record in userfollows for the given follower and followee
    SELECT COUNT(*) INTO is_following
    FROM userfollows
    WHERE follower_id = p_follower_id AND followee_id = p_followee_id;

    RETURN is_following;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCommentToPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCommentToPost`(
    IN p_comment_text VARCHAR(255),
    IN p_post_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    DECLARE new_comment_id INT;

    -- Generate a new comment_id (you can use your own logic here)
    SELECT IFNULL(MAX(comment_id), 0) + 1 INTO new_comment_id FROM comments;

    -- Insert the new comment
    INSERT INTO comments (comment_id, comment_text, post_id, username)
    VALUES (new_comment_id, p_comment_text, p_post_id, p_username);

    SELECT 'Comment added successfully' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateNewPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewPost`(
    IN p_username VARCHAR(255),
    IN p_photo_url VARCHAR(255),
    IN p_video_url VARCHAR(255),
    IN p_caption VARCHAR(200),
    IN p_location VARCHAR(50),
    IN p_size FLOAT
)
BEGIN
    DECLARE new_post_id INT;
    -- generate a new post_id 
    SELECT IFNULL(MAX(post_id), 0) + 1 INTO new_post_id FROM post;
    -- Insert the new post
    INSERT INTO post (post_id, username, photo_url, video_url, caption, location, size)
    VALUES (new_post_id, p_username, p_photo_url, p_video_url, p_caption, p_location, p_size);
    SELECT 'Post created successfully' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateNewUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewUser`(
    IN p_username VARCHAR(255),
    IN p_profile_photo_url VARCHAR(255),
    IN p_bio VARCHAR(255),
    IN p_dob DATE,
    IN p_email VARCHAR(255),
    IN p_user_password VARCHAR(255)
)
BEGIN
    -- Declare a variable to store the new user's login ID
    DECLARE new_login_id INT;

    -- Insert into the login table
    INSERT INTO login (email, user_password)
    VALUES (p_email, p_user_password);

    -- Retrieve the login ID of the newly inserted record
    SET new_login_id = LAST_INSERT_ID();

    -- Insert into the users table
    INSERT INTO users (username, profile_photo_url, bio, dob, login_id)
    VALUES (p_username, p_profile_photo_url, p_bio, p_dob, new_login_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteComment`(
    IN p_comment_id INT
)
BEGIN
    -- Declare a variable to store the username associated with the comment
    DECLARE comment_username VARCHAR(255);

    -- Get the username associated with the comment
    SELECT username INTO comment_username
    FROM comments
    WHERE comment_id = p_comment_id;

    -- Delete the comment from the comments table
    DELETE FROM comments
    WHERE comment_id = p_comment_id;

    -- If the username is not null, delete associated likes
    IF comment_username IS NOT NULL THEN
        DELETE FROM comment_likes
        WHERE comment_id = p_comment_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser`(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete from userfollows table
    DELETE FROM userfollows WHERE follower_id = p_username OR followee_id = p_username;

    -- Delete from comment_likes table
    DELETE FROM comment_likes WHERE username = p_username;

    -- Delete from post_likes table
    DELETE FROM post_likes WHERE username = p_username;

    -- Delete from comments table
    DELETE FROM comments WHERE username = p_username;

    -- Delete from post table
    DELETE FROM post WHERE username = p_username;

    -- Delete from users table
    DELETE FROM users WHERE username = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUserPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUserPost`(
    IN p_username VARCHAR(255),
    IN p_post_id INT
)
BEGIN
    DECLARE post_exists INT;

    -- Check if the post exists and belongs to the user
    SELECT COUNT(*) INTO post_exists
    FROM post
    WHERE username = p_username AND post_id = p_post_id;

    IF post_exists = 1 THEN
        -- Disable foreign key checks
        SET foreign_key_checks = 0;

        -- Delete associated comments
        DELETE FROM comments
        WHERE username = p_username AND post_id = p_post_id;

        -- Delete likes on the post
        DELETE FROM post_likes
        WHERE username = p_username AND post_id = p_post_id;

        -- Delete the post
        DELETE FROM post
        WHERE username = p_username AND post_id = p_post_id;

        -- Enable foreign key checks
        SET foreign_key_checks = 1;

        SELECT 'Post deleted successfully.' AS result;
    ELSE
        SELECT 'Post not found or does not belong to the user.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FollowUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FollowUser`(
    IN p_follower_id VARCHAR(255),
    IN p_followee_id VARCHAR(255)
)
BEGIN
    DECLARE follower_exists INT;
    DECLARE followee_exists INT;

    -- Check if the follower user exists
    SELECT COUNT(*) INTO follower_exists FROM users WHERE username = p_follower_id;

    -- Check if the followee user exists
    SELECT COUNT(*) INTO followee_exists FROM users WHERE username = p_followee_id;

    -- If both users exist, proceed with the follow
    IF follower_exists = 1 AND followee_exists = 1 THEN
        -- Check if the follow relationship already exists to avoid duplicates
        IF NOT EXISTS (
            SELECT 1 FROM userfollows
            WHERE follower_id = p_follower_id AND followee_id = p_followee_id
        ) THEN
            -- Insert the follow relationship
            INSERT INTO userfollows (follower_id, followee_id, created_at)
            VALUES (p_follower_id, p_followee_id, NOW());

            SELECT 'User followed successfully.' AS result;
        ELSE
            SELECT 'You are already following this user.' AS result;
        END IF;
    ELSE
        SELECT 'Follower or followee user does not exist.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPosts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPosts`()
BEGIN
    SELECT *
    FROM post;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUsernames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUsernames`()
BEGIN
    SELECT username
    FROM users;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCommentsByUsername` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCommentsByUsername`(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Select comments based on the provided username
    SELECT *
    FROM comments
    WHERE username = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLikedPostsByUsername` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLikedPostsByUsername`(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Temporary table to store liked posts
    CREATE TEMPORARY TABLE temp_liked_posts (
        post_id INT,
        username VARCHAR(255),
        photo_url VARCHAR(255),
        video_url VARCHAR(255),
        caption VARCHAR(200),
        location VARCHAR(50),
        size FLOAT,
        created_at TIMESTAMP
    );

    -- Insert liked posts into the temporary table
    INSERT INTO temp_liked_posts
    SELECT DISTINCT
        p.post_id,
        p.username,
        p.photo_url,
        p.video_url,
        p.caption,
        p.location,
        p.size,
        p.created_at
    FROM
        post_likes pl
    JOIN
        post p ON pl.post_id = p.post_id AND pl.username = p.username
    WHERE
        pl.user_likes = p_username;

    -- Select the liked posts from the temporary table
    SELECT
        post_id,
        username,
        photo_url,
        video_url,
        caption,
        location,
        size,
        created_at
    FROM
        temp_liked_posts;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_liked_posts;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPostsByUsername` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPostsByUsername`(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Select all posts created by the specified user
    SELECT *
    FROM post
    WHERE username = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserByUsernameAndPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserByUsernameAndPassword`(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE user_name VARCHAR(255);

    -- Retrieve the username based on the provided email and password
    SELECT u.username INTO user_name
    FROM login l
    JOIN users u ON l.login_id = u.login_id
    WHERE l.email = p_email AND l.user_password = p_password;

    -- Return the result
    SELECT user_name AS 'Username';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserDetails`(username_param VARCHAR(255))
BEGIN
    SELECT
        p.post_id,
        p.photo_url,
        p.video_url,
        p.caption,
        p.location,
        p.size,
        p.created_at,
        c.comment_id,
        c.comment_text,
        c.created_at AS comment_created_at,
        cl.userlikescomment,
        uf.follower_id,
        uf.followee_id
    FROM
        post p
    LEFT JOIN comments c ON p.post_id = c.post_id
    LEFT JOIN comment_likes cl ON c.comment_id = cl.comment_id
    LEFT JOIN userfollows uf ON p.username = uf.follower_id
    WHERE
        p.username = username_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LikeComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LikeComment`(
    IN p_username VARCHAR(255),
    IN p_comment_id INT,
    IN p_user_likes_comment VARCHAR(255)
)
BEGIN
    DECLARE user_exists INT;
    DECLARE comment_exists INT;

    -- Check if the user exists
    SELECT COUNT(*) INTO user_exists FROM users WHERE username = p_username;

    -- Check if the comment exists
    SELECT COUNT(*) INTO comment_exists FROM comments WHERE comment_id = p_comment_id;

    -- If the user and comment exist, proceed with the like
    IF user_exists = 1 AND comment_exists = 1 THEN
        -- Check if the like already exists to avoid duplicates
        IF NOT EXISTS (
            SELECT 1 FROM comment_likes
            WHERE username = p_username AND comment_id = p_comment_id AND userlikescomment = p_user_likes_comment
        ) THEN
            -- Insert the like
            INSERT INTO comment_likes (username, comment_id, userlikescomment, created_at)
            VALUES (p_username, p_comment_id, p_user_likes_comment, NOW());

            SELECT 'Like added successfully.' AS result;
        ELSE
            SELECT 'You have already liked this comment.' AS result;
        END IF;
    ELSE
        SELECT 'User or comment does not exist.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LikePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LikePost`(
    IN p_liking_username VARCHAR(255),
    IN p_post_id INT
)
BEGIN
    DECLARE post_creator_username VARCHAR(255);
    DECLARE existing_likes INT;
 
    -- Find the username of the user who created the post
    SELECT username INTO post_creator_username
    FROM post
    WHERE post_id = p_post_id;
 
    -- Check if the liking user has already liked the post
    SELECT COUNT(*) INTO existing_likes
    FROM post_likes
    WHERE post_id = p_post_id AND user_likes = p_liking_username;
 
    -- If the user hasn't liked the post, insert the like
    IF existing_likes = 0 THEN
        INSERT INTO post_likes (username, post_id, user_likes, created_at)
        VALUES (post_creator_username, p_post_id, p_liking_username, NOW());
        SELECT 'Like added successfully.' AS result;
    ELSE
        SELECT 'User has already liked the post.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UnfollowUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UnfollowUser`(
    IN p_follower_id VARCHAR(255),
    IN p_followee_id VARCHAR(255)
)
BEGIN
    -- Delete the follow relationship for the specified follower and followee
    DELETE FROM userfollows
    WHERE follower_id = p_follower_id AND followee_id = p_followee_id;

    -- You can perform additional actions if needed, such as updating follower/following counts
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UnlikeComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UnlikeComment`(
    IN p_comment_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete the like record for the specified comment and user
    DELETE FROM comment_likes
    WHERE comment_id = p_comment_id AND username = p_username;

    -- You can perform additional actions if needed, such as updating like counts on the comments table
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UnlikePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UnlikePost`(
    IN p_post_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete the like record for the specified post and user
    DELETE FROM post_likes
    WHERE post_id = p_post_id AND username = p_username;

    -- You can perform additional actions if needed, such as updating like counts on the post table
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateComment`(
    IN p_comment_id INTEGER,
    IN p_comment_text VARCHAR(255)
)
BEGIN
    -- Update the comment with the specified comment_id
    UPDATE comments
    SET comment_text = p_comment_text
    WHERE comment_id = p_comment_id;

    -- You can perform additional actions if needed
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePost`(
    IN p_post_id INTEGER,
    IN p_caption VARCHAR(200),
    IN p_location VARCHAR(50),
    IN p_size FLOAT
)
BEGIN
    -- Update the post with the specified post_id
    UPDATE post
    SET caption = p_caption,
        location = p_location,
        size = p_size
    WHERE post_id = p_post_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser`(
    IN p_username VARCHAR(255),
    IN p_profile_photo_url VARCHAR(255),
    IN p_bio VARCHAR(255),
    IN p_dob DATE
)
BEGIN
    -- Update the user details with the specified username
    UPDATE users
    SET
        profile_photo_url = p_profile_photo_url,
        bio = p_bio,
        dob = p_dob
    WHERE username = p_username;

    -- You can perform additional actions if needed
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

-- Dump completed on 2023-12-12 20:38:39
