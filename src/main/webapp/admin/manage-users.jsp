<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Users</title>
    <style>
        /* Using the same styles for consistency */
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
            <h2>Manage Registered Users</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Dashboard</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>