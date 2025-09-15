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

@WebServlet("/admin/products/edit")
public class EditProductServlet extends HttpServlet {
    // Display the form to edit an existing product
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        ProductDao productDao = new ProductDao();
        Product product = productDao.getProductById(productId);

        CategoryDao categoryDao = new CategoryDao();
        List<Category> categories = categoryDao.getAllCategories();

        request.setAttribute("product", product);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/admin/edit-product.jsp").forward(request, response);
    }

    // Process the submitted form and update the product
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String imageUrl = request.getParameter("imageUrl");

        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategoryId(categoryId);
        product.setStockQuantity(stockQuantity);
        product.setImageUrl(imageUrl);

        ProductDao productDao = new ProductDao();
        productDao.updateProduct(product);

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}