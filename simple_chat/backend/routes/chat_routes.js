const chatController = require('../controller/chat_controller');
const express = require("express");

const router = express.Router();

router.post('/send',chatController.sendMesseges);
router.post('/get',chatController.getMessages);

module.exports = router;