<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi 500 - Lỗi máy chủ nội bộ</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 0;
            text-align: center;
        }
        .error-code {
            font-size: 120px;
            color: #dc3545;
            margin-bottom: 0;
            font-weight: bold;
        }
        .error-divider {
            max-width: 100px;
            margin: 20px auto;
            border-top: 3px solid #007bff;
        }
        .error-message {
            font-size: 24px;
            margin-bottom: 20px;
            color: #6c757d;
        }
        .error-description {
            color: #6c757d;
            margin-bottom: 30px;
        }
        .back-home {
            margin-top: 20px;
        }
        .error-image {
            max-width: 300px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <h1 class="error-code">500</h1>
            <div class="error-divider"></div>
            <h2 class="error-message">Lỗi máy chủ nội bộ!</h2>
            <p class="error-description">
                Xin lỗi, có lỗi xảy ra trong quá trình xử lý yêu cầu của bạn.
                Vui lòng thử lại sau hoặc liên hệ với quản trị viên hệ thống.
            </p>
            <div class="text-center">
                <i class="fas fa-exclamation-triangle fa-5x mb-4 text-warning"></i>
            </div>
            <div class="back-home">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home mr-2"></i> Quay lại trang chủ
                </a>
            </div>
        </div>
    </div>
</body>
</html> 