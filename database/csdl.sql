-- Tạo cơ sở dữ liệu
CREATE DATABASE QuanLySanXuatMayTinh;
GO

-- Sử dụng cơ sở dữ liệu vừa tạo
USE QuanLySanXuatMayTinh;
GO

-- Tạo bảng Nhà sản xuất (NSX)
CREATE TABLE NSX (
    MaNSX VARCHAR(10) PRIMARY KEY,
    TenNSX NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200)
);
GO

-- Tạo bảng Sản phẩm (SP)
CREATE TABLE SP (
    MaNSX VARCHAR(10) NOT NULL,
    MaSP VARCHAR(10) PRIMARY KEY,
    loai NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_SP_NSX FOREIGN KEY (MaNSX) REFERENCES NSX(MaNSX)
);
GO

-- Tạo bảng PC
CREATE TABLE PC (
    [MaSP-P] VARCHAR(10) PRIMARY KEY,
    CPU NVARCHAR(100) NOT NULL,
    RAM NVARCHAR(50) NOT NULL,
    HD NVARCHAR(100) NOT NULL,
    gia DECIMAL(18, 2) NOT NULL,
    CONSTRAINT FK_PC_SP FOREIGN KEY ([MaSP-P]) REFERENCES SP(MaSP)
);
GO

-- Tạo bảng Laptop
CREATE TABLE Laptop (
    [MaSP-L] VARCHAR(10) PRIMARY KEY,
    CPU NVARCHAR(100) NOT NULL,
    RAM NVARCHAR(50) NOT NULL,
    HD NVARCHAR(100) NOT NULL,
    ManHinh NVARCHAR(50) NOT NULL,
    gia DECIMAL(18, 2) NOT NULL,
    CONSTRAINT FK_Laptop_SP FOREIGN KEY ([MaSP-L]) REFERENCES SP(MaSP)
);
GO

USE QuanLySanXuatMayTinh;
GO

-- Xóa dữ liệu cũ (nếu có)
DELETE FROM Laptop;
DELETE FROM PC;
DELETE FROM SP;
DELETE FROM NSX;
GO

-- Thêm dữ liệu mẫu cho bảng NSX
INSERT INTO NSX (MaNSX, TenNSX, DiaChi) VALUES
('NSX001', 'Dell', N'Hoa Kỳ'),
('NSX002', 'HP', N'Hoa Kỳ'),
('NSX003', 'Lenovo', N'Trung Quốc'),
('NSX004', 'Asus', N'Đài Loan'),
('NSX005', 'Acer', N'Đài Loan'),
('NSX006', 'MSI', N'Đài Loan'),
('NSX007', 'Apple', N'Hoa Kỳ'),
('NSX008', 'Samsung', N'Hàn Quốc'),
('NSX009', 'Sony', N'Nhật Bản'),
('NSX010', 'Gigabyte', N'Đài Loan'),
('NSX011', 'LG', N'Hàn Quốc'),
('NSX012', 'Huawei', N'Trung Quốc'),
('NSX013', 'Razer', N'Hoa Kỳ'),
('NSX014', 'Microsoft', N'Hoa Kỳ'),
('NSX015', 'Toshiba', N'Nhật Bản');
GO

