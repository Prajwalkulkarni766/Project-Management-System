-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2023 at 07:01 PM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_sp_for_privileges` (INOUT `p_privilegeid` INT, IN `p_viewdashboard` INT, IN `p_movecontent` INT, IN `p_viewproject` INT, IN `p_addproject` INT, IN `p_editproject` INT, IN `p_viewreport` INT, IN `p_changeprivilege` INT, IN `p_createuser` INT, IN `p_viewedituser` INT, IN `p_chat` INT, IN `p_uploadimages` INT, IN `p_deleteimages` INT, IN `p_uploaddocuments` INT, IN `p_deletedocuments` INT, IN `p_userid` INT, IN `p_whoallowinguserid` INT, IN `p_privilegeaddeddate` DATETIME, IN `p_mode` INT)   BEGIN

-- mode 1 when user is admin 
	IF(p_mode = 1) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_to_change_privilege,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by,privilege_added_date) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP);
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;

-- mode 2 when user is sub admin 
	IF(p_mode = 2) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by,privilege_added_date) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP);
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 3 when user is requirement gatherer
	IF(p_mode = 3) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by,privilege_added_date) VALUES (1,0,1,1,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP);
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 4 when user is developer
	IF(p_mode = 4) THEN
	-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by,privilege_added_date) VALUES (1,1,0,0,0,0,0,0,1,1,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP);
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;
	
-- mode 5 when user is tester
	IF(p_mode = 5) THEN
		-- insert the new record of the privilege 
		INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_chat,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by,privilege_added_date) VALUES (1,1,0,0,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP);
		SET p_privilegeid = LAST_INSERT_ID();
	END IF;

-- mode 6 when user is custom while editing user
	IF(p_mode = 6) THEN
		UPDATE tbl_user SET user_role = 6 WHERE user_id = p_userid;
		UPDATE tbl_privileges SET privilege_for_view_dashboard = p_viewdashboard, privilege_for_move_dashboard_content = p_movecontent, privilege_for_view_project = p_viewproject, privilege_for_add_new_project = p_addproject,
		privilege_for_edit_project = p_editproject,privilege_for_view_reports = p_viewreport,privilege_for_create_user = p_createuser,privilege_for_view_and_edit_created_user = p_viewedituser,privilege_for_chat = p_chat,privilege_for_upload_images = p_uploadimages,privilege_for_delete_uploaded_images = p_deleteimages,privilege_for_upload_documents = p_uploaddocuments,privilege_for_delete_uploaded_documents = p_deletedocuments,privilege_to_change_privilege = p_changeprivilege WHERE tbl_privileges.privilege_user_id = p_userid;
		SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);
	END IF;
	
	-- mode 7 when user is disabled 
	IF(p_mode = 7) THEN
		UPDATE tbl_privileges SET privilege_for_view_dashboard = 0, privilege_for_move_dashboard_content = 0, privilege_for_view_project = 0, privilege_for_add_new_project = 0,
		privilege_for_edit_project = 0,privilege_for_view_reports = 0,privilege_to_change_privilege = 0,privilege_for_create_user = 0,privilege_for_view_and_edit_created_user = 0,privilege_for_chat = 0,privilege_for_upload_images = 0,privilege_for_delete_uploaded_images = 0,privilege_for_upload_documents = 0,privilege_for_delete_uploaded_documents = 0, privilege_allowed_by=p_whoallowinguserid WHERE tbl_privileges.privilege_user_id = p_userid;
		SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);
	END IF;
	
-- mode 8 when user privelge right changed
	IF(p_mode = 8) THEN
		/*set p_viewdashboard 
		set p_movecontent
		set p_viewproject
		set p_addproject
		set p_editproject
		set p_viewreport
		set p_createuser
		set p_viewedituser
		set p_chat
		set p_uploadimages
		set p_deleteimages
		set p_uploaddocuments
		set p_deletedocuments
		*/		
		CASE p_privilegeid
		
		-- when user become sub admin
			WHEN 2 THEN
				set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 1;set p_addproject = 1;set p_editproject = 1;set p_viewreport = 1;set p_createuser = 1;set p_viewedituser = 1;set p_chat = 1;set p_uploadimages = 1;set p_deleteimages = 1;set p_uploaddocuments = 1;set p_deletedocuments = 1;set  p_changeprivilege = 1;
				
		-- when user become requirement gatherer
			WHEN 3 THEN
				set p_viewdashboard = 1;set p_movecontent = 0;set p_viewproject = 1;set p_addproject = 1;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_chat = 1;set p_uploadimages = 0;set p_deleteimages = 0;set p_uploaddocuments = 1;set p_deletedocuments = 0;set  p_changeprivilege = 0;
				-- 1,0,1,1,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()
		
		-- when user become developer
			WHEN 4 THEN
				set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 0;set p_addproject = 0;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_chat = 1;set p_uploadimages = 1;set p_deleteimages = 0;set p_uploaddocuments = 1;		set p_deletedocuments = 0;set  p_changeprivilege = 0;
				-- 1,1,0,0,0,0,0,0,1,1,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()
		
		-- when user become tester
			WHEN 5 THEN
				set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 0;set p_addproject = 0;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_chat = 1;set p_uploadimages = 0;set p_deleteimages = 0;set p_uploaddocuments = 1;set p_deletedocuments = 0;set  p_changeprivilege = 0;
				-- 1,1,0,0,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()
END CASE;

		
		UPDATE tbl_privileges SET privilege_for_view_dashboard = p_viewdashboard, privilege_for_move_dashboard_content = p_movecontent, privilege_for_view_project = p_viewproject, privilege_for_add_new_project = p_addproject,
		privilege_for_edit_project = p_editproject,privilege_for_view_reports = p_viewreport,privilege_to_change_privilege =  p_changeprivilege,privilege_for_create_user = p_createuser,privilege_for_view_and_edit_created_user = p_viewedituser,privilege_for_chat = p_chat,privilege_for_upload_images = p_uploadimages,privilege_for_delete_uploaded_images = p_deleteimages,privilege_for_upload_documents = p_uploaddocuments,privilege_for_delete_uploaded_documents = p_deletedocuments WHERE tbl_privileges.privilege_user_id = p_userid;
		SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);
	END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_sp_of_fetch_admin_and_project` (IN `p_user_id` INT, OUT `p_project_id_and_name_list` VARCHAR(600))   BEGIN
	SET @out_para_which_holds_users_admin_id = "";
	SET @p_project_list = '';
	SET p_project_id_and_name_list = "";
