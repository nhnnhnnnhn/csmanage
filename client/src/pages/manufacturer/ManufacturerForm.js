import React, { useState, useEffect } from 'react';
import { Container, Form, Button, Card, Alert } from 'react-bootstrap';
import { useNavigate, useParams } from 'react-router-dom';
import { nsxAPI } from '../../services/api';

const ManufacturerForm = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const isEditMode = !!id;

  const [formData, setFormData] = useState({
    maNSX: '',
    tenNSX: '',
    diaChi: ''
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchManufacturer = async () => {
      if (isEditMode) {
        try {
          setLoading(true);
          const response = await nsxAPI.getById(id);
          setFormData({
            maNSX: response.data.MaNSX,
            tenNSX: response.data.TenNSX,
            diaChi: response.data.DiaChi
          });
          setLoading(false);
        } catch (err) {
          console.error('Lỗi khi lấy thông tin nhà sản xuất:', err);
          setError('Không thể tải thông tin nhà sản xuất. Vui lòng thử lại sau.');
          setLoading(false);
        }
      }
    };

    fetchManufacturer();
  }, [id, isEditMode]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setLoading(true);
      if (isEditMode) {
        await nsxAPI.update(id, formData);
      } else {
        await nsxAPI.create(formData);
      }
      setLoading(false);
      navigate('/manufacturers');
    } catch (err) {
      console.error('Lỗi khi lưu nhà sản xuất:', err);
      setError('Không thể lưu thông tin nhà sản xuất. Vui lòng thử lại sau.');
      setLoading(false);
    }
  };

  if (loading && isEditMode) {
    return (
      <Container className="mt-4">
        <Alert variant="info">Đang tải thông tin nhà sản xuất...</Alert>
      </Container>
    );
  }

  return (
    <Container className="mt-4">
      <Card>
        <Card.Header>
          <h4>{isEditMode ? 'Cập Nhật Nhà Sản Xuất' : 'Thêm Nhà Sản Xuất Mới'}</h4>
        </Card.Header>
        <Card.Body>
          {error && <Alert variant="danger">{error}</Alert>}
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3">
              <Form.Label>Mã Nhà Sản Xuất</Form.Label>
              <Form.Control
                type="text"
                name="maNSX"
                value={formData.maNSX}
                onChange={handleChange}
                disabled={isEditMode}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Tên Nhà Sản Xuất</Form.Label>
              <Form.Control
                type="text"
                name="tenNSX"
                value={formData.tenNSX}
                onChange={handleChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Địa Chỉ</Form.Label>
              <Form.Control
                type="text"
                name="diaChi"
                value={formData.diaChi}
                onChange={handleChange}
              />
            </Form.Group>
            <Button variant="primary" type="submit" disabled={loading}>
              {loading ? 'Đang Lưu...' : 'Lưu'}
            </Button>
            <Button
              variant="secondary"
              onClick={() => navigate('/manufacturers')}
              className="ms-2"
            >
              Hủy
            </Button>
          </Form>
        </Card.Body>
      </Card>
    </Container>
  );
};

export default ManufacturerForm; 