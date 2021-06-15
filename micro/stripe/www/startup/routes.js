const express = require("express");
const homeRouter = require("../routes/home");
const error = require("../middleware/error");
const cors = require("cors");

module.exports = function (app) {
  app.use(cors({ origin: true }));
  app.use(express.json());
  app.use("/", homeRouter);
  app.use(error);
};