-- Thêm dữ liệu mẫu cho bảng SP
INSERT INTO SP (MaNSX, MaSP, loai) VALUES
-- Dell
('NSX001', 'SP001', 'PC'),
('NSX001', 'SP002', 'PC'),
('NSX001', 'SP003', 'Laptop'),
('NSX001', 'SP004', 'Laptop'),
('NSX001', 'SP101', 'PC'),
('NSX001', 'SP102', 'Laptop'),
-- HP
('NSX002', 'SP005', 'PC'),
('NSX002', 'SP006', 'Laptop'),
('NSX002', 'SP007', 'Laptop'),
('NSX002', 'SP103', 'PC'),
('NSX002', 'SP104', 'PC'),
('NSX002', 'SP105', 'Laptop'),
-- Lenovo
('NSX003', 'SP008', 'PC'),
('NSX003', 'SP009', 'PC'),
('NSX003', 'SP010', 'Laptop'),
('NSX003', 'SP106', 'Laptop'),
('NSX003', 'SP107', 'Laptop'),
('NSX003', 'SP108', 'PC'),
-- Asus
('NSX004', 'SP011', 'PC'),
('NSX004', 'SP012', 'Laptop'),
('NSX004', 'SP013', 'Laptop'),
('NSX004', 'SP109', 'PC'),
('NSX004', 'SP110', 'Laptop'),
('NSX004', 'SP111', 'PC'),
-- Acer
('NSX005', 'SP014', 'PC'),
('NSX005', 'SP015', 'Laptop'),
('NSX005', 'SP112', 'PC'),
('NSX005', 'SP113', 'Laptop'),
('NSX005', 'SP114', 'PC'),
-- MSI
('NSX006', 'SP016', 'PC'),
('NSX006', 'SP017', 'Laptop'),
('NSX006', 'SP115', 'PC'),
('NSX006', 'SP116', 'Laptop'),
('NSX006', 'SP117', 'PC'),
-- Apple
('NSX007', 'SP018', 'Laptop'),
('NSX007', 'SP019', 'Laptop'),
('NSX007', 'SP118', 'Laptop'),
-- Samsung
('NSX008', 'SP020', 'Laptop'),
('NSX008', 'SP119', 'Laptop'),
('NSX008', 'SP120', 'Laptop'),
-- Sony
('NSX009', 'SP021', 'Laptop'),
('NSX009', 'SP121', 'Laptop'),
-- Gigabyte 
('NSX010', 'SP022', 'PC'),
('NSX010', 'SP023', 'PC'),
('NSX010', 'SP122', 'PC'),
-- LG
('NSX011', 'SP024', 'Laptop'),
('NSX011', 'SP123', 'PC'),
('NSX011', 'SP124', 'Laptop'),
-- Huawei
('NSX012', 'SP025', 'Laptop'),
('NSX012', 'SP125', 'Laptop'),
-- Razer
('NSX013', 'SP026', 'Laptop'),
('NSX013', 'SP126', 'Laptop'),
-- Microsoft
('NSX014', 'SP027', 'Laptop'),
('NSX014', 'SP127', 'Laptop'),
-- Toshiba
('NSX015', 'SP028', 'Laptop'),
('NSX015', 'SP128', 'PC'),
-- Thêm dữ liệu mẫu mới cho PC và Laptop có cùng CPU
('NSX001', 'SP201', 'PC'),
('NSX001', 'SP202', 'Laptop'),
('NSX002', 'SP203', 'PC'),
('NSX002', 'SP204', 'Laptop'),
('NSX003', 'SP205', 'PC'),
('NSX003', 'SP206', 'Laptop');
GO

