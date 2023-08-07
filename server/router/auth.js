const express = require("express");
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "This email is already in use!" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log(email);

    const existingUser = await User.findOne({ email });
    if (existingUser == null) {
      return res.status(400).json({ msg: "User not found!" });
    }

    const isValid = await bcrypt.compare(password, existingUser['password']);
    if(!isValid) {
      return res.status(401).json({msg: "Invalid Password"});
    }

    return res.json({msg: "User is valid"});

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
