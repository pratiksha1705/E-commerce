package com.ecommerce.controller;

import com.ecommerce.bean.User;
import com.ecommerce.dao.UserDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// This annotation maps this servlet to the URL /user/register
@WebServlet("/user/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get the registration data from the form
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPassword_hash(request.getParameter("password")); // DAO will hash it
        user.setPhone(request.getParameter("phone"));

        // 2. Create a UserDao instance
        UserDao userDao = new UserDao();
        
        // 3. Call the registerUser method
        boolean isRegistered = userDao.registerUser(user);

        // 4. Redirect or forward based on the result
        if (isRegistered) {
            // **FIXED LINE**
            // If registration is successful, redirect using the full context path.
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            // If registration fails (e.g., email exists), send an error message
            // and forward back to the registration page.
            request.setAttribute("errorMessage", "Registration failed. The email may already be in use.");
            
            // It's also good practice to use a leading slash for forwarding.
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}