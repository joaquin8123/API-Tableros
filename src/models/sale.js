const db = require("../db");

class Sale {
  static async getAll() {
    try {
      const sql = `
      SELECT
        sale.id AS saleId,
        DATE_FORMAT(sale.date, '%Y-%m-%d') AS Date,
        user.name AS sellerName,
        brand.name AS carBrand,
        car.model AS carModel,
        car.price AS carPrice
      FROM
        jg.sales sale
        LEFT JOIN jg.cars car ON car.id = sale.car_id
        LEFT JOIN jg.users user ON user.id = sale.user_id
        LEFT JOIN jg.brands brand ON brand.id = car.brand_id`;
      const rows = await db.query(sql);
      return rows;
    } catch (error) {
      console.error("Error fetching sales:", error);
      throw error;
    }
  }

  static async getSale(params) {
    const { id } = params;
    try {
      const sql = `
      SELECT
        sale.id AS saleId,
        DATE_FORMAT(sale.date, '%Y-%m-%d') AS Date,
        user.name AS sellerName,
        brand.name AS carBrand,
        car.model AS carModel,
        car.price AS carPrice,
        color.name AS carColor,
        car.year AS carYear,
        client.name AS clientName
      FROM
        jg.sales sale
        LEFT JOIN jg.cars car ON car.id = sale.car_id
        LEFT JOIN jg.users user ON user.id = sale.user_id
        LEFT JOIN jg.clients client ON client.id = sale.client_id
        LEFT JOIN jg.brands brand ON brand.id = car.brand_id
        LEFT JOIN jg.colors color ON color.id = car.color_id
      WHERE sale.id="${id}"`;
      const rows = await db.query(sql);
      return rows;
    } catch (error) {
      console.error("Error fetching sale:", error);
      throw error;
    }
  }

  static async dashboard(params) {
    const { value, dashboardName } = params;
    try {
      const sql = `SELECT ${dashboardName}(${value})`;
      const rows = await db.query(sql);
      return rows[0][`${dashboardName}(${value})`];
    } catch (error) {
      console.error("Error fetching sale:", error);
      throw error;
    }
  }
}

module.exports = Sale;
