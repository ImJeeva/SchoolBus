<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard - SmartBus Admin</title>
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
.sb-bus{position:absolute;right:16px;top:24px;animation:sbBusMove 3s ease-in-out infinite;}
@keyframes sbBusMove{0%,100%{transform:translateX(0);}50%{transform:translateX(6px);}}
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
.topbar{background:rgba(255,255,255,0.03);border-bottom:1px solid rgba(255,255,255,0.05);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;backdrop-filter:blur(10px);position:sticky;top:0;z-index:50;}
.topbar-left h1{font-size:26px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:16px;}
.live-badge{display:flex;align-items:center;gap:8px;background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.3);padding:8px 16px;border-radius:20px;font-size:12px;font-weight:600;color:#68d391;}
.live-dot{width:8px;height:8px;background:#68d391;border-radius:50%;animation:livePulse 1.5s ease-in-out infinite;}
@keyframes livePulse{0%,100%{box-shadow:0 0 0 0 rgba(104,211,145,0.6);}50%{box-shadow:0 0 0 8px rgba(104,211,145,0);}}
.time-badge{background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);padding:8px 16px;border-radius:20px;font-size:12px;color:rgba(255,255,255,0.6);font-weight:600;}
.page-body{padding:32px 36px;flex:1;}

/* ===== STAT CARDS — FIXED ===== */
.stats-row{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-bottom:28px;}

.stat-card{border-radius:20px;padding:18px 22px;position:relative;overflow:hidden;cursor:pointer;transition:all 0.4s;text-decoration:none;display:block;}.stat-card.yellow{background:linear-gradient(135deg,rgba(255,193,7,0.15),rgba(255,150,0,0.08));border:1px solid rgba(255,193,7,0.3);}
.stat-card.blue{background:linear-gradient(135deg,rgba(66,153,225,0.15),rgba(66,153,225,0.05));border:1px solid rgba(66,153,225,0.3);}
.stat-card.green{background:linear-gradient(135deg,rgba(72,187,120,0.15),rgba(72,187,120,0.05));border:1px solid rgba(72,187,120,0.3);}
.stat-card:hover{transform:translateY(-6px);}
.stat-card.yellow:hover{box-shadow:0 20px 50px rgba(255,193,7,0.25);}
.stat-card.blue:hover{box-shadow:0 20px 50px rgba(66,153,225,0.25);}
.stat-card.green:hover{box-shadow:0 20px 50px rgba(72,187,120,0.25);}

