const { pool } = require("../db");

// Create new user
const createUser = async (userData) => {
    const { name, user_name, password } = userData;
    const [result] = await pool.query("CALL create_account(?, ?, ?)", [
        name,
        user_name,
        password,
    ]);
    return { result};
};

// Sign in
const signIn = async (userData) => {
    const { user_name, password } = userData;
    const [result] = await pool.query("CALL sign_in(?, ?)", [
        user_name,
        password,
    ]);
    return { result};
};

// Sign out
const signOut = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL sign_out(?)", [
        uid
    ]);
    return { result};
};

// Update Profile
const updateProfile = async (userData) => {
    const { uid ,name, img } = userData;
    const [result] = await pool.query("CALL sign_in(?, ?, ?)", [
        uid,
        name,
        img,
    ]);
    return { result};
};

// Get profile
// CALL `simple_chat`.`get_profile`(<{IN p_uid INT}>);
const getProfile = async (userData) => {
    const { uid } = userData;
    const [result] = await pool.query("CALL get_profile(?)", [
        uid
    ]);
    return { result};
};

module.exports = {
    createUser,
    signIn,
    signOut,
    updateProfile,
    getProfile
};