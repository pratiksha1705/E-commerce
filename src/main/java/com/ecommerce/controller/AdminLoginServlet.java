package com.ecommerce.controller;

import com.ecommerce.bean.Admin;
import com.ecommerce.dao.AdminDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDao adminDao = new AdminDao();
        Admin admin = adminDao.validateAdmin(email, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            // Use a distinct session attribute for the admin
            session.setAttribute("adminUser", admin);
            // Redirect to a future admin dashboard page
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute("errorMessage", "Invalid credentials");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}