--	CALL project_management_system_sp_for_fetch_admin_id_of_sub_user(p_user_id,@out_para_which_holds_users_admin_id);
	SET @out_para_which_holds_users_admin_id = (SELECT user_id FROM tbl_user WHERE related_user IN(p_user_id));
	CALL project_management_system_sp_to_fetch_project(@out_para_which_holds_users_admin_id, @p_project_list);
	SET p_project_id_and_name_list = @p_project_list;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp1` (IN `p_userid` INT, IN `p_content` VARCHAR(100), IN `p_projectname` VARCHAR(20), IN `p_projectdescription` VARCHAR(1000), IN `p_projectid` INT, IN `p_sectionholdingid` TINYINT, IN `p_contentid` INT, IN `p_datetime` DATETIME, IN `p_mode` TINYINT, INOUT `out_parameter` INT)   BEGIN
-- mode 1
	IF(p_mode =1) THEN
	
	-- insert the new record of the content
		INSERT INTO tbl_content(content, content_added_date, section_holding_ids, project_id, user_id) VALUES (p_content,CURRENT_TIMESTAMP(),p_sectionholdingid,p_projectid,p_userid);
		
		SET out_parameter = LAST_INSERT_ID();
	-- update the count of do it by 1
		UPDATE tbl_count SET count_doit = count_doit + 1 WHERE project_id = p_projectid;
	end if;
	
-- mode 2
	IF(p_mode =2) THEN
	
		set @previous_section_holding_div = (SELECT section_holding_ids FROM tbl_content WHERE content_id = p_contentid AND project_id = p_projectid);
		
		SET @LastUpdateID = 0;
		UPDATE tbl_content SET section_holding_ids=p_sectionholdingid,content_id = (SELECT @LastUpdateID := content_id) WHERE content_id=p_contentid AND project_id=p_projectid;
		
		SET out_parameter = @LastUpdateID;
	
			IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_inprogress = count_inprogress +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_verify = count_verify +1 WHERE project_id = p_projectid;
		end if;
		
			IF(@previous_section_holding_div = 1 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_doit = count_doit -1 , count_done = count_done +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_doit = count_doit +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_verify = count_verify +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 2 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_inprogress = count_inprogress -1, count_done = count_done +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_doit = count_doit +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_inprogress = count_inprogress +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 3 AND p_sectionholdingid = 4) THEN
				UPDATE tbl_count SET count_verify = count_verify -1, count_done = count_done +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 1) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_doit = count_doit +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 2) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_inprogress = count_inprogress +1 WHERE project_id = p_projectid;
		end if;
		
		IF(@previous_section_holding_div = 4 AND p_sectionholdingid = 3) THEN
				UPDATE tbl_count SET count_done = count_done -1, count_verify = count_verify +1 WHERE project_id = p_projectid;
		end if;
	end if;
	
-- mode 3
	IF(p_mode =3) THEN
	
	  INSERT INTO tbl_project(project_name,project_description,project_added_date,user_id) VALUE (p_projectname,p_projectdescription,CURRENT_TIMESTAMP(),p_userid);
		
		SET @new_inseted_project_id = LAST_INSERT_ID();
		SET out_parameter =  @new_inseted_project_id;
	
		INSERT INTO tbl_count(count_doit,count_inprogress,count_verify,count_done,user_id,project_id) VALUES (0,0,0,0,p_userid,@new_inseted_project_id);
	end if;

-- mode 4
	IF(p_mode =4) THEN
		UPDATE tbl_project SET project_name = p_projectname,project_description = p_projectdescription WHERE project_id = p_projectid;
		SET out_parameter = p_projectid;
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_for_fetch_admin_id_of_sub_user` (IN `p_user_id` INT, OUT `p_admin_user_id` VARCHAR(50))   BEGIN 
	DECLARE temp_user_id INT DEFAULT 0;
	DECLARE v_user_created_by INT DEFAULT 0;
	SET p_admin_user_id = p_user_id;
	user_id_loop : loop 
		SET v_user_created_by = (SELECT user_created_by FROM tbl_user WHERE user_id = p_user_id);
		if v_user_created_by = 0 then
				leave user_id_loop;
				else
						SET p_admin_user_id = CONCAT(p_admin_user_id, ",", v_user_created_by);
						SET p_user_id = v_user_created_by;
		END if;	
     END loop user_id_loop;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_for_user` (INOUT `p_userid` INT, IN `p_username` VARCHAR(25), IN `p_contactno` VARCHAR(10), IN `p_usergender` INT, IN `p_userrole` INT, IN `p_useremail` VARCHAR(30), IN `p_userpassword` VARCHAR(255), IN `p_userdisabled` INT, IN `p_usercreatedby` INT, IN `p_signupdate` DATETIME, IN `p_mode` INT)   BEGIN
	DECLARE v_previous_related_user VARCHAR(255) DEFAULT "";
	DECLARE v_user_created_by INT DEFAULT 0;
	DECLARE v_userid INT DEFAULT 0;
	
-- mode 1 create new user
	IF(p_mode = 1) THEN
		-- insert the new record of the user 
		INSERT INTO tbl_user (user_name, user_contact_no, user_gender, user_role, user_email_add, user_password, user_created_by, user_signup_date) VALUES (p_username, p_contactno, p_usergender, p_userrole, p_useremail, p_userpassword, p_usercreatedby, CURRENT_TIMESTAMP);
		SET p_userid = LAST_INSERT_ID();
		if p_userrole = 1 then
			UPDATE tbl_user SET related_user = p_userid WHERE user_id = p_userid;
		END if;
		set @p_privilegeid = 0; 
		call project_management_sp_for_privileges(@p_privilegeid,0,0,0,0,0,0,0,0,0,0,0,0,0,0,p_userid,p_usercreatedby,'',p_userrole);
		
		if p_usercreatedby != 0 then
			fetch_user_id_loop :loop
			SET v_user_created_by = (SELECT user_created_by FROM tbl_user WHERE user_id = p_usercreatedby);
			if v_user_created_by = 0 then
				SET v_userid = p_usercreatedby;
				leave fetch_user_id_loop;
				else
						SET p_usercreatedby = v_user_created_by;
			END if;	
			END loop fetch_user_id_loop;
			SET v_previous_related_user = (SELECT related_user FROM tbl_user WHERE user_id = v_userid);
			if v_previous_related_user != "" then
				UPDATE tbl_user SET related_user = CONCAT(p_userid, ",", v_previous_related_user) WHERE user_id = v_userid;
				ELSE
					UPDATE tbl_user SET related_user = p_userid WHERE user_id = v_userid;
			END if;
		END if;
	END IF;

-- mode 2
	IF(p_mode = 2) THEN
		-- update the record of user
		UPDATE tbl_user SET user_name = p_username, user_contact_no = p_contactno, user_gender = p_usergender, user_role = p_userrole, user_email_add = p_useremail, user_password = p_userpassword where user_id = p_userid;
		-- update the privilege of user
		set @p_privilegeid = p_userrole;
		call project_management_sp_for_privileges(@p_privilegeid,0,0,0,0,0,0,0,0,0,0,0,0,0,0,p_userid,p_usercreatedby,'',8);
	END IF;
	
-- mode 3
	IF(p_mode = 3) THEN
		-- disable the user to avoid login to system and avoid transaction and discard all privileges
		UPDATE tbl_user SET user_disabled = p_userdisabled where user_id = p_userid;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_for_user_2` (INOUT `p_userid` INT, IN `p_username` VARCHAR(25), IN `p_contactno` VARCHAR(10), IN `p_usergender` INT, IN `p_userrole` INT, IN `p_useremail` VARCHAR(30), IN `p_userpassword` VARCHAR(255), IN `p_userdisabled` INT, IN `p_usercreatedby` INT, IN `p_signupdate` DATETIME, IN `p_mode` INT)   BEGIN
	
