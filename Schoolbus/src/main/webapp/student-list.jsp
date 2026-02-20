<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Students - SmartBus</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#0f0f1a;color:#fff;display:flex;min-height:100vh;}

/* ===== SIDEBAR ===== */
.sidebar{width:260px;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);border-right:1px solid rgba(255,193,7,0.1);display:flex;flex-direction:column;position:fixed;top:0;left:0;height:100vh;z-index:100;overflow:hidden;}
.sb-brand{padding:28px 24px 24px;border-bottom:1px solid rgba(255,193,7,0.1);position:relative;}
.sb-logo{width:52px;height:52px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:26px;margin-bottom:12px;box-shadow:0 8px 24px rgba(255,193,7,0.4);animation:logoBounce 2s ease-in-out infinite;}
@keyframes logoBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-5px);}}
.sb-title{font-size:22px;font-weight:900;letter-spacing:2px;background:linear-gradient(135deg,#ffc107,#fff);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.sb-sub{font-size:10px;color:rgba(255,255,255,0.3);letter-spacing:3px;text-transform:uppercase;margin-top:2px;}
.sb-menu{flex:1;padding:20px 0;overflow-y:auto;}
.sb-section{padding:8px 24px 4px;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:rgba(255,193,7,0.4);}
.sb-item{display:flex;align-items:center;gap:14px;padding:13px 24px;color:rgba(255,255,255,0.5);text-decoration:none;font-size:13px;font-weight:500;transition:all 0.3s;border-left:3px solid transparent;position:relative;overflow:hidden;}
.sb-item::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;background:linear-gradient(90deg,rgba(255,193,7,0.1),transparent);opacity:0;transition:opacity 0.3s;}
.sb-item:hover::before,.sb-item.active::before{opacity:1;}
.sb-item:hover,.sb-item.active{color:#ffc107;border-left-color:#ffc107;}
.sb-item.active{color:#fff;background:rgba(255,193,7,0.08);}
.sb-ico{font-size:20px;width:26px;text-align:center;flex-shrink:0;}
.sb-item span.label{flex:1;}
.sb-badge{background:linear-gradient(135deg,#ffc107,#ff9800);color:#1a0a00;padding:2px 8px;border-radius:20px;font-size:10px;font-weight:700;}
.sb-footer{padding:20px 24px;border-top:1px solid rgba(255,193,7,0.1);}
.sb-admin{display:flex;align-items:center;gap:12px;margin-bottom:14px;}
.sb-avatar{width:40px;height:40px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;}
.sb-admin-name{font-size:13px;font-weight:600;color:#fff;}
.sb-admin-role{font-size:10px;color:rgba(255,255,255,0.4);text-transform:uppercase;letter-spacing:1px;}
.sb-logout{display:flex;align-items:center;gap:8px;color:rgba(255,100,100,0.7);text-decoration:none;font-size:13px;font-weight:500;padding:8px 12px;border-radius:10px;border:1px solid rgba(255,100,100,0.2);transition:all 0.3s;}
.sb-logout:hover{color:#ff6b6b;border-color:rgba(255,100,100,0.5);background:rgba(255,100,100,0.08);}

/* ===== MAIN ===== */
.main{margin-left:260px;flex:1;display:flex;flex-direction:column;min-height:100vh;}

/* Topbar */
.topbar{background:rgba(255,255,255,0.03);border-bottom:1px solid rgba(255,255,255,0.05);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;backdrop-filter:blur(10px);position:sticky;top:0;z-index:50;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}

/* Add button */
.btn-add{display:inline-flex;align-items:center;gap:10px;padding:12px 24px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:700;font-family:'Poppins',sans-serif;cursor:pointer;text-decoration:none;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-add::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-add:hover::before{left:100%;}
.btn-add:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}

/* ===== PAGE BODY ===== */
.page-body{padding:28px 36px;flex:1;}

/* ===== SEARCH + FILTER BAR ===== */
.toolbar{display:flex;align-items:center;gap:16px;margin-bottom:24px;}
.search-box{position:relative;flex:1;max-width:360px;}
.search-box input{width:100%;padding:11px 16px 11px 42px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;}
.search-box input::placeholder{color:rgba(255,255,255,0.2);}
.search-box input:focus{border-color:rgba(255,193,7,0.4);background:rgba(255,193,7,0.05);box-shadow:0 0 0 3px rgba(255,193,7,0.08);}
.search-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);font-size:16px;pointer-events:none;}
.total-pill{background:rgba(255,193,7,0.1);border:1px solid rgba(255,193,7,0.2);color:#ffc107;padding:8px 18px;border-radius:20px;font-size:12px;font-weight:700;}

/* ===== TABLE CARD ===== */
.card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.card-head{padding:18px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.card-head h3{font-size:15px;font-weight:700;color:#fff;}
.card-head span{font-size:12px;color:rgba(255,255,255,0.3);}

/* Table */
table{width:100%;border-collapse:collapse;}
thead th{padding:12px 18px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.3);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1.5px;text-align:left;white-space:nowrap;}
tbody td{padding:0;border-bottom:1px solid rgba(255,255,255,0.04);vertical-align:middle;}
tbody tr:last-child td{border-bottom:none;}

/* Row hover glow effect */
tbody tr{transition:all 0.25s;}
tbody tr:hover{background:rgba(255,193,7,0.04);}
tbody tr:hover td{border-bottom-color:rgba(255,193,7,0.08);}

/* Cell inner padding */
.td-inner{padding:14px 18px;display:flex;align-items:center;}
td .td-inner{padding:14px 18px;}

/* Row number */
.row-num{font-size:12px;color:rgba(255,255,255,0.2);font-weight:600;width:40px;}

/* Student name cell */
.student-cell{display:flex;align-items:center;gap:12px;}
.student-avatar{width:36px;height:36px;border-radius:10px;background:linear-gradient(135deg,rgba(255,193,7,0.3),rgba(255,107,0,0.2));border:1px solid rgba(255,193,7,0.2);display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0;}
.student-name{font-size:13px;font-weight:700;color:#fff;}
.student-id{font-size:10px;color:rgba(255,255,255,0.3);margin-top:1px;}

/* Class badge */
.class-badge{background:rgba(147,112,219,0.15);border:1px solid rgba(147,112,219,0.25);color:#c4a0ff;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:600;}

/* QR code badge */
.qr-pill{background:rgba(255,193,7,0.08);border:1px solid rgba(255,193,7,0.2);color:#ffc107;padding:4px 12px;border-radius:8px;font-size:10px;font-weight:700;font-family:monospace;letter-spacing:1px;}

/* Parent / Bus info */
.info-cell{display:flex;flex-direction:column;gap:2px;}
.info-main{font-size:12px;font-weight:600;color:rgba(255,255,255,0.8);}
.info-sub{font-size:10px;color:rgba(255,255,255,0.3);}
.info-empty{font-size:11px;color:rgba(255,255,255,0.2);font-style:italic;}

/* Action buttons */
.actions{display:flex;align-items:center;gap:6px;}
.act-btn{display:inline-flex;align-items:center;gap:5px;padding:6px 12px;border-radius:8px;font-size:11px;font-weight:600;text-decoration:none;transition:all 0.2s;white-space:nowrap;border:1px solid transparent;}
.act-btn.edit  {background:rgba(66,153,225,0.1); border-color:rgba(66,153,225,0.2); color:#63b3ed;}
.act-btn.qr    {background:rgba(255,193,7,0.1);  border-color:rgba(255,193,7,0.2);  color:#ffc107;}
.act-btn.del   {background:rgba(245,101,101,0.1);border-color:rgba(245,101,101,0.2);color:#fc8181;}
.act-btn.edit:hover  {background:rgba(66,153,225,0.2); transform:translateY(-1px);}
.act-btn.qr:hover    {background:rgba(255,193,7,0.2);  transform:translateY(-1px);}
.act-btn.del:hover   {background:rgba(245,101,101,0.2);transform:translateY(-1px);}

/* Empty state */
.empty-state{text-align:center;padding:64px 32px;}
.empty-bus{font-size:64px;display:block;margin-bottom:16px;animation:emptyBounce 2s ease-in-out infinite;}
@keyframes emptyBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-10px);}}
.empty-title{font-size:18px;font-weight:700;color:rgba(255,255,255,0.5);margin-bottom:8px;}
.empty-sub{font-size:13px;color:rgba(255,255,255,0.25);margin-bottom:24px;}
.empty-link{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:10px;color:#1a0a00;font-size:13px;font-weight:700;text-decoration:none;}

/* Scrollbar */
::-webkit-scrollbar{width:4px;}
::-webkit-scrollbar-track{background:transparent;}
::-webkit-scrollbar-thumb{background:rgba(255,193,7,0.3);border-radius:4px;}

/* Row entry animation */
@keyframes rowSlideIn{from{opacity:0;transform:translateX(-10px);}to{opacity:1;transform:translateX(0);}}
tbody tr{animation:rowSlideIn 0.3s ease forwards;}
</style>
</head>
<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
<div class="sb-brand">
<div class="sb-logo">🚌</div>
<div class="sb-title">SMARTBUS</div>
<div class="sb-sub">Admin Control Panel</div>
</div>
<div class="sb-menu">
<div class="sb-section">Main</div>
<a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-item"><span class="sb-ico">📊</span><span class="label">Dashboard</span></a>
<div class="sb-section">Manage</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item active"><span class="sb-ico">🎒</span><span class="label">Students</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/list" class="sb-item"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/list" class="sb-item"><span class="sb-ico">🚌</span><span class="label">Buses</span></a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list" class="sb-item"><span class="sb-ico">📋</span><span class="label">Attendance Log</span></a>
<div class="sb-section">Driver</div>
<a href="${pageContext.request.contextPath}/attendance/scan-page" class="sb-item"><span class="sb-ico">📷</span><span class="label">QR Scan Page</span></a>
</div>
<div class="sb-footer">
<div class="sb-admin">
<div class="sb-avatar">👨‍💼</div>
<div><div class="sb-admin-name">Administrator</div><div class="sb-admin-role">System Admin</div></div>
</div>
<a href="${pageContext.request.contextPath}/admin/logout" class="sb-logout">🚪 Logout</a>
</div>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<!-- Topbar -->
<div class="topbar">

<div class="topbar-left">
<h1>🎒 Student Management</h1>
<p>View, add, edit and manage all registered students</p>
</div>
<a href="${pageContext.request.contextPath}/admin/student/add" class="btn-add">➕ Add New Student</a>
</div>

<div class="page-body">

<!-- Toolbar -->
<div class="toolbar">
<div class="search-box">
<span class="search-icon">🔍</span>
<input type="text" id="searchInput" placeholder="Search student name, class, QR code..." onkeyup="filterTable()"/>
</div>
<div class="total-pill">🎒 ${students.size()} Students Total</div>
</div>

<!-- Table Card -->
<div class="card">
<div class="card-head">
<h3>All Registered Students</h3>
<span>Click a row to highlight • Use search to filter</span>
</div>

<table id="studentTable">
<thead>
<tr>
<th style="width:50px;">#</th>
<th>Student</th>
<th>Class</th>
<th>QR Code</th>
<th>Parent</th>
<th>Bus</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<c:forEach var="student" items="${students}" varStatus="s">
<tr style="animation-delay:${s.index * 0.05}s">
<td><div class="td-inner"><span class="row-num">${s.count}</span></div></td>
<td>
<div class="td-inner">
<div class="student-cell">
<div class="student-avatar">🎒</div>
<div>
<div class="student-name">${student.name}</div>
<div class="student-id">ID #${student.studentId}</div>
</div>
</div>
</div>
</td>
<td>
<div class="td-inner">
<span class="class-badge">Class ${student.className} — ${student.section}</span>
</div>
</td>
<td>
<div class="td-inner">
<span class="qr-pill">📷 ${student.qrCode}</span>
</div>
</td>
<td>
<div class="td-inner">
<c:choose>
<c:when test="${not empty student.parent}">
<div class="info-cell">
<span class="info-main">👨‍👩‍👧 ${student.parent.name}</span>
<span class="info-sub">${student.parent.phone}</span>
</div>
</c:when>
<c:otherwise><span class="info-empty">Not assigned</span></c:otherwise>
</c:choose>
</div>
</td>
<td>
<div class="td-inner">
<c:choose>
<c:when test="${not empty student.bus}">
<div class="info-cell">
<span class="info-main">🚌 ${student.bus.busNumber}</span>
<span class="info-sub">${student.bus.driverName}</span>
</div>
</c:when>
<c:otherwise><span class="info-empty">Not assigned</span></c:otherwise>
</c:choose>
</div>
</td>
<td>
<div class="td-inner">
<div class="actions">
<a href="${pageContext.request.contextPath}/admin/student/edit/${student.studentId}"   class="act-btn edit">✏️ Edit</a>
<a href="${pageContext.request.contextPath}/admin/student/qrcode/${student.studentId}" class="act-btn qr">📷 QR</a>
<a href="${pageContext.request.contextPath}/admin/student/delete/${student.studentId}" class="act-btn del" onclick="return confirm('Delete ${student.name}?')">🗑️ Del</a>
</div>
</div>
</td>
</tr>
</c:forEach>

<c:if test="${empty students}">
<tr>
<td colspan="7">
<div class="empty-state">
<span class="empty-bus">🚌</span>
<div class="empty-title">No students registered yet!</div>
<div class="empty-sub">Add your first student to get started with SmartBus tracking</div>
<a href="${pageContext.request.contextPath}/admin/student/add" class="empty-link">➕ Add First Student</a>
</div>
</td>
</tr>
</c:if>

</tbody>
</table>
</div>
</div>
</div>

<script>
// Live search filter
function filterTable(){
var input = document.getElementById('searchInput').value.toLowerCase();
var rows  = document.querySelectorAll('#studentTable tbody tr');
rows.forEach(function(row){
var text = row.textContent.toLowerCase();
row.style.display = text.includes(input) ? '' : 'none';
});
}

// Row click highlight
document.querySelectorAll('#studentTable tbody tr').forEach(function(row){
row.style.cursor = 'pointer';
row.addEventListener('click', function(e){
if(e.target.tagName === 'A') return;
document.querySelectorAll('#studentTable tbody tr').forEach(function(r){
r.style.background = '';
});
this.style.background = 'rgba(255,193,7,0.08)';
});
});
</script>
</body>
</html>