const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const express = require("express");
const authRouter = express.Router();
const User = require("../models/User");
const {
  PASSWORD_KEY,
  SIGN_UP,
  SIGN_IN,
  UPDATE_USER,
  GET_USER,
} = require("../const");

const generateToken = (id) => jwt.sign({ id }, PASSWORD_KEY);

authRouter.post(SIGN_UP, async (req, res) => {
  try {
    const { user, method } = req.body;
    const { name, email, password, phone, downloadableProfileUrl } = user;

    let existingUser = await User.findOne({ email });

    if (existingUser) {
      if (method === 0) {
        return res.status(400).json({ msg: "This email is already in use!" });
      } else if (method === 1) {
        return res.json({
          token: generateToken(existingUser._id),
          ...existingUser._doc,
        });
      }
    }

    const hashedPassword = await bcrypt.hash(password, 8);
    const newUser = new User({ name, email, password: hashedPassword });

    if (phone) newUser.phoneNo = phone;
    if (downloadableProfileUrl)
      newUser.downloadableProfileUrl = downloadableProfileUrl;

    await newUser.save();

    res.json({
      token: generateToken(newUser._id),
      ...newUser._doc,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post(SIGN_IN, async (req, res) => {
  try {
    const { email, password } = req.body;
    const newUser = await User.findOne({ email });
    if (!newUser) {
      return res.status(400).json({ msg: "User not found!" });
    }

    const isValid = await bcrypt.compare(password, newUser.password);

    if (!isValid) {
      return res.status(401).json({ msg: "Invalid Password" });
    }

    res.json({
      token: generateToken(newUser._id),
      ...newUser._doc,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post(UPDATE_USER, async (req, res) => {
  try {
    const { _id, name, address, phone, downloadableProfileUrl, profileUrl } =
      req.body;
    const newUser = await User.findById(_id);

    if (!newUser) {
      return res.status(400).json({ msg: "User not found!" });
    }

    if (name) newUser.name = name;
    if (address) newUser.address = address;
    if (phone) newUser.phoneNo = phone;
    if (downloadableProfileUrl)
      newUser.downloadableProfileUrl = downloadableProfileUrl;
    if (profileUrl) newUser.profileUrl = profileUrl;

    await newUser.save();
    res.json({
      token: generateToken(_id),
      ...newUser._doc,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.get(`${GET_USER}/:email`, async (req, res) => {
  try {
    const email = req.params.email;
    const existingUser = await User.findOne({ email });

    if (!existingUser) {
      return res.status(400).json({ msg: "User not found" });
    }

    res.json(existingUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
