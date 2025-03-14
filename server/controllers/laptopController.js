const { laptopModel } = require('../models');

// Lấy tất cả Laptop
const getAllLaptop = async (req, res) => {
  try {
    const laptopList = await laptopModel.getAllLaptop();
    res.status(200).json(laptopList);
  } catch (error) {
    console.error('Lỗi khi lấy danh sách Laptop:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Lấy Laptop theo ID
const getLaptopById = async (req, res) => {
  try {
    const maSP = req.params.id;
    const laptop = await laptopModel.getLaptopById(maSP);
    
    if (!laptop) {
      return res.status(404).json({ message: 'Không tìm thấy Laptop' });
    }
    
    res.status(200).json(laptop);
  } catch (error) {
    console.error('Lỗi khi lấy thông tin Laptop:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Tạo Laptop mới
const createLaptop = async (req, res) => {
  try {
    const { maSP, maNSX, cpu, ram, hd, manHinh, gia } = req.body;
    
    // Kiểm tra dữ liệu đầu vào
    if (!maSP || !maNSX || !cpu || !ram || !hd || !manHinh || !gia) {
      return res.status(400).json({ message: 'Vui lòng cung cấp đầy đủ thông tin Laptop' });
    }
    
    // Tạo Laptop mới
    const result = await laptopModel.createLaptop({ maSP, maNSX, cpu, ram, hd, manHinh, gia });
    res.status(201).json({ message: 'Tạo Laptop thành công', maSP });
  } catch (error) {
    console.error('Lỗi khi tạo Laptop:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Cập nhật Laptop
const updateLaptop = async (req, res) => {
  try {
    const maSP = req.params.id;
    const { maNSX, cpu, ram, hd, manHinh, gia } = req.body;
    
    // Kiểm tra Laptop tồn tại
    const existingLaptop = await laptopModel.getLaptopById(maSP);
    if (!existingLaptop) {
      return res.status(404).json({ message: 'Không tìm thấy Laptop' });
    }
    
    // Cập nhật Laptop
    await laptopModel.updateLaptop(maSP, { maNSX, cpu, ram, hd, manHinh, gia });
    res.status(200).json({ message: 'Cập nhật Laptop thành công' });
  } catch (error) {
    console.error('Lỗi khi cập nhật Laptop:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Xóa Laptop
const deleteLaptop = async (req, res) => {
  try {
    const maSP = req.params.id;
    
    // Kiểm tra Laptop tồn tại
    const existingLaptop = await laptopModel.getLaptopById(maSP);
    if (!existingLaptop) {
      return res.status(404).json({ message: 'Không tìm thấy Laptop' });
    }
    
    // Xóa Laptop
    await laptopModel.deleteLaptop(maSP);
    res.status(200).json({ message: 'Xóa Laptop thành công' });
  } catch (error) {
    console.error('Lỗi khi xóa Laptop:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

module.exports = {
  getAllLaptop,
  getLaptopById,
  createLaptop,
  updateLaptop,
  deleteLaptop
}; 