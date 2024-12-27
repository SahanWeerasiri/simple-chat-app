const express = require("express");
const userRoutes = require("./routes/user_routes");

const app = express();
app.use(express.json());

// API routes
app.use("/api/users", userRoutes);

// Server listening
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
