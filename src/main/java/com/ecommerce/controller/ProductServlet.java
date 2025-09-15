package com.ecommerce.controller;

import com.ecommerce.bean.Product;
import com.ecommerce.dao.ProductDao;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("query");
        ProductDao productDao = new ProductDao();
        List<Product> productList;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // If there is a search query, use the search method
            productList = productDao.searchProductsByName(searchQuery);
            request.setAttribute("searchQuery", searchQuery); // Send the query back to the JSP
        } else {
            // Otherwise, get all products
            productList = productDao.getAllProducts();
        }

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}