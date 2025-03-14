const { pcModel } = require('../models');

// Lấy tất cả PC
const getAllPC = async (req, res) => {
  try {
    const pcList = await pcModel.getAllPC();
    res.status(200).json(pcList);
  } catch (error) {
    console.error('Lỗi khi lấy danh sách PC:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Lấy PC theo ID
const getPCById = async (req, res) => {
  try {
    const maSP = req.params.id;
    const pc = await pcModel.getPCById(maSP);
    
    if (!pc) {
      return res.status(404).json({ message: 'Không tìm thấy PC' });
    }
    
    res.status(200).json(pc);
  } catch (error) {
    console.error('Lỗi khi lấy thông tin PC:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Tạo PC mới
const createPC = async (req, res) => {
  try {
    const { maSP, maNSX, cpu, ram, hd, gia } = req.body;
    
    // Kiểm tra dữ liệu đầu vào
    if (!maSP || !maNSX || !cpu || !ram || !hd || !gia) {
      return res.status(400).json({ message: 'Vui lòng cung cấp đầy đủ thông tin PC' });
    }
    
    // Tạo PC mới
    const result = await pcModel.createPC({ maSP, maNSX, cpu, ram, hd, gia });
    res.status(201).json({ message: 'Tạo PC thành công', maSP });
  } catch (error) {
    console.error('Lỗi khi tạo PC:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Cập nhật PC
const updatePC = async (req, res) => {
  try {
    const maSP = req.params.id;
    const { maNSX, cpu, ram, hd, gia } = req.body;
    
    // Kiểm tra PC tồn tại
    const existingPC = await pcModel.getPCById(maSP);
    if (!existingPC) {
      return res.status(404).json({ message: 'Không tìm thấy PC' });
    }
    
    // Cập nhật PC
    await pcModel.updatePC(maSP, { maNSX, cpu, ram, hd, gia });
    res.status(200).json({ message: 'Cập nhật PC thành công' });
  } catch (error) {
    console.error('Lỗi khi cập nhật PC:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Xóa PC
const deletePC = async (req, res) => {
  try {
    const maSP = req.params.id;
    
    // Kiểm tra PC tồn tại
    const existingPC = await pcModel.getPCById(maSP);
    if (!existingPC) {
      return res.status(404).json({ message: 'Không tìm thấy PC' });
    }
    
    // Xóa PC
    await pcModel.deletePC(maSP);
    res.status(200).json({ message: 'Xóa PC thành công' });
  } catch (error) {
    console.error('Lỗi khi xóa PC:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

module.exports = {
  getAllPC,
  getPCById,
  createPC,
  updatePC,
  deletePC
}; 