-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: project_management_system
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_content`
--

DROP TABLE IF EXISTS `tbl_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_content` (
  `content_id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(100) DEFAULT NULL,
  `content_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `section_holding_ids` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_content`
--

LOCK TABLES `tbl_content` WRITE;
/*!40000 ALTER TABLE `tbl_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_count`
--

DROP TABLE IF EXISTS `tbl_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_count` (
  `count_id` int NOT NULL AUTO_INCREMENT,
  `count_doit` int NOT NULL,
  `count_inprogress` int NOT NULL,
  `count_verify` int NOT NULL,
  `count_done` int NOT NULL,
  `count_document` int NOT NULL,
  `count_gallery` int NOT NULL,
  `count_project` int NOT NULL,
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`count_id`),
  KEY `user_id` (`user_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_count`
--

LOCK TABLES `tbl_count` WRITE;
/*!40000 ALTER TABLE `tbl_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_document`
--

DROP TABLE IF EXISTS `tbl_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_document` (
  `document_id` int NOT NULL AUTO_INCREMENT,
  `document_original_name` varchar(100) NOT NULL,
  `document_new_name` varchar(100) NOT NULL,
  `document_path` varchar(200) NOT NULL,
  `project_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `document_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`document_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_document`
--

LOCK TABLES `tbl_document` WRITE;
/*!40000 ALTER TABLE `tbl_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_faq`
--

DROP TABLE IF EXISTS `tbl_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_faq` (
  `faq_id` int NOT NULL AUTO_INCREMENT,
  `faq` varchar(100) DEFAULT NULL,
  `faq_ans` varchar(10000) DEFAULT NULL,
  `faq_ans_status` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `faq_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`faq_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_faq`
--

LOCK TABLES `tbl_faq` WRITE;
/*!40000 ALTER TABLE `tbl_faq` DISABLE KEYS */;
INSERT INTO `tbl_faq` VALUES (1,'What is project management?','Project management is a visual process and project management tool , it is a way to visualize your work and limit the amount of work in progress at any one time.',1,1,'2023-03-20 23:15:14'),(2,'What is the main purpose behind the Project management system ?','The main purpose of representing work as a card on the Project management system is to allow team members to track the progress of work through its workflow in a highly visual manner. ',1,1,'2023-03-20 23:15:54'),(3,'who can use the Project Management System ?','(I). A Single Individual: The Project Management System is not only meant for large organizations. It is sometimes a misconception that because Project Management System  is a little complicated, that it is meant for large scale businesses. \r\n(II). A Small Team: Project Management System is wonderful for project management as it helps allocate tasks based on the degree of importance and thus would be great for a small team to use for management of their project\r\n(III). Software Development Companies: Software development companies can make use of  Project Management System  to plan and strategies their softwares before they are released. Due to  Project Management System\'s  flexibility, and its insistence on important tasks to be dispatched with firstly, thus allowing the software to be available for release at any time while other minor tasks can be worked upon\r\n(IV). Hospitals: Part of project management systeam focus is in keeping the stocks in an inventory to a minimal while satisfying the demand of the customers. This is applied in various hospitals as instruments like catheters, surgical instruments etc need stock piling. If these instruments are excess, then they would go to waste as no one would require them. Thus the use of project management  system is to determine the best possible levels that can be stocked in the supply rooms to avoid waste.',1,1,'2023-03-20 23:16:43'),(4,'Can I add new tasks at any time?','Yes, the beauty of project management is the flexibility. You are free to add tasks at any time, just like you are choosing what to perform next and can reorder priority at any time.',1,1,'2023-03-20 23:17:58'),(5,'Do I need to use specific tools to do Project management systeam ?','Your project management systeam  is a visual representation of how work flows through your process. It helps you assess whether you have a smooth flow of work or things are getting stuck somewhere. Because it makes work more transparent, it facilitates better communication within your team and organization as a whole.',1,1,'2023-03-20 23:18:49'),(6,'What are the main principles of Project management systeam ?','Project management systeam works on three principles \r\n(A)It helps to visualize the task you working on and the items in context of each other\r\n(B)It helps to balance the workflow for teams, so they don’t commit themselves to unnecessary work or overburden of work\r\n(C)On completion of any work, it pulls out the most prioritized work from the backlog.',1,1,'2023-03-20 23:19:40'),(7,'What are the stages of Work on Project management systeam ? ','Do it , In Progress , Verify , Done \r\nIn its most basic form, a task board can be drawn on a whiteboard or even a section of wall. \r\nthe board is dived into 4 columns Do it , In Progress , Verify and Done \r\nThe user will dived the project in 4 sections Do it that is the team has to do that work \r\nin progress  means the work has started and it is in the process \r\nif the some of the part is done from the developer then that will be dragged in to Verify column so that the respective tester will get in touch with that and if any amendments then it will be again dragged in to Do it column .\r\nand the last section that is done these columns comes after first three stages if a particular task is coming through that three columns then finally by fulfilling all the requirements then task is done .',1,1,'2023-03-20 23:21:07'),(8,'abc','',0,3,'2023-07-26 10:04:57'),(9,'asdf','',0,3,'2023-07-26 10:05:21');
/*!40000 ALTER TABLE `tbl_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_gallery`
--

DROP TABLE IF EXISTS `tbl_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_gallery` (
  `gallery_id` int NOT NULL AUTO_INCREMENT,
  `gallery_original_name` varchar(255) NOT NULL,
  `gallery_new_name` varchar(255) NOT NULL,
  `gallery_path` varchar(255) NOT NULL,
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  `gallery_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gallery_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_gallery`
--

LOCK TABLES `tbl_gallery` WRITE;
/*!40000 ALTER TABLE `tbl_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_issue`
--

DROP TABLE IF EXISTS `tbl_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_issue` (
  `issue_id` int NOT NULL AUTO_INCREMENT,
  `issue` varchar(200) DEFAULT NULL,
  `issue_reported_by` int DEFAULT NULL,
  `issue_reported_date` datetime DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issue_reported_by` (`issue_reported_by`),
  CONSTRAINT `tbl_issue_ibfk_1` FOREIGN KEY (`issue_reported_by`) REFERENCES `tbl_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_issue`
--

LOCK TABLES `tbl_issue` WRITE;
/*!40000 ALTER TABLE `tbl_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_privileges`
--

DROP TABLE IF EXISTS `tbl_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_privileges` (
  `privilege_id` int NOT NULL AUTO_INCREMENT,
  `privilege_for_view_dashboard` int NOT NULL DEFAULT '0',
  `privilege_for_move_dashboard_content` int NOT NULL DEFAULT '0',
  `privilege_for_view_project` int NOT NULL DEFAULT '0',
  `privilege_for_add_new_project` int NOT NULL DEFAULT '0',
  `privilege_for_edit_project` int NOT NULL DEFAULT '0',
  `privilege_for_view_reports` int NOT NULL DEFAULT '0',
  `privilege_to_change_privilege` int NOT NULL DEFAULT '0',
  `privilege_for_create_user` int NOT NULL DEFAULT '0',
  `privilege_for_view_and_edit_created_user` int NOT NULL,
  `privilege_for_upload_images` int NOT NULL DEFAULT '0',
  `privilege_for_delete_uploaded_images` int NOT NULL DEFAULT '0',
  `privilege_for_upload_documents` int NOT NULL DEFAULT '0',
  `privilege_for_delete_uploaded_documents` int NOT NULL DEFAULT '0',
  `privilege_user_id` int NOT NULL,
  `privilege_allowed_by` int NOT NULL,
  `privilege_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`privilege_id`),
  KEY `user_id` (`privilege_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_privileges`
--

LOCK TABLES `tbl_privileges` WRITE;
/*!40000 ALTER TABLE `tbl_privileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_project`
--

DROP TABLE IF EXISTS `tbl_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_project` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(20) DEFAULT NULL,
  `project_description` varchar(1000) NOT NULL,
  `project_added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_project`
--

LOCK TABLES `tbl_project` WRITE;
/*!40000 ALTER TABLE `tbl_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `user_role` int NOT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_by` int NOT NULL,
  `related_user` varchar(255) NOT NULL,
  `user_disabled` int NOT NULL DEFAULT '0',
  `user_signup_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_add` (`user_email_add`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (1,'ram',1,'ram@email.com','Ram12345',0,'1',0,'2023-11-29 21:42:23');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_user_privileges`
--

DROP TABLE IF EXISTS `vw_user_privileges`;
/*!50001 DROP VIEW IF EXISTS `vw_user_privileges`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_user_privileges` AS SELECT 
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `user_role`,
 1 AS `user_email_add`,
 1 AS `user_password`,
 1 AS `user_created_by`,
 1 AS `user_disabled`,
 1 AS `user_signup_date`,
 1 AS `privilege_id`,
 1 AS `privilege_for_view_dashboard`,
 1 AS `privilege_for_move_dashboard_content`,
 1 AS `privilege_for_view_project`,
 1 AS `privilege_for_add_new_project`,
 1 AS `privilege_for_edit_project`,
 1 AS `privilege_for_view_reports`,
 1 AS `privilege_to_change_privilege`,
 1 AS `privilege_for_create_user`,
 1 AS `privilege_for_view_and_edit_created_user`,
 1 AS `privilege_for_upload_images`,
 1 AS `privilege_for_delete_uploaded_images`,
 1 AS `privilege_for_upload_documents`,
 1 AS `privilege_for_delete_uploaded_documents`,
 1 AS `privilege_user_id`,
 1 AS `privilege_allowed_by`,
 1 AS `privilege_added_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_user_privileges`
--

/*!50001 DROP VIEW IF EXISTS `vw_user_privileges`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_user_privileges` AS select `tbl_user`.`user_id` AS `user_id`,`tbl_user`.`user_name` AS `user_name`,`tbl_user`.`user_role` AS `user_role`,`tbl_user`.`user_email_add` AS `user_email_add`,`tbl_user`.`user_password` AS `user_password`,`tbl_user`.`user_created_by` AS `user_created_by`,`tbl_user`.`user_disabled` AS `user_disabled`,`tbl_user`.`user_signup_date` AS `user_signup_date`,`tbl_privileges`.`privilege_id` AS `privilege_id`,`tbl_privileges`.`privilege_for_view_dashboard` AS `privilege_for_view_dashboard`,`tbl_privileges`.`privilege_for_move_dashboard_content` AS `privilege_for_move_dashboard_content`,`tbl_privileges`.`privilege_for_view_project` AS `privilege_for_view_project`,`tbl_privileges`.`privilege_for_add_new_project` AS `privilege_for_add_new_project`,`tbl_privileges`.`privilege_for_edit_project` AS `privilege_for_edit_project`,`tbl_privileges`.`privilege_for_view_reports` AS `privilege_for_view_reports`,`tbl_privileges`.`privilege_to_change_privilege` AS `privilege_to_change_privilege`,`tbl_privileges`.`privilege_for_create_user` AS `privilege_for_create_user`,`tbl_privileges`.`privilege_for_view_and_edit_created_user` AS `privilege_for_view_and_edit_created_user`,`tbl_privileges`.`privilege_for_upload_images` AS `privilege_for_upload_images`,`tbl_privileges`.`privilege_for_delete_uploaded_images` AS `privilege_for_delete_uploaded_images`,`tbl_privileges`.`privilege_for_upload_documents` AS `privilege_for_upload_documents`,`tbl_privileges`.`privilege_for_delete_uploaded_documents` AS `privilege_for_delete_uploaded_documents`,`tbl_privileges`.`privilege_user_id` AS `privilege_user_id`,`tbl_privileges`.`privilege_allowed_by` AS `privilege_allowed_by`,`tbl_privileges`.`privilege_added_date` AS `privilege_added_date` from (`tbl_user` join `tbl_privileges` on((`tbl_user`.`user_id` = `tbl_privileges`.`privilege_user_id`))) */;
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

-- Dump completed on 2023-11-30 10:57:17
