const db = require("../db");

class User {
  constructor(username, password, name) {
    this.username = username;
    this.password = password;
    this.name = name
  }

  async register() {
    try {
      const sql = "INSERT INTO jg.users(username, password, name) VALUES (?, ?, ?)";
      const values = [this.username, this.password, this.name];
      const rows = await db.query(sql, values);
      return rows;
    } catch (error) {
      console.error("Error fetching orders:", error);
      throw error;
    }
  }

  static async getUser(params) {
    const { username } = params;
    try {
      const sql = `SELECT * FROM jg.users WHERE username="${username}"`;
      const rows = await db.query(sql);
      return rows;
    } catch (error) {
      console.error("Error fetching user:", error);
      throw error;
    }
  }
}

module.exports = User;
