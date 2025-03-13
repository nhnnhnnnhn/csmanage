<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Học Sinh - Hệ Thống Quản Lý Trường Học</title>
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
                    <h1 class="h2">Quản Lý Học Sinh</h1>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

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
                
                <!-- Hiển thị SQL Thao tác chính (INSERT/UPDATE/DELETE) -->
                <c:if test="${not empty mainSqlOperation && not empty mainSqlQuery}">
                    <div class="card mb-4">
                        <div class="card-header bg-${mainSqlOperation eq 'INSERT' ? 'success' : (mainSqlOperation eq 'UPDATE' ? 'warning' : 'danger')} text-white">
                            <h5 class="card-title mb-0">Thao tác SQL Trước Đó (${mainSqlOperation})</h5>
                        </div>
                        <div class="card-body bg-light">
                            <pre class="mb-0"><code>${mainSqlQuery}</code></pre>
                        </div>
                    </div>
                </c:if>

                <!-- Tìm kiếm và nút thêm mới -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form action="students" method="get" class="form-inline">
                            <input type="hidden" name="action" value="search">
                            <div class="input-group">
                                <input type="text" name="searchName" class="form-control" placeholder="Tìm kiếm học sinh..." value="${searchName}">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit">
                                        <i class="fas fa-search"></i> Tìm Kiếm
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="students?action=new" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Thêm Học Sinh Mới
                        </a>
                    </div>
                </div>

                <!-- Bảng danh sách học sinh -->
                <div class="table-responsive">
                    <table class="table table-striped table-sm">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>Họ và Tên</th>
                                <th>Ngày Sinh</th>
                                <th>Giới Tính</th>
                                <th>Số Điện Thoại</th>
                                <th>Email</th>
                                <th>Trạng Thái</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty students}">
                                    <tr>
                                        <td colspan="8" class="text-center">Không có học sinh nào</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td>${student.studentId}</td>
                                            <td>${student.fullName}</td>
                                            <td><fmt:formatDate value="${student.dateOfBirth}" pattern="dd/MM/yyyy" /></td>
                                            <td>${student.gender}</td>
                                            <td>${student.phoneNumber}</td>
                                            <td>${student.email}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${student.status eq 'Đang học'}">
                                                        <span class="badge badge-success">${student.status}</span>
                                                    </c:when>
                                                    <c:when test="${student.status eq 'Nghỉ học'}">
                                                        <span class="badge badge-warning">${student.status}</span>
                                                    </c:when>
                                                    <c:when test="${student.status eq 'Tốt nghiệp'}">
                                                        <span class="badge badge-primary">${student.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">${student.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="students?action=view&id=${student.studentId}" class="btn btn-sm btn-info" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="students?action=edit&id=${student.studentId}" class="btn btn-sm btn-warning" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="#" onclick="confirmDelete('${student.studentId}')" class="btn btn-sm btn-danger" title="Xóa">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
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
                    Bạn có chắc chắn muốn xóa học sinh này không?
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