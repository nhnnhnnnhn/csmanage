package com.schoolmanagement.utils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Bộ lọc để xử lý mã hóa ký tự UTF-8 cho các yêu cầu và phản hồi
 */
@WebFilter(filterName = "CharacterEncodingFilter", urlPatterns = {"/*"})
public class CharacterEncodingFilter implements Filter {
    private String encoding;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        encoding = filterConfig.getInitParameter("encoding");
        if (encoding == null) {
            encoding = "UTF-8";
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Đặt mã hóa cho yêu cầu
        request.setCharacterEncoding(encoding);
        // Đặt mã hóa cho phản hồi
        response.setCharacterEncoding(encoding);
        response.setContentType("text/html; charset=" + encoding);
        
        // Tiếp tục với chuỗi bộ lọc
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Không có tài nguyên cần giải phóng
    }
} 