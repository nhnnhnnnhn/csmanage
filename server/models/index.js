const { sql, poolPromise } = require('../config/db');

// Model cho NSX (Nhà sản xuất)
const nsxModel = {
  // Lấy tất cả nhà sản xuất
  getAllNSX: async () => {
    try {
      const pool = await poolPromise;
      const result = await pool.request().query('SELECT * FROM NSX');
      return result.recordset;
    } catch (error) {
      console.error('Error in getAllNSX:', error);
      throw error;
    }
  },

  // Lấy nhà sản xuất theo mã
  getNSXById: async (maNSX) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maNSX', sql.VarChar(10), maNSX)
        .query('SELECT * FROM NSX WHERE MaNSX = @maNSX');
      return result.recordset[0];
    } catch (error) {
      console.error('Error in getNSXById:', error);
      throw error;
    }
  },

  // Thêm nhà sản xuất mới
  createNSX: async (nsxData) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maNSX', sql.VarChar(10), nsxData.maNSX)
        .input('tenNSX', sql.NVarChar(100), nsxData.tenNSX)
        .input('diaChi', sql.NVarChar(200), nsxData.diaChi)
        .query('INSERT INTO NSX (MaNSX, TenNSX, DiaChi) VALUES (@maNSX, @tenNSX, @diaChi); SELECT SCOPE_IDENTITY() AS id');
      return result;
    } catch (error) {
      console.error('Error in createNSX:', error);
      throw error;
    }
  },

  // Cập nhật nhà sản xuất
  updateNSX: async (maNSX, nsxData) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maNSX', sql.VarChar(10), maNSX)
        .input('tenNSX', sql.NVarChar(100), nsxData.tenNSX)
        .input('diaChi', sql.NVarChar(200), nsxData.diaChi)
        .query('UPDATE NSX SET TenNSX = @tenNSX, DiaChi = @diaChi WHERE MaNSX = @maNSX');
      return result;
    } catch (error) {
      console.error('Error in updateNSX:', error);
      throw error;
    }
  },

  // Xóa nhà sản xuất
  deleteNSX: async (maNSX) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maNSX', sql.VarChar(10), maNSX)
        .query('DELETE FROM NSX WHERE MaNSX = @maNSX');
      return result;
    } catch (error) {
      console.error('Error in deleteNSX:', error);
      throw error;
    }
  }
};

// Model cho SP (Sản phẩm)
const spModel = {
  // Lấy tất cả sản phẩm
  getAllSP: async () => {
    try {
      const pool = await poolPromise;
      const result = await pool.request().query('SELECT s.*, n.TenNSX FROM SP s JOIN NSX n ON s.MaNSX = n.MaNSX');
      return result.recordset;
    } catch (error) {
      console.error('Error in getAllSP:', error);
      throw error;
    }
  },

  // Lấy sản phẩm theo mã
  getSPById: async (maSP) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('SELECT s.*, n.TenNSX FROM SP s JOIN NSX n ON s.MaNSX = n.MaNSX WHERE s.MaSP = @maSP');
      return result.recordset[0];
    } catch (error) {
      console.error('Error in getSPById:', error);
      throw error;
    }
  },

  // Thêm sản phẩm mới
  createSP: async (spData) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maNSX', sql.VarChar(10), spData.maNSX)
        .input('maSP', sql.VarChar(10), spData.maSP)
        .input('loai', sql.NVarChar(50), spData.loai)
        .query('INSERT INTO SP (MaNSX, MaSP, loai) VALUES (@maNSX, @maSP, @loai); SELECT SCOPE_IDENTITY() AS id');
      return result;
    } catch (error) {
      console.error('Error in createSP:', error);
      throw error;
    }
  },

  // Cập nhật sản phẩm
  updateSP: async (maSP, spData) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .input('maNSX', sql.VarChar(10), spData.maNSX)
        .input('loai', sql.NVarChar(50), spData.loai)
        .query('UPDATE SP SET MaNSX = @maNSX, loai = @loai WHERE MaSP = @maSP');
      return result;
    } catch (error) {
      console.error('Error in updateSP:', error);
      throw error;
    }
  },

  // Xóa sản phẩm
  deleteSP: async (maSP) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('DELETE FROM SP WHERE MaSP = @maSP');
      return result;
    } catch (error) {
      console.error('Error in deleteSP:', error);
      throw error;
    }
  }
};

