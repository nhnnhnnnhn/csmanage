import React, { useState, useEffect } from 'react';
import { Container, Row, Col, Card, Table, Alert } from 'react-bootstrap';
import { dashboardAPI } from '../services/api';

const Dashboard = () => {
  const [stats, setStats] = useState({
    totalNSX: 0,
    totalPC: 0,
    totalLaptop: 0,
    totalValue: 0
  });
  
  const [manufacturerStats, setManufacturerStats] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        
        // Lấy thống kê tổng quan
        const statsResponse = await dashboardAPI.getStats();
        setStats(statsResponse.data);
        
        // Lấy thống kê theo nhà sản xuất
        const manufacturerStatsResponse = await dashboardAPI.getStatsByManufacturer();
        setManufacturerStats(manufacturerStatsResponse.data);
        
        setLoading(false);
      } catch (err) {
        console.error('Lỗi khi lấy dữ liệu thống kê:', err);
        setError('Không thể tải dữ liệu thống kê. Vui lòng thử lại sau.');
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // Format số tiền VND
  const formatCurrency = (value) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
  };

  if (loading) {
    return (
      <Container className="mt-4">
        <Alert variant="info">Đang tải dữ liệu thống kê...</Alert>
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
    <Container>
      <h2 className="mb-4">Thống Kê Tổng Quan</h2>
      
      <Row className="mb-4">
        <Col md={3}>
          <Card className="stats-card">
            <Card.Body>
              <div className="number">{stats.totalNSX}</div>
              <div className="title">Nhà Sản Xuất</div>
            </Card.Body>
          </Card>
        </Col>
        
        <Col md={3}>
          <Card className="stats-card">
            <Card.Body>
              <div className="number">{stats.totalPC}</div>
              <div className="title">Máy Tính PC</div>
            </Card.Body>
          </Card>
        </Col>
        
        <Col md={3}>
          <Card className="stats-card">
            <Card.Body>
              <div className="number">{stats.totalLaptop}</div>
              <div className="title">Laptop</div>
            </Card.Body>
          </Card>
        </Col>
        
        <Col md={3}>
          <Card className="stats-card">
            <Card.Body>
              <div className="number">{formatCurrency(stats.totalValue)}</div>
              <div className="title">Tổng Giá Trị</div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
      
      <h3 className="mb-3">Thống Kê Theo Nhà Sản Xuất</h3>
      <Card>
        <Card.Body>
          <Table striped bordered hover responsive>
            <thead>
              <tr>
                <th>Mã NSX</th>
                <th>Tên Nhà Sản Xuất</th>
                <th>Số Lượng PC</th>
                <th>Số Lượng Laptop</th>
                <th>Tổng Giá Trị</th>
              </tr>
            </thead>
            <tbody>
              {manufacturerStats.map((item) => (
                <tr key={item.MaNSX}>
                  <td>{item.MaNSX}</td>
                  <td>{item.TenNSX}</td>
                  <td>{item.totalPC || 0}</td>
                  <td>{item.totalLaptop || 0}</td>
                  <td>{formatCurrency(item.totalValue || 0)}</td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Card.Body>
      </Card>
    </Container>
  );
};

export default Dashboard; 