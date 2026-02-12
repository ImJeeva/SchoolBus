<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - SmartBus</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Poppins',sans-serif; background:#f0f4f8; color:#2d3748; }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            top:0; left:0;
            width: 240px;
            height: 100vh;
            background: linear-gradient(180deg, #1a1a2e 0%, #0f3460 100%);
            padding: 24px 0;
            z-index: 100;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 24px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        .sidebar-brand .icon {
            width:42px; height:42px;
            background: linear-gradient(135deg,#ffc107,#ff9800);
            border-radius:12px;
            display:flex; align-items:center; justify-content:center;
            font-size:20px;
        }

        .sidebar-brand h2 { color:#fff; font-size:16px; font-weight:700; }
        .sidebar-brand p  { color:rgba(255,255,255,0.4); font-size:11px; }

        .sidebar-menu { margin-top:16px; }

        .menu-label {
            padding: 8px 24px;
            color: rgba(255,255,255,0.3);
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: rgba(255,255,255,0.6);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .menu-item.active {
            background: rgba(255,193,7,0.1);
            color: #ffc107;
            border-left-color: #ffc107;
        }

        .menu-item span.ico { font-size:18px; width:22px; text-align:center; }

        .sidebar-footer {
            position: absolute;
            bottom: 0; left:0; right:0;
            padding: 16px 24px;
            border-top: 1px solid rgba(255,255,255,0.08);
        }

        .sidebar-footer a {
            display:flex; align-items:center; gap:10px;
            color:rgba(255,255,255,0.5); text-decoration:none; font-size:13px;
            transition:color 0.2s;
        }
        .sidebar-footer a:hover { color:#ff6b6b; }

        /* MAIN CONTENT */
        .main {
            margin-left: 240px;
            padding: 32px;
            min-height: 100vh;
        }

        .page-header {
            display:flex; align-items:center; justify-content:space-between;
            margin-bottom:32px;
        }

        .page-header h1 { font-size:24px; font-weight:700; color:#1a1a2e; }
        .page-header p  { color:#718096; font-size:14px; margin-top:2px; }

        .badge {
            background: linear-gradient(135deg,#ffc107,#ff9800);
            color:#1a1a2e;
            padding:6px 16px;
            border-radius:20px;
            font-size:13px;
            font-weight:600;
        }

        /* STAT CARDS */
        .stats-grid {
            display:grid;
            grid-template-columns: repeat(3, 1fr);
            gap:20px;
            margin-bottom:32px;
        }

        .stat-card {
            background:#fff;
            border-radius:16px;
            padding:24px;
            box-shadow:0 2px 12px rgba(0,0,0,0.06);
            display:flex;
            align-items:center;
            gap:20px;
            transition:transform 0.2s, box-shadow 0.2s;
        }

        .stat-card:hover { transform:translateY(-3px); box-shadow:0 8px 24px rgba(0,0,0,0.1); }

        .stat-icon {
            width:56px; height:56px;
            border-radius:14px;
            display:flex; align-items:center; justify-content:center;
            font-size:26px;
            flex-shrink:0;
        }

        .stat-icon.yellow { background:rgba(255,193,7,0.15); }
        .stat-icon.blue   { background:rgba(66,153,225,0.15); }
        .stat-icon.green  { background:rgba(72,187,120,0.15); }

        .stat-info h3 { font-size:28px; font-weight:700; color:#1a1a2e; }
        .stat-info p  { color:#718096; font-size:13px; margin-top:2px; }

        /* TABLE CARD */
        .card {
            background:#fff;
            border-radius:16px;
            box-shadow:0 2px 12px rgba(0,0,0,0.06);
            overflow:hidden;
        }

        .card-header {
            padding:20px 24px;
            border-bottom:1px solid #f0f4f8;
            display:flex; align-items:center; justify-content:space-between;
        }

        .card-header h3 { font-size:16px; font-weight:600; color:#1a1a2e; }

        .btn-sm {
            padding:6px 14px;
            background: linear-gradient(135deg,#ffc107,#ff9800);
            border:none; border-radius:8px;
            color:#1a1a2e; font-size:12px; font-weight:600;
            cursor:pointer; text-decoration:none;
            font-family:'Poppins',sans-serif;
        }

        table { width:100%; border-collapse:collapse; }
        thead th {
            padding:12px 20px;
            background:#f7fafc;
            color:#718096;
            font-size:12px;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:0.5px;
            text-align:left;
        }

        tbody td { padding:14px 20px; font-size:13px; border-bottom:1px solid #f0f4f8; }
        tbody tr:last-child td { border-bottom:none; }
        tbody tr:hover { background:#fafbfc; }

        .badge-boarding { background:rgba(72,187,120,0.15); color:#2f855a; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:600; }
        .badge-dropoff  { background:rgba(66,153,225,0.15); color:#2b6cb0; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:600; }
        .badge-yes      { background:rgba(72,187,120,0.15); color:#2f855a; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:600; }
        .badge-no       { background:rgba(245,101,101,0.15); color:#c53030; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:600; }

        .empty-row td { text-align:center; color:#a0aec0; padding:32px; }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="sidebar-brand">
        <div class="icon">🚌</div>
        <div>
            <h2>SmartBus</h2>
            <p>Admin Panel</p>
        </div>
    </div>

    <div class="sidebar-menu">
        <div class="menu-label">Main</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">
            <span class="ico">📊</span> Dashboard
        </a>

        <div class="menu-label">Manage</div>
        <a href="${pageContext.request.contextPath}/admin/student/list" class="menu-item">
            <span class="ico">🎒</span> Students
        </a>
        <a href="${pageContext.request.contextPath}/admin/parent/list" class="menu-item">
            <span class="ico">👨‍👩‍👧</span> Parents
        </a>
        <a href="${pageContext.request.contextPath}/admin/bus/list" class="menu-item">
            <span class="ico">🚌</span> Buses
        </a>

        <div class="menu-label">Reports</div>
        <a href="${pageContext.request.contextPath}/attendance/list" class="menu-item">
            <span class="ico">📋</span> Attendance
        </a>

        <div class="menu-label">Driver</div>
        <a href="${pageContext.request.contextPath}/attendance/scan-page" class="menu-item">
            <span class="ico">📷</span> Scan QR Page
        </a>
    </div>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/admin/logout">
            <span>🚪</span> Logout
        </a>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main">

    <div class="page-header">
        <div>
            <h1>Dashboard</h1>
            <p>Welcome back, Admin! Here's what's happening today.</p>
        </div>
        <span class="badge">🟢 System Active</span>
    </div>

    <!-- Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon yellow">🎒</div>
            <div class="stat-info">
                <h3>${totalStudents}</h3>
                <p>Total Students</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon blue">👨‍👩‍👧</div>
            <div class="stat-info">
                <h3>${totalParents}</h3>
                <p>Total Parents</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green">🚌</div>
            <div class="stat-info">
                <h3>${totalBuses}</h3>
                <p>Total Buses</p>
            </div>
        </div>
    </div>

    <!-- Recent Attendance -->
    <div class="card">
        <div class="card-header">
            <h3>Recent Attendance (Last 10 Records)</h3>
            <a href="${pageContext.request.contextPath}/attendance/list" class="btn-sm">View All</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Student</th>
                    <th>Bus</th>
                    <th>Event</th>
                    <th>Scan Time</th>
                    <th>Email Sent</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="att" items="${recentAttendance}" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td>${att.student.name}</td>
                        <td>${att.bus.busNumber}</td>
                        <td>
                            <c:choose>
                                <c:when test="${att.eventType == 'BOARDING'}">
                                    <span class="badge-boarding">BOARDING</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-dropoff">DROPOFF</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${att.scanTime}" pattern="dd-MM-yyyy hh:mm a"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${att.alertSent}"><span class="badge-yes">Yes</span></c:when>
                                <c:otherwise><span class="badge-no">No</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty recentAttendance}">
                    <tr class="empty-row"><td colspan="6">No attendance records yet.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>
