const express = require("express");
const userRoutes = require("./routes/user_routes");
const chatRouts = require("./routes/chat_routes");
// const groupRoutes = require("./routes/group_routes");
// const statusRoutes = require("./routes/status_routes");
const contactRoutes = require("./routes/contact_routes");

const app = express();
app.use(express.json());

// API routes
app.use("/api/users", userRoutes);
app.use("/api/chats", chatRouts);
// app.use("/api/status", statusRoutes);
// app.use("/api/groups", groupRoutes);
app.use("/api/contacts", contactRoutes);

// Server listening
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
