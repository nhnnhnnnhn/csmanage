const { nsxModel } = require('../models');

// Lấy tất cả nhà sản xuất
const getAllNSX = async (req, res) => {
  try {
    const nsxList = await nsxModel.getAllNSX();
    res.status(200).json(nsxList);
  } catch (error) {
    console.error('Lỗi khi lấy danh sách NSX:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Lấy nhà sản xuất theo ID
const getNSXById = async (req, res) => {
  try {
    const maNSX = req.params.id;
    const nsx = await nsxModel.getNSXById(maNSX);
    
    if (!nsx) {
      return res.status(404).json({ message: 'Không tìm thấy nhà sản xuất' });
    }
    
    res.status(200).json(nsx);
  } catch (error) {
    console.error('Lỗi khi lấy thông tin NSX:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Tạo nhà sản xuất mới
const createNSX = async (req, res) => {
  try {
    const { maNSX, tenNSX, diaChi } = req.body;
    
    // Kiểm tra dữ liệu đầu vào
    if (!maNSX || !tenNSX) {
      return res.status(400).json({ message: 'Mã NSX và Tên NSX là bắt buộc' });
    }
    
    // Kiểm tra NSX đã tồn tại chưa
    const existingNSX = await nsxModel.getNSXById(maNSX);
    if (existingNSX) {
      return res.status(400).json({ message: 'Mã NSX đã tồn tại' });
    }
    
    const result = await nsxModel.createNSX({ maNSX, tenNSX, diaChi });
    res.status(201).json({ message: 'Tạo nhà sản xuất thành công', maNSX });
  } catch (error) {
    console.error('Lỗi khi tạo NSX:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Cập nhật nhà sản xuất
const updateNSX = async (req, res) => {
  try {
    const maNSX = req.params.id;
    const { tenNSX, diaChi } = req.body;
    
    // Kiểm tra dữ liệu đầu vào
    if (!tenNSX) {
      return res.status(400).json({ message: 'Tên NSX là bắt buộc' });
    }
    
    // Kiểm tra NSX tồn tại
    const existingNSX = await nsxModel.getNSXById(maNSX);
    if (!existingNSX) {
      return res.status(404).json({ message: 'Không tìm thấy nhà sản xuất' });
    }
    
    await nsxModel.updateNSX(maNSX, { tenNSX, diaChi });
    res.status(200).json({ message: 'Cập nhật nhà sản xuất thành công' });
  } catch (error) {
    console.error('Lỗi khi cập nhật NSX:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// Xóa nhà sản xuất
const deleteNSX = async (req, res) => {
  try {
    const maNSX = req.params.id;
    
    // Kiểm tra NSX tồn tại
    const existingNSX = await nsxModel.getNSXById(maNSX);
    if (!existingNSX) {
      return res.status(404).json({ message: 'Không tìm thấy nhà sản xuất' });
    }
    
    await nsxModel.deleteNSX(maNSX);
    res.status(200).json({ message: 'Xóa nhà sản xuất thành công' });
  } catch (error) {
    console.error('Lỗi khi xóa NSX:', error);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

module.exports = {
  getAllNSX,
  getNSXById,
  createNSX,
  updateNSX,
  deleteNSX
}; 