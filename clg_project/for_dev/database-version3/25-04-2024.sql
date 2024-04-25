-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2024 at 04:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
CREATE DATABASE IF NOT EXISTS `project_management_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `project_management_system`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_content`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_content` (IN `p_userid` INT, IN `p_contentid` INT, IN `p_content` VARCHAR(100), IN `p_sectionholdingid` TINYINT, IN `p_projectid` INT, IN `p_mode` TINYINT, INOUT `o_outparameter` INT)   BEGIN
        -- mode 1 insert the new record of content
        IF(p_mode = 1) THEN
        -- inserting the content record in the tbl_content
    INSERT INTO tbl_content(
        content,
        content_added_date,
        section_holding_ids,
        project_id,
        user_id
    )
VALUES(
    p_content,
    CURRENT_TIMESTAMP(), p_sectionholdingid, p_projectid, p_userid) ;
    -- setting the last insert id to out parameter
SET
    o_outparameter = LAST_INSERT_ID() ;
    -- update the count of do it by 1
UPDATE
    tbl_count
SET
    count_doit = count_doit + 1
WHERE
    project_id = p_projectid ;
    END IF ;
    -- mode 2 if content is moved
    IF(p_mode = 2) THEN
    -- getting previous section id of that content
SET
    @previous_section_holding_div =(
    SELECT
        section_holding_ids
    FROM
        tbl_content
    WHERE
        content_id = p_contentid AND project_id = p_projectid
) ;
-- setting last update id equal to 0
SET
    @LastUpdateID = 0 ;
    -- updating the content id
UPDATE
    tbl_content
SET
    section_holding_ids = p_sectionholdingid,
    content_id =(
    SELECT
        @LastUpdateID := content_id
)
WHERE
    content_id = p_contentid AND project_id = p_projectid ;
    -- setting last update id
SET
    o_outparameter = @LastUpdateID ;
    -- if previous section id is 1 and new section id is 2 means this content is moved from do it section to in progress section
    IF(
        @previous_section_holding_div = 1 AND p_sectionholdingid = 2
    ) THEN
UPDATE
    tbl_count
SET
    count_doit = count_doit -1,
    count_inprogress = count_inprogress +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 1 and new section id is 3 means this content is moved from do it section to verify section
    ELSEIF(
        @previous_section_holding_div = 1 AND p_sectionholdingid = 3
    ) THEN
UPDATE
    tbl_count
SET
    count_doit = count_doit -1,
    count_verify = count_verify +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 1 and new section id is 4 means this content is moved from do it section to done section
    ELSEIF(
        @previous_section_holding_div = 1 AND p_sectionholdingid = 4
    ) THEN
UPDATE
    tbl_count
SET
    count_doit = count_doit -1,
    count_done = count_done +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 2 and new section id is 1 means this content is moved from in progress section to do it section
    ELSEIF(
        @previous_section_holding_div = 2 AND p_sectionholdingid = 1
    ) THEN
UPDATE
    tbl_count
SET
    count_inprogress = count_inprogress -1,
    count_doit = count_doit +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 2 and new section id is 3 means this content is moved from in progress section to verify section
    ELSEIF(
        @previous_section_holding_div = 2 AND p_sectionholdingid = 3
    ) THEN
UPDATE
    tbl_count
SET
    count_inprogress = count_inprogress -1,
    count_verify = count_verify +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 2 and new section id is 4 means this content is moved from in progress section to done section
    ELSEIF(
        @previous_section_holding_div = 2 AND p_sectionholdingid = 4
    ) THEN
UPDATE
    tbl_count
SET
    count_inprogress = count_inprogress -1,
    count_done = count_done +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 3 and new section id is 1 means this content is moved from verify section to do it section
    ELSEIF(
        @previous_section_holding_div = 3 AND p_sectionholdingid = 1
    ) THEN
UPDATE
    tbl_count
SET
    count_verify = count_verify -1,
    count_doit = count_doit +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 3 and new section id is 2 means this content is moved from verify section to in progress section
    ELSEIF(
        @previous_section_holding_div = 3 AND p_sectionholdingid = 2
    ) THEN
UPDATE
    tbl_count
SET
    count_verify = count_verify -1,
    count_inprogress = count_inprogress +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 3 and new section id is 4 means this content is moved from verify section to done section
    ELSEIF(
        @previous_section_holding_div = 3 AND p_sectionholdingid = 4
    ) THEN
UPDATE
    tbl_count
SET
    count_verify = count_verify -1,
    count_done = count_done +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 4 and new section id is 1 means this content is moved from done section to do it section
    ELSEIF(
        @previous_section_holding_div = 4 AND p_sectionholdingid = 1
    ) THEN
UPDATE
    tbl_count
SET
    count_done = count_done -1,
    count_doit = count_doit +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 4 and new section id is 2 means this content is moved from done section to in progress section
    ELSEIF(
        @previous_section_holding_div = 4 AND p_sectionholdingid = 2
    ) THEN
UPDATE
    tbl_count
SET
    count_done = count_done -1,
    count_inprogress = count_inprogress +1
WHERE
    project_id = p_projectid ;
    -- if previous section id is 4 and new section id is 3 means this content is moved from done section to verify section
    ELSEIF(
        @previous_section_holding_div = 4 AND p_sectionholdingid = 3
    ) THEN
UPDATE
    tbl_count
SET
    count_done = count_done -1,
    count_verify = count_verify +1
WHERE
    project_id = p_projectid ;
END IF ;
    END IF ;
    -- mode 3 if content is modified
    IF(p_mode = 3) THEN
    -- updating the content text
UPDATE
    tbl_content
SET
    content = p_content
WHERE
    content_id = p_contentid ;
    -- setting the content id to out parameter
SET
    o_outparameter = p_contentid ;
END IF ;
-- mode 4 if content is deleted
IF(p_mode = 4) THEN
-- deleting the content 
DELETE
FROM
    tbl_content
WHERE
    content_id = p_contentid ;
    -- setting the content id to out parameter
SET
    o_outparameter = p_contentid ;
END IF ;
END$$

DROP PROCEDURE IF EXISTS `sp_document`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_document` (INOUT `p_documentid` INT, IN `p_documentoriginalname` VARCHAR(100), IN `p_documentnewname` VARCHAR(100), IN `p_documentpath` VARCHAR(200), IN `p_projectid` INT, IN `p_userid` INT, IN `p_mode` TINYINT)   BEGIN
        -- mode 1 to insert the record of document
        IF(p_mode = 1) THEN
        -- insert the new record of the document
    INSERT INTO tbl_document(
        document_original_name,
        document_new_name,
        document_path,
        project_id,
        user_id,
        document_added_date
    )
