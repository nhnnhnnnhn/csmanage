# Hệ Thống Quản Lý Trường Học

Dự án này là một ứng dụng web quản lý trường học được xây dựng bằng Java Servlet, JSP và kết nối với cơ sở dữ liệu SQL Server thông qua JDBC.

## Cấu trúc dự án

- `src/main/java`: Chứa mã nguồn Java
- `src/main/webapp`: Chứa các file JSP và tài nguyên web
- `database`: Chứa scripts SQL để tạo cơ sở dữ liệu

## Cài đặt và Chạy

1. Cài đặt SQL Server
2. Chạy script SQL trong thư mục `database` để tạo cơ sở dữ liệu
3. Cấu hình kết nối database trong file `src/main/java/utils/DBConnection.java`
4. Biên dịch và triển khai ứng dụng vào máy chủ servlet (như Tomcat)
5. Truy cập ứng dụng tại `http://localhost:8080/school-management`

## Chức năng chính

- Quản lý học sinh
- Quản lý giáo viên
- Quản lý lớp học
- Quản lý điểm số
- Quản lý môn học 