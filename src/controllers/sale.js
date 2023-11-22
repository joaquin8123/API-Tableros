const logging = require("../config/logging");
const sendResponse = require("../helpers/handleResponse");

const Sale = require("../models/sale");

const NAMESPACE = "Sale Controller";

const GetSales = async (req, res) => {
  logging.info(NAMESPACE, `GetSales Method`);
  const sales = await Sale.getAll();
  sendResponse(res, "GET_SALES_SUCCESS", 200, { data: sales });
};

const GetSaleById = async (req, res) => {
  logging.info(NAMESPACE, "GetSaleById Method");
  let { id } = req.params;
  const sale = await Sale.getSale({ id });
  if (!sale) {
    return sendResponse(res, "UNEXISTENT_SALE", 401);
  }
  sendResponse(res, "GET_SALE_SUCCESS", 200, { data: sale });
};

const dashboard = async (req, res) => {
  let { dashboardName, value } = req.body;
  logging.info(NAMESPACE, `${dashboardName} Method`);
  const response = await Sale.dashboard({ value, dashboardName });
  sendResponse(res, `${dashboardName.toUpperCase()}_SUCCESS`, 200, { data: response });
};

module.exports = { GetSaleById, GetSales, dashboard };
