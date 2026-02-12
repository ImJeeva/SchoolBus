<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Form - Schoolbus System</title>
</head>
<body>

<h2>
    <c:choose>
        <c:when test="${parent.parentId == 0}">Add New Parent</c:when>
        <c:otherwise>Edit Parent</c:otherwise>
    </c:choose>
</h2>

<nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a> |
    <a href="${pageContext.request.contextPath}/admin/parent/list">Back to Parent List</a>
</nav>

<hr/>

<c:choose>
    <c:when test="${parent.parentId == 0}">
        <form action="${pageContext.request.contextPath}/admin/parent/save" method="post">
    </c:when>
    <c:otherwise>
        <form action="${pageContext.request.contextPath}/admin/parent/update" method="post">
        <input type="hidden" name="parentId" value="${parent.parentId}" />
    </c:otherwise>
</c:choose>

<table>
    <tr>
        <td>Parent Name: *</td>
        <td><input type="text" name="name" value="${parent.name}" required /></td>
    </tr>
    <tr>
        <td>Email: *</td>
        <td><input type="email" name="email" value="${parent.email}" required /></td>
    </tr>
    <tr>
        <td>Password: *</td>
        <td>
            <input type="password" name="password" value="${parent.password}" required />
            <c:if test="${parent.parentId != 0}">
                <small>(leave unchanged to keep existing password)</small>
            </c:if>
        </td>
    </tr>
    <tr>
        <td>Phone: *</td>
        <td>
            <input type="text" name="phone" value="${parent.phone}" required
                   placeholder="+91XXXXXXXXXX (include country code for SMS)"/>
        </td>
    </tr>
    <tr>
        <td>Address:</td>
        <td><textarea name="address" rows="3" cols="30">${parent.address}</textarea></td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="submit" value="${parent.parentId == 0 ? 'Save Parent' : 'Update Parent'}" />
            <a href="${pageContext.request.contextPath}/admin/parent/list">Cancel</a>
        </td>
    </tr>
</table>

</form>

<c:if test="${parent.parentId == 0}">
    <p><small>* Phone number must include country code (e.g. +919876543210) for SMS alerts to work.</small></p>
</c:if>

</body>
</html>