/* Big circle decoration behind number */
.stat-card::after{content:'';position:absolute;top:-20px;right:-20px;width:120px;height:120px;border-radius:50%;opacity:0.08;}
.stat-card.yellow::after{background:#ffc107;}
.stat-card.blue::after{background:#4299e1;}
.stat-card.green::after{background:#48bb78;}

.stat-top{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;}
.stat-icon-box{width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;}.stat-card.yellow .stat-icon-box{background:rgba(255,193,7,0.2);}
.stat-card.blue   .stat-icon-box{background:rgba(66,153,225,0.2);}
.stat-card.green  .stat-icon-box{background:rgba(72,187,120,0.2);}

.stat-pill{font-size:11px;font-weight:700;padding:5px 12px;border-radius:20px;}
.stat-card.yellow .stat-pill{background:rgba(255,193,7,0.15);color:#ffc107;border:1px solid rgba(255,193,7,0.2);}
.stat-card.blue   .stat-pill{background:rgba(66,153,225,0.15);color:#63b3ed;border:1px solid rgba(66,153,225,0.2);}
.stat-card.green  .stat-pill{background:rgba(72,187,120,0.15);color:#68d391;border:1px solid rgba(72,187,120,0.2);}

.stat-number{font-size:28px;font-weight:800;line-height:1;margin-bottom:6px;display:block;}.stat-card.yellow .stat-number{color:#ffc107;text-shadow:0 0 40px rgba(255,193,7,0.5);}
.stat-card.blue   .stat-number{color:#63b3ed;text-shadow:0 0 40px rgba(99,179,237,0.5);}
.stat-card.green  .stat-number{color:#68d391;text-shadow:0 0 40px rgba(104,211,145,0.5);}

.stat-name{font-size:13px;font-weight:600;color:rgba(255,255,255,0.6);}
.stat-desc{font-size:10px;color:rgba(255,255,255,0.3);margin-top:2px;}

/* ===== QUICK ACTIONS ===== */
.quick-actions{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px;}
.qa-btn{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:20px 16px;text-align:center;text-decoration:none;color:#fff;transition:all 0.3s;display:block;}
.qa-btn:hover{background:rgba(255,193,7,0.08);border-color:rgba(255,193,7,0.4);transform:translateY(-4px);box-shadow:0 10px 30px rgba(255,193,7,0.15);}
.qa-icon{font-size:30px;display:block;margin-bottom:10px;}
.qa-label{font-size:12px;font-weight:600;color:rgba(255,255,255,0.7);}

/* ===== CONTENT GRID ===== */
.content-grid{display:grid;grid-template-columns:1fr 340px;gap:24px;}

/* Cards */
.card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.card-head{padding:18px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.card-head h3{font-size:15px;font-weight:700;color:#fff;}
.card-head a{font-size:12px;font-weight:600;color:#ffc107;text-decoration:none;padding:6px 14px;border:1px solid rgba(255,193,7,0.3);border-radius:8px;transition:all 0.2s;}
.card-head a:hover{background:rgba(255,193,7,0.1);}

table{width:100%;border-collapse:collapse;}
thead th{padding:11px 18px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.35);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1px;text-align:left;}
tbody td{padding:13px 18px;font-size:13px;border-bottom:1px solid rgba(255,255,255,0.04);color:rgba(255,255,255,0.75);vertical-align:middle;}
tbody tr:last-child td{border-bottom:none;}
tbody tr:hover{background:rgba(255,193,7,0.03);}
.t-num{color:rgba(255,255,255,0.25);font-size:12px;}
.t-name{font-weight:600;color:#fff;}
.t-bus{color:rgba(255,255,255,0.5);font-size:12px;}
.badge-board{background:rgba(72,187,120,0.15);color:#68d391;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;border:1px solid rgba(72,187,120,0.2);}
.badge-drop{background:rgba(66,153,225,0.15);color:#63b3ed;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;border:1px solid rgba(66,153,225,0.2);}
.badge-yes{background:rgba(72,187,120,0.1);color:#68d391;padding:3px 10px;border-radius:20px;font-size:11px;}
.badge-no{background:rgba(245,101,101,0.1);color:#fc8181;padding:3px 10px;border-radius:20px;font-size:11px;}
.empty-row td{text-align:center;padding:40px;color:rgba(255,255,255,0.2);font-size:13px;}

/* ===== ACTIVITY FEED — REDESIGNED & CLEAR ===== */
.activity-feed{display:flex;flex-direction:column;}

.act-item{display:flex;align-items:center;gap:14px;padding:14px 20px;border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;}
.act-item:last-child{border-bottom:none;}
.act-item:hover{background:rgba(255,255,255,0.02);}

/* Icon box */
.act-icon{width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.act-icon.board{background:rgba(72,187,120,0.15);border:1px solid rgba(72,187,120,0.2);}
.act-icon.drop {background:rgba(66,153,225,0.15);border:1px solid rgba(66,153,225,0.2);}

/* Text info */
.act-info{flex:1;min-width:0;}
.act-student{font-size:13px;font-weight:700;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
.act-event{font-size:11px;margin-top:3px;}
.act-event.board{color:#68d391;}
.act-event.drop {color:#63b3ed;}
.act-bus{font-size:11px;color:rgba(255,255,255,0.35);margin-top:1px;}

/* Time */
.act-time{font-size:11px;font-weight:600;color:rgba(255,255,255,0.4);white-space:nowrap;flex-shrink:0;}

/* Activity legend */
.act-legend{display:flex;gap:16px;padding:12px 20px;background:rgba(0,0,0,0.2);border-bottom:1px solid rgba(255,255,255,0.04);}
.leg-item{display:flex;align-items:center;gap:6px;font-size:11px;color:rgba(255,255,255,0.4);}
.leg-dot{width:8px;height:8px;border-radius:50%;}
.leg-dot.green{background:#68d391;}
.leg-dot.blue{background:#63b3ed;}

/* ===== MINI BUS TRACKER ===== */
.bus-tracker{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:20px;margin-top:16px;}
.tracker-title{font-size:13px;font-weight:700;margin-bottom:14px;color:rgba(255,255,255,0.8);display:flex;align-items:center;gap:8px;}
.road-track{background:#111827;border-radius:10px;height:56px;position:relative;overflow:hidden;border:1px solid rgba(255,255,255,0.05);}
/* grass strips */
.grass-top{position:absolute;top:0;left:0;width:100%;height:10px;background:#1a3a1a;}
.grass-bot{position:absolute;bottom:0;left:0;width:100%;height:10px;background:#1a3a1a;}
/* road */
.road-surface{position:absolute;top:10px;bottom:10px;left:0;right:0;background:#2d2d2d;}
.road-dashes{position:absolute;top:50%;left:0;width:100%;height:2px;margin-top:-1px;background:repeating-linear-gradient(90deg,rgba(255,193,7,0.5) 0px,rgba(255,193,7,0.5) 24px,transparent 24px,transparent 48px);animation:dashMove 0.6s linear infinite;}
@keyframes dashMove{from{background-position:0 0;}to{background-position:-48px 0;}}
.mini-bus{position:absolute;top:50%;transform:translateY(-55%);animation:miniBusRide 3.5s linear infinite;}
@keyframes miniBusRide{0%{left:-60px;opacity:0;}5%{opacity:1;}95%{opacity:1;}100%{left:calc(100% + 10px);opacity:0;}}

/* scrollbar */
::-webkit-scrollbar{width:4px;}
::-webkit-scrollbar-track{background:transparent;}
::-webkit-scrollbar-thumb{background:rgba(255,193,7,0.3);border-radius:4px;}

#liveClock{font-weight:700;}
</style>
</head>
<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
<div class="sb-brand">
<div class="sb-logo">🚌</div>
<div class="sb-title">SMARTBUS</div>
<div class="sb-sub">Admin Control Panel</div>
<div class="sb-bus">
<svg width="42" height="20" viewBox="0 0 42 20"><rect x="1" y="1" width="36" height="13" rx="4" fill="#ffc107"/><rect x="5" y="3" width="6" height="6" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="15" y="3" width="6" height="6" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="25" y="3" width="6" height="6" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="37" y="4" width="4" height="7" rx="2" fill="#ff8f00"/><circle cx="9" cy="16" r="4" fill="#333"/><circle cx="9" cy="16" r="2" fill="#555"/><circle cx="30" cy="16" r="4" fill="#333"/><circle cx="30" cy="16" r="2" fill="#555"/></svg>
</div>
</div>
<div class="sb-menu">
<div class="sb-section">Main</div>
<a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-item active"><span class="sb-ico">📊</span><span class="label">Dashboard</span></a>
<div class="sb-section">Manage</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item"><span class="sb-ico">🎒</span><span class="label">Students</span><span class="sb-badge">${totalStudents}</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/list"  class="sb-item"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span><span class="sb-badge">${totalParents}</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/list"     class="sb-item"><span class="sb-ico">🚌</span><span class="label">Buses</span><span class="sb-badge">${totalBuses}</span></a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list"      class="sb-item"><span class="sb-ico">📋</span><span class="label">Attendance Log</span></a>
<div class="sb-section">Settings</div>
<a href="${pageContext.request.contextPath}/admin/school-info" class="sb-item"><span class="sb-ico">🏫</span><span class="label">School Info</span></a>
<div class="sb-section">Driver</div>
<a href="${pageContext.request.contextPath}/attendance/scan-page" class="sb-item"><span class="sb-ico">📷</span><span class="label">QR Scan Page</span></a></div>
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

<div class="topbar">
<div class="topbar-left">
<h1>Dashboard Overview</h1>
<p>Welcome back, Admin! Here's today's SmartBus summary.</p>
</div>
<div class="topbar-right">
<div class="live-badge"><div class="live-dot"></div>System Live</div>
<div class="time-badge">🕐 <span id="liveClock"></span></div>
</div>
</div>

<div class="page-body">

<!-- ===== STAT CARDS FIXED ===== -->
<div class="stats-row">

<a href="${pageContext.request.contextPath}/admin/student/list" class="stat-card yellow">
<div class="stat-top">
<div class="stat-icon-box">🎒</div>
<span class="stat-pill">Total Enrolled</span>
</div>
<span class="stat-number">${totalStudents}</span>
<div class="stat-name">Students</div>
<div class="stat-desc">All registered students in system</div>
</a>

<a href="${pageContext.request.contextPath}/admin/parent/list" class="stat-card blue">
<div class="stat-top">
<div class="stat-icon-box">👨‍👩‍👧</div>
<span class="stat-pill">Registered</span>
</div>
<span class="stat-number">${totalParents}</span>
<div class="stat-name">Parents</div>
<div class="stat-desc">Parents receiving email alerts</div>
</a>

<a href="${pageContext.request.contextPath}/admin/bus/list" class="stat-card green">
<div class="stat-top">
<div class="stat-icon-box">🚌</div>
<span class="stat-pill">🟢 Running</span>
</div>
<span class="stat-number">${totalBuses}</span>
<div class="stat-name">Buses</div>
<div class="stat-desc">Active buses on routes today</div>
</a>

</div>

<!-- ===== QUICK ACTIONS ===== -->
<div class="quick-actions">
<a href="${pageContext.request.contextPath}/admin/student/add"    class="qa-btn"><span class="qa-icon">➕🎒</span><span class="qa-label">Add Student</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/add"     class="qa-btn"><span class="qa-icon">➕👨‍👩‍👧</span><span class="qa-label">Add Parent</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/add"        class="qa-btn"><span class="qa-icon">➕🚌</span><span class="qa-label">Add Bus</span></a>
<a href="${pageContext.request.contextPath}/attendance/scan-page" class="qa-btn"><span class="qa-icon">📷</span><span class="qa-label">Driver Scan</span></a>
</div>

<!-- ===== CONTENT GRID ===== -->
<div class="content-grid">

<!-- LEFT: Attendance Table -->
<div class="card">
<div class="card-head">
<h3>📋 Recent Attendance Records</h3>
<a href="${pageContext.request.contextPath}/attendance/list">View All →</a>
</div>
<table>
<thead>
<tr><th>#</th><th>Student Name</th><th>Bus</th><th>Event</th><th>Time</th><th>Email Sent</th></tr>
</thead>
<tbody>
<c:forEach var="att" items="${recentAttendance}" varStatus="s">
<tr>
<td class="t-num">${s.count}</td>
<td class="t-name">${att.student.name}</td>
<td class="t-bus">${att.bus.busNumber}</td>
<td>
<c:choose>
<c:when test="${att.eventType=='BOARDING'}"><span class="badge-board">🟢 BOARDING</span></c:when>
<c:otherwise><span class="badge-drop">🔵 DROPOFF</span></c:otherwise>
</c:choose>
</td>
<td style="font-size:12px;color:rgba(255,255,255,0.5);"><fmt:formatDate value="${att.scanTime}" pattern="hh:mm a dd/MM"/></td>
<td>
<c:choose>
<c:when test="${att.alertSent}"><span class="badge-yes">✅ Sent</span></c:when>
<c:otherwise><span class="badge-no">❌ No</span></c:otherwise>
</c:choose>
</td>
</tr>
</c:forEach>
<c:if test="${empty recentAttendance}">
<tr class="empty-row"><td colspan="6">📭 No attendance records yet. Start scanning students!</td></tr>
</c:if>
</tbody>
</table>
</div>

<!-- RIGHT: Activity Feed -->
<div>
<div class="card">
<div class="card-head"><h3>⚡ Live Activity Feed</h3></div>

<!-- Legend — explains what activity feed shows -->
<div class="act-legend">
<div class="leg-item"><div class="leg-dot green"></div>Student boarded bus</div>
<div class="leg-item"><div class="leg-dot blue"></div>Student dropped off</div>
</div>

<div class="activity-feed">
<c:forEach var="att" items="${recentAttendance}" varStatus="s">
<c:if test="${s.index < 7}">
<div class="act-item">

<div class="act-icon ${att.eventType=='BOARDING'?'board':'drop'}">
<c:choose>
<c:when test="${att.eventType=='BOARDING'}">🟢</c:when>
<c:otherwise>🔵</c:otherwise>
</c:choose>
</div>

<div class="act-info">
<div class="act-student">${att.student.name}</div>
<div class="act-event ${att.eventType=='BOARDING'?'board':'drop'}">
<c:choose>
<c:when test="${att.eventType=='BOARDING'}">✅ Boarded ${att.bus.busNumber}</c:when>
<c:otherwise>🏁 Dropped off from ${att.bus.busNumber}</c:otherwise>
</c:choose>
</div>
<div class="act-bus">Class ${att.student.className} • Parent email sent: ${att.alertSent?'Yes':'No'}</div>
</div>

<div class="act-time"><fmt:formatDate value="${att.scanTime}" pattern="hh:mm a"/></div>

</div>
</c:if>
</c:forEach>
<c:if test="${empty recentAttendance}">
<div style="text-align:center;padding:36px 20px;color:rgba(255,255,255,0.2);">
<div style="font-size:36px;margin-bottom:10px;">📡</div>
<div style="font-size:13px;">Waiting for first scan...</div>
<div style="font-size:11px;margin-top:4px;">Activity will appear here when driver scans QR codes</div>
</div>
</c:if>
</div>
</div>

<!-- Mini Bus Tracker -->
<div class="bus-tracker">
<div class="tracker-title">🚌 Bus Route Simulation</div>
<div class="road-track">
<div class="grass-top"></div>
<div class="grass-bot"></div>
<div class="road-surface"></div>
<div class="road-dashes"></div>
<div class="mini-bus">
<svg width="52" height="24" viewBox="0 0 52 24"><rect x="1" y="1" width="44" height="16" rx="5" fill="#ffc107"/><rect x="5" y="3" width="8" height="8" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="17" y="3" width="8" height="8" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="29" y="3" width="8" height="8" rx="1" fill="#e3f2fd" opacity="0.9"/><rect x="45" y="4" width="5" height="9" rx="2" fill="#ff8f00"/><rect x="46" y="5" width="3" height="3" rx="1" fill="#fff9c4"/><circle cx="11" cy="20" r="4" fill="#222"/><circle cx="11" cy="20" r="2" fill="#555"/><circle cx="38" cy="20" r="4" fill="#222"/><circle cx="38" cy="20" r="2" fill="#555"/></svg>
</div>
</div>
<p style="font-size:11px;color:rgba(255,255,255,0.25);margin-top:10px;text-align:center;">Visual simulation of active bus route</p>
</div>

</div>
</div>
</div>
</div>
</div>

<script>
// ===== LIVE CLOCK — 12hr AM/PM format =====
function updateClock(){
var now = new Date();
var h   = now.getHours();
var m   = String(now.getMinutes()).padStart(2,'0');
var s   = String(now.getSeconds()).padStart(2,'0');
var ampm= h >= 12 ? 'PM' : 'AM';
h = h % 12;
if(h === 0) h = 12;
document.getElementById('liveClock').textContent = h + ':' + m + ':' + s + ' ' + ampm;
}
setInterval(updateClock, 1000);
updateClock();
</script>
</body>
</html>