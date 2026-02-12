<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Login - Schoolbus System</title>
</head>
<body>

<h2>Parent Login</h2>
<p>Login to track your child's bus status</p>

<hr/>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/parent/login" method="post">
    <table>
        <tr>
            <td>Email: *</td>
            <td><input type="email" name="email" required placeholder="Enter your email" /></td>
        </tr>
        <tr>
            <td>Password: *</td>
            <td><input type="password" name="password" required placeholder="Enter your password" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Login" />
            </td>
        </tr>
    </table>
</form>

<br/>
<a href="${pageContext.request.contextPath}/admin/login">Admin Login</a>

</body>
</html>
