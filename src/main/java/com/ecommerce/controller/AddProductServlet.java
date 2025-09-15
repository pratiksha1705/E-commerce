package com.ecommerce.controller;

import com.ecommerce.bean.Category;
import com.ecommerce.bean.Product;
import com.ecommerce.dao.CategoryDao;
import com.ecommerce.dao.ProductDao;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/add")
public class AddProductServlet extends HttpServlet {
    // Display the form to add a new product
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDao categoryDao = new CategoryDao();
        List<Category> categories = categoryDao.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/add-product.jsp").forward(request, response);
    }

    // Process the submitted form and save the new product
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String imageUrl = request.getParameter("imageUrl");

        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategoryId(categoryId); // You'll need to add this field to Product.java
        product.setStockQuantity(stockQuantity);
        product.setImageUrl(imageUrl);

        ProductDao productDao = new ProductDao();
        productDao.addProduct(product);

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}