-- mode 1
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
		SELECT user_id FROM tbl_user WHERE user_email_add = p_useremail AND user_password = p_userpassword;
		SET p_userid = user_id;
	END IF;
	
-- mode 3
	IF(p_mode = 3) THEN
		-- disable the user to avoid login to system and avoid transaction
		UPDATE tbl_user SET user_disabled = 1 where user_id = p_userid;
	END IF;

END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_of_gallery_details` (IN `p_imageoriginalname` VARCHAR(200), IN `p_imagenewname` VARCHAR(200), IN `p_imagepath` VARCHAR(300), IN `p_projectid` INT, IN `p_userid` INT, IN `p_imagedate` DATETIME, IN `p_mode` INT, INOUT `p_imageid` VARCHAR(255))   BEGIN
	DECLARE v_imgpath VARCHAR(255) DEFAULT '';
-- mode 1
	IF(p_mode = 1) THEN
		-- insert the new record of the image
		INSERT INTO tbl_gallery (gallery_original_name, gallery_new_name, gallery_path, project_id, user_id,gallery_added_date) VALUES (p_imageoriginalname, p_imagenewname, p_imagepath, p_projectid, p_userid, CURRENT_TIMESTAMP());
		SET p_imageid = LAST_INSERT_ID();
	END IF;

-- mode 2
	IF(p_mode = 2) THEN
		-- delete the record of image
		SET v_imgpath = (SELECT gallery_path FROM tbl_gallery WHERE gallery_id = p_imageid);
		DELETE FROM tbl_gallery WHERE gallery_id = p_imageid;
		SET p_imageid = v_imgpath;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_to_fetch_all_related_user` (IN `p_user_id` VARCHAR(50))   BEGIN
    DECLARE v_userid INT DEFAULT 0;
    DECLARE inputString VARCHAR(2000) DEFAULT '';
    DECLARE outputString VARCHAR(2000) DEFAULT '';
    DECLARE i INT DEFAULT 1;
    DECLARE isAdmin INT;
    SET isAdmin = (SELECT user_role FROM tbl_user WHERE user_id = p_user_id);

    IF isAdmin = 1 THEN
        SET inputString =  (SELECT related_user FROM tbl_user WHERE LOCATE(p_user_id, related_user));
        SET @TEMPTABLE = 'DROP TEMPORARY TABLE IF EXISTS temp_users';
        PREPARE stmt FROM @tempTable;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        -- SET @tempTable = 'CREATE TEMPORARY TABLE IF NOT EXISTS temp_users (user_id INT, user_name VARCHAR(255), user_contact_no VARCHAR(255), user_email_add VARCHAR(255), user_gender VARCHAR(10), user_role INT, user_password VARCHAR(255), user_disabled INT)';
        SET @tempTable = 'CREATE TEMPORARY TABLE IF NOT EXISTS temp_users (user_id INT, user_name VARCHAR(255), user_contact_no VARCHAR(255), user_gender VARCHAR(10), user_role INT, user_email_add VARCHAR(255), user_password VARCHAR(255), user_created_by INT(11), user_disabled INT, user_signup_date DATETIME, 
		  privilege_id INT(11), privilege_for_view_dashboard INT(11),	privilege_for_move_dashboard_content INT(11), 
		  privilege_for_view_project INT(11), privilege_for_add_new_project INT(11), privilege_for_edit_project INT(11),	
		  privilege_for_view_reports INT(11),	privilege_to_change_privilege INT(11),	privilege_for_create_user INT(11), 
		  privilege_for_view_and_edit_created_user INT(11), privilege_for_chat INT(11), privilege_for_upload_images INT(11),
		  privilege_for_delete_uploaded_images INT(11), privilege_for_upload_documents INT(11), privilege_for_delete_uploaded_documents INT(11),
		  privilege_user_id INT(11),	privilege_allowed_by INT(11), privilege_added_date DATETIME)';
        PREPARE stmt FROM @tempTable;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        WHILE i <= LENGTH(inputString) - LENGTH(REPLACE(inputString, ',', '')) + 1 DO
            SET v_userid = SUBSTRING_INDEX(SUBSTRING_INDEX(inputString, ',', i), ',', -1);
            IF v_userid != p_user_id THEN
                -- SET @insertQuery = CONCAT('INSERT INTO temp_users SELECT user_id, user_name, user_contact_no, user_email_add, user_gender, user_role, user_password, user_disabled FROM vw_user_privileges WHERE user_id = ', v_userid);
                SET @insertQuery = CONCAT('INSERT INTO temp_users SELECT * FROM vw_user_privileges WHERE user_id = ', v_userid);
                PREPARE stmt FROM @insertQuery;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
            END IF;
            SET i = i + 1;
        END WHILE;

        SET @selectQuery = 'SELECT * FROM temp_users';
        PREPARE stmt FROM @selectQuery;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    ELSE
        -- SET @selectQuery = CONCAT('SELECT user_id, user_name, user_contact_no, user_email_add, user_gender, user_role, user_password, user_disabled FROM vw_user_privileges WHERE user_created_by = ', p_user_id);
        SET @selectQuery = CONCAT('SELECT * FROM vw_user_privileges WHERE user_created_by = ', p_user_id);
        PREPARE stmt FROM @selectQuery;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `project_management_system_sp_to_fetch_project` (IN `p_user_id` INT, INOUT `p_project_list` VARCHAR(2000))   BEGIN
    DECLARE v_userid INT DEFAULT 0;
    DECLARE inputString VARCHAR(2000) DEFAULT '';
    DECLARE outputString VARCHAR(2000) DEFAULT '';
    DECLARE i INT DEFAULT 1;
    SET p_project_list = '';
    -- SET inputString = (SELECT related_user FROM tbl_user WHERE user_id = p_user_id);
    SET inputString =  (SELECT related_user FROM tbl_user WHERE LOCATE(p_user_id, related_user));

    WHILE i <= LENGTH(inputString) - LENGTH(REPLACE(inputString, ',', '')) + 1 DO
        SET v_userid = SUBSTRING_INDEX(SUBSTRING_INDEX(inputString, ',', i), ',', -1);
        SET outputString = (SELECT CONCAT(project_id, '#', project_name, '#', project_description, '#', project_added_date) FROM tbl_project WHERE user_id = v_userid);
        IF outputString IS NOT NULL THEN
            SET p_project_list = CONCAT(outputString, '*', p_project_list);
        END IF;
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_chat`
--

CREATE TABLE `tbl_chat` (
  `chat_id` int(11) NOT NULL,
  `chat_msg` varchar(500) NOT NULL,
  `chat_sendby` int(11) NOT NULL,
  `chatroom_id` int(11) NOT NULL,
  `chat_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_chat`
--

INSERT INTO `tbl_chat` (`chat_id`, `chat_msg`, `chat_sendby`, `chatroom_id`, `chat_datetime`) VALUES
(1, 'hi subuser', 1, 1, '2023-07-29 20:34:49'),
(2, 'kahi nahi super user', 4, 1, '2023-07-29 20:35:03'),
(3, 'kasa aahes', 1, 1, '2023-07-29 20:35:08'),
(4, 'okay madhe aahe sagla', 4, 1, '2023-07-29 20:35:21'),
(5, 'bok ki', 4, 1, '2023-07-29 20:37:11'),
(6, 'kahi nai', 1, 1, '2023-07-29 20:37:15'),
(7, 'ojlj;', 4, 1, '2023-07-29 20:37:19'),
(8, 'akjljlj', 1, 1, '2023-07-29 20:37:21'),
(9, 'jljjl', 4, 1, '2023-07-29 20:37:24'),
(10, 'dada', 1, 1, '2023-07-29 20:37:26'),
(11, 'saheb', 4, 1, '2023-07-29 20:37:29'),
(12, 'sarkar', 1, 1, '2023-07-29 20:37:32'),
(13, 'shet', 4, 1, '2023-07-29 20:37:35'),
(14, 'khasdar', 1, 1, '2023-07-29 20:37:39'),
(15, 'aamdar', 4, 1, '2023-07-29 20:37:44'),
(16, 'modi', 1, 1, '2023-07-29 20:37:47'),
(17, 'chodi', 4, 1, '2023-07-29 20:37:50'),
(18, 'chutiya', 1, 1, '2023-07-29 20:37:55'),
(19, 'mutiya', 4, 1, '2023-07-29 20:37:58'),
(20, 'lavada', 1, 1, '2023-07-29 20:38:02'),
(21, 'lasun', 4, 1, '2023-07-29 20:38:06'),
(22, 'randi', 1, 1, '2023-07-29 20:38:09'),
(23, 'rona', 4, 1, '2023-07-29 20:38:11'),
(24, 'gand', 1, 1, '2023-07-29 20:38:14'),
(25, 'marin', 4, 1, '2023-07-29 20:38:17'),
(26, 'tujay', 1, 1, '2023-07-29 20:38:21'),
(27, 'nahi jaat', 4, 1, '2023-07-29 20:38:27'),
(28, 'kare ', 1, 1, '2023-07-29 20:38:32'),
(29, 'mutiye', 4, 1, '2023-07-29 20:38:42');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_chatroom`
--

