const mongoose = require("mongoose");
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
const MONGOOSE_API =
  "mongodb+srv://senpai:Senpai%401122@cluster0.eteyoyt.mongodb.net/test?retryWrites=true&w=majority";

// Import routes
const authRouter = require("./router/auth");

// Middleware
app.use(express.json());
app.use(authRouter);

// Connect to MongoDB using Mongoose
mongoose
  .connect(MONGOOSE_API)
  .then(() => console.log("MongoDB connected successfully"))
  .catch((error) => console.error("MongoDB connection error:", error));

// Start the server
app.listen(PORT, "0.0.0.0", () =>
  console.log(`Server is running on port ${PORT}`)
);
