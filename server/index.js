const mongoose = require("mongoose");
const express = require("express");
const app = express();
const PORT = 3000;

// router
const authRouter = require("./router/auth");

// middlewares
app.use(authRouter);

// mongoose connection
mongoose
  .connect(MONGOOSE_API)
  .then(() => console.log("mongoos connected successfuly"))
  .catch((e) => console.log(e));

// app listening
app.listen(PORT, () => console.log(`connect at post ${PORT} successfully.`));
