package com.ecommerce.controller;

import com.ecommerce.dao.OrderDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders/update-status")
public class UpdateOrderStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        OrderDao orderDao = new OrderDao();
        orderDao.updateOrderStatus(orderId, status);

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}