VALUES(
    p_documentoriginalname,
    p_documentnewname,
    p_documentpath,
    p_projectid,
    p_userid,
    CURRENT_TIMESTAMP());
    -- update the count of document
UPDATE
    tbl_count
SET
    count_document = count_document + 1
WHERE
    project_id = p_projectid;
    -- setting the inserted record's id to the out parameter
SET
    p_documentid = LAST_INSERT_ID();
    END IF;
    -- mode 2 to delete the document
    IF(p_mode = 2) THEN
    -- update the count of document
UPDATE
    tbl_count
SET
    count_document = count_document - 1
WHERE
    project_id = p_projectid;
    -- delete the record of document
DELETE
FROM
    tbl_document
WHERE
    document_id = p_documentid;
END IF;
    END$$

DROP PROCEDURE IF EXISTS `sp_fetchproject`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchproject` (IN `p_user_id` INT, INOUT `p_project_list` VARCHAR(2000))   BEGIN
	-- declaring some variable
	DECLARE v_userid INT DEFAULT 0;

	-- declaring user holding string
	DECLARE userstring VARCHAR(2000) DEFAULT '';

	-- declaring variable to hold list of the project
	DECLARE outputString VARCHAR(2000) DEFAULT '';

	-- declaring value of variable i which is used for iterate while loop
	DECLARE i INT DEFAULT 1;

	-- setting inout parameter's value equal to ''
	SET p_project_list = '';

	-- getting related users and setting to variable
	SET userstring =  (SELECT related_user FROM tbl_user WHERE LOCATE(p_user_id, related_user));

	-- using while loop to access the project id, name, description and added date
	WHILE i <= LENGTH(userstring) - LENGTH(REPLACE(userstring, ',', '')) + 1 DO
        	SET v_userid = SUBSTRING_INDEX(SUBSTRING_INDEX(userstring, ',', i), ',', -1);

	        SET outputString = (SELECT GROUP_CONCAT(CONCAT(project_id, '#', project_name, '#', project_description, '#', project_added_date) SEPARATOR '*') FROM tbl_project WHERE user_id = v_userid);

        	IF outputString IS NOT NULL THEN
            		SET p_project_list = CONCAT(outputString, '*', p_project_list);
        	END IF;
        	SET i = i + 1;
    	END WHILE;

end$$

DROP PROCEDURE IF EXISTS `sp_gallery`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_gallery` (INOUT `p_imageid` VARCHAR(255), IN `p_userid` INT, IN `p_projectid` INT, IN `p_imageoriginalname` VARCHAR(200), IN `p_imagenewname` VARCHAR(200), IN `p_imagepath` VARCHAR(300), IN `p_mode` INT)   BEGIN
        DECLARE v_imgpath VARCHAR(255) DEFAULT '';
