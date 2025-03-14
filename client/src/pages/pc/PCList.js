import React, { useState, useEffect } from 'react';
import { Container, Table, Button, Card, Alert } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { pcAPI } from '../../services/api';

const PCList = () => {
  const [pcs, setPCs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchPCs = async () => {
    try {
      setLoading(true);
      const response = await pcAPI.getAll();
      setPCs(response.data);
      setLoading(false);
    } catch (err) {
      console.error('Lỗi khi lấy danh sách PC:', err);
      setError('Không thể tải danh sách PC. Vui lòng thử lại sau.');
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPCs();
  }, []);

  const handleDelete = async (id) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa PC này?')) {
      try {
        await pcAPI.delete(id);
        fetchPCs();
      } catch (err) {
        console.error('Lỗi khi xóa PC:', err);
        setError('Không thể xóa PC. Vui lòng thử lại sau.');
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
        <Alert variant="info">Đang tải danh sách PC...</Alert>
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
          <h4 className="mb-0">Danh Sách Máy Tính PC</h4>
          <Link to="/pcs/add">
            <Button variant="success">Thêm Mới</Button>
          </Link>
        </Card.Header>
        <Card.Body>
          <Table striped bordered hover responsive>
            <thead>
              <tr>
                <th>Mã PC</th>
                <th>Nhà Sản Xuất</th>
                <th>CPU</th>
                <th>RAM</th>
                <th>Ổ Cứng</th>
                <th>Giá</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              {pcs.map((pc) => (
                <tr key={pc['MaSP-P']}>
                  <td>{pc['MaSP-P']}</td>
                  <td>{pc.TenNSX}</td>
                  <td>{pc.CPU}</td>
                  <td>{pc.RAM}</td>
                  <td>{pc.HD}</td>
                  <td>{formatCurrency(pc.gia)}</td>
                  <td>
                    <Link to={`/pcs/edit/${pc['MaSP-P']}`}>
                      <Button variant="primary" size="sm" className="me-2">
                        Sửa
                      </Button>
                    </Link>
                    <Button
                      variant="danger"
                      size="sm"
                      onClick={() => handleDelete(pc['MaSP-P'])}
                    >
                      Xóa
                    </Button>
                  </td>
                </tr>
              ))}
              {pcs.length === 0 && (
                <tr>
                  <td colSpan="7" className="text-center">
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

export default PCList; 