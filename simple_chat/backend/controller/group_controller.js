const groupModel = require('../model/group_model');

const addGroupMembers = async(req,res)=>{
    try {
        console.log("Adding group members...")
        const {result} = await groupModel.addGroupMembers(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Adding group members successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getGroups = async(req,res)=>{
    try {
        console.log("Getting groups...")
        const {result} = await groupModel.getGroups(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Getting groups successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const createGroup = async(req,res)=>{
    try {
        console.log("Creating group...")
        const {result} = await groupModel.createGroup(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Creating groups successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getGroupMsg = async(req,res)=>{
    try {
        console.log("Getting group msg...")
        const {result} = await groupModel.getGroupMsg(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Getting group msg successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getGroupMembers = async(req,res)=>{
    try {
        console.log("Getting group members...")
        const {result} = await groupModel.getGroupMembers(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Getting group members successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const removeMembers = async(req,res)=>{
    try {
        console.log("Removing group members...")
        const {result} = await groupModel.removeMembers(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Removing group members successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    createGroup,
    addGroupMembers,
    getGroupMembers,
    getGroupMsg,
    getGroups,
    removeMembers
};
