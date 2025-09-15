<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Your Shopping Cart</title>
    <style>
        body { font-family: sans-serif; }
        .container { width: 80%; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total-row { font-weight: bold; }
        .empty-cart { text-align: center; padding: 50px; }
        .checkout-btn { float: right; padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Shopping Cart</h2>
        <a href="${pageContext.request.contextPath}/products">Continue Shopping</a>
        <hr>

        <c:if test="${empty sessionScope.cart.items}">
            <div class="empty-cart">
                <p>Your cart is empty.</p>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cart.items}">
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.cart.items}">
                        <tr>
                            <td>${item.product.name}</td>
                            <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$"/></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display: flex;">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" style="width: 50px;">
                                    <button type="submit" style="margin-left: 5px;">Update</button>
                                </form>
                            </td>
                            <td><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="$"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart/remove?productId=${item.product.id}">Remove</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="4">Grand Total</td>
                        <td><fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="$"/></td>
                    </tr>
                </tfoot>
            </table>
            <br>
            <form action="${pageContext.request.contextPath}/checkout" method="post">
                <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </form>
        </c:if>
    </div>
</body>
</html>