-- Thêm dữ liệu mẫu cho bảng PC
INSERT INTO PC ([MaSP-P], CPU, RAM, HD, gia) VALUES
-- Dell
('SP001', 'Intel Core i5 11400', '8GB', '256GB SSD', 12000000),
('SP002', 'Intel Core i7 11700', '16GB', '512GB SSD', 20000000),
('SP101', 'AMD Ryzen 7 5800X', '32GB', '1TB SSD', 28000000),
-- HP
('SP005', 'AMD Ryzen 5 5600X', '16GB', '512GB SSD', 18000000),
('SP103', 'Intel Core i9 11900K', '64GB', '2TB SSD', 40000000),
('SP104', 'Intel Core i5 11400', '8GB', '256GB SSD', 13500000),
-- Lenovo
('SP008', 'Intel Core i5 11400', '8GB', '256GB SSD', 13000000),
('SP009', 'Intel Core i7 11700', '32GB', '1TB SSD', 25000000),
('SP108', 'AMD Ryzen 9 5900X', '64GB', '2TB SSD', 38000000),
-- Asus
('SP011', 'AMD Ryzen 7 5800X', '32GB', '1TB SSD', 27000000),
('SP109', 'Intel Core i9 11900K', '32GB', '1TB SSD', 35000000),
('SP111', 'Intel Core i5 11400', '16GB', '512GB SSD', 16500000),
-- Acer
('SP014', 'Intel Core i5 11400', '16GB', '512GB SSD', 15000000),
('SP112', 'AMD Ryzen 5 5600X', '8GB', '512GB SSD', 16000000),
('SP114', 'Intel Core i7 11700', '16GB', '1TB SSD', 23000000),
-- MSI
('SP016', 'AMD Ryzen 9 5900X', '64GB', '2TB SSD', 35000000),
('SP115', 'Intel Core i9 11900K', '32GB', '1TB SSD', 34000000),
('SP117', 'AMD Ryzen 7 5800X', '16GB', '1TB SSD', 26000000),
-- Gigabyte
('SP022', 'Intel Core i7 11700K', '32GB', '1TB SSD', 28000000),
('SP023', 'AMD Ryzen 9 5900X', '64GB', '2TB SSD', 37000000),
('SP122', 'Intel Core i5 11600K', '16GB', '512GB SSD', 19000000),
-- LG
('SP123', 'Intel Core i7 11700', '16GB', '512GB SSD', 22000000),
-- Toshiba
('SP128', 'Intel Core i5 11400', '8GB', '256GB SSD', 14000000),
-- Thêm dữ liệu cho PC mới
('SP201', 'Intel Core i5 11400H', '16GB', '512GB SSD', 15000000),
('SP203', 'Intel Core i7 11800H', '16GB', '1TB SSD', 22000000),
('SP205', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', 20000000);
GO

-- Thêm dữ liệu mẫu cho bảng Laptop
INSERT INTO Laptop ([MaSP-L], CPU, RAM, HD, ManHinh, gia) VALUES
-- Dell
('SP003', 'Intel Core i5 11400H', '8GB', '256GB SSD', '15.6 inch FHD', 18000000),
('SP004', 'Intel Core i7 11800H', '16GB', '512GB SSD', '15.6 inch FHD', 25000000),
('SP102', 'Intel Core i9 11900H', '32GB', '1TB SSD', '17.3 inch 4K', 42000000),
-- HP
('SP006', 'AMD Ryzen 5 5600H', '8GB', '512GB SSD', '14 inch FHD', 16000000),
('SP007', 'Intel Core i7 11800H', '16GB', '1TB SSD', '15.6 inch QHD', 26000000),
('SP105', 'Intel Core i5 11400H', '16GB', '512GB SSD', '15.6 inch FHD', 19000000),
-- Lenovo
('SP010', 'Intel Core i5 11400H', '8GB', '512GB SSD', '14 inch FHD', 17000000),
('SP106', 'Intel Core i7 11800H', '16GB', '1TB SSD', '15.6 inch QHD', 27000000),
('SP107', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', '14 inch FHD', 23000000),
-- Asus
('SP012', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', '15.6 inch FHD', 23000000),
('SP013', 'Intel Core i9 11900H', '32GB', '1TB SSD', '17.3 inch QHD', 35000000),
('SP110', 'Intel Core i7 11800H', '16GB', '512GB SSD', '15.6 inch FHD', 24000000),
-- Acer
('SP015', 'Intel Core i5 11400H', '8GB', '256GB SSD', '15.6 inch FHD', 16500000),
('SP113', 'AMD Ryzen 5 5600H', '8GB', '512GB SSD', '14 inch FHD', 17500000),
-- MSI
('SP017', 'AMD Ryzen 9 5900HX', '32GB', '1TB SSD', '17.3 inch QHD', 39000000),
('SP116', 'Intel Core i7 11800H', '16GB', '1TB SSD', '15.6 inch FHD', 29000000),
-- Apple
('SP018', 'Apple M1 Pro', '16GB', '512GB SSD', '14 inch Retina', 40000000),
('SP019', 'Apple M1 Max', '32GB', '1TB SSD', '16 inch Retina', 55000000),
('SP118', 'Apple M1', '8GB', '256GB SSD', '13.3 inch Retina', 32000000),
-- Samsung
('SP020', 'Intel Core i7 11800H', '16GB', '512GB SSD', '15.6 inch AMOLED', 24000000),
('SP119', 'Intel Core i5 11400H', '8GB', '256GB SSD', '14 inch FHD', 18000000),
('SP120', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', '15.6 inch AMOLED', 25000000),
-- Sony
('SP021', 'Intel Core i7 11800H', '16GB', '128GB SSD', '15.6 inch 4K', 22000000),
('SP121', 'Intel Core i5 11400H', '8GB', '256GB SSD', '14 inch FHD', 19000000),
-- LG
('SP024', 'Intel Core i7 11800H', '16GB', '512GB SSD', '17 inch 4K', 27000000),
('SP124', 'Intel Core i5 11400H', '8GB', '256GB SSD', '15.6 inch FHD', 18500000),
-- Huawei
('SP025', 'Intel Core i7 11800H', '16GB', '512GB SSD', '14 inch 2K', 23000000),
('SP125', 'Intel Core i5 11400H', '8GB', '256GB SSD', '13 inch FHD', 16000000),
-- Razer
('SP026', 'Intel Core i9 11900H', '32GB', '1TB SSD', '15.6 inch QHD', 45000000),
('SP126', 'AMD Ryzen 9 5900HX', '32GB', '1TB SSD', '17.3 inch 4K', 48000000),
-- Microsoft
('SP027', 'Intel Core i7 11800H', '16GB', '512GB SSD', '13.5 inch PixelSense', 35000000),
('SP127', 'Intel Core i5 11400H', '8GB', '256GB SSD', '13.5 inch PixelSense', 28000000),
-- Toshiba
('SP028', 'Intel Core i5 11400H', '8GB', '256GB SSD', '15.6 inch FHD', 17000000),
-- Thêm dữ liệu cho Laptop mới
('SP202', 'Intel Core i5 11400H', '16GB', '512GB SSD', '15.6 inch FHD', 18000000),
('SP204', 'Intel Core i7 11800H', '16GB', '1TB SSD', '15.6 inch QHD', 25000000),
('SP206', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', '15.6 inch FHD', 23000000);
GO

-- 2) Tìm tên của các nhà sản xuất chỉ sản xuất Laptop mà không sản xuất PC.
SELECT DISTINCT n.TenNSX
FROM NSX n
WHERE n.MaNSX IN (
    SELECT DISTINCT s.MaNSX
    FROM SP s
    WHERE s.loai = 'Laptop'
)
AND n.MaNSX NOT IN (
    SELECT DISTINCT s.MaNSX
    FROM SP s
    WHERE s.loai = 'PC'
);
GO

-- 1) Xóa thông tin của tất cả các nhà sản xuất mà không sản xuất bất kỳ một sản phẩm PC nào.
-- Hiển thị các nhà sản xuất sẽ bị xóa
SELECT n.MaNSX, n.TenNSX, n.DiaChi
FROM NSX n
WHERE n.MaNSX NOT IN (
    SELECT DISTINCT s.MaNSX
    FROM SP s
    JOIN PC p ON s.MaSP = p.[MaSP-P]
);
GO

-- Xóa các sản phẩm của các nhà sản xuất không sản xuất PC
DELETE FROM Laptop
WHERE [MaSP-L] IN (
    SELECT s.MaSP
    FROM SP s
    JOIN NSX n ON s.MaNSX = n.MaNSX
    WHERE n.MaNSX NOT IN (
        SELECT DISTINCT s2.MaNSX
        FROM SP s2
        JOIN PC p ON s2.MaSP = p.[MaSP-P]
    )
);
GO

DELETE FROM PC
WHERE [MaSP-P] IN (
    SELECT s.MaSP
    FROM SP s
    JOIN NSX n ON s.MaNSX = n.MaNSX
    WHERE n.MaNSX NOT IN (
        SELECT DISTINCT s2.MaNSX
        FROM SP s2
        JOIN PC p ON s2.MaSP = p.[MaSP-P]
    )
);
GO

DELETE FROM SP
WHERE MaNSX NOT IN (
    SELECT DISTINCT s.MaNSX
    FROM SP s
    JOIN PC p ON s.MaSP = p.[MaSP-P]
);
GO

DELETE FROM NSX
WHERE MaNSX NOT IN (
    SELECT DISTINCT s.MaNSX
    FROM SP s
    JOIN PC p ON s.MaSP = p.[MaSP-P]
);
GO

-- 3) Cập nhật giá cho tất cả các máy PC của nhà sản xuất tên là Dell tăng lên 15%
-- Hiển thị giá trước khi tăng
SELECT n.TenNSX, p.[MaSP-P], p.CPU, p.gia AS 'Giá ban đầu'
FROM PC p
JOIN SP s ON p.[MaSP-P] = s.MaSP
JOIN NSX n ON s.MaNSX = n.MaNSX
WHERE n.TenNSX = 'Dell';
GO

UPDATE PC
SET gia = gia * 1.15
WHERE [MaSP-P] IN (
    SELECT s.MaSP
    FROM SP s
    JOIN NSX n ON s.MaNSX = n.MaNSX
    WHERE n.TenNSX = 'Dell' AND s.loai = 'PC'
);
GO

-- Hiển thị giá sau khi tăng
SELECT n.TenNSX, p.[MaSP-P], p.CPU, p.gia AS 'Giá sau khi tăng 15%'
FROM PC p
JOIN SP s ON p.[MaSP-P] = s.MaSP
JOIN NSX n ON s.MaNSX = n.MaNSX
WHERE n.TenNSX = 'Dell';
GO

-- 4) Tìm tên của các nhà sản xuất có ít nhất 2 máy tính thuộc loại khác nhau (PC và Laptop) có cùng tốc độ CPU.
SELECT DISTINCT n.TenNSX
FROM NSX n
WHERE EXISTS (
    SELECT 1
    FROM SP s1
    JOIN PC p ON s1.MaSP = p.[MaSP-P]
    JOIN SP s2 ON s1.MaNSX = s2.MaNSX  -- Cùng nhà sản xuất
    JOIN Laptop l ON s2.MaSP = l.[MaSP-L]
    WHERE s1.MaNSX = n.MaNSX
    AND p.CPU = l.CPU  -- Cùng loại CPU chính xác
);
GO

-- 5) Tìm tên của các nhà sản xuất của tất cả các sản phẩm (PC hoặc Laptop) có dung lượng ổ cứng tối thiểu 128 GB.
SELECT DISTINCT n.TenNSX
FROM NSX n
WHERE NOT EXISTS (
    -- Tìm sản phẩm có dung lượng HD < 128GB
    SELECT *
    FROM SP s
    LEFT JOIN PC p ON s.MaSP = p.[MaSP-P]
    LEFT JOIN Laptop l ON s.MaSP = l.[MaSP-L]
    WHERE s.MaNSX = n.MaNSX
    AND (
        (p.HD IS NOT NULL AND p.HD NOT LIKE '%128%' AND p.HD NOT LIKE '%256%' AND p.HD NOT LIKE '%512%' AND p.HD NOT LIKE '%1TB%' AND p.HD NOT LIKE '%2TB%')
        OR
        (l.HD IS NOT NULL AND l.HD NOT LIKE '%128%' AND l.HD NOT LIKE '%256%' AND l.HD NOT LIKE '%512%' AND l.HD NOT LIKE '%1TB%' AND l.HD NOT LIKE '%2TB%')
    )
);

