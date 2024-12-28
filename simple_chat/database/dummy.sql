use simple_chat;

-- Insert into `user_`
INSERT INTO `user_` (`uid`, `user_name`, `user_password`, `state`)
VALUES
(1, 'Alice', 'password1', 'Signed'),
(2, 'Bob', 'password2', 'Signed'),
(3, 'Charlie', 'password3', 'Signed_Out');

-- Insert into `u_profile`
INSERT INTO `u_profile` (`uid`, `u_name`, `img`)
VALUES
(1, 'Alice', 'alice.jpg'),
(2, 'Bob', 'bob.jpg'),
(3, 'Charlie', 'charlie.jpg');

-- Insert into `msg`
INSERT INTO `msg` (`msg_id`, `messege`)
VALUES
(1, 'Hello!'),
(2, 'How are you?'),
(3, 'Goodbye.'),
(4, 'How are you?2');

-- Insert into `chat_history`
INSERT INTO `chat_history` (`chat_id`, `sender_id`, `time_stamp`, `msg_id`, `chat_type`)
VALUES
(1, 1, '2024-12-26 10:00:00', 1, 'Single'),
(2, 2, '2024-12-26 10:05:00', 2, 'Single'),
(3, 3, '2024-12-26 10:10:00', 3, 'Group');

-- Insert into `connect`
INSERT INTO `connect` (`uid_1`, `uid_2`)
VALUES
(1, 2),
(2, 3);

-- Insert into `group_`
INSERT INTO `group_` (`group_id`, `group_name`)
VALUES
(1, 'Group A'),
(2, 'Group B');

-- Insert into `group_chat`
INSERT INTO `group_chat` (`chat_id`, `group_id`)
VALUES
(2, 1);

-- Insert into `group_member`
INSERT INTO `group_member` (`group_id`, `member_id`, `post`)
VALUES
(1, 1, 'Admin'),
(1, 2, 'Member'),
(2, 3, 'Member');

-- Insert into `request`
INSERT INTO `request` (`request_id`, `sender_id`, `reciver_id`, `state`, `time_stamp`)
VALUES
(1, 1, 2, 'Pending', '2024-12-26 11:00:00'),
(2, 2, 3, 'Accepted', '2024-12-26 11:10:00');

-- Insert into `single_chat`
INSERT INTO `single_chat` (`chat_id`, `reciver_id`)
VALUES
(1, 2),
(2, 3);

-- Insert into `state`
INSERT INTO `state` (`state_id`, `uid`, `msg_id`, `time_stamp`)
VALUES
(1, 1, 4, '2024-12-28 12:00:00'),
(2, 2, 4, '2024-12-28 12:10:00');
