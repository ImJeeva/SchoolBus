<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Records - Schoolbus System</title>
</head>
<body>

<h2>Attendance Records</h2>

<nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
</nav>

<hr/>

<!-- Filter by Date -->
<h3>Filter by Date</h3>
<form action="${pageContext.request.contextPath}/attendance/byDate" method="get">
    <label>Select Date:</label>
    <input type="date" name="date" value="${selectedDate}" />
    <input type="submit" value="Filter" />
    <a href="${pageContext.request.contextPath}/attendance/list">Show All</a>
</form>

<br/>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<!-- Attendance Table -->
<table border="1" cellpadding="8">
    <tr>
        <th>#</th>
        <th>Student Name</th>
        <th>Class</th>
        <th>Bus Number</th>
        <th>Driver</th>
        <th>Event Type</th>
        <th>Scan Time</th>
        <th>SMS Sent</th>
        <th>Parent Phone</th>
    </tr>
    <c:forEach var="att" items="${attendanceList}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${att.student.name}</td>
            <td>${att.student.className} - ${att.student.section}</td>
            <td>${att.bus.busNumber}</td>
            <td>${att.bus.driverName}</td>
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
            <td><fmt:formatDate value="${att.scanTime}" pattern="dd-MM-yyyy hh:mm a"/></td>
            <td>${att.alertSent ? 'Yes' : 'No'}</td>
            <td>
                <c:if test="${not empty att.student.parent}">${att.student.parent.phone}</c:if>
                <c:if test="${empty att.student.parent}">-</c:if>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty attendanceList}">
        <tr><td colspan="9">No attendance records found.</td></tr>
    </c:if>
</table>

<br/>
<p>Total Records: ${attendanceList.size()}</p>

</body>
</html>