-- Cách thứ 2 để hiểu rõ hơn:
SELECT DISTINCT n.TenNSX
FROM NSX n
JOIN SP s ON n.MaNSX = s.MaNSX
LEFT JOIN PC p ON s.MaSP = p.[MaSP-P]
LEFT JOIN Laptop l ON s.MaSP = l.[MaSP-L]
WHERE 
    (p.HD IS NOT NULL AND (p.HD LIKE '%128%' OR p.HD LIKE '%256%' OR p.HD LIKE '%512%' OR p.HD LIKE '%1TB%' OR p.HD LIKE '%2TB%'))
    OR 
    (l.HD IS NOT NULL AND (l.HD LIKE '%128%' OR l.HD LIKE '%256%' OR l.HD LIKE '%512%' OR l.HD LIKE '%1TB%' OR l.HD LIKE '%2TB%'));
GO

-- 6) Tìm tên của các nhà sản xuất của máy PC có dung lượng ổ cứng lớn nhất.
SELECT DISTINCT n.TenNSX
FROM NSX n
JOIN SP s ON n.MaNSX = s.MaNSX
JOIN PC p ON s.MaSP = p.[MaSP-P]
WHERE p.HD IN (
    SELECT TOP 1 HD 
    FROM PC
    ORDER BY 
        CASE 
            WHEN HD LIKE '%2TB%' THEN 2048
            WHEN HD LIKE '%1TB%' THEN 1024
            WHEN HD LIKE '%512GB%' THEN 512
            WHEN HD LIKE '%256GB%' THEN 256
            WHEN HD LIKE '%128GB%' THEN 128
            ELSE 0
        END DESC
);
GO

