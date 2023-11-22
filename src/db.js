const mysql = require("mysql2");
const config = require("./config/config");

class Database {
  constructor() {
    if (Database.instance) {
      return Database.instance;
    }
    this.connection = mysql.createConnection({
      host: config.database.host,
      user: config.database.user,
      password: config.database.password,
      database: config.database.database,
    });

    Database.instance = this;
    return this;
  }

  query(sql, args) {
    return new Promise((resolve, reject) => {
      this.connection.query(sql, args, (err, rows) => {
        if (err) {
          reject(err);
        } else {
          resolve(rows);
        }
      });
    });
  }

  close() {
    return new Promise((resolve, reject) => {
      this.connection.end((err) => {
        if (err) {
          reject(err);
        } else {
          resolve();
        }
      });
    });
  }
}

const dbInstance = new Database();

module.exports = dbInstance; 