-- mode 1 to insert the record of image
        IF(p_mode = 1) THEN
                -- insert the new record of the image
                INSERT INTO tbl_gallery (gallery_original_name, gallery_new_name, gallery_path, project_id, user_id) VALUES (p_imageoriginalname, p_imagenewname, p_imagepath, p_projectid, p_userid);

		-- update the count of images
                -- UPDATE tbl_count SET count_gallery = count_gallery + 1 WHERE project_id = p_projectid;
                SET p_imageid = LAST_INSERT_ID();
        END IF;

-- mode 2 to delete the image
        IF(p_mode = 2) THEN
                -- delete the record of image
                SET v_imgpath = (SELECT gallery_path FROM tbl_gallery WHERE gallery_id = p_imageid);
                DELETE FROM tbl_gallery WHERE gallery_id = p_imageid;

		-- update the count of images
                -- UPDATE tbl_count SET count_gallery = count_gallery - 1 WHERE project_id = p_projectid;
                SET p_imageid = v_imgpath;
        END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_insert_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_user` (OUT `p_inserted_userid` INT, IN `p_username` VARCHAR(25), IN `p_userrole` INT, IN `p_useremail` VARCHAR(30), IN `p_userpassword` VARCHAR(255), IN `p_usercreatedby` INT)   BEGIN
    -- Insert the new record of the user
    INSERT INTO tbl_user (
        user_name,
        user_role,
        user_email_add,
        user_password,
        user_created_by
    )
    VALUES (
        p_username,
        p_userrole,
        p_useremail,
        p_userpassword,
        p_usercreatedby
    );

    -- Setting newly created user id to OUT parameter
    SET p_inserted_userid = LAST_INSERT_ID();

    -- If user is admin, update related_user
    IF p_userrole = 1 THEN
        UPDATE tbl_user
        SET related_user = p_inserted_userid
        WHERE user_id = p_inserted_userid;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_privileges`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_privileges` (INOUT `p_privilegeid` INT, IN `p_viewdashboard` INT, IN `p_movecontent` INT, IN `p_viewproject` INT, IN `p_addproject` INT, IN `p_editproject` INT, IN `p_viewreport` INT, IN `p_changeprivilege` INT, IN `p_createuser` INT, IN `p_viewedituser` INT, IN `p_uploadimages` INT, IN `p_deleteimages` INT, IN `p_uploaddocuments` INT, IN `p_deletedocuments` INT, IN `p_userid` INT, IN `p_whoallowinguserid` INT, IN `p_mode` INT)   BEGIN

-- mode 1 when user is admin
	IF(p_mode = 1) THEN
		-- insert the new record of the privilege
                INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_to_change_privilege,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid);
                SET p_privilegeid = LAST_INSERT_ID();

-- mode 2 when user is sub admin
	elseif (p_mode = 2) THEN
                -- insert the new record of the privilege
                INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by) VALUES (1,1,1,1,1,1,1,1,1,1,1,1,p_userid,p_whoallowinguserid);
                SET p_privilegeid = LAST_INSERT_ID();

-- mode 3 when user is requirement gatherer
	elseif (p_mode = 3) THEN
                -- insert the new record of the privilege
                INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by) VALUES (1,0,1,1,0,0,0,0,0,0,1,0,p_userid,p_whoallowinguserid);
                SET p_privilegeid = LAST_INSERT_ID();

-- mode 4 when user is developer
	elseif (p_mode = 4) THEN
        -- insert the new record of the privilege
                INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by) VALUES (1,1,0,0,0,0,0,0,1,0,1,0,p_userid,p_whoallowinguserid);
                SET p_privilegeid = LAST_INSERT_ID();

-- mode 5 when user is tester
	elseif (p_mode = 5) THEN
                -- insert the new record of the privilege
                INSERT INTO tbl_privileges (privilege_for_view_dashboard, privilege_for_move_dashboard_content,privilege_for_view_project,privilege_for_add_new_project,privilege_for_edit_project,privilege_for_view_reports,privilege_for_create_user,privilege_for_view_and_edit_created_user,privilege_for_upload_images,privilege_for_delete_uploaded_images,privilege_for_upload_documents,privilege_for_delete_uploaded_documents,privilege_user_id,privilege_allowed_by) VALUES (1,1,0,0,0,0,0,0,0,0,1,0,p_userid,p_whoallowinguserid);
                SET p_privilegeid = LAST_INSERT_ID();

-- mode 6 when user is custom while editing user
	elseif (p_mode = 6) THEN
                UPDATE tbl_user SET user_role = 6 WHERE user_id = p_userid;
                UPDATE tbl_privileges SET privilege_for_view_dashboard = p_viewdashboard, privilege_for_move_dashboard_content = p_movecontent, privilege_for_view_project = p_viewproject, privilege_for_add_new_project = p_addproject,
                privilege_for_edit_project = p_editproject,privilege_for_view_reports = p_viewreport,privilege_for_create_user = p_createuser,privilege_for_view_and_edit_created_user = p_viewedituser,privilege_for_upload_images = p_uploadimages,privilege_for_delete_uploaded_images = p_deleteimages,privilege_for_upload_documents = p_uploaddocuments,privilege_for_delete_uploaded_documents = p_deletedocuments,privilege_to_change_privilege = p_changeprivilege WHERE tbl_privileges.privilege_user_id = p_userid;
                SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);

        -- mode 7 when user is disabled
	elseif (p_mode = 7) THEN
                UPDATE tbl_privileges SET privilege_for_view_dashboard = 0, privilege_for_move_dashboard_content = 0, privilege_for_view_project = 0, privilege_for_add_new_project = 0,
                privilege_for_edit_project = 0,privilege_for_view_reports = 0,privilege_to_change_privilege = 0,privilege_for_create_user = 0,privilege_for_view_and_edit_created_user = 0,privilege_for_upload_images = 0,privilege_for_delete_uploaded_images = 0,privilege_for_upload_documents = 0,privilege_for_delete_uploaded_documents = 0, privilege_allowed_by=p_whoallowinguserid WHERE tbl_privileges.privilege_user_id = p_userid;
                SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);

-- mode 8 when user privelge right changed
	elseif (p_mode = 8) THEN
                CASE p_privilegeid

                -- when user become sub admin
                        WHEN 2 THEN
                                set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 1;set p_addproject = 1;set p_editproject = 1;set p_viewreport = 1;set p_createuser = 1;set p_viewedituser = 1;set p_uploadimages = 1;set p_deleteimages = 1;set p_uploaddocuments = 1;set p_deletedocuments = 1;set  p_changeprivilege = 1;

                -- when user become requirement gatherer
                        WHEN 3 THEN
                                set p_viewdashboard = 1;set p_movecontent = 0;set p_viewproject = 1;set p_addproject = 1;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_uploadimages = 0;set p_deleteimages = 0;set p_uploaddocuments = 1;set p_deletedocuments = 0;set  p_changeprivilege = 0;
                                -- 1,0,1,1,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()

                -- when user become developer
                        WHEN 4 THEN
                                set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 0;set p_addproject = 0;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_uploadimages = 1;set p_deleteimages = 0;set p_uploaddocuments = 1;             set p_deletedocuments = 0;set  p_changeprivilege = 0;
                                -- 1,1,0,0,0,0,0,0,1,1,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()

                -- when user become tester
                        WHEN 5 THEN
                                set p_viewdashboard = 1;set p_movecontent = 1;set p_viewproject = 0;set p_addproject = 0;set p_editproject = 0;set p_viewreport = 0;set p_createuser = 0;set p_viewedituser = 0;set p_uploadimages = 0;set p_deleteimages = 0;set p_uploaddocuments = 1;set p_deletedocuments = 0;set  p_changeprivilege = 0;
                                -- 1,1,0,0,0,0,0,0,1,0,0,1,0,p_userid,p_whoallowinguserid,CURRENT_TIMESTAMP()
END CASE;

                UPDATE tbl_privileges SET privilege_for_view_dashboard = p_viewdashboard, privilege_for_move_dashboard_content = p_movecontent, privilege_for_view_project = p_viewproject, privilege_for_add_new_project = p_addproject,
                privilege_for_edit_project = p_editproject,privilege_for_view_reports = p_viewreport,privilege_to_change_privilege =  p_changeprivilege,privilege_for_create_user = p_createuser,privilege_for_view_and_edit_created_user = p_viewedituser,privilege_for_upload_images = p_uploadimages,privilege_for_delete_uploaded_images = p_deleteimages,privilege_for_upload_documents = p_uploaddocuments,privilege_for_delete_uploaded_documents = p_deletedocuments WHERE tbl_privileges.privilege_user_id = p_userid;
                SET p_privilegeid = (SELECT privilege_id FROM tbl_privileges WHERE privilege_user_id = p_userid);
        END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_project` (IN `p_userid` INT, IN `p_projectid` INT, IN `p_projectname` VARCHAR(20), IN `p_projectdescription` VARCHAR(1000), IN `p_mode` TINYINT, INOUT `p_outparameter` INT)   begin
    -- Declare a variable to store the last inserted project ID
    DECLARE projectid INT;

    -- Mode 1: Insert the record of the project
    IF (p_mode = 1) THEN
        INSERT INTO tbl_project (project_name, project_description, user_id) 
        VALUES (p_projectname, p_projectdescription, p_userid);

        -- Get the last inserted project ID
        SET projectid = LAST_INSERT_ID();

        -- Set the OUT parameter to the last inserted project ID
        SET p_outparameter = projectid;
    END IF;


