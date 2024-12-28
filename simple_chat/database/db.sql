DROP DATABASE IF EXISTS simple_chat;

CREATE DATABASE simple_chat;

use simple_chat;

DROP TABLE IF EXISTS user_;
CREATE TABLE user_(
    uid INT PRIMARY KEY AUTO_INCREMENT,
	user_name TEXT,
    user_password TEXT,
    state ENUM("Signed","Signed_Out")
);

DROP TABLE IF EXISTS msg;
CREATE TABLE msg(
	msg_id INT PRIMARY KEY AUTO_INCREMENT,
    messege TEXT
);

DROP TABLE IF EXISTS chat_history;
CREATE TABLE chat_history(
	chat_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    time_stamp timestamp,
    msg_id INT,
    chat_type ENUM("Single","Group"),
    FOREIGN KEY (sender_id) REFERENCES user_(uid),
    FOREIGN KEY (msg_id) REFERENCES msg(msg_id)
);

DROP TABLE IF EXISTS single_chat;
CREATE TABLE single_chat(
	chat_id INT PRIMARY KEY,
    reciver_id INT,
    FOREIGN KEY (reciver_id) REFERENCES user_(uid),
    FOREIGN KEY (chat_id) REFERENCES chat_history(chat_id)
);

DROP TABLE IF EXISTS group_;
CREATE TABLE group_(
	group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name TEXT
);

DROP TABLE IF EXISTS group_member;
CREATE TABLE group_member(
	group_id INT,
    member_id INT,
    post ENUM('Admin','Member'),
    PRIMARY KEY (group_id,member_id),
    FOREIGN KEY (group_id) REFERENCES group_(group_id),
    FOREIGN KEY (member_id) REFERENCES user_(uid)
);

DROP TABLE IF EXISTS group_chat;
CREATE TABLE group_chat(
	chat_id INT PRIMARY KEY,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES group_(group_id),
    FOREIGN KEY (chat_id) REFERENCES chat_history(chat_id)
);

DROP TABLE IF EXISTS u_profile;
CREATE TABLE u_profile(
	uid INT PRIMARY KEY,
    u_name TEXT,
    img TEXT,
    FOREIGN KEY (uid) REFERENCES user_(uid)
);

DROP TABLE IF EXISTS request;
CREATE TABLE request(
	request_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    reciver_id INT,
    state ENUM("Pending","Accepted","Rejected"),
    time_stamp timestamp,
    FOREIGN KEY (sender_id) REFERENCES user_(uid),
    FOREIGN KEY (reciver_id) REFERENCES user_(uid)
);

DROP TABLE IF EXISTS connect;
CREATE TABLE connect(
    uid_1 INT,
    uid_2 INT,
    PRIMARY KEY (uid_1,uid_2),
    FOREIGN KEY (uid_1) REFERENCES user_(uid),
    FOREIGN KEY (uid_2) REFERENCES user_(uid)
);

DROP TABLE IF EXISTS state;
CREATE TABLE state(
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    uid INT,
    msg_id INT,
    time_stamp timestamp,
    FOREIGN KEY (uid) REFERENCES user_(uid),
    FOREIGN KEY (msg_id) REFERENCES msg(msg_id)
);

-- Procedures

DROP PROCEDURE IF EXISTS create_account;
DELIMITER $$
CREATE PROCEDURE create_account(
	IN p_u_name TEXT,
	IN p_user_name TEXT,
    IN p_user_password TEXT
)
BEGIN
	DECLARE v_user_name_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    DECLARE v_uid INT;
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    IF p_user_name = "" OR p_user_password = "" OR p_u_name = "" THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User name, name and password can not be empty';
    END IF;
    
    IF LENGTH(p_user_password)<8 THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password should have atleast 8 characters';
    END IF;
    
    SELECT COUNT(*)>0 INTO v_user_name_exists
    FROM user_
    WHERE user_name = p_user_name;
    
    IF v_user_name_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User name is already in use. Try another';
    END IF;
    
    INSERT INTO user_(user_name,user_password,state) VALUES(p_user_name,p_user_password,"Signed_Out");
    
    SET v_uid = LAST_INSERT_ID();
    
    INSERT INTO u_profile(uid,u_name) VALUES(v_uid,p_u_name);
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS sign_in;
DELIMITER $$
CREATE PROCEDURE sign_in(
	IN p_user_name TEXT,
    IN p_user_password TEXT
)
BEGIN
	DECLARE v_match_exists BOOLEAN;
    DECLARE v_uid INT;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    IF p_user_name = "" OR p_user_password = "" THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User name and password can not be empty';
    END IF;
    
    SELECT COUNT(*)>0 INTO v_match_exists
    FROM user_
    WHERE user_name = p_user_name AND user_password = p_user_password;
    
    IF NOT v_match_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User name or Password is incorrect. Try another';
    END IF;
    
    SELECT uid INTO v_uid
    FROM user_
    WHERE user_name = p_user_name AND user_password = p_user_password;
    
    UPDATE user_ SET state = "Signed" WHERE uid = v_uid;
    
    SELECT v_uid;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS sign_out;