// Model cho PC
const pcModel = {
  // Lấy tất cả PC
  getAllPC: async () => {
    try {
      const pool = await poolPromise;
      const result = await pool.request().query(`
        SELECT p.*, s.loai, s.MaNSX, n.TenNSX
        FROM PC p 
        JOIN SP s ON p.[MaSP-P] = s.MaSP 
        JOIN NSX n ON s.MaNSX = n.MaNSX
      `);
      return result.recordset;
    } catch (error) {
      console.error('Error in getAllPC:', error);
      throw error;
    }
  },

  // Lấy PC theo mã
  getPCById: async (maSP) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query(`
          SELECT p.*, s.loai, s.MaNSX, n.TenNSX
          FROM PC p 
          JOIN SP s ON p.[MaSP-P] = s.MaSP 
          JOIN NSX n ON s.MaNSX = n.MaNSX
          WHERE p.[MaSP-P] = @maSP
        `);
      return result.recordset[0];
    } catch (error) {
      console.error('Error in getPCById:', error);
      throw error;
    }
  },

  // Thêm PC mới
  createPC: async (pcData) => {
    try {
      const pool = await poolPromise;
      
      // Thêm sản phẩm trước
      await pool.request()
        .input('maNSX', sql.VarChar(10), pcData.maNSX)
        .input('maSP', sql.VarChar(10), pcData.maSP)
        .input('loai', sql.NVarChar(50), 'PC')
        .query('INSERT INTO SP (MaNSX, MaSP, loai) VALUES (@maNSX, @maSP, @loai)');
      
      // Thêm PC
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), pcData.maSP)
        .input('cpu', sql.NVarChar(100), pcData.cpu)
        .input('ram', sql.NVarChar(50), pcData.ram)
        .input('hd', sql.NVarChar(100), pcData.hd)
        .input('gia', sql.Decimal(18, 2), pcData.gia)
        .query('INSERT INTO PC ([MaSP-P], CPU, RAM, HD, gia) VALUES (@maSP, @cpu, @ram, @hd, @gia); SELECT SCOPE_IDENTITY() AS id');
      
      return result;
    } catch (error) {
      console.error('Error in createPC:', error);
      throw error;
    }
  },

  // Cập nhật PC
  updatePC: async (maSP, pcData) => {
    try {
      const pool = await poolPromise;
      
      // Cập nhật thông tin SP nếu cần
      if (pcData.maNSX) {
        await pool.request()
          .input('maSP', sql.VarChar(10), maSP)
          .input('maNSX', sql.VarChar(10), pcData.maNSX)
          .query('UPDATE SP SET MaNSX = @maNSX WHERE MaSP = @maSP');
      }
      
      // Cập nhật PC
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .input('cpu', sql.NVarChar(100), pcData.cpu)
        .input('ram', sql.NVarChar(50), pcData.ram)
        .input('hd', sql.NVarChar(100), pcData.hd)
        .input('gia', sql.Decimal(18, 2), pcData.gia)
        .query('UPDATE PC SET CPU = @cpu, RAM = @ram, HD = @hd, gia = @gia WHERE [MaSP-P] = @maSP');
      
      return result;
    } catch (error) {
      console.error('Error in updatePC:', error);
      throw error;
    }
  },

  // Xóa PC
  deletePC: async (maSP) => {
    try {
      const pool = await poolPromise;
      
      // Xóa PC
      await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('DELETE FROM PC WHERE [MaSP-P] = @maSP');
      
      // Xóa SP
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('DELETE FROM SP WHERE MaSP = @maSP');
      
      return result;
    } catch (error) {
      console.error('Error in deletePC:', error);
      throw error;
    }
  }
};

