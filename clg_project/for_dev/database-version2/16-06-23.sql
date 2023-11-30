-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2023 at 08:43 AM
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
DROP PROCEDURE IF EXISTS `project_management_sp_for_privileges`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_sp_for_privileges` (INOUT `p_privilegeid` INT, IN `p_viewdashboard` INT, IN `p_movecontent` INT, IN `p_viewproject` INT, IN `p_addproject` INT, IN `p_editproject` INT, IN `p_viewreport` INT, IN `p_createuser` INT, IN `p_viewedituser` INT, IN `p_chat` INT, IN `p_uploadimages` INT, IN `p_deleteimages` INT, IN `p_uploaddocuments` INT, IN `p_deletedocuments` INT, IN `p_userid` INT, IN `p_whoallowinguserid` INT, IN `p_privilegeaddeddate` DATETIME, IN `p_mode` INT)   BEGIN

-- mode 1 when user is admin 
	IF(p_mode = 1) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,user_id,allowed_by,privilege_added_date) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP());
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;

-- mode 2 when user is sub admin 
	IF(p_mode = 2) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,user_id,allowed_by,privilege_added_date) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP());
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 3 when user is requirement gatherer
	IF(p_mode = 3) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,user_id,allowed_by,privilege_added_date) VALUES (1,0,1,1,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP());
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 4 when user is developer
	IF(p_mode = 4) THEN
	-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,user_id,allowed_by,privilege_added_date) VALUES (1,1,0,0,0,0,0,0,1,1,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP());
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 5 when user is tester
	IF(p_mode = 5) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,user_id,allowed_by,privilege_added_date) VALUES (1,1,0,0,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP());
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;

-- mode 6 when user is custom while editing user
	IF(p_mode = 6) THEN
		UPDATE tbl_user SET user_role = 6 WHERE user_id = p_userid;
		UPDATE tbl_privileges SET privilege_for_view_dashboard = p_viewdashboard, privilege_for_move_dashboard_content = p_movecontent, privilege_for_view_project = p_viewproject, privilege_for_add_new_project = p_addproject,
		privilege_for_edit_project = p_editproject,privilege_for_view_reports = p_viewreport,privilege_for_create_user = p_createuser,privilege_for_view_and_edit_created_user = p_viewedituser,privilege_for_chat = p_chat,privilege_for_upload_images = p_uploadimages,privilege_for_delete_uploaded_images = p_deleteimages,privilege_for_upload_documents = p_uploaddocuments,privilege_for_delete_uploaded_documents = p_deletedocuments WHERE tbl_privileges.user_id = p_userid;
		SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE user_id = p_userid);
	END IF;

END$$

DROP PROCEDURE IF EXISTS `project_management_system_sp1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp1` (IN `p_userid` INT, IN `p_content` VARCHAR(100), IN `p_projectname` VARCHAR(20), IN `p_projectdescription` VARCHAR(1000), IN `p_projectid` INT, IN `p_sectionholdingid` TINYINT, IN `p_contentid` INT, IN `p_datetime` DATETIME, IN `p_mode` TINYINT, INOUT `out_parameter` INT)   BEGIN
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

DROP PROCEDURE IF EXISTS `project_management_system_sp_for_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_for_user` (INOUT `p_userid` INT, IN `p_username` VARCHAR(25), IN `p_contactno` VARCHAR(10), IN `p_usergender` INT, IN `p_userrole` INT, IN `p_useremail` VARCHAR(30), IN `p_userpassword` VARCHAR(255), IN `p_userdisabled` INT, IN `p_usercreatedby` INT, IN `p_signupdate` DATETIME, IN `p_mode` INT)   BEGIN
	
-- mode 1 create new user
	IF(p_mode = 1) THEN
		-- insert the new record of the user 
		INSERT INTO tbl_user (user_name, user_contact_no, user_gender, user_role, user_email_add, user_password, user_created_by, user_signup_date) VALUES (p_username, p_contactno, p_usergender, p_userrole, p_useremail, p_userpassword, p_usercreatedby, CURRENT_TIMESTAMP);
		SET p_userid = LAST_INSERT_ID();
		-- add this user into tbl_privileges
		set @p_privilegeid = 0; 
		call project_management_sp_for_privileges(@p_privilegeid,0,0,0,0,0,0,0,0,0,0,0,0,0,p_userid,p_usercreatedby,'',p_userrole);		
	END IF;

-- mode 2
	IF(p_mode = 2) THEN
		-- check the record of user for login
		UPDATE tbl_user SET user_name = p_username, user_contact_no = p_contactno, user_gender = p_usergender, user_role = p_userrole, user_email_add = p_useremail, user_password = p_userpassword where user_id = p_userid;
	END IF;
	
-- mode 3
	IF(p_mode = 3) THEN
		-- disable the user to avoid login to system and avoid transaction
		UPDATE tbl_user SET user_disabled = 1 where user_id = p_userid;
	END IF;

END$$

DROP PROCEDURE IF EXISTS `project_management_system_sp_of_document_details`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_of_document_details` (IN `p_documentoriginalname` VARCHAR(100), IN `p_documentnewname` VARCHAR(100), IN `p_documentpath` VARCHAR(200), IN `p_projectid` INT, IN `p_userid` INT, IN `p_documentdate` DATETIME, IN `p_mode` TINYINT, INOUT `p_documentid` INT)   BEGIN
	
