package com.ecommerce.controller;

import com.ecommerce.bean.Order;
import com.ecommerce.dao.OrderDao;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class ManageOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDao orderDao = new OrderDao();
        List<Order> orderList = orderDao.getAllOrders();
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/admin/manage-orders.jsp").forward(request, response);
    }
}