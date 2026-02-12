<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bus Form - Schoolbus System</title>
</head>
<body>

<h2>
    <c:choose>
        <c:when test="${bus.busId == 0}">Add New Bus</c:when>
        <c:otherwise>Edit Bus</c:otherwise>
    </c:choose>
</h2>

<nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a> |
    <a href="${pageContext.request.contextPath}/admin/bus/list">Back to Bus List</a>
</nav>

<hr/>

<c:choose>
    <c:when test="${bus.busId == 0}">
        <form action="${pageContext.request.contextPath}/admin/bus/save" method="post">
    </c:when>
    <c:otherwise>
        <form action="${pageContext.request.contextPath}/admin/bus/update" method="post">
        <input type="hidden" name="busId" value="${bus.busId}" />
    </c:otherwise>
</c:choose>

<table>
    <tr>
        <td>Bus Number: *</td>
        <td><input type="text" name="busNumber" value="${bus.busNumber}" required placeholder="e.g. BUS-01"/></td>
    </tr>
    <tr>
        <td>Driver Name: *</td>
        <td><input type="text" name="driverName" value="${bus.driverName}" required /></td>
    </tr>
    <tr>
        <td>Driver Phone:</td>
        <td><input type="text" name="driverPhone" value="${bus.driverPhone}" /></td>
    </tr>
    <tr>
        <td>Route:</td>
        <td><input type="text" name="route" value="${bus.route}" placeholder="e.g. School - Anna Nagar - T.Nagar"/></td>
    </tr>
    <tr>
        <td>Capacity:</td>
        <td><input type="number" name="capacity" value="${bus.capacity}" /></td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="submit" value="${bus.busId == 0 ? 'Save Bus' : 'Update Bus'}" />
            <a href="${pageContext.request.contextPath}/admin/bus/list">Cancel</a>
        </td>
    </tr>
</table>

</form>

</body>
</html>
