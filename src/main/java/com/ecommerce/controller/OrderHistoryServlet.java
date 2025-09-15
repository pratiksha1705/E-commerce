package com.ecommerce.controller;

import com.ecommerce.bean.Order;
import com.ecommerce.bean.User;
import com.ecommerce.dao.OrderDao;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        OrderDao orderDao = new OrderDao();
        List<Order> orderList = orderDao.getOrdersByUserId(user.getId());

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/order-history.jsp").forward(request, response);
    }
}