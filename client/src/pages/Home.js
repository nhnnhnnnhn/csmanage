import React from 'react';
import { Container, Row, Col, Card, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';

const Home = () => {
  return (
    <Container>
      <Row className="mb-4">
        <Col>
          <div className="jumbotron bg-light p-5 rounded">
            <h1 className="display-4">Quản Lý Bán Máy Tính</h1>
            <p className="lead">
              Hệ thống quản lý bán máy tính với đầy đủ tính năng quản lý nhà sản xuất, PC và Laptop.
            </p>
            <hr className="my-4" />
            <p>
              Sử dụng hệ thống để theo dõi sản phẩm, quản lý nhà sản xuất và xem thống kê doanh số.
            </p>
            <Link to="/dashboard">
              <Button variant="primary" size="lg">Xem Thống Kê</Button>
            </Link>
          </div>
        </Col>
      </Row>

      <Row>
        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Header as="h5">Nhà Sản Xuất</Card.Header>
            <Card.Body>
              <Card.Title>Quản lý nhà sản xuất</Card.Title>
              <Card.Text>
                Thêm, sửa, xóa và xem danh sách các nhà sản xuất máy tính.
              </Card.Text>
              <Link to="/manufacturers">
                <Button variant="primary">Quản Lý Nhà Sản Xuất</Button>
              </Link>
            </Card.Body>
          </Card>
        </Col>

        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Header as="h5">Máy Tính PC</Card.Header>
            <Card.Body>
              <Card.Title>Quản lý PC</Card.Title>
              <Card.Text>
                Thêm, sửa, xóa và xem danh sách các máy tính PC với đầy đủ thông số kỹ thuật.
              </Card.Text>
              <Link to="/pcs">
                <Button variant="primary">Quản Lý PC</Button>
              </Link>
            </Card.Body>
          </Card>
        </Col>

        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Header as="h5">Laptop</Card.Header>
            <Card.Body>
              <Card.Title>Quản lý Laptop</Card.Title>
              <Card.Text>
                Thêm, sửa, xóa và xem danh sách các laptop với đầy đủ thông số kỹ thuật.
              </Card.Text>
              <Link to="/laptops">
                <Button variant="primary">Quản Lý Laptop</Button>
              </Link>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Home; 