// Model cho Laptop
const laptopModel = {
  // Lấy tất cả Laptop
  getAllLaptop: async () => {
    try {
      const pool = await poolPromise;
      const result = await pool.request().query(`
        SELECT l.*, s.loai, s.MaNSX, n.TenNSX
        FROM Laptop l 
        JOIN SP s ON l.[MaSP-L] = s.MaSP 
        JOIN NSX n ON s.MaNSX = n.MaNSX
      `);
      return result.recordset;
    } catch (error) {
      console.error('Error in getAllLaptop:', error);
      throw error;
    }
  },

  // Lấy Laptop theo mã
  getLaptopById: async (maSP) => {
    try {
      const pool = await poolPromise;
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query(`
          SELECT l.*, s.loai, s.MaNSX, n.TenNSX
          FROM Laptop l 
          JOIN SP s ON l.[MaSP-L] = s.MaSP 
          JOIN NSX n ON s.MaNSX = n.MaNSX
          WHERE l.[MaSP-L] = @maSP
        `);
      return result.recordset[0];
    } catch (error) {
      console.error('Error in getLaptopById:', error);
      throw error;
    }
  },

  // Thêm Laptop mới
  createLaptop: async (laptopData) => {
    try {
      const pool = await poolPromise;
      
      // Thêm sản phẩm trước
      await pool.request()
        .input('maNSX', sql.VarChar(10), laptopData.maNSX)
        .input('maSP', sql.VarChar(10), laptopData.maSP)
        .input('loai', sql.NVarChar(50), 'Laptop')
        .query('INSERT INTO SP (MaNSX, MaSP, loai) VALUES (@maNSX, @maSP, @loai)');
      
      // Thêm Laptop
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), laptopData.maSP)
        .input('cpu', sql.NVarChar(100), laptopData.cpu)
        .input('ram', sql.NVarChar(50), laptopData.ram)
        .input('hd', sql.NVarChar(100), laptopData.hd)
        .input('manHinh', sql.NVarChar(50), laptopData.manHinh)
        .input('gia', sql.Decimal(18, 2), laptopData.gia)
        .query('INSERT INTO Laptop ([MaSP-L], CPU, RAM, HD, ManHinh, gia) VALUES (@maSP, @cpu, @ram, @hd, @manHinh, @gia); SELECT SCOPE_IDENTITY() AS id');
      
      return result;
    } catch (error) {
      console.error('Error in createLaptop:', error);
      throw error;
    }
  },

  // Cập nhật Laptop
  updateLaptop: async (maSP, laptopData) => {
    try {
      const pool = await poolPromise;
      
      // Cập nhật thông tin SP nếu cần
      if (laptopData.maNSX) {
        await pool.request()
          .input('maSP', sql.VarChar(10), maSP)
          .input('maNSX', sql.VarChar(10), laptopData.maNSX)
          .query('UPDATE SP SET MaNSX = @maNSX WHERE MaSP = @maSP');
      }
      
      // Cập nhật Laptop
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .input('cpu', sql.NVarChar(100), laptopData.cpu)
        .input('ram', sql.NVarChar(50), laptopData.ram)
        .input('hd', sql.NVarChar(100), laptopData.hd)
        .input('manHinh', sql.NVarChar(50), laptopData.manHinh)
        .input('gia', sql.Decimal(18, 2), laptopData.gia)
        .query('UPDATE Laptop SET CPU = @cpu, RAM = @ram, HD = @hd, ManHinh = @manHinh, gia = @gia WHERE [MaSP-L] = @maSP');
      
      return result;
    } catch (error) {
      console.error('Error in updateLaptop:', error);
      throw error;
    }
  },

  // Xóa Laptop
  deleteLaptop: async (maSP) => {
    try {
      const pool = await poolPromise;
      
      // Xóa Laptop
      await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('DELETE FROM Laptop WHERE [MaSP-L] = @maSP');
      
      // Xóa SP
      const result = await pool.request()
        .input('maSP', sql.VarChar(10), maSP)
        .query('DELETE FROM SP WHERE MaSP = @maSP');
      
      return result;
    } catch (error) {
      console.error('Error in deleteLaptop:', error);
      throw error;
    }
  }
};

const dashboardModel = {
  // Thống kê tổng quan
  getStats: async () => {
    try {
      const pool = await poolPromise;
      
      // Số lượng NSX
      const nsxResult = await pool.request().query('SELECT COUNT(*) as totalNSX FROM NSX');
      
      // Số lượng PC
      const pcResult = await pool.request().query('SELECT COUNT(*) as totalPC FROM PC');
      
      // Số lượng Laptop
      const laptopResult = await pool.request().query('SELECT COUNT(*) as totalLaptop FROM Laptop');
      
      // Tổng giá trị sản phẩm
      const totalValueResult = await pool.request().query(`
        SELECT SUM(gia) as totalValue FROM (
          SELECT gia FROM PC
          UNION ALL
          SELECT gia FROM Laptop
        ) as AllProducts
      `);
      
      return {
        totalNSX: nsxResult.recordset[0].totalNSX,
        totalPC: pcResult.recordset[0].totalPC,
        totalLaptop: laptopResult.recordset[0].totalLaptop,
        totalValue: totalValueResult.recordset[0].totalValue || 0
      };
    } catch (error) {
      console.error('Error in getStats:', error);
      throw error;
    }
  },
  
  // Thống kê theo nhà sản xuất
  getStatsByManufacturer: async () => {
    try {
      const pool = await poolPromise;
      
      const result = await pool.request().query(`
        SELECT 
          n.MaNSX,
          n.TenNSX,
          COUNT(DISTINCT CASE WHEN s.loai = 'PC' THEN s.MaSP END) as totalPC,
          COUNT(DISTINCT CASE WHEN s.loai = 'Laptop' THEN s.MaSP END) as totalLaptop,
          SUM(CASE 
            WHEN s.loai = 'PC' THEN p.gia
            WHEN s.loai = 'Laptop' THEN l.gia
            ELSE 0
          END) as totalValue
        FROM NSX n
        LEFT JOIN SP s ON n.MaNSX = s.MaNSX
        LEFT JOIN PC p ON s.MaSP = p.[MaSP-P]
        LEFT JOIN Laptop l ON s.MaSP = l.[MaSP-L]
        GROUP BY n.MaNSX, n.TenNSX
      `);
      
      return result.recordset;
    } catch (error) {
      console.error('Error in getStatsByManufacturer:', error);
      throw error;
    }
  }
};

module.exports = {
  nsxModel,
  spModel,
  pcModel,
  laptopModel,
  dashboardModel
}; 