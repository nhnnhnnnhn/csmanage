package com.schoolmanagement.controller;

import com.schoolmanagement.dao.StudentDAO;
import com.schoolmanagement.model.Student;
import com.schoolmanagement.utils.SQLLogger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet để xử lý các yêu cầu liên quan đến học sinh
 */
@WebServlet(name = "StudentServlet", urlPatterns = {"/students", "/student/*"})
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;
    private SimpleDateFormat dateFormat;

    @Override
    public void init() throws ServletException {
        super.init();
        studentDAO = new StudentDAO();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "view":
                viewStudent(request, response);
                break;
            case "search":
                searchStudents(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                createStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách học sinh
     */
    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        
        // Nếu không có thao tác chính, chỉ ghi log thao tác SELECT
        if (request.getAttribute("mainSqlOperation") == null) {
            SQLLogger.logSQL(request, "SELECT", 
                          studentDAO.getLastExecutedSQL());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(request, response);
    }

    /**
     * Hiển thị form thêm học sinh
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(request, response);
    }

    /**
     * Hiển thị form chỉnh sửa học sinh
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        request.setAttribute("student", student);
        
        // Log SQL operation
        SQLLogger.logSQL(request, "SELECT", 
                      studentDAO.getLastExecutedSQL());
        
        request.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(request, response);
    }

    /**
     * Tạo học sinh mới
     */
    private void createStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            Date dateOfBirth = dateFormat.parse(request.getParameter("dateOfBirth"));
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            Date enrollmentDate = dateFormat.parse(request.getParameter("enrollmentDate"));
            String status = request.getParameter("status");

            Student student = new Student(firstName, lastName, dateOfBirth, gender, address, 
                                        phoneNumber, email, enrollmentDate, status);
            
            int result = studentDAO.addStudent(student);
            
            // Lưu câu lệnh SQL INSERT
            String mainSql = studentDAO.getLastExecutedSQL();
            
            if (result > 0) {
                request.setAttribute("message", "Thêm học sinh thành công");
            } else {
                request.setAttribute("message", "Thêm học sinh thất bại");
            }
            
            // Lấy danh sách học sinh và lưu cả hai thao tác SQL
            List<Student> students = studentDAO.getAllStudents();
            request.setAttribute("students", students);
            
            SQLLogger.logMainAndListSQL(request, 
                                      "INSERT", mainSql,
                                      "SELECT", studentDAO.getLastExecutedSQL());
            
            request.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Lỗi định dạng ngày tháng");
            showNewForm(request, response);
        }
    }

    /**
     * Cập nhật thông tin học sinh
     */
    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            Date dateOfBirth = dateFormat.parse(request.getParameter("dateOfBirth"));
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            Date enrollmentDate = dateFormat.parse(request.getParameter("enrollmentDate"));
            String status = request.getParameter("status");

            Student student = new Student(id, firstName, lastName, dateOfBirth, gender, address, 
                                        phoneNumber, email, enrollmentDate, status);
            
            boolean result = studentDAO.updateStudent(student);
            
            // Lưu câu lệnh SQL UPDATE
            String mainSql = studentDAO.getLastExecutedSQL();
            
            if (result) {
                request.setAttribute("message", "Cập nhật học sinh thành công");
            } else {
                request.setAttribute("message", "Cập nhật học sinh thất bại");
            }
            
            // Lấy danh sách học sinh và lưu cả hai thao tác SQL
            List<Student> students = studentDAO.getAllStudents();
            request.setAttribute("students", students);
            
            SQLLogger.logMainAndListSQL(request, 
                                      "UPDATE", mainSql,
                                      "SELECT", studentDAO.getLastExecutedSQL());
            
            request.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Lỗi định dạng ngày tháng");
            showEditForm(request, response);
        }
    }

    /**
     * Xóa học sinh
     */
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean result = studentDAO.deleteStudent(id);
        
        // Lưu câu lệnh SQL DELETE
        String mainSql = studentDAO.getLastExecutedSQL();
        
        if (result) {
            request.setAttribute("message", "Xóa học sinh thành công");
        } else {
            request.setAttribute("message", "Xóa học sinh thất bại");
        }
        
        // Lấy danh sách học sinh và lưu cả hai thao tác SQL
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        
        SQLLogger.logMainAndListSQL(request, 
                                  "DELETE", mainSql,
                                  "SELECT", studentDAO.getLastExecutedSQL());
        
        request.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(request, response);
    }

    /**
     * Xem chi tiết học sinh
     */
    private void viewStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        request.setAttribute("student", student);
        
        // Log SQL operation
        SQLLogger.logSQL(request, "SELECT", 
                      studentDAO.getLastExecutedSQL());
        
        request.getRequestDispatcher("/WEB-INF/views/student/view.jsp").forward(request, response);
    }

    /**
     * Tìm kiếm học sinh
     */
    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        List<Student> students = studentDAO.searchStudentsByName(searchName);
        request.setAttribute("students", students);
        request.setAttribute("searchName", searchName);
        
        // Log SQL operation
        SQLLogger.logSQL(request, "SELECT", 
                      studentDAO.getLastExecutedSQL());
        
        request.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(request, response);
    }
} 