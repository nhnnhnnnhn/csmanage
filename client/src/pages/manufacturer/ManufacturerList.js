import React, { useState, useEffect } from 'react';
import { Container, Table, Button, Card, Alert } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { nsxAPI } from '../../services/api';

const ManufacturerList = () => {
  const [manufacturers, setManufacturers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchManufacturers = async () => {
    try {
      setLoading(true);
      const response = await nsxAPI.getAll();
      setManufacturers(response.data);
      setLoading(false);
    } catch (err) {
      console.error('Lỗi khi lấy danh sách nhà sản xuất:', err);
      setError('Không thể tải danh sách nhà sản xuất. Vui lòng thử lại sau.');
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchManufacturers();
  }, []);

  const handleDelete = async (id) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa nhà sản xuất này?')) {
      try {
        await nsxAPI.delete(id);
        fetchManufacturers();
      } catch (err) {
        console.error('Lỗi khi xóa nhà sản xuất:', err);
        setError('Không thể xóa nhà sản xuất. Vui lòng thử lại sau.');
      }
    }
  };

  if (loading) {
    return (
      <Container className="mt-4">
        <Alert variant="info">Đang tải danh sách nhà sản xuất...</Alert>
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
          <h4 className="mb-0">Danh Sách Nhà Sản Xuất</h4>
          <Link to="/manufacturers/add">
            <Button variant="success">Thêm Mới</Button>
          </Link>
        </Card.Header>
        <Card.Body>
          <Table striped bordered hover responsive>
            <thead>
              <tr>
                <th>Mã NSX</th>
                <th>Tên Nhà Sản Xuất</th>
                <th>Địa Chỉ</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              {manufacturers.map((nsx) => (
                <tr key={nsx.MaNSX}>
                  <td>{nsx.MaNSX}</td>
                  <td>{nsx.TenNSX}</td>
                  <td>{nsx.DiaChi}</td>
                  <td>
                    <Link to={`/manufacturers/edit/${nsx.MaNSX}`}>
                      <Button variant="primary" size="sm" className="me-2">
                        Sửa
                      </Button>
                    </Link>
                    <Button
                      variant="danger"
                      size="sm"
                      onClick={() => handleDelete(nsx.MaNSX)}
                    >
                      Xóa
                    </Button>
                  </td>
                </tr>
              ))}
              {manufacturers.length === 0 && (
                <tr>
                  <td colSpan="4" className="text-center">
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

export default ManufacturerList; 