--Truy vấn đã được tối ưu hoá
-- 1) Xóa thông tin của tất cả các nhà sản xuất mà không sản xuất bất kỳ một sản phẩm PC nào.
SELECT n.MaNSX, n.TenNSX, n.DiaChi
FROM NSX n
WHERE NOT EXISTS (
    SELECT 1
    FROM SP s
    WHERE s.MaNSX = n.MaNSX AND s.loai = 'PC'
);
GO

-- Xóa các sản phẩm liên quan
-- Đầu tiên xóa từ Laptop vì nó phụ thuộc vào SP
DELETE FROM Laptop
WHERE [MaSP-L] IN (
    SELECT s.MaSP
    FROM SP s
    WHERE s.MaNSX IN (
        SELECT n.MaNSX
        FROM NSX n
        WHERE NOT EXISTS (
            SELECT 1
            FROM SP s2
            WHERE s2.MaNSX = n.MaNSX AND s2.loai = 'PC'
        )
    )
);
GO

-- Sau đó xóa từ SP
DELETE FROM SP
WHERE MaNSX IN (
    SELECT n.MaNSX
    FROM NSX n
    WHERE NOT EXISTS (
        SELECT 1
        FROM SP s
        WHERE s.MaNSX = n.MaNSX AND s.loai = 'PC'
    )
);
GO

