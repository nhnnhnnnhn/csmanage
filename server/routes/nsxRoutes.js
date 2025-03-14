const express = require('express');
const router = express.Router();
const nsxController = require('../controllers/nsxController');

// Lấy tất cả nhà sản xuất
router.get('/', nsxController.getAllNSX);

// Lấy nhà sản xuất theo ID
router.get('/:id', nsxController.getNSXById);

// Tạo nhà sản xuất mới
router.post('/', nsxController.createNSX);

// Cập nhật nhà sản xuất
router.put('/:id', nsxController.updateNSX);

// Xóa nhà sản xuất
router.delete('/:id', nsxController.deleteNSX);

module.exports = router; 