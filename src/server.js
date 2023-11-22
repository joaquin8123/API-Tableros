const http = require("http");
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const logging = require("./config/logging");
const config = require("./config/config");

/* Routes Import */
const authRoutes = require("./routes/auth");
const saleRoutes = require("./routes/sale");

const NAMESPACE = "Server";
const app = express();

app.use((req, res, next) => {
  logging.info(
    NAMESPACE,
    `METHOD: [${req.method}] => URL: [${req.url}] => IP: [${req.socket.remoteAddress}]`
  );
  res.on("finish", () => {
    logging.info(
      NAMESPACE,
      `METHOD: [${req.method}] => URL: [${req.url}] => IP: [${req.socket.remoteAddress}] => STATUS: [${res.statusCode}]`
    );
  });

  next();
});

/* Parse the request */
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

/* Rules of our API */
app.use(cors());

/* Routes */
app.use("/auth", authRoutes);
app.use("/sale", saleRoutes);

/* Error handling */
app.use((req, res, next) => {
  const error = new Error("not found");
  return res.status(404).json({
    message: error.message,
  });
});

/* Create the server */
const httpServer = http.createServer(app);
httpServer.listen(config.server.port, () =>
  logging.info(
    NAMESPACE,
    `API [Online] => Running on: ${config.server.hostname}:${config.server.port}`
  )
);