-- mode 2 to modify the project
	if (p_mode = 2) then
		SET p_outparameter = p_projectid;
		update tbl_project set project_name = p_projectname , project_description = p_projectdescription where project_id = p_projectid;
	end if;

-- mode 3 to delete the project
	if (p_mode = 3) then
		delete from tbl_project where project_id = p_projectid;
		SET @p_outparameter = p_projectid;
	end if;

end$$

DROP PROCEDURE IF EXISTS `sp_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user` (INOUT `p_userid` INT, IN `p_username` VARCHAR(25), IN `p_userrole` INT, IN `p_useremail` VARCHAR(30), IN `p_userpassword` VARCHAR(255), IN `p_userdisabled` INT, IN `p_usercreatedby` INT, IN `p_mode` INT)   BEGIN
    DECLARE v_previous_related_user VARCHAR(255) DEFAULT "";
    DECLARE v_user_created_by INT DEFAULT 0;
    DECLARE v_userid INT DEFAULT 0;
    DECLARE userid INT;
    
    -- Mode 1: Create new user
    IF p_mode = 1 THEN
        -- Insert the new record of the user
        INSERT INTO tbl_user (
            user_name,
            user_role,
            user_email_add,
            user_password,
            user_created_by
        )
        VALUES (
            p_username,
            p_userrole,
            p_useremail,
            p_userpassword,
            p_usercreatedby
        );

        -- Setting newly created user id to out parameter
	SET userid = LAST_INSERT_ID();
        SET p_userid = userid;

        -- If user is admin, update related_user
        IF p_userrole = 1 THEN
            UPDATE tbl_user
            SET related_user = p_userid
            WHERE user_id = p_userid;
        END IF;

        -- Call sp_privileges to set user privileges
        SET @p_privilegeid = 0;
        CALL sp_privileges(@p_privilegeid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, p_userid, p_usercreatedby, p_userrole);

        -- Update previous related user if exists
        IF p_usercreatedby != 0 THEN
            FETCH_USER_ID_LOOP:LOOP
                SET v_user_created_by = (
                    SELECT user_created_by
                    FROM tbl_user
                    WHERE user_id = p_usercreatedby
                );

                IF v_user_created_by = 0 THEN
                    SET v_userid = p_usercreatedby;
                    LEAVE FETCH_USER_ID_LOOP;
                ELSE
                    SET p_usercreatedby = v_user_created_by;
                END IF;
            END LOOP FETCH_USER_ID_LOOP;

            -- Get previous related user
            SELECT related_user INTO v_previous_related_user FROM tbl_user WHERE user_id = v_userid;

            -- Update related user list
            IF v_previous_related_user != "" THEN
                UPDATE tbl_user
                SET related_user = CONCAT(p_userid, ",", v_previous_related_user)
                WHERE user_id = v_userid;
            ELSE
                UPDATE tbl_user
                SET related_user = p_userid
                WHERE user_id = v_userid;
            END IF;
        END IF; 
    END IF;

    -- Mode 2: Update user
    IF p_mode = 2 THEN
        -- Update the record of user
        UPDATE tbl_user
        SET
            user_name = p_username,
            user_role = p_userrole,
            user_email_add = p_useremail,
            user_password = p_userpassword
        WHERE user_id = p_userid;

        -- Update user privileges
        SET @p_privilegeid = p_userrole;
        CALL sp_privileges(@p_privilegeid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, p_userid, p_usercreatedby, 8);
    END IF; 

    -- Mode 3: Delete user
    IF p_mode = 3 THEN
        -- Delete user privileges
        DELETE FROM tbl_privileges WHERE privilege_user_id = p_userid;

        -- Delete user
        DELETE FROM tbl_user WHERE user_id = p_userid;
    END IF; 

    -- Mode 4: Disable user
    IF p_mode = 4 THEN
        -- Disable the user
        UPDATE tbl_user
        SET user_disabled = p_userdisabled
        WHERE user_id = p_userid;
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
  `content_added_date` datetime DEFAULT current_timestamp(),
  `section_holding_ids` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `count_document` int(11) NOT NULL,
  `count_gallery` int(11) NOT NULL,
  `count_project` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `document_added_date` datetime DEFAULT current_timestamp()
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
  `faq_added_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `gallery_added_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_issue`
--

DROP TABLE IF EXISTS `tbl_issue`;
CREATE TABLE `tbl_issue` (
  `issue_id` int(11) NOT NULL,
  `issue` varchar(200) DEFAULT NULL,
  `issue_reported_by` int(11) DEFAULT NULL,
  `issue_reported_date` datetime DEFAULT NULL
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
  `privilege_to_change_privilege` int(11) NOT NULL DEFAULT 0,
  `privilege_for_create_user` int(11) NOT NULL DEFAULT 0,
  `privilege_for_view_and_edit_created_user` int(11) NOT NULL,
  `privilege_for_upload_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_images` int(11) NOT NULL DEFAULT 0,
  `privilege_for_upload_documents` int(11) NOT NULL DEFAULT 0,
  `privilege_for_delete_uploaded_documents` int(11) NOT NULL DEFAULT 0,
  `privilege_user_id` int(11) NOT NULL,
  `privilege_allowed_by` int(11) NOT NULL,
  `privilege_added_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project`
--

DROP TABLE IF EXISTS `tbl_project`;
CREATE TABLE `tbl_project` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(20) DEFAULT NULL,
  `project_description` varchar(1000) NOT NULL,
  `project_added_date` datetime DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(25) NOT NULL,
  `user_role` int(11) NOT NULL,
  `user_email_add` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_by` int(11) NOT NULL,
  `related_user` varchar(255) NOT NULL,
  `user_disabled` int(11) NOT NULL DEFAULT 0,
  `user_signup_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_privileges`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `vw_user_privileges`;
