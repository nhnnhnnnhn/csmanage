const express = require('express');
const router = express.Router();
const laptopController = require('../controllers/laptopController');

// Lấy tất cả Laptop
router.get('/', laptopController.getAllLaptop);

// Lấy Laptop theo ID
router.get('/:id', laptopController.getLaptopById);

// Tạo Laptop mới
router.post('/', laptopController.createLaptop);

// Cập nhật Laptop
router.put('/:id', laptopController.updateLaptop);

// Xóa Laptop
router.delete('/:id', laptopController.deleteLaptop);

module.exports = router; 