DELIMITER $$
CREATE PROCEDURE sign_out(
	IN p_uid INT
)
BEGIN    
    START TRANSACTION;
    
    UPDATE user_ SET state = "Signed_Out" WHERE uid = p_uid;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_all_contacts;
DELIMITER $$
CREATE PROCEDURE get_all_contacts(
	IN p_uid INT
)
BEGIN
	SELECT * FROM u_profile WHERE (NOT(uid = p_uid)) AND ((uid NOT IN (SELECT uid_1 FROM connect WHERE uid_2=p_uid)) AND (uid NOT IN (SELECT uid_2 FROM connect WHERE uid_1=p_uid))); 
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_my_contacts;
DELIMITER $$
CREATE PROCEDURE get_my_contacts(
	IN p_uid INT
)
BEGIN
	SELECT * FROM u_profile WHERE uid IN (SELECT uid_1 FROM connect WHERE uid_2 = p_uid) OR uid IN (SELECT uid_2 FROM connect WHERE uid_1 = p_uid); 
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS send_request;
DELIMITER $$
CREATE PROCEDURE send_request(
	IN p_uid INT,
    IN p_friend_uid INT
)
BEGIN
	DECLARE v_request_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_request_exists
    FROM request
    WHERE sender_id = p_uid AND reciver_id = p_friend_uid;
    
    IF  v_request_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have already sent a request';
    END IF;
    
    INSERT INTO request(sender_id,reciver_id,state,time_stamp) VALUES(p_uid,p_friend_uid,"Pending",CURRENT_TIMESTAMP);
        
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS response_request;
DELIMITER $$
CREATE PROCEDURE response_request(
	IN p_uid INT,
    IN p_friend_uid INT,
    IN p_state ENUM("Accepted","Rejected")
)
BEGIN
	DECLARE v_request_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_request_exists
    FROM request
    WHERE reciver_id = p_uid AND sender_id = p_friend_uid;
    
    IF NOT v_request_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Request is not existed';
    END IF;
    
    UPDATE request SET state = p_state, time_stamp = CURRENT_TIMESTAMP WHERE sender_id = p_friend_uid AND reciver_id = p_uid;
    
    IF p_state = "Accepted" THEN
		INSERT INTO connect(uid_1,uid_2) VALUES(p_friend_uid,p_uid);
    END IF;
        
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS show_my_request;
DELIMITER $$
CREATE PROCEDURE show_my_request(
	IN p_uid INT
)
BEGIN
	SELECT request_id,u_name,img,state,time_stamp FROM request INNER JOIN u_profile ON reciver_id = uid WHERE sender_id = p_uid;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS show_their_request;
DELIMITER $$
CREATE PROCEDURE show_their_request(
	IN p_uid INT
)
BEGIN
	SELECT request_id,u_name,img,state,time_stamp FROM request INNER JOIN u_profile ON sender_id = uid WHERE reciver_id = p_uid;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_contact;
