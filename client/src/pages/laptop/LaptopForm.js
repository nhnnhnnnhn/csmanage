import React, { useState, useEffect } from 'react';
import { Container, Form, Button, Card, Alert } from 'react-bootstrap';
import { useNavigate, useParams } from 'react-router-dom';
import { laptopAPI, nsxAPI } from '../../services/api';

const LaptopForm = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const isEditMode = !!id;

  const [manufacturers, setManufacturers] = useState([]);
  const [formData, setFormData] = useState({
    maSP: '',
    maNSX: '',
    cpu: '',
    ram: '',
    hd: '',
    manHinh: '',
    gia: ''
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        // Lấy danh sách nhà sản xuất
        const nsxResponse = await nsxAPI.getAll();
        setManufacturers(nsxResponse.data);

        // Nếu đang ở chế độ chỉnh sửa, lấy thông tin Laptop
        if (isEditMode) {
          const laptopResponse = await laptopAPI.getById(id);
          setFormData({
            maSP: laptopResponse.data['MaSP-L'],
            maNSX: laptopResponse.data.MaNSX,
            cpu: laptopResponse.data.CPU,
            ram: laptopResponse.data.RAM,
            hd: laptopResponse.data.HD,
            manHinh: laptopResponse.data.ManHinh,
            gia: laptopResponse.data.gia
          });
        }
        
        setLoading(false);
      } catch (err) {
        console.error('Lỗi khi lấy dữ liệu:', err);
        setError('Không thể tải dữ liệu. Vui lòng thử lại sau.');
        setLoading(false);
      }
    };

    fetchData();
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
        await laptopAPI.update(id, formData);
      } else {
        await laptopAPI.create(formData);
      }
      setLoading(false);
      navigate('/laptops');
    } catch (err) {
      console.error('Lỗi khi lưu Laptop:', err);
      setError('Không thể lưu thông tin Laptop. Vui lòng thử lại sau.');
      setLoading(false);
    }
  };

  if (loading && isEditMode) {
    return (
      <Container className="mt-4">
        <Alert variant="info">Đang tải thông tin Laptop...</Alert>
      </Container>
    );
  }

  return (
    <Container className="mt-4">
      <Card>
        <Card.Header>
          <h4>{isEditMode ? 'Cập Nhật Laptop' : 'Thêm Laptop Mới'}</h4>
        </Card.Header>
        <Card.Body>
          {error && <Alert variant="danger">{error}</Alert>}
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3">
              <Form.Label>Mã Laptop</Form.Label>
              <Form.Control
                type="text"
                name="maSP"
                value={formData.maSP}
                onChange={handleChange}
                disabled={isEditMode}
                required
              />
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>Nhà Sản Xuất</Form.Label>
              <Form.Select
                name="maNSX"
                value={formData.maNSX}
                onChange={handleChange}
                required
              >
                <option value="">-- Chọn Nhà Sản Xuất --</option>
                {manufacturers.map((nsx) => (
                  <option key={nsx.MaNSX} value={nsx.MaNSX}>
                    {nsx.TenNSX}
                  </option>
                ))}
              </Form.Select>
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>CPU</Form.Label>
              <Form.Control
                type="text"
                name="cpu"
                value={formData.cpu}
                onChange={handleChange}
                required
              />
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>RAM</Form.Label>
              <Form.Control
                type="text"
                name="ram"
                value={formData.ram}
                onChange={handleChange}
                required
              />
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>Ổ Cứng</Form.Label>
              <Form.Control
                type="text"
                name="hd"
                value={formData.hd}
                onChange={handleChange}
                required
              />
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>Màn Hình</Form.Label>
              <Form.Control
                type="text"
                name="manHinh"
                value={formData.manHinh}
                onChange={handleChange}
                required
              />
            </Form.Group>
            
            <Form.Group className="mb-3">
              <Form.Label>Giá</Form.Label>
              <Form.Control
                type="number"
                name="gia"
                value={formData.gia}
                onChange={handleChange}
                required
              />
            </Form.Group>
            
            <Button variant="primary" type="submit" disabled={loading}>
              {loading ? 'Đang Lưu...' : 'Lưu'}
            </Button>
            <Button
              variant="secondary"
              onClick={() => navigate('/laptops')}
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

export default LaptopForm; 