<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Attendance - SmartBus</title>
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
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}
.record-pill{background:rgba(255,193,7,0.1);border:1px solid rgba(255,193,7,0.2);color:#ffc107;padding:8px 18px;border-radius:20px;font-size:12px;font-weight:700;}

/* ===== PAGE BODY ===== */
.page-body{padding:28px 36px;flex:1;}

/* ===== MINI STAT CARDS ===== */
.mini-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px;}
.mini-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:16px 18px;display:flex;align-items:center;gap:12px;transition:all 0.3s;}
.mini-card:hover{transform:translateY(-3px);}
.mini-card-icon{width:40px;height:40px;border-radius:11px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.mc-yellow .mini-card-icon{background:rgba(255,193,7,0.15);}
.mc-green  .mini-card-icon{background:rgba(72,187,120,0.15);}
.mc-blue   .mini-card-icon{background:rgba(66,153,225,0.15);}
.mc-red    .mini-card-icon{background:rgba(245,101,101,0.15);}
.mini-card-num{font-size:22px;font-weight:900;line-height:1;}
.mc-yellow .mini-card-num{color:#ffc107;}
.mc-green  .mini-card-num{color:#68d391;}
.mc-blue   .mini-card-num{color:#63b3ed;}
.mc-red    .mini-card-num{color:#fc8181;}
.mini-card-lbl{font-size:11px;color:rgba(255,255,255,0.35);margin-top:2px;}

/* ===== FILTER BAR ===== */
.filter-bar{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:18px 24px;margin-bottom:24px;display:flex;align-items:center;gap:16px;flex-wrap:wrap;}
.filter-label{font-size:12px;font-weight:600;color:rgba(255,255,255,0.4);letter-spacing:1px;text-transform:uppercase;white-space:nowrap;}
.filter-bar input[type="date"]{padding:10px 14px;background:rgba(255,255,255,0.06);border:1.5px solid rgba(255,255,255,0.08);border-radius:10px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;color-scheme:dark;}
.filter-bar input[type="date"]:focus{border-color:rgba(255,193,7,0.4);background:rgba(255,193,7,0.05);}
.btn-filter{padding:10px 20px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:10px;color:#1a0a00;font-size:13px;font-weight:700;cursor:pointer;font-family:'Poppins',sans-serif;transition:all 0.3s;box-shadow:0 4px 14px rgba(255,193,7,0.3);}
.btn-filter:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(255,193,7,0.4);}
.btn-showall{padding:10px 18px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.1);border-radius:10px;color:rgba(255,255,255,0.5);font-size:13px;font-weight:500;text-decoration:none;transition:all 0.3s;white-space:nowrap;}
.btn-showall:hover{border-color:rgba(255,193,7,0.3);color:#ffc107;}

/* Search box */
.search-box{position:relative;flex:1;min-width:200px;max-width:280px;}
.search-box input{width:100%;padding:10px 14px 10px 40px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);border-radius:10px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;}
.search-box input::placeholder{color:rgba(255,255,255,0.2);}
.search-box input:focus{border-color:rgba(255,193,7,0.4);background:rgba(255,193,7,0.04);}
.s-icon{position:absolute;left:12px;top:50%;transform:translateY(-50%);font-size:15px;pointer-events:none;}

/* ===== ERROR MSG ===== */
.error-msg{background:rgba(245,101,101,0.1);border:1px solid rgba(245,101,101,0.3);border-radius:12px;padding:14px 18px;color:#fc8181;font-size:13px;margin-bottom:20px;display:flex;align-items:center;gap:10px;}

/* ===== TABLE CARD ===== */
.card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.card-head{padding:18px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.card-head h3{font-size:15px;font-weight:700;color:#fff;}
.count-badge{background:linear-gradient(135deg,#ffc107,#ff9800);color:#1a0a00;padding:4px 14px;border-radius:20px;font-size:11px;font-weight:800;}

table{width:100%;border-collapse:collapse;}
thead th{padding:11px 16px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.3);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1.2px;text-align:left;white-space:nowrap;}
tbody td{padding:0;border-bottom:1px solid rgba(255,255,255,0.04);vertical-align:middle;}
tbody tr:last-child td{border-bottom:none;}
tbody tr{transition:all 0.2s;animation:rowIn 0.3s ease forwards;}
@keyframes rowIn{from{opacity:0;transform:translateX(-8px);}to{opacity:1;transform:translateX(0);}}
tbody tr:hover{background:rgba(255,193,7,0.03);}
.td-p{padding:13px 16px;}

/* Cells */
.row-num{font-size:11px;color:rgba(255,255,255,0.2);}
.s-name{font-size:13px;font-weight:700;color:#fff;}
.s-class{font-size:10px;color:rgba(255,255,255,0.35);margin-top:2px;}
.bus-cell{display:flex;flex-direction:column;gap:2px;}
.bus-num{font-size:12px;font-weight:700;color:#ffc107;}
.bus-driver{font-size:10px;color:rgba(255,255,255,0.35);}
.badge-board{background:rgba(72,187,120,0.12);border:1px solid rgba(72,187,120,0.25);color:#68d391;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;white-space:nowrap;}
.badge-drop{background:rgba(66,153,225,0.12);border:1px solid rgba(66,153,225,0.25);color:#63b3ed;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;white-space:nowrap;}
.badge-yes{background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.2);color:#68d391;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-no{background:rgba(245,101,101,0.1);border:1px solid rgba(245,101,101,0.2);color:#fc8181;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.time-cell{font-size:11px;color:rgba(255,255,255,0.5);}
.email-cell{font-size:11px;color:rgba(255,255,255,0.3);font-family:monospace;max-width:140px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}

/* Empty state */
.empty-state{text-align:center;padding:60px 32px;}
.empty-icon{font-size:56px;display:block;margin-bottom:14px;animation:emptyBounce 2s ease-in-out infinite;}
@keyframes emptyBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-8px);}}
.empty-title{font-size:17px;font-weight:700;color:rgba(255,255,255,0.4);margin-bottom:6px;}
.empty-sub{font-size:12px;color:rgba(255,255,255,0.2);}

/* Scrollbar */
::-webkit-scrollbar{width:4px;}
::-webkit-scrollbar-track{background:transparent;}
::-webkit-scrollbar-thumb{background:rgba(255,193,7,0.3);border-radius:4px;}
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
<a href="${pageContext.request.contextPath}/admin/dashboard"    class="sb-item"><span class="sb-ico">📊</span><span class="label">Dashboard</span></a>
<div class="sb-section">Manage</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item"><span class="sb-ico">🎒</span><span class="label">Students</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/list"  class="sb-item"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/list"     class="sb-item"><span class="sb-ico">🚌</span><span class="label">Buses</span></a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list"      class="sb-item active"><span class="sb-ico">📋</span><span class="label">Attendance Log</span></a>
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
<div class="topbar">
<div class="topbar-left">
<h1>📋 Attendance Records</h1>
<p>View and filter all student boarding and drop-off events</p>
</div>
<div class="record-pill">📊 ${attendanceList.size()} Records</div>
</div>

<div class="page-body">

<!-- Error -->
<c:if test="${not empty error}">
<div class="error-msg">⚠️ ${error}</div>
</c:if>

<!-- Mini stat cards -->
<div class="mini-stats">
<div class="mini-card mc-yellow">
<div class="mini-card-icon">📋</div>
<div><div class="mini-card-num">${attendanceList.size()}</div><div class="mini-card-lbl">Total Records</div></div>
</div>
<div class="mini-card mc-green">
<div class="mini-card-icon">🟢</div>
<div>
<div class="mini-card-num">
<c:set var="boardCount" value="0"/>
<c:forEach var="a" items="${attendanceList}"><c:if test="${a.eventType=='BOARDING'}"><c:set var="boardCount" value="${boardCount+1}"/></c:if></c:forEach>
${boardCount}
</div>
<div class="mini-card-lbl">Boardings</div>
</div>
</div>
<div class="mini-card mc-blue">
<div class="mini-card-icon">🔵</div>
<div>
<div class="mini-card-num">
<c:set var="dropCount" value="0"/>
<c:forEach var="a" items="${attendanceList}"><c:if test="${a.eventType=='DROPOFF'}"><c:set var="dropCount" value="${dropCount+1}"/></c:if></c:forEach>
${dropCount}
</div>
<div class="mini-card-lbl">Dropoffs</div>
</div>
</div>
<div class="mini-card mc-green">
<div class="mini-card-icon">✉️</div>
<div>
<div class="mini-card-num">
<c:set var="emailCount" value="0"/>
<c:forEach var="a" items="${attendanceList}"><c:if test="${a.alertSent}"><c:set var="emailCount" value="${emailCount+1}"/></c:if></c:forEach>
${emailCount}
</div>
<div class="mini-card-lbl">Emails Sent</div>
</div>
</div>
</div>

<!-- Filter bar -->
<form action="${pageContext.request.contextPath}/attendance/byDate" method="get">
<div class="filter-bar">
<span class="filter-label">📅 Filter:</span>
<input type="date" name="date" value="${selectedDate}"/>
<button type="submit" class="btn-filter">🔍 Apply Filter</button>
<a href="${pageContext.request.contextPath}/attendance/list" class="btn-showall">📋 Show All</a>
<div class="search-box">
<span class="s-icon">🔍</span>
<input type="text" id="searchInput" placeholder="Search student, bus..." onkeyup="filterTable()"/>
</div>
</div>
</form>

<!-- Table card -->
<div class="card">
<div class="card-head">
<h3>Attendance Log</h3>
<span class="count-badge">${attendanceList.size()} records</span>
</div>
<table id="attTable">
<thead>
<tr>
<th>#</th>
<th>Student</th>
<th>Bus</th>
<th>Event</th>
<th>Date &amp; Time</th>
<th>Email</th>
<th>Parent Email</th>
</tr>
</thead>
<tbody>
<c:forEach var="att" items="${attendanceList}" varStatus="s">
<tr style="animation-delay:${s.index * 0.03}s">

<td><div class="td-p"><span class="row-num">${s.count}</span></div></td>

<td><div class="td-p">
<div class="s-name">${att.student.name}</div>
<div class="s-class">Class ${att.student.className}-${att.student.section}</div>
</div></td>

<td><div class="td-p">
<div class="bus-cell">
<span class="bus-num">🚌 ${att.bus.busNumber}</span>
<span class="bus-driver">👨‍✈️ ${att.bus.driverName}</span>
</div>
</div></td>

<td><div class="td-p">
<c:choose>
<c:when test="${att.eventType=='BOARDING'}"><span class="badge-board">🟢 BOARDING</span></c:when>
<c:otherwise><span class="badge-drop">🔵 DROPOFF</span></c:otherwise>
</c:choose>
</div></td>

<td><div class="td-p">
<div class="time-cell">
📅 <fmt:formatDate value="${att.scanTime}" pattern="dd-MM-yyyy"/><br/>
🕐 <fmt:formatDate value="${att.scanTime}" pattern="hh:mm a"/>
</div>
</div></td>

<td><div class="td-p">
<c:choose>
<c:when test="${att.alertSent}"><span class="badge-yes">✅ Sent</span></c:when>
<c:otherwise><span class="badge-no">❌ No</span></c:otherwise>
</c:choose>
</div></td>

<td><div class="td-p">
<span class="email-cell">
<c:choose>
<c:when test="${not empty att.student.parent}">✉️ ${att.student.parent.email}</c:when>
<c:otherwise><span style="color:rgba(255,255,255,0.2);font-style:italic;">No parent</span></c:otherwise>
</c:choose>
</span>
</div></td>

</tr>
</c:forEach>

<c:if test="${empty attendanceList}">
<tr><td colspan="7">
<div class="empty-state">
<span class="empty-icon">📋</span>
<div class="empty-title">No attendance records found</div>
<div class="empty-sub">Records will appear here after driver scans student QR codes</div>
</div>
</td></tr>
</c:if>
</tbody>
</table>
</div>
</div>
</div>
</div>

<script>
function filterTable(){
var input = document.getElementById('searchInput').value.toLowerCase();
var rows  = document.querySelectorAll('#attTable tbody tr');
rows.forEach(function(row){
row.style.display = row.textContent.toLowerCase().includes(input) ? '' : 'none';
});
}
document.querySelectorAll('#attTable tbody tr').forEach(function(row){
row.style.cursor='pointer';
row.addEventListener('click',function(e){
if(e.target.tagName==='A') return;
document.querySelectorAll('#attTable tbody tr').forEach(function(r){ r.style.background=''; });
this.style.background='rgba(255,193,7,0.06)';
});
});
</script>
</body>
</html>