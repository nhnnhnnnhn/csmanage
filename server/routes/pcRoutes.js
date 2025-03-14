const express = require('express');
const router = express.Router();
const pcController = require('../controllers/pcController');

// Lấy tất cả PC
router.get('/', pcController.getAllPC);

// Lấy PC theo ID
router.get('/:id', pcController.getPCById);

// Tạo PC mới
router.post('/', pcController.createPC);

// Cập nhật PC
router.put('/:id', pcController.updatePC);

// Xóa PC
router.delete('/:id', pcController.deletePC);

module.exports = router; 