-- Cuối cùng xóa các NSX không có sản phẩm PC
DELETE FROM NSX
WHERE NOT EXISTS (
    SELECT 1
    FROM SP s
    WHERE s.MaNSX = NSX.MaNSX AND s.loai = 'PC'
);
GO

-- 2) Tìm tên của các nhà sản xuất chỉ sản xuất Laptop mà không sản xuất PC.
SELECT n.TenNSX
FROM NSX n
WHERE EXISTS (
    SELECT 1
    FROM SP s
    WHERE s.MaNSX = n.MaNSX AND s.loai = 'Laptop'
)
AND NOT EXISTS (
    SELECT 1
    FROM SP s
    WHERE s.MaNSX = n.MaNSX AND s.loai = 'PC'
);
GO

-- 3) Cập nhật giá cho tất cả các máy PC của nhà sản xuất tên là Dell tăng lên 15%
-- Hiển thị giá trước khi tăng
SELECT n.TenNSX, p.[MaSP-P], p.CPU, p.gia AS 'Giá ban đầu'
FROM PC p
INNER JOIN SP s ON p.[MaSP-P] = s.MaSP
INNER JOIN NSX n ON s.MaNSX = n.MaNSX
WHERE n.TenNSX = 'Dell';
GO

-- Cập nhật giá
UPDATE PC
SET gia = gia * 1.15
FROM PC
INNER JOIN SP s ON PC.[MaSP-P] = s.MaSP
INNER JOIN NSX n ON s.MaNSX = n.MaNSX
WHERE n.TenNSX = 'Dell';
GO

