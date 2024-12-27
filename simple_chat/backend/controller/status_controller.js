const statusModel = require('../model/status_model');

const addStatus = async(req,res)=>{
    try {
        console.log("Adding status...")
        const {result} = await statusModel.addStatus(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Adding status successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const deleteStatus = async(req,res)=>{
    try {
        console.log("Deleting status...")
        const {result} = await statusModel.deleteStatus(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Deleting status successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getMyStatus = async(req,res)=>{
    try {
        console.log("Getting my status...")
        const {result} = await statusModel.getMyStatus(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Getting my status successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getStatus = async(req,res)=>{
    try {
        console.log("Getting status...")
        const {result} = await statusModel.getStatus(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Getting status successful"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    addStatus,
    deleteStatus,
    getMyStatus,
    getStatus
};