CREATE TABLE `tbl_chatroom` (
  `chatroom_id` int(11) NOT NULL,
  `chatroom_name` varchar(500) NOT NULL,
  `chatroom_created_by` int(11) NOT NULL,
  `chatroom_created_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_chatroom`
--

INSERT INTO `tbl_chatroom` (`chatroom_id`, `chatroom_name`, `chatroom_created_by`, `chatroom_created_date`) VALUES
(1, 'abc', 1, '2023-07-29 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_content`
--

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
(1, 'hello', '2023-07-26 16:20:18', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_count`
--

CREATE TABLE `tbl_count` (
  `count_id` int(11) NOT NULL,
  `count_doit` int(11) NOT NULL,
  `count_inprogress` int(11) NOT NULL,
  `count_verify` int(11) NOT NULL,
  `count_done` int(11) NOT NULL,
  `count_document` int(11) NOT NULL,
  `count_gallery` int(11) NOT NULL,
  `count_project` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_count`
--

INSERT INTO `tbl_count` (`count_id`, `count_doit`, `count_inprogress`, `count_verify`, `count_done`, `count_document`, `count_gallery`, `count_project`, `project_id`, `user_id`) VALUES
(1, 1, 0, 0, 0, 0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_document`
--

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
(7, 'What are the stages of Work on Project management systeam ? ', 'Do it , In Progress , Verify , Done \r\nIn its most basic form, a task board can be drawn on a whiteboard or even a section of wall. \r\nthe board is dived into 4 columns Do it , In Progress , Verify and Done \r\nThe user will dived the project in 4 sections Do it that is the team has to do that work \r\nin progress  means the work has started and it is in the process \r\nif the some of the part is done from the developer then that will be dragged in to Verify column so that the respective tester will get in touch with that and if any amendments then it will be again dragged in to Do it column .\r\nand the last section that is done these columns comes after first three stages if a particular task is coming through that three columns then finally by fulfilling all the requirements then task is done .', 1, 1, '2023-03-20 23:21:07'),
(8, 'abc', '', 0, 3, '2023-07-26 10:04:57'),
(9, 'asdf', '', 0, 3, '2023-07-26 10:05:21');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gallery`
--

CREATE TABLE `tbl_gallery` (
  `gallery_id` int(11) NOT NULL,
  `gallery_original_name` varchar(255) NOT NULL,
  `gallery_new_name` varchar(255) NOT NULL,
  `gallery_path` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `gallery_added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_gallery`
--

INSERT INTO `tbl_gallery` (`gallery_id`, `gallery_original_name`, `gallery_new_name`, `gallery_path`, `project_id`, `user_id`, `gallery_added_date`) VALUES
(10, 'report_process_dfd_page.jpg', '64c0ccfd0f08d0.15887135.jpg', 'user_uploaded_gallery/1/64c0ccfd0f08d0.15887135.jpg', 1, 4, '2023-07-26 13:06:29'),
(11, 'project_process_dfd_page.jpg', '64c0ccfd10dff7.71781021.jpg', 'user_uploaded_gallery/1/64c0ccfd10dff7.71781021.jpg', 1, 4, '2023-07-26 13:06:29');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_privileges`
--

CREATE TABLE `tbl_privileges` (
  `privilege_id` int(11) NOT NULL,
  `privilege_for_view_dashboard` int(11) NOT NULL DEFAULT 0,
  `privilege_for_move_dashboard_content` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_add_new_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_edit_project` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_reports` int(11) NOT NULL DEFAULT 0,
  `privilege_to_change_privilege` int(11) NOT NULL DEFAULT 0,
  `privilege_for_create_user` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_and_edit_created_user` int(11) NOT NULL,
  `privilege_for_chat` int(11) NOT NULL DEFAULT 0,
  `privilege_for_upload_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_upload_documents` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_documents` int(11) NOT NULL DEFAULT 0,
  `privilege_user_id` int(11) NOT NULL,
  `privilege_allowed_by` int(11) NOT NULL,
  `privilege_added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_privileges`
--

INSERT INTO `tbl_privileges` (`privilege_id`, `privilege_for_view_dashboard`, `privilege_for_move_dashboard_content`, `privilege_for_view_project`, `privilege_for_add_new_project`, `privilege_for_edit_project`, `privilege_for_view_reports`, `privilege_to_change_privilege`, `privilege_for_create_user`, `privilege_for_view_and_edit_created_user`, `privilege_for_chat`, `privilege_for_upload_images`, `privilege_for_delete_uploaded_images`, `privilege_for_upload_documents`, `privilege_for_delete_uploaded_documents`, `privilege_user_id`, `privilege_allowed_by`, `privilege_added_date`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2023-07-26 09:43:21'),
(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, '2023-07-26 13:02:36'),
(3, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 4, 3, '2023-07-26 13:04:46');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project`
--

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
(1, 'trial', 'trial', '2023-07-26 09:43:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(25) NOT NULL,
  `user_contact_no` varchar(10) NOT NULL,
  `user_gender` int(11) NOT NULL,
  `user_role` int(11) NOT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_by` int(11) NOT NULL,
  `related_user` varchar(255) NOT NULL,
  `user_disabled` int(11) NOT NULL DEFAULT 0,
  `user_signup_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_name`, `user_contact_no`, `user_gender`, `user_role`, `user_email_add`, `user_password`, `user_created_by`, `related_user`, `user_disabled`, `user_signup_date`) VALUES
(1, 'admin', '1234567890', 1, 1, 'admin@email.com', 'Admin123', 0, '4,3,1', 0, '2023-07-26 09:43:21'),
(2, 'user1', '1234567890', 1, 2, 'user1@email.com', 'User1234', 1, '', 0, '2023-07-26 13:00:23'),
(3, 'user3', '1234567890', 1, 2, 'user2@email.com', 'User1234', 1, '', 0, '2023-07-26 13:02:36'),
(4, 'subuser1', '1234567890', 1, 6, 'subuser1@email.com', 'User1234', 3, '', 0, '2023-07-26 13:04:46');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_privileges`
-- (See below for the actual view)
--
CREATE TABLE `vw_user_privileges` (
`user_id` int(11)
,`user_name` varchar(25)
,`user_contact_no` varchar(10)
,`user_gender` int(11)
,`user_role` int(11)
,`user_email_add` varchar(30)
,`user_password` varchar(255)
,`user_created_by` int(11)
,`user_disabled` int(11)
,`user_signup_date` datetime
,`privilege_id` int(11)
,`privilege_for_view_dashboard` int(11)
,`privilege_for_move_dashboard_content` int(11)
,`privilege_for_view_project` int(11)
,`privilege_for_add_new_project` int(11)
,`privilege_for_edit_project` int(11)
,`privilege_for_view_reports` int(11)
,`privilege_to_change_privilege` int(11)
,`privilege_for_create_user` int(11)
,`privilege_for_view_and_edit_created_user` int(11)
,`privilege_for_chat` int(11)
,`privilege_for_upload_images` int(11)
,`privilege_for_delete_uploaded_images` int(11)
,`privilege_for_upload_documents` int(11)
,`privilege_for_delete_uploaded_documents` int(11)
,`privilege_user_id` int(11)
,`privilege_allowed_by` int(11)
,`privilege_added_date` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `vw_user_privileges`
--
DROP TABLE IF EXISTS `vw_user_privileges`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_user_privileges`  AS SELECT `tbl_user`.`user_id` AS `user_id`, `tbl_user`.`user_name` AS `user_name`, `tbl_user`.`user_contact_no` AS `user_contact_no`, `tbl_user`.`user_gender` AS `user_gender`, `tbl_user`.`user_role` AS `user_role`, `tbl_user`.`user_email_add` AS `user_email_add`, `tbl_user`.`user_password` AS `user_password`, `tbl_user`.`user_created_by` AS `user_created_by`, `tbl_user`.`user_disabled` AS `user_disabled`, `tbl_user`.`user_signup_date` AS `user_signup_date`, `tbl_privileges`.`privilege_id` AS `privilege_id`, `tbl_privileges`.`privilege_for_view_dashboard` AS `privilege_for_view_dashboard`, `tbl_privileges`.`privilege_for_move_dashboard_content` AS `privilege_for_move_dashboard_content`, `tbl_privileges`.`privilege_for_view_project` AS `privilege_for_view_project`, `tbl_privileges`.`privilege_for_add_new_project` AS `privilege_for_add_new_project`, `tbl_privileges`.`privilege_for_edit_project` AS `privilege_for_edit_project`, `tbl_privileges`.`privilege_for_view_reports` AS `privilege_for_view_reports`, `tbl_privileges`.`privilege_to_change_privilege` AS `privilege_to_change_privilege`, `tbl_privileges`.`privilege_for_create_user` AS `privilege_for_create_user`, `tbl_privileges`.`privilege_for_view_and_edit_created_user` AS `privilege_for_view_and_edit_created_user`, `tbl_privileges`.`privilege_for_chat` AS `privilege_for_chat`, `tbl_privileges`.`privilege_for_upload_images` AS `privilege_for_upload_images`, `tbl_privileges`.`privilege_for_delete_uploaded_images` AS `privilege_for_delete_uploaded_images`, `tbl_privileges`.`privilege_for_upload_documents` AS `privilege_for_upload_documents`, `tbl_privileges`.`privilege_for_delete_uploaded_documents` AS `privilege_for_delete_uploaded_documents`, `tbl_privileges`.`privilege_user_id` AS `privilege_user_id`, `tbl_privileges`.`privilege_allowed_by` AS `privilege_allowed_by`, `tbl_privileges`.`privilege_added_date` AS `privilege_added_date` FROM (`tbl_user` join `tbl_privileges` on(`tbl_user`.`user_id` = `tbl_privileges`.`privilege_user_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_chat`
--
ALTER TABLE `tbl_chat`
  ADD PRIMARY KEY (`chat_id`);

--
-- Indexes for table `tbl_chatroom`
--
ALTER TABLE `tbl_chatroom`
  ADD PRIMARY KEY (`chatroom_id`);

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
  ADD KEY `user_id` (`privilege_user_id`);

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
-- AUTO_INCREMENT for table `tbl_chat`
--
ALTER TABLE `tbl_chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tbl_chatroom`
--
ALTER TABLE `tbl_chatroom`
  MODIFY `chatroom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_content`
--
ALTER TABLE `tbl_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_count`
--
ALTER TABLE `tbl_count`
  MODIFY `count_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_document`
--
ALTER TABLE `tbl_document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  MODIFY `gallery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_privileges`
--
ALTER TABLE `tbl_privileges`
  MODIFY `privilege_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_project`
--
ALTER TABLE `tbl_project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
