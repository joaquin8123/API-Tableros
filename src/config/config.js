require("dotenv").config();

const DATABASE = {
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
};

const SERVER_HOSTNAME = process.env.SERVER_HOSTNAME || "localhost";
const PORT = process.env.PORT || 3002;

const SERVER = {
  hostname: SERVER_HOSTNAME,
  port: PORT,
};

const config = {
  database: DATABASE,
  server: SERVER,
};

module.exports = config;
