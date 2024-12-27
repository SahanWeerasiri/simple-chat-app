const contactController = require('../controller/contact_controller');
const express = require("express");

const router = express.Router();

router.post('/getall', contactController.getAllContacts);
router.post('/getmy', contactController.getMyContacts);
router.post('/send', contactController.sendRequest);
router.post('/response', contactController.responseRequest);
router.post('/myrequests', contactController.showMyRequests);
router.post('/theirrequest', contactController.showTheirRequests);

module.exports = router;