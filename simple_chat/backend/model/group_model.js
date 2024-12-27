const {pool} = require('../db');

// Add group members
// CALL `simple_chat`.`add_group_members`(<{IN p_uid INT}>, <{IN p_group_id INT}>, <{IN p_friend_id INT}>);
const addGroupMembers = async (userData) => {
    const {uid, group_id, friend_id} = userData;
    const [result] = await pool.query("CALL add_group_members(?,?,?)", [
        uid,
        group_id,
        friend_id
    ]);
    return { result};
};

// Create group
// CALL `simple_chat`.`create_group`(<{IN p_uid INT}>, <{IN p_name TEXT}>);
const createGroup = async (userData) => {
    const {uid, name} = userData;
    const [result] = await pool.query("CALL create_group(?,?)", [
        uid,
        name
    ]);
    return { result};
};

// Get groups
// CALL `simple_chat`.`get_groups`(<{IN p_uid INT}>);
const getGroups = async (userData) => {
    const {uid} = userData;
    const [result] = await pool.query("CALL get_groups(?)", [
        uid
    ]);
    return { result};
};

// Get group messege
// CALL `simple_chat`.`get_group_msg`(<{IN p_uid INT}>, <{IN p_group_id INT}>);
const getGroupMsg = async (userData) => {
    const {uid, group_id} = userData;
    const [result] = await pool.query("CALL get_group_msg(?,?)", [
        uid,
        group_id
    ]);
    return { result};
};

// Get group members
// CALL `simple_chat`.`get_group_members`(<{IN p_uid INT}>, <{IN p_group_id INT}>);
const getGroupMembers = async (userData) => {
    const {uid, group_id} = userData;
    const [result] = await pool.query("CALL get_group_members(?,?)", [
        uid,
        group_id
    ]);
    return { result};
};

// Remove members
// CALL `simple_chat`.`remove_members`(<{IN p_uid INT}>, <{IN p_foe_id INT}>, <{IN p_group_id INT}>);
const removeMembers = async (userData) => {
    const {uid, foe_id, group_id} = userData;
    const [result] = await pool.query("CALL remove_members(?,?,?)", [
        uid,
        foe_id,
        group_id
    ]);
    return { result};
};


module.exports = {
    createGroup,
    getGroupMsg,
    getGroupMembers,
    removeMembers,
    addGroupMembers,
    getGroups
};
