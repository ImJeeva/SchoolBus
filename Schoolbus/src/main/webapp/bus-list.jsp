<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bus List - Schoolbus System</title>
</head>
<body>

<h2>Bus List</h2>

<nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a> |
    <a href="${pageContext.request.contextPath}/admin/bus/add">+ Add New Bus</a>
</nav>

<hr/>

<table border="1" cellpadding="8">
    <tr>
        <th>#</th>
        <th>Bus Number</th>
        <th>Driver Name</th>
        <th>Driver Phone</th>
        <th>Route</th>
        <th>Capacity</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="bus" items="${buses}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${bus.busNumber}</td>
            <td>${bus.driverName}</td>
            <td>${bus.driverPhone}</td>
            <td>${bus.route}</td>
            <td>${bus.capacity}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/bus/edit/${bus.busId}">Edit</a> |
                <a href="${pageContext.request.contextPath}/admin/bus/delete/${bus.busId}"
                   onclick="return confirm('Are you sure you want to delete this bus?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty buses}">
        <tr><td colspan="7">No buses found. <a href="${pageContext.request.contextPath}/admin/bus/add">Add one now.</a></td></tr>
    </c:if>
</table>

</body>
</html>
