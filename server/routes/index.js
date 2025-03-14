const express = require('express');
const router = express.Router();

const nsxRoutes = require('./nsxRoutes');
const pcRoutes = require('./pcRoutes');
const laptopRoutes = require('./laptopRoutes');
const dashboardRoutes = require('./dashboardRoutes');

// Đăng ký routes
router.use('/nsx', nsxRoutes);
router.use('/pc', pcRoutes);
router.use('/laptop', laptopRoutes);
router.use('/dashboard', dashboardRoutes);

// Route mặc định
router.get('/', (req, res) => {
  res.json({ message: 'API Quản lý bán máy tính' });
});

module.exports = router;