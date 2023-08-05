-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2023 at 04:34 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `project_management_system_sp1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp1` (IN `p_userid` INT, IN `p_content` VARCHAR(100), IN `p_projectname` VARCHAR(20), IN `p_projectdescription` VARCHAR(1000), IN `p_projectid` INT, IN `p_sectionholdingid` TINYINT, IN `p_contentid` INT, IN `p_datetime` DATETIME, IN `p_mode` TINYINT, INOUT `out_parameter` INT)  NO SQL BEGIN

-- mode 1
	IF(p_mode =1) THEN
	
	-- insert the new record of the content
		INSERT INTO tbl_content(content, content_added_date, section_holding_ids, project_id, user_id) VALUES (p_content,CURRENT_TIMESTAMP(),p_sectionholdingid,p_projectid,p_userid);
		
		SET out_parameter = LAST_INSERT_ID();
	-- update the count of do it by 1
		UPDATE tbl_count SET count_doit = count_doit + 1 WHERE project_id = p_projectid AND user_id = p_userid;
	end if;
	
-- mode 2
	IF(p_mode =2) THEN
	
		set @previous_section_holding_div = (SELECT section_holding_ids FROM tbl_content WHERE content_id = p_contentid AND project_id = p_projectid AND user_id = p_userid);
		
		SET @LastUpdateID = 0;
		UPDATE tbl_content SET section_holding_ids=p_sectionholdingid,content_id = (SELECT @LastUpdateID := content_id) WHERE content_id=p_contentid AND project_id=p_projectid AND user_id=p_userid;
		
		SET out_parameter = @LastUpdateID;
	
			IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_inprogress = count_inprogress +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_verify = count_verify +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
			IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_done = count_done +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_doit = count_doit +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_verify = count_verify +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_done = count_done +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_doit = count_doit +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_inprogress = count_inprogress +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_done = count_done +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_doit = count_doit +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_inprogress = count_inprogress +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_verify = count_verify +1 WHERE project_id = p_projectid AND user_id = p_userid;
		end if;
	end if;
	
-- mode 3
	IF(p_mode =3) THEN
	
	  INSERT INTO tbl_project(project_name,project_description,project_added_date,user_id) VALUE (p_projectname,p_projectdescription,CURRENT_TIMESTAMP(),p_userid);
		
		SET @new_inseted_project_id = LAST_INSERT_ID();
		SET out_parameter =  LAST_INSERT_ID();
	
		INSERT INTO tbl_count(count_doit,count_inprogress,count_verify,count_done,user_id,project_id) VALUES (0,0,0,0,p_userid,@new_inseted_project_id);
	end if;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_content`
--

DROP TABLE IF EXISTS `tbl_content`;
CREATE TABLE `tbl_content` (
  `content_id` int(11) NOT NULL,
  `content` varchar(100) DEFAULT NULL,
  `content_added_date` datetime DEFAULT NULL,
  `section_holding_ids` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_content`
--

INSERT INTO `tbl_content` (`content_id`, `content`, `content_added_date`, `section_holding_ids`, `project_id`, `user_id`) VALUES
(1, 'Make login page', '2023-04-06 11:34:10', 4, 1, 1),
(2, 'Make a signup page', '2023-04-06 11:34:21', 4, 1, 1),
(3, 'Make a search page where outlet user can search the  data present in the outlet', '2023-04-06 11:34:45', 4, 1, 1),
(4, 'Provide a bill page to calculate total cost', '2023-04-06 11:36:10', 3, 1, 1),
(5, 'Provide a print button on the bill page to print the bill', '2023-04-06 11:36:40', 2, 1, 1),
(6, 'The bill is in form of pdf', '2023-04-06 11:37:03', 2, 1, 1),
(7, 'Make a page of sales return where we keep record of returned goods', '2023-04-06 11:38:02', 1, 1, 1),
(8, 'Make sure that page is responsive.', '2023-04-06 11:38:53', 1, 1, 1),
(9, 'Page providing same functionality on mobile or tablet as like laptop or computer', '2023-04-06 11:39:26', 1, 1, 1),
(10, 'some thing must done ', '2023-05-13 12:46:53', 4, 1, 1),
(11, 'Please change the ui of login page coze login page not looking good', '2023-05-23 15:01:14', 4, 1, 1),
(12, 'Frontend design ', '2023-05-26 07:49:31', 1, 3, 1),
(13, 'Make a Login Page', '2023-05-27 09:35:28', 1, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_count`
--

DROP TABLE IF EXISTS `tbl_count`;
CREATE TABLE `tbl_count` (
  `count_id` int(11) NOT NULL,
  `count_doit` int(11) NOT NULL,
  `count_inprogress` int(11) NOT NULL,
  `count_verify` int(11) NOT NULL,
  `count_done` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_count`
--

INSERT INTO `tbl_count` (`count_id`, `count_doit`, `count_inprogress`, `count_verify`, `count_done`, `user_id`, `project_id`) VALUES
(1, 3, 2, 1, 5, 1, 1),
(2, 0, 0, 0, 0, 1, 2),
(3, 2, 0, 0, 0, 1, 3),
(4, 0, 0, 0, 0, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_faq`
--

DROP TABLE IF EXISTS `tbl_faq`;
CREATE TABLE `tbl_faq` (
  `faq_id` int(11) NOT NULL,
  `faq` varchar(100) DEFAULT NULL,
  `faq_ans` varchar(10000) DEFAULT NULL,
  `faq_ans_status` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `faq_added_date_time` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
CREATE TABLE `tbl_project` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(20) DEFAULT NULL,
  `project_description` varchar(1000) NOT NULL,
  `project_added_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_project`
--

INSERT INTO `tbl_project` (`project_id`, `project_name`, `project_description`, `project_added_date`, `user_id`) VALUES
(1, 'CottonKing', 'This project is related to cottonking company ltd. This software provide a outlet management system to the outlets of cottonking all over the India.', '2023-04-06 11:33:51', 1),
(2, 'Coffee Product ', 'coffee product ', '2023-05-23 15:06:36', 1),
(3, 'o2uk', 'xyz', '2023-05-26 07:48:44', 1),
(4, 'Warehouse Management', 'In this project we are developing a software to manage the warehouse.', '2023-05-27 09:58:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(25) NOT NULL,
  `user_contact_no` varchar(10) DEFAULT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_by` int(11) NOT NULL,
  `user_signup_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_name`, `user_contact_no`, `user_email_add`, `user_password`, `user_created_by`, `user_signup_date`) VALUES
(1, 'admin', '1111111111', 'admin@email.com', 'Admin123', 0, '2023-04-06 11:32:21'),
(2, 'abc', '1122334455', 'abc@gmail.com', 'Abcd1234', 1, '2023-05-22 12:23:47'),
(3, 'bca', '1111111111', 'bca@email.com', 'Abcd1234', 1, '2023-05-23 13:31:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_content`
--
ALTER TABLE `tbl_content`
  ADD PRIMARY KEY (`content_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_count`
--
ALTER TABLE `tbl_count`
  ADD PRIMARY KEY (`count_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  ADD PRIMARY KEY (`faq_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_project`
--
ALTER TABLE `tbl_project`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email_add` (`user_email_add`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_content`
--
ALTER TABLE `tbl_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_count`
--
ALTER TABLE `tbl_count`
  MODIFY `count_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_project`
--
ALTER TABLE `tbl_project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
