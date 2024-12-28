const {pool} = require('../db');

// Get all the contacts
// CALL `simple_chat`.`get_all_contacts`(<{IN p_uid INT}>);
const getAllContacts = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL get_all_contacts(?)", [
        uid
    ]);
    return { result};
};

// Get my contacts
// CALL `simple_chat`.`get_my_contacts`(<{IN p_uid INT}>);
const getMyContacts = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL get_my_contacts(?)", [
        uid
    ]);
    return { result };
};

// Send request
// CALL `simple_chat`.`send_request`(<{IN p_uid INT}>, <{IN p_friend_uid INT}>);
const sendRequest = async (userData) => {
    const {uid, friendUid} = userData;
    const [result] = await pool.query("CALL send_request(?,?)", [
        uid,
        friendUid
    ]);
    return {result};
};

// Response request
// CALL `simple_chat`.`response_request`(<{IN p_uid INT}>, <{IN p_friend_uid INT}>, <{IN p_state ENUM("Accepted","Rejected")}>);
const responseRequest = async (userData) => {
    const {uid, friendUid, state} = userData;
    const [result] = await pool.query("CALL response_request(?,?,?)", [
        uid,
        friendUid,
        state
    ]);
    return {result};
};

// Remove contact
// CALL `simple_chat`.`remove_contact`(<{IN p_uid INT}>, <{IN p_foe_id INT}>);
const removeContact = async (userData) => {
    const {uid, foeUid} = userData;
    const [result] = await pool.query("CALL remove_contact(?,?)", [
        uid,
        foeUid,
    ]);
    return {result};
};

// Show my requests
// CALL `simple_chat`.`show_my_request`(<{IN p_uid INT}>);
const showMyRequests = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL show_my_request(?)", [
        uid
    ]);
    return { result };
};

// Show their requests
// CALL `simple_chat`.`show_their_request`(<{IN p_uid INT}>);
const showTheirRequests = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL show_their_request(?)", [
        uid
    ]);
    return { result };
};

module.exports = {
    getAllContacts,
    getMyContacts,
    sendRequest,
    responseRequest,
    showMyRequests,
    showTheirRequests,
    removeContact
};
    