CREATE TABLE `vw_user_privileges` (
`user_id` int(11)
,`user_name` varchar(25)
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

DROP VIEW IF EXISTS `vw_user_privileges`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_user_privileges`  AS SELECT `tbl_user`.`user_id` AS `user_id`, `tbl_user`.`user_name` AS `user_name`, `tbl_user`.`user_role` AS `user_role`, `tbl_user`.`user_email_add` AS `user_email_add`, `tbl_user`.`user_password` AS `user_password`, `tbl_user`.`user_created_by` AS `user_created_by`, `tbl_user`.`user_disabled` AS `user_disabled`, `tbl_user`.`user_signup_date` AS `user_signup_date`, `tbl_privileges`.`privilege_id` AS `privilege_id`, `tbl_privileges`.`privilege_for_view_dashboard` AS `privilege_for_view_dashboard`, `tbl_privileges`.`privilege_for_move_dashboard_content` AS `privilege_for_move_dashboard_content`, `tbl_privileges`.`privilege_for_view_project` AS `privilege_for_view_project`, `tbl_privileges`.`privilege_for_add_new_project` AS `privilege_for_add_new_project`, `tbl_privileges`.`privilege_for_edit_project` AS `privilege_for_edit_project`, `tbl_privileges`.`privilege_for_view_reports` AS `privilege_for_view_reports`, `tbl_privileges`.`privilege_to_change_privilege` AS `privilege_to_change_privilege`, `tbl_privileges`.`privilege_for_create_user` AS `privilege_for_create_user`, `tbl_privileges`.`privilege_for_view_and_edit_created_user` AS `privilege_for_view_and_edit_created_user`, `tbl_privileges`.`privilege_for_upload_images` AS `privilege_for_upload_images`, `tbl_privileges`.`privilege_for_delete_uploaded_images` AS `privilege_for_delete_uploaded_images`, `tbl_privileges`.`privilege_for_upload_documents` AS `privilege_for_upload_documents`, `tbl_privileges`.`privilege_for_delete_uploaded_documents` AS `privilege_for_delete_uploaded_documents`, `tbl_privileges`.`privilege_user_id` AS `privilege_user_id`, `tbl_privileges`.`privilege_allowed_by` AS `privilege_allowed_by`, `tbl_privileges`.`privilege_added_date` AS `privilege_added_date` FROM (`tbl_user` join `tbl_privileges` on(`tbl_user`.`user_id` = `tbl_privileges`.`privilege_user_id`)) ;

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
-- Indexes for table `tbl_issue`
--
ALTER TABLE `tbl_issue`
  ADD PRIMARY KEY (`issue_id`),
  ADD KEY `issue_reported_by` (`issue_reported_by`);

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
  ADD UNIQUE KEY `user_email_add` (`user_email_add`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_content`
--
ALTER TABLE `tbl_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_count`
--
ALTER TABLE `tbl_count`
  MODIFY `count_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_document`
--
ALTER TABLE `tbl_document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  MODIFY `gallery_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_issue`
--
ALTER TABLE `tbl_issue`
  MODIFY `issue_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_privileges`
--
ALTER TABLE `tbl_privileges`
  MODIFY `privilege_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_project`
--
ALTER TABLE `tbl_project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
