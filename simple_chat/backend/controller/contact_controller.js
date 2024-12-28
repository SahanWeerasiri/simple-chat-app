const contactModel = require('../model/contact_model');

const getAllContacts = async(req,res)=>{
    try {
        console.log("Getting all the contacts...")
        const {result} = await contactModel.getAllContacts(req.body);
        console.log(result)
        res.status(200).json({
            msg: "all contacts getting successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const getMyContacts = async(req,res)=>{
    try {
        console.log("Getting my contacts...")
        const {result} = await contactModel.getMyContacts(req.body);
        console.log(result)
        res.status(200).json({
            msg: "My contacts getting successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const sendRequest = async(req,res)=>{
    try {
        console.log("Sending a request...")
        const {result} = await contactModel.sendRequest(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Sending a request successful",
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const responseRequest = async(req,res)=>{
    try {
        console.log("Responsing to a request...")
        const {result} = await contactModel.responseRequest(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Sending response successful",
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const removeContact = async(req,res)=>{
    try {
        console.log("Removing a contact...")
        const {result} = await contactModel.removeContact(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Removing a contact successful",
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

const showMyRequests = async(req,res)=>{
    try {
        console.log("Getting my requests...")
        const {result} = await contactModel.showMyRequests(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Getting my requests successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};


const showTheirRequests = async(req,res)=>{
    try {
        console.log("Getting their requests...")
        const {result} = await contactModel.showTheirRequests(req.body);
        console.log(result)
        res.status(200).json({
            msg: "Getting their requests successful",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    sendRequest,
    responseRequest,
    showMyRequests,
    showTheirRequests,
    getAllContacts,
    getMyContacts,
    removeContact  
};