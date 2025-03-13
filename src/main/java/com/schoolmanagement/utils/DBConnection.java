package com.schoolmanagement.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp tiện ích để quản lý kết nối đến cơ sở dữ liệu SQL Server
 */
public class DBConnection {
    // Thông tin kết nối cơ sở dữ liệu
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://nhn.id.vn:1433;databaseName=SchoolManagement;encrypt=false;trustServerCertificate=false";
    private static final String USERNAME = "sa"; // Thay đổi thông tin đăng nhập của bạn
    private static final String PASSWORD = "Mnnn1616"; // Thay đổi mật khẩu của bạn

    /**
     * Thiết lập kết nối đến cơ sở dữ liệu
     * 
     * @return Đối tượng Connection đến cơ sở dữ liệu
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            // Đăng ký driver JDBC
            Class.forName(DRIVER);
            // Thiết lập kết nối
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver không tìm thấy", e);
        } catch (SQLException e) {
            throw new SQLException("Không thể kết nối đến cơ sở dữ liệu", e);
        }
        return connection;
    }

    /**
     * Đóng kết nối đến cơ sở dữ liệu
     * 
     * @param connection Kết nối cần đóng
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }

    /**
     * Phương thức kiểm tra kết nối
     * 
     * @return true nếu kết nối thành công, false nếu thất bại
     */
    public static boolean testConnection() {
        Connection connection = null;
        try {
            connection = getConnection();
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            System.err.println("Kiểm tra kết nối thất bại: " + e.getMessage());
            return false;
        } finally {
            closeConnection(connection);
        }
    }
} 