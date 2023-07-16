-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 25, 2023 at 02:06 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_management_system`
--
CREATE DATABASE IF NOT EXISTS `project_management_system` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `project_management_system`;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_content`
--

DROP TABLE IF EXISTS `tbl_content`;
CREATE TABLE IF NOT EXISTS `tbl_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(100) DEFAULT NULL,
  `content_added_date` datetime DEFAULT NULL,
  `section_holding_ids` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_content`
--

INSERT INTO `tbl_content` (`content_id`, `content`, `content_added_date`, `section_holding_ids`, `project_id`, `user_id`) VALUES
(1, 'Make login page', '2023-03-25 07:32:41', 4, 1, 1),
(2, 'Make signup page', '2023-03-25 07:32:53', 4, 1, 1),
(3, 'Add plus button on manage stock page', '2023-03-25 07:33:09', 1, 1, 1),
(4, 'Make manage stock page', '2023-03-25 07:34:00', 2, 1, 1),
(5, 'use different colors', '2023-03-25 07:34:15', 3, 1, 1),
(6, 'Include logo of test1 on signup and login page', '2023-03-25 07:35:14', 2, 1, 1),
(7, 'make report page to generate report.', '2023-03-25 07:35:57', 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_count`
--

DROP TABLE IF EXISTS `tbl_count`;
CREATE TABLE IF NOT EXISTS `tbl_count` (
  `count_id` int(11) NOT NULL AUTO_INCREMENT,
  `count_doit` int(11) NOT NULL,
  `count_inprogress` int(11) NOT NULL,
  `count_verify` int(11) NOT NULL,
  `count_done` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`count_id`),
  KEY `user_id` (`user_id`),
  KEY `project_id` (`project_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_count`
--

INSERT INTO `tbl_count` (`count_id`, `count_doit`, `count_inprogress`, `count_verify`, `count_done`, `user_id`, `project_id`) VALUES
(1, 1, 3, 1, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_faq`
--

DROP TABLE IF EXISTS `tbl_faq`;
CREATE TABLE IF NOT EXISTS `tbl_faq` (
  `faq_id` int(11) NOT NULL AUTO_INCREMENT,
  `faq` varchar(100) DEFAULT NULL,
  `faq_ans` varchar(10000) DEFAULT NULL,
  `faq_ans_status` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `faq_added_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`faq_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_faq`
--

INSERT INTO `tbl_faq` (`faq_id`, `faq`, `faq_ans`, `faq_ans_status`, `user_id`, `faq_added_date_time`) VALUES
(1, 'What is project management?', 'Project management is a visual process and project management tool , it is a way to visualize your work and limit the amount of work in progress at any one time.', 1, 1, '2023-03-20 23:15:14'),
(2, 'What is the main purpose behind the Project management system ?', 'The main purpose of representing work as a card on the Project management system is to allow team members to track the progress of work through its workflow in a highly visual manner. ', 1, 1, '2023-03-20 23:15:54'),
(3, 'who can use the Project Management System ?', '(I). A Single Individual: The Project Management System is not only meant for large organizations. It is sometimes a misconception that because Project Management System  is a little complicated, that it is meant for large scale businesses. \r\n(II). A Small Team: Project Management System is wonderful for project management as it helps allocate tasks based on the degree of importance and thus would be great for a small team to use for management of their project\r\n(III). Software Development Companies: Software development companies can make use of  Project Management System  to plan and strategies their softwares before they are released. Due to  Project Management System\'s  flexibility, and its insistence on important tasks to be dispatched with firstly, thus allowing the software to be available for release at any time while other minor tasks can be worked upon\r\n(IV). Hospitals: Part of project management systeam focus is in keeping the stocks in an inventory to a minimal while satisfying the demand of the customers. This is applied in various hospitals as instruments like catheters, surgical instruments etc need stock piling. If these instruments are excess, then they would go to waste as no one would require them. Thus the use of project management  system is to determine the best possible levels that can be stocked in the supply rooms to avoid waste.', 1, 1, '2023-03-20 23:16:43'),
(4, 'Can I add new tasks at any time?', 'Yes, the beauty of project management is the flexibility. You are free to add tasks at any time, just like you are choosing what to perform next and can reorder priority at any time.', 1, 1, '2023-03-20 23:17:58'),
(5, 'Do I need to use specific tools to do Project management systeam ?', 'Your project management systeam  is a visual representation of how work flows through your process. It helps you assess whether you have a smooth flow of work or things are getting stuck somewhere. Because it makes work more transparent, it facilitates better communication within your team and organization as a whole.', 1, 1, '2023-03-20 23:18:49'),
(6, 'What are the main principles of Project management systeam ?', 'Project management systeam works on three principles \r\n(A)It helps to visualize the task you working on and the items in context of each other\r\n(B)It helps to balance the workflow for teams, so they don’t commit themselves to unnecessary work or overburden of work\r\n(C)On completion of any work, it pulls out the most prioritized work from the backlog.', 1, 1, '2023-03-20 23:19:40'),
(7, 'What are the stages of Work on Project management systeam ? ', 'Do it , In Progress , Verify , Done \r\nIn its most basic form, a task board can be drawn on a whiteboard or even a section of wall. \r\nthe board is dived into 4 columns Do it , In Progress , Verify and Done \r\nThe user will dived the project in 4 sections Do it that is the team has to do that work \r\nin progress  means the work has started and it is in the process \r\nif the some of the part is done from the developer then that will be dragged in to Verify column so that the respective tester will get in touch with that and if any amendments then it will be again dragged in to Do it column .\r\nand the last section that is done these columns comes after first three stages if a particular task is coming through that three columns then finally by fulfilling all the requirements then task is done .', 1, 1, '2023-03-20 23:21:07');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project`
--

DROP TABLE IF EXISTS `tbl_project`;
CREATE TABLE IF NOT EXISTS `tbl_project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(20) DEFAULT NULL,
  `project_description` varchar(1000) NOT NULL,
  `project_added_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_project`
--

INSERT INTO `tbl_project` (`project_id`, `project_name`, `project_description`, `project_added_date`, `user_id`) VALUES
(1, 'Test1', 'Test1', '2023-03-25 07:32:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `user_contact_no` varchar(10) DEFAULT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_signup_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_add` (`user_email_add`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_name`, `user_contact_no`, `user_email_add`, `user_password`, `user_signup_date`) VALUES
(1, 'test', '1111111111', 'test@email.com', 'Test1234', '2023-03-25 07:30:22');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
