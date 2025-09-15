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

@WebServlet("/admin/products")
public class ManageProductsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDao productDao = new ProductDao();
        // We can reuse the existing method to get all products
        List<Product> productList = productDao.getAllProducts(); 

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/admin/manage-products.jsp").forward(request, response);
    }
}