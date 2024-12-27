const express = require("express");
const userController = require("../controller/user_controller");

const router = express.Router();

// Define routes
router.post("/create", userController.createUser);
router.post("/signin",userController.signIn);
router.post("/signout",userController.signOut);
router.post("/update",userController.updateProfile);
router.post("/get",userController.getProfile);

module.exports = router;
