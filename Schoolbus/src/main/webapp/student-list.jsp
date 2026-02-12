<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Students - SmartBus</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Poppins',sans-serif; background:#f0f4f8; color:#2d3748; }

        .sidebar {
            position:fixed; top:0; left:0;
            width:240px; height:100vh;
            background:linear-gradient(180deg,#1a1a2e 0%,#0f3460 100%);
            padding:24px 0; z-index:100;
        }
        .sidebar-brand { display:flex; align-items:center; gap:12px; padding:0 24px 24px; border-bottom:1px solid rgba(255,255,255,0.08); }
        .sidebar-brand .icon { width:42px; height:42px; background:linear-gradient(135deg,#ffc107,#ff9800); border-radius:12px; display:flex; align-items:center; justify-content:center; font-size:20px; }
        .sidebar-brand h2 { color:#fff; font-size:16px; font-weight:700; }
        .sidebar-brand p  { color:rgba(255,255,255,0.4); font-size:11px; }
        .menu-label { padding:8px 24px; color:rgba(255,255,255,0.3); font-size:10px; font-weight:600; letter-spacing:1.5px; text-transform:uppercase; }
        .menu-item { display:flex; align-items:center; gap:12px; padding:12px 24px; color:rgba(255,255,255,0.6); text-decoration:none; font-size:14px; font-weight:500; transition:all 0.2s; border-left:3px solid transparent; }
        .menu-item:hover, .menu-item.active { background:rgba(255,193,7,0.1); color:#ffc107; border-left-color:#ffc107; }
        .menu-item span.ico { font-size:18px; width:22px; text-align:center; }
        .sidebar-footer { position:absolute; bottom:0; left:0; right:0; padding:16px 24px; border-top:1px solid rgba(255,255,255,0.08); }
        .sidebar-footer a { display:flex; align-items:center; gap:10px; color:rgba(255,255,255,0.5); text-decoration:none; font-size:13px; }
        .sidebar-footer a:hover { color:#ff6b6b; }

        .main { margin-left:240px; padding:32px; min-height:100vh; }

        .page-header { display:flex; align-items:center; justify-content:space-between; margin-bottom:28px; }
        .page-header h1 { font-size:24px; font-weight:700; color:#1a1a2e; }
        .page-header p  { color:#718096; font-size:14px; margin-top:2px; }

        .btn-primary {
            display:inline-flex; align-items:center; gap:8px;
            padding:10px 20px;
            background:linear-gradient(135deg,#ffc107,#ff9800);
            border:none; border-radius:10px;
            color:#1a1a2e; font-size:14px; font-weight:600;
            cursor:pointer; text-decoration:none;
            font-family:'Poppins',sans-serif;
            transition:all 0.2s;
            box-shadow:0 4px 12px rgba(255,193,7,0.3);
        }
        .btn-primary:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(255,193,7,0.4); }

        .card { background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.06); overflow:hidden; }
        .card-header { padding:20px 24px; border-bottom:1px solid #f0f4f8; }
        .card-header h3 { font-size:16px; font-weight:600; color:#1a1a2e; }

        table { width:100%; border-collapse:collapse; }
        thead th { padding:12px 20px; background:#f7fafc; color:#718096; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.5px; text-align:left; }
        tbody td { padding:14px 20px; font-size:13px; border-bottom:1px solid #f0f4f8; vertical-align:middle; }
        tbody tr:last-child td { border-bottom:none; }
        tbody tr:hover { background:#fafbfc; }

        .student-name { font-weight:600; color:#1a1a2e; }
        .text-muted   { color:#a0aec0; }

        .qr-badge { background:rgba(255,193,7,0.15); color:#b7791f; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:600; font-family:monospace; }

        .action-links a { font-size:12px; font-weight:500; text-decoration:none; padding:5px 10px; border-radius:6px; margin-right:4px; transition:all 0.2s; }
        .action-links .edit   { background:rgba(66,153,225,0.1); color:#2b6cb0; }
        .action-links .qr     { background:rgba(255,193,7,0.1);  color:#b7791f; }
        .action-links .delete { background:rgba(245,101,101,0.1); color:#c53030; }
        .action-links .edit:hover   { background:rgba(66,153,225,0.2); }
        .action-links .qr:hover     { background:rgba(255,193,7,0.2); }
        .action-links .delete:hover { background:rgba(245,101,101,0.2); }

        .empty-row td { text-align:center; color:#a0aec0; padding:48px; }
        .empty-row .empty-icon { font-size:40px; display:block; margin-bottom:12px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="icon">🚌</div>
        <div><h2>SmartBus</h2><p>Admin Panel</p></div>
    </div>
    <div class="sidebar-menu">
        <div class="menu-label">Main</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item"><span class="ico">📊</span> Dashboard</a>
        <div class="menu-label">Manage</div>
        <a href="${pageContext.request.contextPath}/admin/student/list" class="menu-item active"><span class="ico">🎒</span> Students</a>
        <a href="${pageContext.request.contextPath}/admin/parent/list"  class="menu-item"><span class="ico">👨‍👩‍👧</span> Parents</a>
        <a href="${pageContext.request.contextPath}/admin/bus/list"     class="menu-item"><span class="ico">🚌</span> Buses</a>
        <div class="menu-label">Reports</div>
        <a href="${pageContext.request.contextPath}/attendance/list"    class="menu-item"><span class="ico">📋</span> Attendance</a>
        <div class="menu-label">Driver</div>
        <a href="${pageContext.request.contextPath}/attendance/scan-page" class="menu-item"><span class="ico">📷</span> Scan QR Page</a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/admin/logout"><span>🚪</span> Logout</a>
    </div>
</div>

<div class="main">
    <div class="page-header">
        <div>
            <h1>Students</h1>
            <p>Manage all registered students</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/student/add" class="btn-primary">+ Add New Student</a>
    </div>

    <div class="card">
        <div class="card-header">
            <h3>All Students (${students.size()} total)</h3>
        </div>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Class / Section</th>
                    <th>QR Code</th>
                    <th>Parent</th>
                    <th>Bus</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${students}" varStatus="s">
                    <tr>
                        <td class="text-muted">${s.count}</td>
                        <td class="student-name">${student.name}</td>
                        <td>${student.className} - ${student.section}</td>
                        <td><span class="qr-badge">${student.qrCode}</span></td>
                        <td>
                            <c:if test="${not empty student.parent}">${student.parent.name}</c:if>
                            <c:if test="${empty student.parent}"><span class="text-muted">-</span></c:if>
                        </td>
                        <td>
                            <c:if test="${not empty student.bus}">${student.bus.busNumber}</c:if>
                            <c:if test="${empty student.bus}"><span class="text-muted">-</span></c:if>
                        </td>
                        <td class="action-links">
                            <a href="${pageContext.request.contextPath}/admin/student/edit/${student.studentId}"   class="edit">✏️ Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/student/qrcode/${student.studentId}" class="qr">📷 QR</a>
                            <a href="${pageContext.request.contextPath}/admin/student/delete/${student.studentId}" class="delete"
                               onclick="return confirm('Delete ${student.name}?')">🗑️ Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty students}">
                    <tr class="empty-row">
                        <td colspan="7">
                            <span class="empty-icon">🎒</span>
                            No students yet. <a href="${pageContext.request.contextPath}/admin/student/add">Add your first student</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
