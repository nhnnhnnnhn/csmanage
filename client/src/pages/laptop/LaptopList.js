import React, { useState, useEffect } from 'react';
import { Container, Table, Button, Card, Alert } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { laptopAPI } from '../../services/api';

const LaptopList = () => {
  const [laptops, setLaptops] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchLaptops = async () => {
    try {
      setLoading(true);
      const response = await laptopAPI.getAll();
      setLaptops(response.data);
      setLoading(false);
    } catch (err) {
      console.error('Lỗi khi lấy danh sách Laptop:', err);
      setError('Không thể tải danh sách Laptop. Vui lòng thử lại sau.');
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchLaptops();
  }, []);

  const handleDelete = async (id) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa Laptop này?')) {
      try {
        await laptopAPI.delete(id);
        fetchLaptops();
      } catch (err) {
        console.error('Lỗi khi xóa Laptop:', err);
        setError('Không thể xóa Laptop. Vui lòng thử lại sau.');
      }
    }
  };

  // Format số tiền VND
  const formatCurrency = (value) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
  };

  if (loading) {
    return (
      <Container className="mt-4">
        <Alert variant="info">Đang tải danh sách Laptop...</Alert>
      </Container>
    );
  }

  if (error) {
    return (
      <Container className="mt-4">
        <Alert variant="danger">{error}</Alert>
      </Container>
    );
  }

  return (
    <Container className="mt-4">
      <Card>
        <Card.Header className="d-flex justify-content-between align-items-center">
          <h4 className="mb-0">Danh Sách Laptop</h4>
          <Link to="/laptops/add">
            <Button variant="success">Thêm Mới</Button>
          </Link>
        </Card.Header>
        <Card.Body>
          <Table striped bordered hover responsive>
            <thead>
              <tr>
                <th>Mã Laptop</th>
                <th>Nhà Sản Xuất</th>
                <th>CPU</th>
                <th>RAM</th>
                <th>Ổ Cứng</th>
                <th>Màn Hình</th>
                <th>Giá</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              {laptops.map((laptop) => (
                <tr key={laptop['MaSP-L']}>
                  <td>{laptop['MaSP-L']}</td>
                  <td>{laptop.TenNSX}</td>
                  <td>{laptop.CPU}</td>
                  <td>{laptop.RAM}</td>
                  <td>{laptop.HD}</td>
                  <td>{laptop.ManHinh}</td>
                  <td>{formatCurrency(laptop.gia)}</td>
                  <td>
                    <Link to={`/laptops/edit/${laptop['MaSP-L']}`}>
                      <Button variant="primary" size="sm" className="me-2">
                        Sửa
                      </Button>
                    </Link>
                    <Button
                      variant="danger"
                      size="sm"
                      onClick={() => handleDelete(laptop['MaSP-L'])}
                    >
                      Xóa
                    </Button>
                  </td>
                </tr>
              ))}
              {laptops.length === 0 && (
                <tr>
                  <td colSpan="8" className="text-center">
                    Không có dữ liệu
                  </td>
                </tr>
              )}
            </tbody>
          </Table>
        </Card.Body>
      </Card>
    </Container>
  );
};

export default LaptopList; 