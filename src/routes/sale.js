const express = require("express");
const saleController = require("../controllers/sale");

const router = express.Router();

router.get("/", saleController.GetSales);
router.get("/:id", saleController.GetSaleById);
router.post("/dashboard", saleController.dashboard);

module.exports = router;
