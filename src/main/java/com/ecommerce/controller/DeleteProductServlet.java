package com.ecommerce.controller;

import com.ecommerce.dao.ProductDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/delete")
public class DeleteProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDao productDao = new ProductDao();
        productDao.deleteProduct(productId);

        // Redirect back to the product list page
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}