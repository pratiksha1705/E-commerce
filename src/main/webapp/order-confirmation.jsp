<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
    </style>
</head>
<body>
    <h1>Thank You For Your Order!</h1>
    <p>Your order has been placed successfully.</p>
    <p>Your Order ID is: <strong>${param.orderId}</strong></p>
    <a href="${pageContext.request.contextPath}/products">Continue Shopping</a>
</body>
</html>