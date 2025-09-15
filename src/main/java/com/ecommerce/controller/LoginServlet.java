package com.ecommerce.controller;

import com.ecommerce.bean.User;
import com.ecommerce.dao.UserDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/user/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get email and password from the form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 2. Create a UserDao instance
        UserDao userDao = new UserDao();
        
        // 3. Call the validateUser method
        User user = userDao.validateUser(email, password);

        // 4. Check the result and redirect
        if (user != null) {
            // If user is valid, create a session
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Store user object in session
            
            // **FIX 1: Use the full context path for the redirect.**
            // This now correctly points to your ProductServlet.
            response.sendRedirect(request.getContextPath() + "/products");
        } else {
            // If user is invalid, set an error message
            request.setAttribute("errorMessage", "Invalid email or password");

            // **FIX 2: Use a context-relative path for the forward (good practice).**
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}