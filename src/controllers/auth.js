const bcrypt = require("bcrypt");

const logging = require("../config/logging");
const sendResponse = require("../helpers/handleResponse");

const User = require("../models/user");

const NAMESPACE = "Auth Controller";
const SALT_ROUNDS = 10;

const register = async (req, res) => {
  logging.info(NAMESPACE, `Register Method`);
  let { username, password, name } = req.body;
  bcrypt.hash(password, SALT_ROUNDS, async (error, hash) => {
    if (error) sendResponse(res, "HASH_ERROR", 500, { data: error });
    const userExists = await User.getUser({ username });
    if (userExists.length) {
      return sendResponse(res, "USER_EXISTS", 401, { data: error });
    }

    const user = new User(username, hash, name);

    return user
      .register()
      .then((user) =>
        sendResponse(res, "REGISTER_SUCCESS", 201, { data: user })
      )
      .catch((error) =>
        sendResponse(res, "REGISTER_ERROR", 500, { data: error })
      );
  });
};

const login = async (req, res) => {
  logging.info(NAMESPACE, "Login Method");
  let { username, password } = req.body;
  const user = await User.getUser({ username });
  if (!user.length) {
    return sendResponse(res, "UNEXISTENT_USER", 401);
  }
  bcrypt.compare(password, user[0].password, (error, result) => {
    if (error) return sendResponse(res, "LOGIN_ERROR", 401, { data: error });
    if (result) {
      return sendResponse(res, "LOGIN_SUCCESS", 200);
    } else return sendResponse(res, "INCORRECT_PASSWORD", 401, { data: error });
  });
};

module.exports = { register, login };
