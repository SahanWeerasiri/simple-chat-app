const { pool } = require("../db");

// send messege
// CALL `simple_chat`.`send_msg`(<{IN p_uid INT}>, <{IN p_friend_uid INT}>, <{IN p_msg TEXT}>, <{IN p_type ENUM("Single","Group")}>);
const sendMessege = async (userData) => {
    const { uid, friend_uid, msg, type } = userData;
    const [result] = await pool.query("CALL send_msg(?,?,?,?)", [
        uid,
        friend_uid,
        msg,
        type
    ]);
    return { result};
};

// get messages
// CALL `simple_chat`.`get_msg`(<{IN p_uid INT}>, <{IN p_friend_uid INT}>);
const getMessages = async (userData) => {
    const { uid, friend_uid } = userData;
    const [result] = await pool.query("CALL get_msg(?,?)", [
        uid,
        friend_uid
    ]);
    return { result };
};

module.exports = {
    sendMessege,
    getMessages
};
    

