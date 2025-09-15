<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Manage Orders</title>
    <style>
        /* Using the same styles from manage-products.jsp for consistency */
        body { font-family: sans-serif; margin: 0; background-color: #f9f9f9; }
        .container { padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;}
        table { width: 100%; border-collapse: collapse; background-color: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; vertical-align: middle;}
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Manage Customer Orders</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Dashboard</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer Name</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.customerName}</td>
                        <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <select name="status">
                                    <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                    <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="Delivered" ${order.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                    <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button type="submit">Update</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>