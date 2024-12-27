const statusController = require('../controller/status_controller');
const express = require("express");

const router = express.Router();

router.post('/add',statusController.addStatus);
router.post('/delete',statusController.deleteStatus);
router.post('/getmy',statusController.getMyStatus);
router.post('/get',statusController.getStatus);

module.exports = router;