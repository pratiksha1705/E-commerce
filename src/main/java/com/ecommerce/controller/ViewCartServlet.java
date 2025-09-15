package com.ecommerce.controller;

import com.ecommerce.bean.Cart;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/cart")
public class ViewCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // If the cart doesn't exist in the session, create a new one.
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Forward to the JSP page to display the cart
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}