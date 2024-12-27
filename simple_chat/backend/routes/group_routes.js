const groupController = require('../controller/group_controller');
const express = require("express");

const router = express.Router();

router.post('/create',groupController.createGroup);
router.post('/add',groupController.addGroupMembers);
router.post('/member',groupController.getGroupMembers);
router.post('/remove',groupController.removeMembers);
router.post('/group',groupController.getGroups);
router.post('/msg',groupController.getGroupMsg);

module.exports = router;