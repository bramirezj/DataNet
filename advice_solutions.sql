-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: advice_solutions
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

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
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `id` varchar(16) NOT NULL,
  `model` varchar(30) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `stock` smallint NOT NULL,
  `price` float NOT NULL,
  `processor` varchar(50) NOT NULL,
  `ram` tinyint NOT NULL,
  `graphic_card` varchar(30) NOT NULL,
  `storage` smallint NOT NULL,
  `description` varchar(3000) NOT NULL,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devices_images`
--

DROP TABLE IF EXISTS `devices_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `device` varchar(16) NOT NULL,
  `device_image_name` varchar(100) NOT NULL,
  `device_image_size` int NOT NULL,
  `device_image_type` varchar(20) NOT NULL,
  `device_image_data` longblob NOT NULL,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_dvc_images_devices` (`device`),
  CONSTRAINT `fk_dvc_images_devices` FOREIGN KEY (`device`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dt_invoice`
--

DROP TABLE IF EXISTS `dt_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_invoice` int DEFAULT NULL,
  `id_device` varchar(16) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `taxes` float DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dt_invoice_devices` (`id_device`),
  KEY `fk_dt_invoice_id_invoice` (`id_invoice`),
  CONSTRAINT `fk_dt_invoice_devices` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id`),
  CONSTRAINT `fk_dt_invoice_id_invoice` FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dt_shop_cart`
--

DROP TABLE IF EXISTS `dt_shop_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_shop_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_sp` int NOT NULL,
  `id_device` varchar(16) NOT NULL,
  `qty` smallint NOT NULL,
  `taxes` float DEFAULT NULL,
  `price` float DEFAULT NULL,
  `registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_shop_cart_devices` (`id_device`),
  KEY `fk_shop_cart_id_sp` (`id_sp`),
  CONSTRAINT `fk_shop_cart_devices` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id`),
  CONSTRAINT `fk_shop_cart_id_sp` FOREIGN KEY (`id_sp`) REFERENCES `shop_cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_token` varchar(8) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_user_token` (`user_token`),
  CONSTRAINT `fk_invoice_user_token` FOREIGN KEY (`user_token`) REFERENCES `users` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shop_cart`
--

DROP TABLE IF EXISTS `shop_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_token` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shop_cart_users` (`user_token`),
  CONSTRAINT `fk_shop_cart_users` FOREIGN KEY (`user_token`) REFERENCES `users` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `token` varchar(8) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `role` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`token`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_admin`
--

DROP TABLE IF EXISTS `users_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_admin` (
  `token` varchar(8) NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`token`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_images`
--

DROP TABLE IF EXISTS `users_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(8) NOT NULL,
  `user_image_name` varchar(100) NOT NULL,
  `user_image_size` int NOT NULL,
  `user_image_type` varchar(20) NOT NULL,
  `user_image_data` longblob NOT NULL,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`),
  CONSTRAINT `fk_usr_images_users` FOREIGN KEY (`user`) REFERENCES `users` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_devices`
--

DROP TABLE IF EXISTS `vw_devices`;
/*!50001 DROP VIEW IF EXISTS `vw_devices`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_devices` AS SELECT 
 1 AS `id`,
 1 AS `model`,
 1 AS `brand`,
 1 AS `stock`,
 1 AS `price`,
 1 AS `processor`,
 1 AS `ram`,
 1 AS `graphic_card`,
 1 AS `storage`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_devices_images`
--

DROP TABLE IF EXISTS `vw_devices_images`;
/*!50001 DROP VIEW IF EXISTS `vw_devices_images`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_devices_images` AS SELECT 
 1 AS `id`,
 1 AS `device`,
 1 AS `device_image_name`,
 1 AS `device_image_size`,
 1 AS `device_image_type`,
 1 AS `device_image_data`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_users`
--

DROP TABLE IF EXISTS `vw_users`;
/*!50001 DROP VIEW IF EXISTS `vw_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_users` AS SELECT 
 1 AS `token`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `role`,
 1 AS `username`,
 1 AS `phone`,
 1 AS `email`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_users_admin`
--

DROP TABLE IF EXISTS `vw_users_admin`;
/*!50001 DROP VIEW IF EXISTS `vw_users_admin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_users_admin` AS SELECT 
 1 AS `token`,
 1 AS `username`,
 1 AS `email`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_users_images`
--

DROP TABLE IF EXISTS `vw_users_images`;
/*!50001 DROP VIEW IF EXISTS `vw_users_images`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_users_images` AS SELECT 
 1 AS `user`,
 1 AS `user_image_name`,
 1 AS `user_image_size`,
 1 AS `user_image_type`,
 1 AS `user_image_data`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_devices`
--

/*!50001 DROP VIEW IF EXISTS `vw_devices`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_devices` (`id`,`model`,`brand`,`stock`,`price`,`processor`,`ram`,`graphic_card`,`storage`,`description`) AS select `devices`.`id` AS `id`,`devices`.`model` AS `model`,`devices`.`brand` AS `brand`,`devices`.`stock` AS `stock`,`devices`.`price` AS `price`,`devices`.`processor` AS `processor`,`devices`.`ram` AS `ram`,`devices`.`graphic_card` AS `graphic_card`,`devices`.`storage` AS `storage`,`devices`.`description` AS `description` from `devices` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_devices_images`
--

/*!50001 DROP VIEW IF EXISTS `vw_devices_images`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_devices_images` (`id`,`device`,`device_image_name`,`device_image_size`,`device_image_type`,`device_image_data`) AS select `devices_images`.`id` AS `id`,`devices_images`.`device` AS `device`,`devices_images`.`device_image_name` AS `device_image_name`,`devices_images`.`device_image_size` AS `device_image_size`,`devices_images`.`device_image_type` AS `device_image_type`,`devices_images`.`device_image_data` AS `device_image_data` from `devices_images` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_users`
--

/*!50001 DROP VIEW IF EXISTS `vw_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_users` (`token`,`first_name`,`last_name`,`role`,`username`,`phone`,`email`,`password`) AS select `users`.`token` AS `token`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`role` AS `role`,`users`.`username` AS `username`,`users`.`phone` AS `phone`,`users`.`email` AS `email`,`users`.`password` AS `password` from `users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_users_admin`
--

/*!50001 DROP VIEW IF EXISTS `vw_users_admin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_users_admin` (`token`,`username`,`email`,`password`) AS select `users_admin`.`token` AS `token`,`users_admin`.`username` AS `username`,`users_admin`.`email` AS `email`,`users_admin`.`password` AS `password` from `users_admin` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_users_images`
--

/*!50001 DROP VIEW IF EXISTS `vw_users_images`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_users_images` (`user`,`user_image_name`,`user_image_size`,`user_image_type`,`user_image_data`) AS select `users_images`.`user` AS `user`,`users_images`.`user_image_name` AS `user_image_name`,`users_images`.`user_image_size` AS `user_image_size`,`users_images`.`user_image_type` AS `user_image_type`,`users_images`.`user_image_data` AS `user_image_data` from `users_images` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-18 19:16:01
