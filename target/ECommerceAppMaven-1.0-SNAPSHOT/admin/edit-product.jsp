<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body { font-family: sans-serif; }
        .container { padding: 20px; width: 50%; margin: auto;}
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type=text], input[type=number], textarea, select { width: 100%; padding: 8px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Product</h2>
        <form action="${pageContext.request.contextPath}/admin/products/edit" method="post">
            <input type="hidden" name="id" value="${product.id}">

            <div><label>Name:</label><input type="text" name="name" value="${product.name}" required></div>
            <div><label>Description:</label><textarea name="description" rows="4">${product.description}</textarea></div>
            <div><label>Price:</label><input type="number" name="price" step="0.01" value="${product.price}" required></div>
            <div><label>Stock Quantity:</label><input type="number" name="stockQuantity" value="${product.stockQuantity}" required></div>
            <div><label>Image URL:</label><input type="text" name="imageUrl" value="${product.imageUrl}"></div>
            <div>
                <label>Category:</label>
                <select name="categoryId" required>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.id}" ${category.id == product.categoryId ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div><button type="submit">Update Product</button></div>
        </form>
    </div>
</body>
</html>