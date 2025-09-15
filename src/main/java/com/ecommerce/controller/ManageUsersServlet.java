package com.ecommerce.controller;

import com.ecommerce.bean.User;
import com.ecommerce.dao.UserDao;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        List<User> userList = userDao.getAllUsers();

        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/admin/manage-users.jsp").forward(request, response);
    }
}