const chatController = require('../controller/chat_controller');
const express = require("express");

const router = express.Router();

router.post('/send',chatController.sendMesseges);
router.get('/get',chatController.getMessages);

module.exports = router;