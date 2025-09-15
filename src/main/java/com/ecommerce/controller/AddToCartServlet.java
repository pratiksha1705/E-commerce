package com.ecommerce.controller;

import com.ecommerce.bean.Cart;
import com.ecommerce.bean.Product;
import com.ecommerce.dao.ProductDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product ID and quantity from the form
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 1; // For now, we add 1 item at a time

        // Get the user's session
        HttpSession session = request.getSession();

        // Get the cart from the session, or create a new one if it doesn't exist
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Get the product from the database
        ProductDao productDao = new ProductDao();
        Product product = productDao.getProductById(productId);

        if (product != null) {
            // Add the item to the cart
            cart.addItem(product, quantity);
        }

        // Redirect the user to the products page (or a dedicated cart page)
        response.sendRedirect(request.getContextPath() + "/products");
    }
}