-- Hiển thị giá sau khi tăng
SELECT n.TenNSX, p.[MaSP-P], p.CPU, p.gia AS 'Giá sau khi tăng 15%'
FROM PC p
INNER JOIN SP s ON p.[MaSP-P] = s.MaSP
INNER JOIN NSX n ON s.MaNSX = n.MaNSX
WHERE n.TenNSX = 'Dell';
GO

-- 4) Tìm tên của các nhà sản xuất có ít nhất 2 máy tính thuộc loại khác nhau (PC và Laptop) có cùng tốc độ CPU.
SELECT DISTINCT n.TenNSX
FROM NSX n
WHERE EXISTS (
    SELECT 1
    FROM SP s1
    INNER JOIN PC p ON s1.MaSP = p.[MaSP-P]
    INNER JOIN SP s2 ON s1.MaNSX = s2.MaNSX
    INNER JOIN Laptop l ON s2.MaSP = l.[MaSP-L]
    WHERE s1.MaNSX = n.MaNSX
    AND p.CPU = l.CPU
);
GO

-- 5) Tìm tên của các nhà sản xuất của tất cả các sản phẩm (PC hoặc Laptop) có dung lượng ổ cứng tối thiểu 128 GB.
SELECT DISTINCT n.TenNSX
FROM NSX n
WHERE NOT EXISTS (
    SELECT 1
    FROM SP s
    LEFT JOIN PC p ON s.MaSP = p.[MaSP-P] AND p.HD NOT LIKE '%128%' AND p.HD NOT LIKE '%256%' AND p.HD NOT LIKE '%512%' AND p.HD NOT LIKE '%1TB%' AND p.HD NOT LIKE '%2TB%'
    LEFT JOIN Laptop l ON s.MaSP = l.[MaSP-L] AND l.HD NOT LIKE '%128%' AND l.HD NOT LIKE '%256%' AND l.HD NOT LIKE '%512%' AND l.HD NOT LIKE '%1TB%' AND l.HD NOT LIKE '%2TB%'
    WHERE s.MaNSX = n.MaNSX
    AND (
        (p.[MaSP-P] IS NOT NULL) OR (l.[MaSP-L] IS NOT NULL)
    )
);
GO

-- Cách tối ưu hơn cho câu 5
SELECT DISTINCT n.TenNSX
FROM NSX n
INNER JOIN SP s ON n.MaNSX = s.MaNSX
LEFT JOIN PC p ON s.MaSP = p.[MaSP-P]
LEFT JOIN Laptop l ON s.MaSP = l.[MaSP-L]
GROUP BY n.TenNSX
HAVING COUNT(DISTINCT s.MaSP) = 
       SUM(CASE WHEN 
                (p.HD IS NOT NULL AND (p.HD LIKE '%128%' OR p.HD LIKE '%256%' OR p.HD LIKE '%512%' OR p.HD LIKE '%1TB%' OR p.HD LIKE '%2TB%'))
                OR 
                (l.HD IS NOT NULL AND (l.HD LIKE '%128%' OR l.HD LIKE '%256%' OR l.HD LIKE '%512%' OR l.HD LIKE '%1TB%' OR l.HD LIKE '%2TB%'))
           THEN 1 ELSE 0 END);
GO

-- 6) Tìm tên của các nhà sản xuất của máy PC có dung lượng ổ cứng lớn nhất.
WITH HD_Size AS (
    SELECT 
        CASE 
            WHEN HD LIKE '%2TB%' THEN 2048
            WHEN HD LIKE '%1TB%' THEN 1024
            WHEN HD LIKE '%512GB%' THEN 512
            WHEN HD LIKE '%256GB%' THEN 256
            WHEN HD LIKE '%128GB%' THEN 128
            ELSE 0
        END AS size_in_GB,
        HD
    FROM PC
)
SELECT DISTINCT n.TenNSX
FROM NSX n
INNER JOIN SP s ON n.MaNSX = s.MaNSX
INNER JOIN PC p ON s.MaSP = p.[MaSP-P]
INNER JOIN HD_Size h ON p.HD = h.HD
WHERE h.size_in_GB = (SELECT MAX(size_in_GB) FROM HD_Size);
GO