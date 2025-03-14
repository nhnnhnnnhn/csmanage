const { dashboardModel } = require('../models');

// Lấy thống kê tổng quan
const getStats = async (req, res) => {
  try {
    const stats = await dashboardModel.getStats();
    res.status(200).json(stats);
  } catch (error) {
    console.error('Lỗi khi lấy thống kê:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Lấy thống kê theo nhà sản xuất
const getStatsByManufacturer = async (req, res) => {
  try {
    const stats = await dashboardModel.getStatsByManufacturer();
    res.status(200).json(stats);
  } catch (error) {
    console.error('Lỗi khi lấy thống kê theo nhà sản xuất:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

module.exports = {
  getStats,
  getStatsByManufacturer
}; 