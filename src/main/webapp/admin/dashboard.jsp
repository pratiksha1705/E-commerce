<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: sans-serif; margin: 0; background-color: #f9f9f9;}
        .header { display: flex; justify-content: space-between; align-items: center; padding: 10px 20px; background-color: #333; color: white; }
        .container { padding: 20px; }
        .kpi-grid { display: flex; gap: 20px; margin-bottom: 30px; }
        .kpi-box { background: white; padding: 20px; border-radius: 5px; border: 1px solid #ddd; flex-grow: 1; text-align: center; }
        .kpi-box h3 { margin-top: 0; }
        .kpi-box .number { font-size: 2.5em; font-weight: bold; }
        .management-links ul { list-style: none; padding: 0; }
        .management-links li { background: #fff; margin: 10px 0; padding: 15px; border: 1px solid #ddd; border-left: 5px solid #007bff; }
        .management-links a { text-decoration: none; color: #333; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard</h1>
        <div>
            <span>Welcome, ${sessionScope.adminUser.name}!</span>
            <a href="${pageContext.request.contextPath}/admin/logout" style="color: white; margin-left: 20px;">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Dashboard Overview</h2>

        <div class="kpi-grid">
            <div class="kpi-box">
                <h3>Total Users</h3>
                <div class="number">${userCount}</div>
            </div>
            <div class="kpi-box">
                <h3>Total Products</h3>
                <div class="number">${productCount}</div>
            </div>
            <div class="kpi-box">
                <h3>Total Orders</h3>
                <div class="number">${orderCount}</div>
            </div>
            <div class="kpi-box">
                <h3>Total Revenue</h3>
                <div class="number"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="$"/></div>
            </div>
        </div>

        <h2>Management Links</h2>
        <div class="management-links">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/products">Manage Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            </ul>
        </div>
    </div>
</body>
</html>