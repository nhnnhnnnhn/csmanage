import React from 'react';
import { Container, Row, Col } from 'react-bootstrap';

const Footer = () => {
  const currentYear = new Date().getFullYear();
  
  return (
    <footer className="bg-dark text-light">
      <Container>
        <Row className="py-3">
          <Col md={6}>
            <h5>Quản Lý Bán Máy Tính</h5>
            <p>Hệ thống quản lý bán máy tính với Node.js, React và MSSQL</p>
          </Col>
          <Col md={3}>
            <h5>Liên Kết</h5>
            <ul className="list-unstyled">
              <li><a href="/" className="text-light">Trang Chủ</a></li>
              <li><a href="/dashboard" className="text-light">Thống Kê</a></li>
              <li><a href="/manufacturers" className="text-light">Nhà Sản Xuất</a></li>
            </ul>
          </Col>
          <Col md={3}>
            <h5>Sản Phẩm</h5>
            <ul className="list-unstyled">
              <li><a href="/pcs" className="text-light">Máy Tính PC</a></li>
              <li><a href="/laptops" className="text-light">Laptop</a></li>
            </ul>
          </Col>
        </Row>
        <Row>
          <Col className="text-center py-3 border-top">
            <p className="mb-0">&copy; {currentYear} Quản Lý Bán Máy Tính. All rights reserved.</p>
          </Col>
        </Row>
      </Container>
    </footer>
  );
};

export default Footer;
