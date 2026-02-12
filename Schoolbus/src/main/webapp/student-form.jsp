<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Form - SmartBus</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Poppins',sans-serif; background:#f0f4f8; color:#2d3748; }

        .sidebar { position:fixed; top:0; left:0; width:240px; height:100vh; background:linear-gradient(180deg,#1a1a2e 0%,#0f3460 100%); padding:24px 0; z-index:100; }
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

        .btn-back { display:inline-flex; align-items:center; gap:6px; padding:8px 16px; background:#fff; border:1px solid #e2e8f0; border-radius:8px; color:#718096; font-size:13px; font-weight:500; text-decoration:none; transition:all 0.2s; }
        .btn-back:hover { border-color:#ffc107; color:#ffc107; }

        .form-card { background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.06); padding:32px; max-width:640px; }

        .form-group { margin-bottom:22px; }
        .form-group label { display:block; color:#4a5568; font-size:13px; font-weight:600; margin-bottom:8px; }
        .form-group input,
        .form-group select {
            width:100%;
            padding:12px 16px;
            background:#f7fafc;
            border:1px solid #e2e8f0;
            border-radius:10px;
            color:#2d3748;
            font-size:14px;
            font-family:'Poppins',sans-serif;
            transition:all 0.2s;
            outline:none;
            appearance:none;
        }
        .form-group input:focus,
        .form-group select:focus {
            border-color:#ffc107;
            background:#fffef5;
            box-shadow:0 0 0 3px rgba(255,193,7,0.12);
        }

        .form-row { display:grid; grid-template-columns:1fr 1fr; gap:20px; }

        .form-note { background:rgba(255,193,7,0.1); border:1px solid rgba(255,193,7,0.3); border-radius:10px; padding:12px 16px; color:#b7791f; font-size:12px; margin-bottom:24px; }

        .qr-display { background:#f7fafc; border:1px solid #e2e8f0; border-radius:10px; padding:12px 16px; font-size:14px; color:#718096; font-family:monospace; }

        .form-actions { display:flex; gap:12px; margin-top:8px; }

        .btn-submit {
            padding:12px 28px;
            background:linear-gradient(135deg,#ffc107,#ff9800);
            border:none; border-radius:10px;
            color:#1a1a2e; font-size:14px; font-weight:700;
            cursor:pointer; font-family:'Poppins',sans-serif;
            transition:all 0.2s;
            box-shadow:0 4px 12px rgba(255,193,7,0.3);
        }
        .btn-submit:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(255,193,7,0.4); }

        .btn-cancel { padding:12px 20px; background:#f7fafc; border:1px solid #e2e8f0; border-radius:10px; color:#718096; font-size:14px; font-weight:500; text-decoration:none; transition:all 0.2s; }
        .btn-cancel:hover { border-color:#a0aec0; color:#4a5568; }
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
            <h1>
                <c:choose>
                    <c:when test="${student.studentId == 0}">Add New Student</c:when>
                    <c:otherwise>Edit Student</c:otherwise>
                </c:choose>
            </h1>
            <p>Fill in the student details below</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/student/list" class="btn-back">← Back to List</a>
    </div>

    <c:if test="${student.studentId == 0}">
        <div class="form-note">
            ℹ️ QR Code will be <strong>automatically generated</strong> after saving the student.
        </div>
    </c:if>

    <div class="form-card">

        <c:choose>
            <c:when test="${student.studentId == 0}">
                <form action="${pageContext.request.contextPath}/admin/student/save" method="post">
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/admin/student/update" method="post">
                <input type="hidden" name="studentId" value="${student.studentId}" />
                <input type="hidden" name="qrCode"    value="${student.qrCode}" />
            </c:otherwise>
        </c:choose>

        <div class="form-group">
            <label>Student Full Name *</label>
            <input type="text" name="name" value="${student.name}" placeholder="e.g. Ravi Kumar" required />
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Class *</label>
                <input type="text" name="className" value="${student.className}" placeholder="e.g. 6" required />
            </div>
            <div class="form-group">
                <label>Section</label>
                <input type="text" name="section" value="${student.section}" placeholder="e.g. A" />
            </div>
        </div>

        <div class="form-group">
            <label>Assign Parent *</label>
            <select name="parent.parentId" required>
                <option value="">-- Select Parent --</option>
                <c:forEach var="parent" items="${parents}">
                    <option value="${parent.parentId}"
                        <c:if test="${not empty student.parent && student.parent.parentId == parent.parentId}">selected</c:if>>
                        ${parent.name} (${parent.phone})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Assign Bus *</label>
            <select name="bus.busId" required>
                <option value="">-- Select Bus --</option>
                <c:forEach var="bus" items="${buses}">
                    <option value="${bus.busId}"
                        <c:if test="${not empty student.bus && student.bus.busId == bus.busId}">selected</c:if>>
                        ${bus.busNumber} — ${bus.driverName} (${bus.route})
                    </option>
                </c:forEach>
            </select>
        </div>

        <c:if test="${student.studentId != 0}">
            <div class="form-group">
                <label>QR Code (Auto-generated)</label>
                <div class="qr-display">📷 ${student.qrCode}</div>
            </div>
        </c:if>

        <div class="form-actions">
            <button type="submit" class="btn-submit">
                <c:choose>
                    <c:when test="${student.studentId == 0}">✅ Save Student</c:when>
                    <c:otherwise>✅ Update Student</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/admin/student/list" class="btn-cancel">Cancel</a>
        </div>

        </form>
    </div>
</div>
</body>
</html>
