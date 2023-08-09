const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const express = require("express");
const authRouter = express.Router();
const User = require("../models/User");
const { PASSWORD_KEY } = require("../const");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: "This email is already in use!" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);
    const user = await User.create({ name, email, password: hashedPassword });

    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const existingUser = await User.findOne({ email });

    if (!existingUser) {
      return res.status(400).json({ msg: "User not found!" });
    }

    const isValid = await bcrypt.compare(password, existingUser.password);

    if (!isValid) {
      return res.status(401).json({ msg: "Invalid Password" });
    }

    const token = jwt.sign({ id: existingUser._id }, PASSWORD_KEY);
    res.json({ token, existingUser });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post("/api/updateUser", async (req, res) => {
  try {
    const { id, name, address } = req.body;
    const user = await User.findById(id);

    if (!user) {
      return res.status(400).json({ msg: "User not found!" });
    }

    if (name) user.name = name;
    if (address) user.address = address;

    await user.save();
    const token = jwt.sign({ id: id }, PASSWORD_KEY);
    res.json({ token, user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;
