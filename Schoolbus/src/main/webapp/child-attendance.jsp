<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance History - ${student.name}</title>
</head>
<body>

<h2>Attendance History</h2>

<nav>
    <a href="${pageContext.request.contextPath}/parent/dashboard">Back to Dashboard</a> |
    <a href="${pageContext.request.contextPath}/parent/logout">Logout</a>
</nav>

<hr/>

<!-- Student Info -->
<h3>Student Details</h3>
<table border="1" cellpadding="8">
    <tr><th>Name</th>        <td>${student.name}</td></tr>
    <tr><th>Class</th>       <td>${student.className} - ${student.section}</td></tr>
    <tr>
        <th>Bus</th>
        <td>
            <c:if test="${not empty student.bus}">
                ${student.bus.busNumber} | Driver: ${student.bus.driverName} | ${student.bus.route}
            </c:if>
            <c:if test="${empty student.bus}">Not assigned</c:if>
        </td>
    </tr>
</table>

<br/>

<!-- Attendance Records -->
<h3>All Scan Records</h3>
<table border="1" cellpadding="8">
    <tr>
        <th>#</th>
        <th>Date</th>
        <th>Time</th>
        <th>Event</th>
        <th>Bus</th>
        <th>SMS Sent to Parent</th>
    </tr>
    <c:forEach var="att" items="${attendanceList}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td><fmt:formatDate value="${att.scanTime}" pattern="dd-MM-yyyy"/></td>
            <td><fmt:formatDate value="${att.scanTime}" pattern="hh:mm a"/></td>
            <td>
                <c:choose>
                    <c:when test="${att.eventType == 'BOARDING'}">
                        <strong style="color:green;">BOARDING</strong>
                    </c:when>
                    <c:otherwise>
                        <strong style="color:blue;">DROPOFF</strong>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${att.bus.busNumber}</td>
            <td>${att.alertSent ? 'Yes' : 'No'}</td>
        </tr>
    </c:forEach>
    <c:if test="${empty attendanceList}">
        <tr><td colspan="6">No attendance records found for this student.</td></tr>
    </c:if>
</table>

<br/>
<p>Total Records: ${attendanceList.size()}</p>

</body>
</html>
