package com.ecommerce.controller;

import com.ecommerce.bean.Cart;
import com.ecommerce.bean.User;
import com.ecommerce.dao.OrderDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || cart == null || cart.getItems().isEmpty()) {
            // Redirect to login or cart page if something is wrong
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        OrderDao orderDao = new OrderDao();
        int orderId = orderDao.createOrder(user, cart);

        if (orderId != -1) {
            // Order created successfully
            // Clear the cart from the session
            session.removeAttribute("cart");
            // Redirect to a confirmation page
            response.sendRedirect(request.getContextPath() + "/order-confirmation.jsp?orderId=" + orderId);
        } else {
            // Handle order creation failure
            response.sendRedirect(request.getContextPath() + "/cart?error=true");
        }
    }
}