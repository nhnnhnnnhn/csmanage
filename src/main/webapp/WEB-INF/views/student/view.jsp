<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Học Sinh - Hệ Thống Quản Lý Trường Học</title>
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
                            <a class="nav-link" href="index.jsp">
                                <i class="fas fa-home"></i> Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="students">
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
                    <h1 class="h2">Chi Tiết Học Sinh</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group mr-2">
                            <a href="students?action=edit&id=${student.studentId}" class="btn btn-sm btn-outline-warning">
                                <i class="fas fa-edit"></i> Chỉnh Sửa
                            </a>
                            <a href="#" onclick="confirmDelete('${student.studentId}')" class="btn btn-sm btn-outline-danger">
                                <i class="fas fa-trash-alt"></i> Xóa
                            </a>
                        </div>
                        <a href="students" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay Lại
                        </a>
                    </div>
                </div>

                <!-- Hiển thị SQL Query -->
                <c:if test="${not empty sqlOperation && not empty sqlQuery}">
                    <div class="card mb-4">
                        <div class="card-header bg-dark text-white">
                            <h5 class="card-title mb-0">Thao tác SQL (${sqlOperation})</h5>
                        </div>
                        <div class="card-body bg-light">
                            <pre class="mb-0"><code>${sqlQuery}</code></pre>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty student}">
                    <div class="alert alert-warning">
                        Không tìm thấy thông tin học sinh!
                    </div>
                </c:if>

                <c:if test="${not empty student}">
                    <div class="row">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="card-title mb-0">Thông Tin Cơ Bản</h5>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-4">
                                        <i class="fas fa-user-graduate fa-5x text-primary"></i>
                                        <h4 class="mt-3">${student.fullName}</h4>
                                        <p class="text-muted">Mã Học Sinh: ${student.studentId}</p>
                                        <span class="badge badge-pill 
                                            ${student.status eq 'Đang học' ? 'badge-success' : 
                                              student.status eq 'Nghỉ học' ? 'badge-warning' : 
                                              student.status eq 'Tốt nghiệp' ? 'badge-primary' : 'badge-secondary'}">
                                            ${student.status}
                                        </span>
                                    </div>
                                    <hr>
                                    <div class="student-info">
                                        <p><i class="fas fa-calendar-alt"></i> <strong>Ngày sinh:</strong> <fmt:formatDate value="${student.dateOfBirth}" pattern="dd/MM/yyyy" /></p>
                                        <p><i class="fas fa-venus-mars"></i> <strong>Giới tính:</strong> ${student.gender}</p>
                                        <p><i class="fas fa-calendar-check"></i> <strong>Ngày nhập học:</strong> <fmt:formatDate value="${student.enrollmentDate}" pattern="dd/MM/yyyy" /></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-8 mb-4">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <h5 class="card-title mb-0">Thông Tin Chi Tiết</h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <tbody>
                                            <tr>
                                                <th style="width: 30%;">Họ và tên</th>
                                                <td>${student.fullName}</td>
                                            </tr>
                                            <tr>
                                                <th>Địa chỉ</th>
                                                <td>${empty student.address ? 'Chưa cập nhật' : student.address}</td>
                                            </tr>
                                            <tr>
                                                <th>Số điện thoại</th>
                                                <td>${empty student.phoneNumber ? 'Chưa cập nhật' : student.phoneNumber}</td>
                                            </tr>
                                            <tr>
                                                <th>Email</th>
                                                <td>${empty student.email ? 'Chưa cập nhật' : student.email}</td>
                                            </tr>
                                            <tr>
                                                <th>Ngày sinh</th>
                                                <td><fmt:formatDate value="${student.dateOfBirth}" pattern="dd/MM/yyyy" /></td>
                                            </tr>
                                            <tr>
                                                <th>Giới tính</th>
                                                <td>${student.gender}</td>
                                            </tr>
                                            <tr>
                                                <th>Ngày nhập học</th>
                                                <td><fmt:formatDate value="${student.enrollmentDate}" pattern="dd/MM/yyyy" /></td>
                                            </tr>
                                            <tr>
                                                <th>Trạng thái</th>
                                                <td>${student.status}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin lớp học và điểm số sẽ được thêm sau khi phát triển thêm các chức năng -->
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-success text-white">
                                    <h5 class="card-title mb-0">Lớp Học Đã Đăng Ký</h5>
                                </div>
                                <div class="card-body">
                                    <p class="text-muted text-center">Chức năng này sẽ được phát triển sau.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-warning text-white">
                                    <h5 class="card-title mb-0">Điểm Số</h5>
                                </div>
                                <div class="card-body">
                                    <p class="text-muted text-center">Chức năng này sẽ được phát triển sau.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <footer class="bg-light text-center text-lg-start mt-4">
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
            © 2023 Hệ Thống Quản Lý Trường Học
        </div>
    </footer>

    <!-- Xác nhận xóa Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa học sinh <strong>${student.fullName}</strong> không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <a href="#" id="confirmDeleteButton" class="btn btn-danger">Xóa</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function confirmDelete(id) {
            document.getElementById('confirmDeleteButton').href = 'students?action=delete&id=' + id;
            $('#deleteModal').modal('show');
        }
    </script>
</body>
</html> 