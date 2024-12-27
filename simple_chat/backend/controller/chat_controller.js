const chatModule = require('../model/chat_model');

// Send messeges
const sendMesseges = async (req, res) => {
    try {
        console.log("Sending messege...")
        const result = await chatModule.sendMessege(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Messege sent successfully"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

// get messege
const getMessages = async (req, res) => {
    try {
        console.log("Getting messeges...")
        const result = await chatModule.getMessages(req.body);
        console.log(result)
        res.status(201).json({
            msg: "Messege recieved successfully",
            data: result[0]
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    sendMesseges,
    getMessages
};