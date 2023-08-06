const express = require("express");
const authRouter = express.Router();

authRouter.get("/api/signup", (req, res) => {
  // const {name, email, password} = req.body;

  res.json({ name: "Huraira Younas", nick: "Senpai", code: "69" });
});

module.exports = authRouter;
