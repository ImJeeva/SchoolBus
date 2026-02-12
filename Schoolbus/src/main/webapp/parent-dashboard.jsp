<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Dashboard - Schoolbus System</title>
    <!-- Auto-refresh every 60 seconds to show latest status -->
    <meta http-equiv="refresh" content="60">
</head>
<body>

<h2>Welcome, ${parent.name}!</h2>
<p>
    Phone: ${parent.phone} |
    Email: ${parent.email} |
    <a href="${pageContext.request.contextPath}/parent/logout">Logout</a>
</p>

<hr/>

<h3>Your Children's Bus Status</h3>

<c:if test="${empty children}">
    <p>No children assigned to your account yet. Please contact the school admin.</p>
</c:if>

<c:forEach var="child" items="${children}">
    <table border="1" cellpadding="8">
        <tr>
            <th colspan="2" style="background-color:#f0f0f0;">
                ${child.name} | Class: ${child.className} - ${child.section}
            </th>
        </tr>
        <tr>
            <td>Assigned Bus:</td>
            <td>
                <c:if test="${not empty child.bus}">
                    ${child.bus.busNumber} | Driver: ${child.bus.driverName} | Route: ${child.bus.route}
                </c:if>
                <c:if test="${empty child.bus}">Not assigned</c:if>
            </td>
        </tr>
        <tr>
            <td>Current Status:</td>
            <td>
                <c:if test="${not empty child.lastEvent}">
                    <c:choose>
                        <c:when test="${child.lastEvent.eventType == 'BOARDING'}">
                            <strong style="color:green;">
                                ON BUS — Boarded at
                                <fmt:formatDate value="${child.lastEvent.scanTime}" pattern="hh:mm a, dd-MM-yyyy"/>
                            </strong>
                        </c:when>
                        <c:otherwise>
                            <strong style="color:blue;">
                                DROPPED OFF — at
                                <fmt:formatDate value="${child.lastEvent.scanTime}" pattern="hh:mm a, dd-MM-yyyy"/>
                            </strong>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${empty child.lastEvent}">
                    <strong style="color:grey;">No scan recorded today</strong>
                </c:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="${pageContext.request.contextPath}/attendance/student/${child.studentId}">
                    View Full Attendance History
                </a>
            </td>
        </tr>
    </table>
    <br/>
</c:forEach>

<hr/>
<p><small>Page auto-refreshes every 60 seconds. Last updated: <fmt:formatDate value="<%=new java.util.Date()%>" pattern="hh:mm a"/></small></p>

</body>
</html>