-- mode 1
	IF(p_mode = 1) THEN
		-- insert the new record of the document 
		INSERT INTO tbl_document (document_original_name, document_new_name, document_path, project_id, user_id, document_added_date) VALUES (p_documentoriginalname, p_documentnewname, p_documentpath, p_projectid, p_userid, CURRENT_TIMESTAMP());
		SET p_documentid = LAST_INSERT_ID();
	END IF;

-- mode 2
	IF(p_mode = 2) THEN
		-- delete the record of document
		DELETE FROM tbl_document WHERE document_id = p_documentid;
	END IF;
	
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
(1, 'a', '2023-06-15 20:13:18', 1, 1, 1),
(2, 'b', '2023-06-15 20:13:24', 1, 1, 1),
(3, 'c', '2023-06-15 20:13:29', 1, 1, 1),
(4, 'd', '2023-06-15 20:13:36', 1, 1, 1),
(5, 'e', '2023-06-15 20:13:42', 1, 1, 1),
(6, 'f', '2023-06-15 20:13:47', 1, 1, 1),
(7, 'g', '2023-06-15 20:13:53', 1, 1, 1),
(8, 'h', '2023-06-15 20:15:36', 1, 1, 1),
(9, 'i', '2023-06-15 20:15:43', 1, 1, 1);

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
  `project_id` int(11) NOT NULL,
  `count_document` int(11) NOT NULL,
  `count_gallery` int(11) NOT NULL,
  `count_project` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_count`
--

INSERT INTO `tbl_count` (`count_id`, `count_doit`, `count_inprogress`, `count_verify`, `count_done`, `project_id`, `count_document`, `count_gallery`, `count_project`, `user_id`) VALUES
(1, 9, 0, 0, 0, 1, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_document`
--

