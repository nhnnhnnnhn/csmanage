const express = require('express');
const router = express.Router();
const dashboardController = require('../controllers/dashboardController');

// Lấy thống kê tổng quan
router.get('/stats', dashboardController.getStats);

// Lấy thống kê theo nhà sản xuất
router.get('/stats/manufacturer', dashboardController.getStatsByManufacturer);

module.exports = router; 