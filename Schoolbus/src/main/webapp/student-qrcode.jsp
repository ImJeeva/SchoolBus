<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>QR Code - ${student.name}</title>
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
        .menu-item:hover,.menu-item.active { background:rgba(255,193,7,0.1); color:#ffc107; border-left-color:#ffc107; }
        .menu-item span.ico { font-size:18px; width:22px; text-align:center; }
        .sidebar-footer { position:absolute; bottom:0; left:0; right:0; padding:16px 24px; border-top:1px solid rgba(255,255,255,0.08); }
        .sidebar-footer a { display:flex; align-items:center; gap:10px; color:rgba(255,255,255,0.5); text-decoration:none; font-size:13px; }

        .main { margin-left:240px; padding:32px; min-height:100vh; }

        .page-header { display:flex; align-items:center; justify-content:space-between; margin-bottom:28px; }
        .page-header h1 { font-size:24px; font-weight:700; color:#1a1a2e; }
        .page-header p  { color:#718096; font-size:14px; margin-top:2px; }

        .btn-back { display:inline-flex; align-items:center; gap:6px; padding:8px 16px; background:#fff; border:1px solid #e2e8f0; border-radius:8px; color:#718096; font-size:13px; text-decoration:none; }
        .btn-back:hover { border-color:#ffc107; color:#ffc107; }

        .content-grid { display:grid; grid-template-columns:1fr 1fr; gap:24px; max-width:860px; }

        /* Info Card */
        .info-card { background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.06); padding:28px; }
        .info-card h3 { font-size:16px; font-weight:600; color:#1a1a2e; margin-bottom:20px; padding-bottom:12px; border-bottom:1px solid #f0f4f8; }
        .info-row { display:flex; justify-content:space-between; padding:10px 0; border-bottom:1px solid #f7fafc; font-size:14px; }
        .info-row:last-child { border-bottom:none; }
        .info-label { color:#718096; font-weight:500; }
        .info-value { color:#2d3748; font-weight:600; text-align:right; }

        /* QR Card */
        .qr-card {
            background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.06);
            padding:28px; text-align:center;
        }
        .qr-card h3 { font-size:16px; font-weight:600; color:#1a1a2e; margin-bottom:20px; }
        .qr-image-box {
            background:#f7fafc; border:2px dashed #e2e8f0;
            border-radius:12px; padding:20px;
            display:inline-block; margin-bottom:16px;
        }
        .qr-image-box img { display:block; }
        .qr-code-text { font-family:monospace; font-size:16px; font-weight:700; color:#1a1a2e; background:rgba(255,193,7,0.1); border:1px solid rgba(255,193,7,0.3); padding:8px 16px; border-radius:8px; display:inline-block; margin-bottom:20px; }

        /* Printable ID Card */
        .print-card {
            margin-top:24px;
            border:2px solid #1a1a2e;
            border-radius:12px;
            padding:16px;
            text-align:center;
        }
        .print-card .school-name { font-size:13px; font-weight:700; color:#1a1a2e; letter-spacing:1px; text-transform:uppercase; }
        .print-card .student-name-print { font-size:18px; font-weight:700; color:#1a1a2e; margin:8px 0 4px; }
        .print-card .class-info { font-size:12px; color:#718096; }

        .btn-print {
            display:inline-flex; align-items:center; gap:8px;
            padding:11px 24px;
            background:linear-gradient(135deg,#1a1a2e,#0f3460);
            border:none; border-radius:10px;
            color:#fff; font-size:14px; font-weight:600;
            cursor:pointer; font-family:'Poppins',sans-serif;
            transition:all 0.2s; margin-top:16px;
        }
        .btn-print:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(26,26,46,0.4); }

        /* Hide sidebar on print */
        @media print {
            .sidebar, .main > .page-header, .info-card, .btn-print, .btn-back { display:none !important; }
            .main { margin-left:0; padding:20px; }
            .content-grid { display:block; }
            .qr-card { box-shadow:none; border:none; }
        }
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
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/admin/logout"><span>🚪</span> Logout</a>
    </div>
</div>

<div class="main">
    <div class="page-header">
        <div><h1>Student QR Code</h1><p>View and print the student's QR card</p></div>
        <a href="${pageContext.request.contextPath}/admin/student/list" class="btn-back">← Back to List</a>
    </div>

    <div class="content-grid">

        <!-- Student Info -->
        <div class="info-card">
            <h3>🎒 Student Details</h3>
            <div class="info-row"><span class="info-label">Name</span>       <span class="info-value">${student.name}</span></div>
            <div class="info-row"><span class="info-label">Class</span>      <span class="info-value">${student.className} - ${student.section}</span></div>
            <div class="info-row"><span class="info-label">QR Code</span>    <span class="info-value">${student.qrCode}</span></div>
            <div class="info-row">
                <span class="info-label">Parent</span>
                <span class="info-value">
                    <c:if test="${not empty student.parent}">${student.parent.name}<br/><small>${student.parent.phone}</small></c:if>
                    <c:if test="${empty student.parent}">Not assigned</c:if>
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Bus</span>
                <span class="info-value">
                    <c:if test="${not empty student.bus}">${student.bus.busNumber}<br/><small>Driver: ${student.bus.driverName}</small></c:if>
                    <c:if test="${empty student.bus}">Not assigned</c:if>
                </span>
            </div>
        </div>

        <!-- QR Code -->
        <div class="qr-card">
            <h3>📷 QR Code Card</h3>
            <c:if test="${not empty qrBase64}">
                <div class="qr-image-box">
                    <img src="data:image/png;base64,${qrBase64}" alt="QR Code" width="200" height="200"/>
                </div>
                <br/>
                <div class="qr-code-text">${student.qrCode}</div>

                <!-- Printable Card Preview -->
                <div class="print-card">
                    <div class="school-name">🚌 SmartBus — Student ID Card</div>
                    <img src="data:image/png;base64,${qrBase64}" alt="QR" width="150" height="150" style="margin:10px 0;"/>
                    <div class="student-name-print">${student.name}</div>
                    <div class="class-info">Class ${student.className} - ${student.section} | ${student.qrCode}</div>
                </div>

                <button onclick="window.print()" class="btn-print">🖨️ Print QR Card</button>
            </c:if>
            <c:if test="${empty qrBase64}">
                <p style="color:#c53030;">QR Code could not be generated. Please try again.</p>
            </c:if>
        </div>

    </div>
</div>
</body>
</html>
