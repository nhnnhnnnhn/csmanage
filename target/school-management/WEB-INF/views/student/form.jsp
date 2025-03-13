<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty student ? 'Thêm Học Sinh Mới' : 'Cập Nhật Học Sinh'} - Hệ Thống Quản Lý Trường Học</title>
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
                    <h1 class="h2">${empty student ? 'Thêm Học Sinh Mới' : 'Cập Nhật Học Sinh'}</h1>
                </div>

                <!-- Thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

                <!-- Form học sinh -->
                <div class="card">
                    <div class="card-body">
                        <form action="students" method="post">
                            <input type="hidden" name="action" value="${empty student ? 'create' : 'update'}">
                            <c:if test="${not empty student}">
                                <input type="hidden" name="id" value="${student.studentId}">
                            </c:if>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="firstName">Tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="${student.firstName}" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lastName">Họ <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="${student.lastName}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="dateOfBirth">Ngày Sinh <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" 
                                           value="<fmt:formatDate value="${student.dateOfBirth}" pattern="yyyy-MM-dd" />" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="gender">Giới Tính <span class="text-danger">*</span></label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="">-- Chọn Giới Tính --</option>
                                        <option value="Nam" ${student.gender eq 'Nam' ? 'selected' : ''}>Nam</option>
                                        <option value="Nữ" ${student.gender eq 'Nữ' ? 'selected' : ''}>Nữ</option>
                                        <option value="Khác" ${student.gender eq 'Khác' ? 'selected' : ''}>Khác</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="address">Địa Chỉ</label>
                                <input type="text" class="form-control" id="address" name="address" value="${student.address}">
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="phoneNumber">Số Điện Thoại</label>
                                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${student.phoneNumber}">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${student.email}">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="enrollmentDate">Ngày Nhập Học <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="enrollmentDate" name="enrollmentDate" 
                                           value="<fmt:formatDate value="${student.enrollmentDate}" pattern="yyyy-MM-dd" />" 
                                           required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="status">Trạng Thái</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="Đang học" ${student.status eq 'Đang học' || empty student.status ? 'selected' : ''}>Đang học</option>
                                        <option value="Nghỉ học" ${student.status eq 'Nghỉ học' ? 'selected' : ''}>Nghỉ học</option>
                                        <option value="Tốt nghiệp" ${student.status eq 'Tốt nghiệp' ? 'selected' : ''}>Tốt nghiệp</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group text-center mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${empty student ? 'Thêm Mới' : 'Cập Nhật'}
                                </button>
                                <a href="students" class="btn btn-secondary ml-2">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </div>
                        </form>
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