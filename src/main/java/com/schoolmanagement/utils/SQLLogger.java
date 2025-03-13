package com.schoolmanagement.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Lớp tiện ích để lưu trữ và hiển thị câu lệnh SQL cho mục đích học tập
 */
public class SQLLogger {
    
    /**
     * Ghi lại thao tác SQL và câu lệnh tương ứng vào request attribute
     * 
     * @param request HttpServletRequest
     * @param operation Loại thao tác (SELECT, INSERT, UPDATE, DELETE)
     * @param sql Câu lệnh SQL tương ứng
     */
    public static void logSQL(HttpServletRequest request, String operation, String sql) {
        request.setAttribute("sqlOperation", operation);
        request.setAttribute("sqlQuery", sql);
    }
    
    /**
     * Ghi lại thao tác SQL chính và câu lệnh SQL danh sách
     * 
     * @param request HttpServletRequest
     * @param mainOperation Loại thao tác chính (INSERT, UPDATE, DELETE)
     * @param mainSql Câu lệnh SQL chính
     * @param listOperation Loại thao tác danh sách (thường là SELECT)
     * @param listSql Câu lệnh SQL danh sách
     */
    public static void logMainAndListSQL(HttpServletRequest request, 
                                        String mainOperation, String mainSql,
                                        String listOperation, String listSql) {
        request.setAttribute("mainSqlOperation", mainOperation);
        request.setAttribute("mainSqlQuery", mainSql);
        request.setAttribute("sqlOperation", listOperation);
        request.setAttribute("sqlQuery", listSql);
    }
} 