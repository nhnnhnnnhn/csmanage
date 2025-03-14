import React from 'react';
import { Link, NavLink } from 'react-router-dom';
import { Navbar as BootstrapNavbar, Nav, Container } from 'react-bootstrap';

const Navbar = () => {
  return (
    <BootstrapNavbar bg="dark" variant="dark" expand="lg">
      <Container>
        <BootstrapNavbar.Brand as={Link} to="/">Quản Lý Máy Tính</BootstrapNavbar.Brand>
        <BootstrapNavbar.Toggle aria-controls="basic-navbar-nav" />
        <BootstrapNavbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link as={NavLink} to="/" end>Trang Chủ</Nav.Link>
            <Nav.Link as={NavLink} to="/dashboard">Thống Kê</Nav.Link>
            <Nav.Link as={NavLink} to="/manufacturers">Nhà Sản Xuất</Nav.Link>
            <Nav.Link as={NavLink} to="/pcs">Máy Tính PC</Nav.Link>
            <Nav.Link as={NavLink} to="/laptops">Laptop</Nav.Link>
          </Nav>
        </BootstrapNavbar.Collapse>
      </Container>
    </BootstrapNavbar>
  );
};

export default Navbar; 