DROP TABLE IF EXISTS `tbl_document`;
CREATE TABLE `tbl_document` (
  `document_id` int(11) NOT NULL,
  `document_original_name` varchar(100) NOT NULL,
  `document_new_name` varchar(100) NOT NULL,
  `document_path` varchar(200) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `document_added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
-- Table structure for table `tbl_gallery`
--

DROP TABLE IF EXISTS `tbl_gallery`;
CREATE TABLE `tbl_gallery` (
  `gallery_id` int(11) NOT NULL,
  `gallery_original_name` varchar(255) NOT NULL,
  `gallery_new_name` varchar(255) NOT NULL,
  `gallery_path` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `gallery_added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_privileges`
--

DROP TABLE IF EXISTS `tbl_privileges`;
CREATE TABLE `tbl_privileges` (
  `privilege_id` int(11) NOT NULL,
  `privilege_for_view_dashboard` int(11) NOT NULL DEFAULT 0,
  `privilege_for_move_dashboard_content` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_add_new_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_edit_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_reports` int(11) NOT NULL DEFAULT 0,
  `privilege_for_create_user` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_and_edit_created_user` int(11) NOT NULL,
  `privilege_for_chat` int(11) NOT NULL DEFAULT 0,
  `privilege_for_upload_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_upload_documents` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_documents` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `allowed_by` int(11) NOT NULL,
  `privilege_added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_privileges`
--

INSERT INTO `tbl_privileges` (`privilege_id`, `privilege_for_view_dashboard`, `privilege_for_move_dashboard_content`, `privilege_for_view_project`, `privilege_for_add_new_project`, `privilege_for_edit_project`, `privilege_for_view_reports`, `privilege_for_create_user`, `privilege_for_view_and_edit_created_user`, `privilege_for_chat`, `privilege_for_upload_images`, `privilege_for_delete_uploaded_images`, `privilege_for_upload_documents`, `privilege_for_delete_uploaded_documents`, `user_id`, `allowed_by`, `privilege_added_date`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2023-06-11 20:07:15'),
(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, '2023-06-16 08:15:01'),
(3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, '2023-06-16 08:21:45'),
(4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 8, 1, '2023-06-16 08:24:23'),
(5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 1, '2023-06-16 08:24:23'),
(6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 1, '2023-06-16 08:24:23'),
(7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 11, 1, '2023-06-16 08:24:23'),
(8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 1, '2023-06-16 08:24:23'),
(9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 13, 1, '2023-06-16 09:31:20'),
(10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 14, 1, '2023-06-16 09:31:20'),
(11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 15, 1, '2023-06-16 09:31:20'),
(12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 16, 1, '2023-06-16 09:31:20'),
(13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 17, 1, '2023-06-16 09:31:20'),
(14, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 18, 1, '2023-06-16 09:40:28'),
(15, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 19, 1, '2023-06-16 09:40:29'),
(16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 1, '2023-06-16 09:41:37'),
(17, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 1, '2023-06-16 09:41:37'),
(18, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 22, 1, '2023-06-16 11:52:53');

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
(1, 'new p', 'new p', '2023-06-13 18:15:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(25) NOT NULL,
  `user_contact_no` varchar(10) NOT NULL,
  `user_gender` int(11) NOT NULL,
  `user_role` int(11) NOT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_by` int(11) NOT NULL,
  `user_disabled` int(11) NOT NULL DEFAULT 0,
  `user_signup_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_name`, `user_contact_no`, `user_gender`, `user_role`, `user_email_add`, `user_password`, `user_created_by`, `user_disabled`, `user_signup_date`) VALUES
(1, 'admin', '1122334455', 1, 1, 'admin@email.com', 'Admin123', 0, 0, '2023-06-11 18:37:12'),
(2, 'subadmin', '1122334455', 1, 2, 'subadmin@email.com', 'Subadmin@123', 1, 1, '2023-06-11 18:39:10'),
(3, 'requirementgatherer', '1122334455', 1, 3, 'requirementgatherer@email.com', 'Requirementgatherer@123', 1, 0, '2023-06-11 18:40:50'),
(4, 'developer', '1122334455', 1, 6, 'developer@email.com', 'Developer@123', 1, 0, '2023-06-11 18:42:57'),
(5, 'tester', '1122334455', 2, 6, 'tester@email.com', 'Tester@123', 1, 0, '2023-06-11 18:47:01'),
(6, 'pk', '1234567891', 1, 2, 'pk@email.com', 'Pk123456', 1, 0, '2023-06-16 08:15:01'),
(7, 'prajwal', 'kllj', 1, 2, 'jll@email.com', 'jljj;', 1, 0, '2023-06-16 08:21:45'),
(8, 'a', '1', 1, 2, 'a@email.com', 'a', 1, 0, '2023-06-16 08:24:23'),
(9, 'c', '3', 1, 2, 'c@email.com', 'c', 1, 0, '2023-06-16 08:24:23'),
(10, 'd', '4', 1, 2, 'd@email.com', 'd', 1, 0, '2023-06-16 08:24:23'),
(11, 'b', '2', 1, 2, 'b@email.com', 'b', 1, 0, '2023-06-16 08:24:23'),
(12, 'e', '5', 1, 2, 'e@email.com', 'e', 1, 0, '2023-06-16 08:24:23'),
(13, 'a', '1', 1, 2, 'a1@email.com', 'a', 1, 0, '2023-06-16 09:31:20'),
(14, 'c', '3', 1, 2, 'c1@email.com', 'c', 1, 0, '2023-06-16 09:31:20'),
(15, 'e', '5', 1, 2, 'e1@email.com', 'e', 1, 0, '2023-06-16 09:31:20'),
(16, 'd', '4', 1, 2, 'd1@email.com', 'd', 1, 0, '2023-06-16 09:31:20'),
(17, 'b', '2', 1, 2, 'b1@email.com', 'b', 1, 0, '2023-06-16 09:31:20'),
(18, 'y', '12', 1, 2, 'y@email.com', 'x', 1, 0, '2023-06-16 09:40:28'),
(19, 'x', '12', 1, 2, 'x@email.com', 'x', 1, 0, '2023-06-16 09:40:29'),
(20, 'v', '12', 1, 2, 'v@email.com', 's', 1, 0, '2023-06-16 09:41:37'),
(21, 'z', '12', 1, 2, 'z@email.com', 's', 1, 0, '2023-06-16 09:41:37'),
(22, 'x', '1234567891', 1, 2, 'xyz@email.com', 'Xyz12345', 1, 0, '2023-06-16 11:52:53');

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
-- Indexes for table `tbl_document`
--
ALTER TABLE `tbl_document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  ADD PRIMARY KEY (`faq_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  ADD PRIMARY KEY (`gallery_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_privileges`
--
ALTER TABLE `tbl_privileges`
  ADD PRIMARY KEY (`privilege_id`),
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
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_count`
--
ALTER TABLE `tbl_count`
  MODIFY `count_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_document`
--
ALTER TABLE `tbl_document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  MODIFY `gallery_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_privileges`
--
ALTER TABLE `tbl_privileges`
  MODIFY `privilege_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tbl_project`
--
ALTER TABLE `tbl_project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
