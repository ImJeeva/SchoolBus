<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Parent List - Schoolbus System</title>
</head>
<body>

<h2>Parent List</h2>

<nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a> |
    <a href="${pageContext.request.contextPath}/admin/parent/add">+ Add New Parent</a>
</nav>

<hr/>

<table border="1" cellpadding="8">
    <tr>
        <th>#</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Children</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="parent" items="${parents}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${parent.name}</td>
            <td>${parent.email}</td>
            <td>${parent.phone}</td>
            <td>${parent.address}</td>
            <td>
                <!-- Show all children names for this parent -->
                <c:forEach var="child" items="${parent.students}" varStatus="cs">
                    ${child.name}<c:if test="${!cs.last}">, </c:if>
                </c:forEach>
                <c:if test="${empty parent.students}">-</c:if>
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/parent/edit/${parent.parentId}">Edit</a> |
                <a href="${pageContext.request.contextPath}/admin/parent/delete/${parent.parentId}"
                   onclick="return confirm('Are you sure you want to delete this parent?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty parents}">
        <tr><td colspan="7">No parents found. <a href="${pageContext.request.contextPath}/admin/parent/add">Add one now.</a></td></tr>
    </c:if>
</table>

</body>
</html>
