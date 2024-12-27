const userModel = require("../model/user_model");

// Create new user
const createUser = async (req, res) => {
    try {
        console.log("Creating a new account...")
        const result = await userModel.createUser(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Account creation successull"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

// Sign in
const signIn = async (req, res) => {
    try {
        console.log("Sign In...")
        const {result} = await userModel.signIn(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Sign in successful",
            data: result[0][0].v_uid
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

// Sign out
const signOut = async (req, res) => {
    try {
        console.log("Sign out...")
        const result = await userModel.signOut(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Sign out successfull"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

// Update profile
const updateProfile = async (req, res) => {
    try {
        console.log("Profile updating...")
        const result = await userModel.updateProfile(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Profile updated successfully"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

// Get user details
const getProfile = async (req, res) => {
    try {
        console.log("Profile updating...")
        const result = await userModel.getProfile(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Profile recieved successfully",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    signIn,
    signOut,
    updateProfile,
    createUser,
    getProfile
};