DELIMITER $$
CREATE PROCEDURE remove_contact(
	IN p_uid INT,
    IN p_foe_id INT
)
BEGIN
	DELETE FROM connect WHERE (uid_1 = p_uid AND uid_2 = p_foe_id) OR (uid_2 = p_uid AND uid_1 = p_foe_id); 
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS send_msg;
DELIMITER $$
CREATE PROCEDURE send_msg(
	IN p_uid INT,
    IN p_friend_uid INT,
    IN p_msg TEXT,
    IN p_type ENUM("Single","Group")
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_msg_id INT;
    DECLARE v_chat_id INT;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM connect
    WHERE (uid_1 = p_uid AND uid_2 = p_friend_uid) OR (uid_2 = p_uid AND uid_1 = p_friend_uid);
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that reciver';
    END IF;
    
    INSERT INTO msg(messege) VALUES (p_msg);
    
    SET v_msg_id = LAST_INSERT_ID();
    
    INSERT INTO chat_history(sender_id,time_stamp,msg_id,chat_type) VALUES(p_uid,CURRENT_TIMESTAMP,v_msg_id,p_type);
    
    SET v_chat_id = LAST_INSERT_ID();
    
    IF p_type = "Single" THEN
		INSERT INTO single_chat(chat_id,reciver_id) VALUES (v_chat_id,p_friend_uid);
	ELSE
		INSERT INTO group_chat(chat_id,group_id) VALUES (v_chat_id,p_friend_uid);
	END IF;
    
    COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_msg;
DELIMITER $$
CREATE PROCEDURE get_msg(
	IN p_uid INT,
    IN p_friend_uid INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_msg_id INT;
    DECLARE v_chat_id INT;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM connect
    WHERE (uid_1 = p_uid AND uid_2 = p_friend_uid) OR (uid_2 = p_uid AND uid_1 = p_friend_uid);
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that reciver';
    END IF;
    
	SELECT sender_id,time_stamp,messege,u_name FROM 
	(((chat_history INNER JOIN single_chat ON chat_history.chat_id = single_chat.chat_id) 
	INNER JOIN u_profile ON sender_id = uid )) 
    INNER JOIN msg ON chat_history.msg_id = msg.msg_id
	WHERE (sender_id = p_uid AND reciver_id = p_friend_uid) OR (reciver_id = p_uid AND sender_id = p_friend_uid) ORDER BY time_stamp ASC;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_group_msg;
DELIMITER $$
CREATE PROCEDURE get_group_msg(
	IN p_uid INT,
	IN p_group_id INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_msg_id INT;
    DECLARE v_chat_id INT;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_uid;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that group';
    END IF;
        
	SELECT sender_id,time_stamp,messege,u_name FROM 
	((chat_history INNER JOIN group_chat ON chat_history.chat_id = group_chat.chat_id) 
	INNER JOIN u_profile ON sender_id = uid ) INNER JOIN msg ON msg.msg_id = chat_history.msg_id
	WHERE group_id = p_group_id ORDER BY time_stamp ASC;

    COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_group_members;
DELIMITER $$
CREATE PROCEDURE get_group_members(
	IN p_uid INT,
	IN p_group_id INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_uid;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that group';
    END IF;
    
    SELECT uid,u_name,img FROM u_profile INNER JOIN group_member ON u_profile.uid = group_member.member_id WHERE group_id = p_group_id;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS create_group;
DELIMITER $$
CREATE PROCEDURE create_group(
	IN p_uid INT,
	IN p_name TEXT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_group_id INT;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    IF p_name = "" THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Group name can not be empty';
    END IF;
    
    INSERT INTO group_(group_name) VALUES(p_name);
    
    SET v_group_id = LAST_INSERT_ID();
    
    INSERT INTO group_member(group_id, member_id, post) VALUES (v_group_id,p_uid,"Admin");
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS add_group_members;
DELIMITER $$
CREATE PROCEDURE add_group_members(
	IN p_uid INT,
    IN p_group_id INT,
	IN p_friend_id INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_friend_connection_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_uid;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that group';
    END IF;
    
    SELECT COUNT(*)>0 INTO v_friend_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_friend_id;
    
    IF v_friend_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Your friend is already in the group';
    END IF;
    
    INSERT INTO group_member(group_id, member_id,post) VALUES (p_group_id,p_friend_id,"Member");
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_members;
DELIMITER $$
CREATE PROCEDURE remove_members(
	IN p_uid INT,
    IN p_foe_id INT,
    IN p_group_id INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    DECLARE v_is_admin BOOLEAN;
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_uid;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not connected with that group';
    END IF;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM group_member
    WHERE group_id = p_group_id AND member_id = p_foe_id;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Foe have not connected with that group';
    END IF;
    
    SELECT post = "Admin" INTO v_is_admin FROM group_member WHERE group_id = p_group_id AND member_id = p_uid;
    
    IF NOT v_is_admin THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You are not the admin';
    END IF;
    
    DELETE FROM group_member WHERE member_id = p_foe_id; 
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_groups;
DELIMITER $$
CREATE PROCEDURE get_groups(
	IN p_uid INT
)
BEGIN
    
    START TRANSACTION;
    
    SELECT * FROM group_ WHERE group_id IN (SELECT group_id FROM group_member WHERE member_id = p_uid);
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_profile;
DELIMITER $$
CREATE PROCEDURE get_profile(
	IN p_uid INT
)
BEGIN
    
    START TRANSACTION;
    
    SELECT * FROM u_profile WHERE uid = p_uid;
    
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_profile;
DELIMITER $$
CREATE PROCEDURE update_profile(
	IN p_uid INT,
    IN p_name TEXT,
    IN p_img TEXT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    IF p_name = "" THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Your name can not be empty';
    END IF;
    
    UPDATE u_profile SET u_name = p_name, img = p_img;
    
    COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS add_status;
DELIMITER $$
CREATE PROCEDURE add_status(
	IN p_uid INT,
    IN p_msg TEXT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    DECLARE v_msg_id INT;
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    INSERT INTO msg(messege) VALUES(p_msg);
    
    SET v_msg_id = LAST_INSERT_ID();
    
    INSERT INTO state(uid,msg_id) VALUES(p_uid,v_msg_id,CURRENT_TIMESTAMP);
    
    COMMIT;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_status;
DELIMITER $$
CREATE PROCEDURE get_status(
	IN p_uid INT
)
BEGIN
	DECLARE v_connection_exists BOOLEAN;
    DECLARE v_error_message VARCHAR(255);
    
    -- Error handler to capture error message
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_message = MESSAGE_TEXT;

        -- Rollback the transaction
        ROLLBACK;

        -- Signal an error with a custom message
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = v_error_message;
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*)>0 INTO v_connection_exists
    FROM connect
    WHERE uid_1 = p_uid OR uid_2 = p_uid;
    
    IF NOT v_connection_exists THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have not any contact';
    END IF;
    
     -- Delete expired status
    DELETE FROM state WHERE time_stamp < NOW() - INTERVAL 1 DAY;
    DELETE FROM msg WHERE msg_id NOT IN (SELECT msg_id FROM state) AND msg_id NOT IN (SELECT msg_id FROM chat_history);
    
    SELECT messege,u_name,state_id AS status_id FROM 
    ((state INNER JOIN msg ON state.msg_id = msg.msg_id)
    INNER JOIN u_profile ON state.uid = u_profile.uid) 
    WHERE state.uid IN (SELECT uid_1 FROM connect WHERE uid_2 = p_uid) OR state.uid IN (SELECT uid_2 FROM connect WHERE uid_1 = p_uid);
        
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_my_status;
DELIMITER $$
CREATE PROCEDURE get_my_status(
	IN p_uid INT
)
BEGIN
    
    START TRANSACTION;
    
     -- Delete expired status
    DELETE FROM state WHERE time_stamp < NOW() - INTERVAL 1 DAY;
    DELETE FROM msg WHERE msg_id NOT IN (SELECT msg_id FROM state) AND msg_id NOT IN (SELECT msg_id FROM chat_history);
    
    SELECT messege,state_id AS status_id FROM 
    state INNER JOIN msg ON state.msg_id = msg.msg_id
    WHERE state.uid = p_uid;
        
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_status;
DELIMITER $$
CREATE PROCEDURE delete_status(
	IN p_uid INT,
    IN p_status_id INT
)
BEGIN
    
    START TRANSACTION;
    
    DELETE FROM state WHERE state_id = p_status_id;
    
    DELETE FROM msg WHERE msg_id NOT IN (SELECT msg_id FROM state) AND msg_id NOT IN (SELECT msg_id FROM chat_history);
    
    COMMIT;
END $$
DELIMITER ;