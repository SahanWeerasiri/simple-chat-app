const { pool } = require("../db");

// Get all users
exports.getAllUsers = async () => {
    const [rows] = await pool.query("SELECT * FROM users");
    return rows;
};

// Get user by ID
exports.getUserById = async (id) => {
    const [rows] = await pool.query("SELECT * FROM users WHERE id = ?", [id]);
    return rows[0];
};

// Create new user
exports.createUser = async (userData) => {
    const { name, email, password } = userData;
    const [result] = await pool.query("INSERT INTO users (name, email, password) VALUES (?, ?, ?)", [
        name,
        email,
        password,
    ]);
    return { id: result.insertId, ...userData };
};

// Update user
exports.updateUser = async (id, userData) => {
    const { name, email, password } = userData;
    const [result] = await pool.query("UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?", [
        name,
        email,
        password,
        id,
    ]);
    return result.affectedRows > 0 ? { id, ...userData } : null;
};

// Delete user
exports.deleteUser = async (id) => {
    const [result] = await pool.query("DELETE FROM users WHERE id = ?", [id]);
    return result.affectedRows > 0;
};
