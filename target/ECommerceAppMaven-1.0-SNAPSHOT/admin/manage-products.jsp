<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Manage Products</title>
    <style>
        body { font-family: sans-serif; margin: 0; background-color: #f9f9f9; }
        .container { padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;}
        table { width: 100%; border-collapse: collapse; background-color: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; vertical-align: middle;}
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        img { display: block; }
        .actions a { margin-right: 10px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Manage Products</h2>
            <a href="${pageContext.request.contextPath}/admin/products/add" style="padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none;">Add New Product</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${productList}">
                    <tr>
                        <td>${product.id}</td>
                        <td><img src="${product.imageUrl}" alt="${product.name}" width="50"></td>
                        <td>${product.name}</td>
                        <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></td>
                        <td>${product.stockQuantity}</td>
                        <td class="actions">
                            <a href="${pageContext.request.contextPath}/admin/products/edit?productId=${product.id}">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/products/delete?productId=${product.id}" 
                               onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>