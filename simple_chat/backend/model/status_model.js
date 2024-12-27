const {pool} = require('../db');

// Add status
// CALL `simple_chat`.`add_status`(<{IN p_uid INT}>, <{IN p_msg TEXT}>);
const addStatus = async (userData) => {
    const {uid, msg} = userData;
    const [result] = await pool.query("CALL add_status(?,?)", [
        uid,
        msg
    ]);
    return { result};
};

// Delete Status
// CALL `simple_chat`.`delete_status`(<{IN p_uid INT}>, <{IN p_status_id INT}>);
const deleteStatus = async (userData) => {
    const {uid, statusId} = userData;
    const [result] = await pool.query("CALL delete_status(?,?)", [
        uid,
        statusId
    ]);
    return { result};
};

// My status
// CALL `simple_chat`.`get_my_status`(<{IN p_uid INT}>);
const getMyStatus = async (userData) => {
    const {uid} = userData;
    const [result] = await pool.query("CALL get_my_status(?)", [
        uid
    ]);
    return { result};
};

// Get status
// CALL `simple_chat`.`get_status`(<{IN p_uid INT}>);
const getStatus = async (userData) => {
    const {uid} = userData;
    const [result] = await pool.query("CALL get_status(?)", [
        uid
    ]);
    return { result};
};

module.exports = {
    addStatus,
    deleteStatus,
    getMyStatus,
    getStatus
};
