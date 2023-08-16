const mongoose = require("mongoose");
require("dotenv").config();
const cors = require("cors");
const express = require("express");
const app = express();
const PORT = process.env.PORT || 5000;

// Import routes
const authRouter = require("./router/auth");
const exploreRouter = require("./router/explore");
const itemRouter = require("./router/item");

// Middleware
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(exploreRouter);
app.use(itemRouter);

// Connect to MongoDB using Mongoose
mongoose
  .connect(process.env.MONGOOSE_API)
  .then(() => console.log("MongoDB connected successfully"))
  .catch((error) => console.error("MongoDB connection error:", error));

// Start the server
app.listen(PORT, "0.0.0.0", () =>
  console.log(`Server is running on port ${PORT}`)
);
