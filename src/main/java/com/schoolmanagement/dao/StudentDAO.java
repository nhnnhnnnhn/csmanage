package com.schoolmanagement.dao;

import com.schoolmanagement.model.Student;
import com.schoolmanagement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp Data Access Object cho đối tượng Student
 * Cung cấp các phương thức để tương tác với bảng Students trong cơ sở dữ liệu
 */
public class StudentDAO {
    // Lưu trữ câu lệnh SQL mới nhất được thực thi
    private String lastExecutedSQL;

    /**
     * Lấy câu lệnh SQL mới nhất được thực thi
     * 
     * @return Câu lệnh SQL mới nhất
     */
    public String getLastExecutedSQL() {
        return lastExecutedSQL;
    }

    /**
     * Thêm một học sinh mới vào cơ sở dữ liệu
     * 
     * @param student Đối tượng Student cần thêm
     * @return ID của học sinh vừa thêm, -1 nếu thất bại
     */
    public int addStudent(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int generatedId = -1;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Students (first_name, last_name, date_of_birth, gender, address, " +
                         "phone_number, email, enrollment_date, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            this.lastExecutedSQL = sql + " [Values: " + 
                student.getFirstName() + ", " + 
                student.getLastName() + ", " + 
                student.getDateOfBirth() + ", " +
                student.getGender() + ", " +
                student.getAddress() + ", " +
                student.getPhoneNumber() + ", " +
                student.getEmail() + ", " +
                student.getEnrollmentDate() + ", " +
                student.getStatus() + "]";
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setDate(3, new java.sql.Date(student.getDateOfBirth().getTime()));
            stmt.setString(4, student.getGender());
            stmt.setString(5, student.getAddress());
            stmt.setString(6, student.getPhoneNumber());
            stmt.setString(7, student.getEmail());
            
            if (student.getEnrollmentDate() != null) {
                stmt.setDate(8, new java.sql.Date(student.getEnrollmentDate().getTime()));
            } else {
                stmt.setDate(8, new java.sql.Date(System.currentTimeMillis()));
            }
            
            stmt.setString(9, student.getStatus());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                    student.setStudentId(generatedId); // Cập nhật ID cho đối tượng
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return generatedId;
    }

    /**
     * Cập nhật thông tin của một học sinh
     * 
     * @param student Đối tượng Student cần cập nhật
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateStudent(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Students SET first_name = ?, last_name = ?, date_of_birth = ?, " +
                         "gender = ?, address = ?, phone_number = ?, email = ?, " +
                         "enrollment_date = ?, status = ? WHERE student_id = ?";
            
            this.lastExecutedSQL = sql + " [Values: " + 
                student.getFirstName() + ", " + 
                student.getLastName() + ", " + 
                student.getDateOfBirth() + ", " +
                student.getGender() + ", " +
                student.getAddress() + ", " +
                student.getPhoneNumber() + ", " +
                student.getEmail() + ", " +
                student.getEnrollmentDate() + ", " +
                student.getStatus() + ", " +
                student.getStudentId() + "]";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setDate(3, new java.sql.Date(student.getDateOfBirth().getTime()));
            stmt.setString(4, student.getGender());
            stmt.setString(5, student.getAddress());
            stmt.setString(6, student.getPhoneNumber());
            stmt.setString(7, student.getEmail());
            stmt.setDate(8, new java.sql.Date(student.getEnrollmentDate().getTime()));
            stmt.setString(9, student.getStatus());
            stmt.setInt(10, student.getStudentId());
            
            int affectedRows = stmt.executeUpdate();
            success = (affectedRows > 0);
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }

    /**
     * Xóa một học sinh khỏi cơ sở dữ liệu
     * 
     * @param studentId ID của học sinh cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     */
    public boolean deleteStudent(int studentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Students WHERE student_id = ?";
            
            this.lastExecutedSQL = sql + " [Values: " + studentId + "]";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            
            int affectedRows = stmt.executeUpdate();
            success = (affectedRows > 0);
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }

    /**
     * Lấy thông tin một học sinh theo ID
     * 
     * @param studentId ID của học sinh cần lấy thông tin
     * @return Đối tượng Student, null nếu không tìm thấy
     */
    public Student getStudentById(int studentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Student student = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Students WHERE student_id = ?";
            
            this.lastExecutedSQL = sql + " [Values: " + studentId + "]";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                student = mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thông tin học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return student;
    }

    /**
     * Lấy danh sách tất cả học sinh
     * 
     * @return Danh sách các đối tượng Student
     */
    public List<Student> getAllStudents() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Student> students = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Students ORDER BY last_name, first_name";
            
            this.lastExecutedSQL = sql;
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Student student = mapResultSetToStudent(rs);
                students.add(student);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return students;
    }

    /**
     * Tìm kiếm học sinh theo tên
     * 
     * @param name Tên học sinh cần tìm
     * @return Danh sách các đối tượng Student phù hợp
     */
    public List<Student> searchStudentsByName(String name) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Student> students = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Students WHERE first_name LIKE ? OR last_name LIKE ? ORDER BY last_name, first_name";
            
            String searchPattern = "%" + name + "%";
            this.lastExecutedSQL = sql + " [Values: '" + searchPattern + "', '" + searchPattern + "']";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Student student = mapResultSetToStudent(rs);
                students.add(student);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm học sinh: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return students;
    }

    /**
     * Phương thức trợ giúp để ánh xạ ResultSet thành đối tượng Student
     * 
     * @param rs ResultSet chứa dữ liệu học sinh
     * @return Đối tượng Student
     * @throws SQLException
     */
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setFirstName(rs.getString("first_name"));
        student.setLastName(rs.getString("last_name"));
        student.setDateOfBirth(rs.getDate("date_of_birth"));
        student.setGender(rs.getString("gender"));
        student.setAddress(rs.getString("address"));
        student.setPhoneNumber(rs.getString("phone_number"));
        student.setEmail(rs.getString("email"));
        student.setEnrollmentDate(rs.getDate("enrollment_date"));
        student.setStatus(rs.getString("status"));
        return student;
    }

    /**
     * Đóng tài nguyên JDBC
     * 
     * @param conn Connection
     * @param stmt PreparedStatement
     * @param rs ResultSet
     */
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) DBConnection.closeConnection(conn);
        } catch (SQLException e) {
            System.err.println("Lỗi khi đóng tài nguyên: " + e.getMessage());
        }
    }
} 