<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Your Order History</title>
    <style>
        body { font-family: sans-serif; }
        .container { width: 80%; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Order History</h2>
        <a href="${pageContext.request.contextPath}/products">Back to Products</a>
        <hr>

        <c:if test="${empty orderList}">
            <p>You have not placed any orders yet.</p>
        </c:if>

        <c:if test="${not empty orderList}">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.id}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                            <td>${order.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>