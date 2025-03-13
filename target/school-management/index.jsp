<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Lý Trường Học</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="sidebar-sticky pt-3">
                    <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Quản Lý Trường Học</span>
                    </h5>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">
                                <i class="fas fa-home"></i> Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="students">
                                <i class="fas fa-user-graduate"></i> Quản Lý Học Sinh
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-chalkboard-teacher"></i> Quản Lý Giáo Viên
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-book"></i> Quản Lý Môn Học
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-school"></i> Quản Lý Lớp Học
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-award"></i> Quản Lý Điểm Số
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Hệ Thống Quản Lý Trường Học</h1>
                </div>

                <!-- Dashboard -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="card bg-primary text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-user-graduate"></i> Học Sinh</h5>
                                <p class="card-text display-4">0</p>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="text-white stretched-link" href="students">Xem Chi Tiết</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-success text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-chalkboard-teacher"></i> Giáo Viên</h5>
                                <p class="card-text display-4">0</p>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="text-white stretched-link" href="#">Xem Chi Tiết</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-warning text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-school"></i> Lớp Học</h5>
                                <p class="card-text display-4">0</p>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="text-white stretched-link" href="#">Xem Chi Tiết</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- About section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Giới Thiệu Hệ Thống</h5>
                            </div>
                            <div class="card-body">
                                <p>Hệ thống quản lý trường học giúp tự động hóa các hoạt động quản lý trong trường học như:</p>
                                <ul>
                                    <li>Quản lý hồ sơ học sinh, giáo viên</li>
                                    <li>Quản lý lớp học và môn học</li>
                                    <li>Quản lý điểm số và kết quả học tập</li>
                                    <li>Thống kê báo cáo về tình hình học tập</li>
                                </ul>
                                <p>Sử dụng hệ thống giúp giảm thiểu công việc hành chính, tăng hiệu quả quản lý và dễ dàng truy cập thông tin khi cần thiết.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <footer class="bg-light text-center text-lg-start mt-4">
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
            © 2023 Hệ Thống Quản Lý Trường Học
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 