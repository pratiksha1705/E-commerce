<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Products | TechBoutique</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        
        .container { 
            width: 90%; 
            max-width: 1200px;
            margin: 0 auto; 
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        
        .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            border-bottom: 1px solid #e0e0e0; 
            margin-bottom: 20px;
            padding-bottom: 20px;
        }
        
        .header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin: 0;
            font-weight: 700;
        }
        
        .header-links a { 
            margin-left: 20px; 
            text-decoration: none;
            color: #3498db;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        
        .header-links a:hover { 
            background-color: #f8f9fa;
            color: #2980b9;
        }
        
        .welcome-message {
            background: linear-gradient(135deg, #3498db, #2c3e50);
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: inline-block;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .search-container {
            margin: 20px 0; 
            display: flex; 
            justify-content: center;
        }
        
        .search-bar { 
            display: flex; 
            width: 100%;
            max-width: 600px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 30px;
            overflow: hidden;
        }
        
        .search-bar input[type=text] { 
            flex-grow: 1; 
            padding: 14px 20px; 
            border: none;
            font-size: 16px;
            background: white;
        }
        
        .search-bar input[type=text]:focus {
            outline: none;
        }
        
        .search-bar button { 
            padding: 14px 25px; 
            background: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .search-bar button:hover { 
            background: #2980b9;
        }
        
        .product-grid { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 25px; 
            justify-content: center;
            margin-top: 30px;
        }
        
        .product-card { 
            border: 1px solid #e0e0e0; 
            padding: 20px; 
            width: 250px; 
            text-align: center; 
            display: flex; 
            flex-direction: column; 
            border-radius: 12px;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .product-card img { 
            max-width: 100%; 
            height: 180px; 
            object-fit: cover; 
            margin-bottom: 15px; 
            border-radius: 8px;
        }
        
        .product-card .product-info { 
            flex-grow: 1; 
            margin-bottom: 15px;
        }
        
        .product-card h3 {
            color: #2c3e50;
            margin: 10px 0;
            font-size: 18px;
        }
        
        .product-card p {
            color: #7f8c8d;
            font-size: 14px;
            line-height: 1.5;
            margin: 10px 0;
        }
        
        .product-card h4 {
            color: #e74c3c;
            font-size: 20px;
            margin: 10px 0;
        }
        
        .product-card button { 
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white; 
            border: none; 
            padding: 12px; 
            cursor: pointer; 
            width: 100%; 
            margin-top: auto; 
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            z-index: 2;
        }
        
        .product-card button:hover { 
            background: linear-gradient(135deg, #2980b9, #3498db);
            transform: translateY(-2px);
        }
        
        .stock-info {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 8px 0;
            font-size: 14px;
            color: #27ae60;
        }
        
        .stock-info i {
            margin-right: 5px;
        }
        
        /* Description overlay styles */
        .description-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(44, 62, 80, 0.95);
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
            border-radius: 12px;
            box-sizing: border-box;
        }
        
        .description-overlay h3 {
            color: white;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .description-overlay p {
            color: #ecf0f1;
            font-size: 14px;
            line-height: 1.6;
            text-align: center;
            max-height: 70%;
            overflow-y: auto;
            padding: 0 10px;
        }
        
        .product-card:hover .description-overlay {
            opacity: 1;
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .header-links {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            .header-links a {
                margin: 0;
            }
            
            .product-card {
                width: 100%;
                max-width: 300px;
            }
            
            /* On mobile, show description without hover */
            .description-overlay {
                position: static;
                opacity: 1;
                background: transparent;
                color: #7f8c8d;
                height: auto;
                margin-top: 10px;
                padding: 0;
            }
            
            .description-overlay h3 {
                display: none;
            }
            
            .description-overlay p {
                color: #7f8c8d;
                max-height: none;
                padding: 0;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .container {
                padding: 15px;
                width: 100%;
            }
            
            .search-bar {
                flex-direction: column;
                border-radius: 10px;
            }
            
            .search-bar input[type="text"] {
                border-radius: 10px 10px 0 0;
            }
            
            .search-bar button {
                border-radius: 0 0 10px 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2><i class="fas fa-box-open"></i> Our Products</h2>
        <div class="header-links">
            <a href="${pageContext.request.contextPath}/order-history"><i class="fas fa-history"></i> My Orders</a>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> View Cart</a>
        </div>
    </div>
    <c:if test="${not empty sessionScope.user}">
        <div class="welcome-message">
            <p>Welcome, ${sessionScope.user.name}!</p>
        </div>
    </c:if>
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/products" method="get" class="search-bar">
            <input type="text" name="query" placeholder="Search for products..." value="${searchQuery}">
            <button type="submit"><i class="fas fa-search"></i> Search</button>
        </form>
    </div>
    <div class="product-grid">
        <c:forEach var="product" items="${productList}">
            <div class="product-card">
                <img src="${product.imageUrl}" alt="${product.name}">
                <div class="product-info">
                    <h3>${product.name}</h3>
                    <h4>Price: $${product.price}</h4>
                    <div class="stock-info">
                        <i class="fas fa-cubes"></i> In Stock: ${product.stockQuantity}
                    </div>
                </div>
                <div class="description-overlay">
                    <h3>${product.name}</h3>
                    <p>${product.description}</p>
                </div>
                <form action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button type="submit"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>