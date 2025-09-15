package com.ecommerce.controller;

import com.ecommerce.dao.OrderDao;
import com.ecommerce.dao.ProductDao;
import com.ecommerce.dao.UserDao;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        ProductDao productDao = new ProductDao();
        OrderDao orderDao = new OrderDao();

        int userCount = userDao.getUserCount();
        int productCount = productDao.getProductCount();
        int orderCount = orderDao.getOrderCount();
        BigDecimal totalRevenue = orderDao.getTotalRevenue();

        if (totalRevenue == null) {
            totalRevenue = BigDecimal.ZERO;
        }

        request.setAttribute("userCount", userCount);
        request.setAttribute("productCount", productCount);
        request.setAttribute("orderCount", orderCount);
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}