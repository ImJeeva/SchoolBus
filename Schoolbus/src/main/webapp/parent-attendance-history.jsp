<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Attendance History - SmartBus</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#0a0a1a;color:#fff;display:flex;min-height:100vh;}

/* ===== SIDEBAR ===== */
.sidebar{width:260px;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);border-right:1px solid rgba(66,153,225,0.15);display:flex;flex-direction:column;position:fixed;top:0;left:0;height:100vh;z-index:100;overflow:hidden;}
.sb-brand{padding:28px 24px 24px;border-bottom:1px solid rgba(66,153,225,0.15);}
.sb-logo{width:52px;height:52px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:26px;margin-bottom:12px;box-shadow:0 8px 24px rgba(66,153,225,0.4);animation:logoBounce 2s ease-in-out infinite;}
@keyframes logoBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-5px);}}
.sb-title{font-size:22px;font-weight:900;letter-spacing:2px;background:linear-gradient(135deg,#63b3ed,#fff);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.sb-sub{font-size:10px;color:rgba(255,255,255,0.3);letter-spacing:3px;text-transform:uppercase;margin-top:2px;}

.sb-parent{display:flex;align-items:center;gap:12px;padding:12px 20px;margin:16px;background:rgba(66,153,225,0.08);border:1px solid rgba(66,153,225,0.15);border-radius:12px;}
.sb-parent-avatar{width:40px;height:40px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.sb-parent-name{font-size:13px;font-weight:600;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
.sb-parent-role{font-size:10px;color:rgba(255,255,255,0.35);text-transform:uppercase;letter-spacing:1px;}

.sb-menu{flex:1;padding:20px 0;overflow-y:auto;}
.sb-section{padding:8px 24px 4px;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:rgba(66,153,225,0.4);}
.sb-item{display:flex;align-items:center;gap:14px;padding:13px 24px;color:rgba(255,255,255,0.5);text-decoration:none;font-size:13px;font-weight:500;transition:all 0.3s;border-left:3px solid transparent;position:relative;overflow:hidden;}
.sb-item::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;background:linear-gradient(90deg,rgba(66,153,225,0.1),transparent);opacity:0;transition:opacity 0.3s;}
.sb-item:hover::before,.sb-item.active::before{opacity:1;}
.sb-item:hover,.sb-item.active{color:#63b3ed;border-left-color:#4299e1;}
.sb-item.active{color:#fff;background:rgba(66,153,225,0.12);}
.sb-ico{font-size:20px;width:26px;text-align:center;flex-shrink:0;}
.sb-item span.label{flex:1;}

.sb-footer{padding:20px 24px;border-top:1px solid rgba(66,153,225,0.15);}
.sb-logout{display:flex;align-items:center;gap:8px;width:100%;color:rgba(255,100,100,0.7);text-decoration:none;font-size:13px;font-weight:500;padding:10px 14px;border-radius:10px;border:1px solid rgba(255,100,100,0.2);transition:all 0.3s;justify-content:center;}
.sb-logout:hover{color:#ff6b6b;border-color:rgba(255,100,100,0.5);background:rgba(255,100,100,0.08);}

/* ===== MAIN ===== */
.main{margin-left:260px;flex:1;display:flex;flex-direction:column;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);position:relative;}
.main::before{content:'';position:fixed;width:500px;height:500px;background:radial-gradient(circle,rgba(66,153,225,0.05) 0%,transparent 70%);top:-100px;right:-100px;border-radius:50%;animation:bgPulse 6s ease-in-out infinite;z-index:0;}
.main::after{content:'';position:fixed;width:400px;height:400px;background:radial-gradient(circle,rgba(66,153,225,0.03) 0%,transparent 70%);bottom:-80px;left:-80px;border-radius:50%;animation:bgPulse 6s ease-in-out infinite reverse;z-index:0;}
@keyframes bgPulse{0%,100%{transform:scale(1);}50%{transform:scale(1.2);}}

.topbar{position:relative;z-index:10;background:rgba(255,255,255,0.03);backdrop-filter:blur(20px);border-bottom:1px solid rgba(66,153,225,0.1);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:12px;}
.record-badge{background:rgba(66,153,225,0.1);border:1px solid rgba(66,153,225,0.25);color:#63b3ed;padding:8px 16px;border-radius:20px;font-size:12px;font-weight:700;}

.page-body{padding:28px 36px;flex:1;position:relative;z-index:5;}

/* Children filter buttons */
.children-filter{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:24px;}
.child-btn{display:inline-flex;align-items:center;gap:8px;padding:10px 18px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:12px;color:rgba(255,255,255,0.5);font-size:13px;font-weight:500;cursor:pointer;transition:all 0.3s;text-decoration:none;}
.child-btn:hover{border-color:rgba(66,153,225,0.3);color:#63b3ed;background:rgba(66,153,225,0.05);}
.child-btn.active{border-color:rgba(66,153,225,0.5);color:#fff;background:rgba(66,153,225,0.12);box-shadow:0 4px 14px rgba(66,153,225,0.2);}
.child-btn.all-btn{border-color:rgba(255,193,7,0.3);color:#ffc107;}
.child-btn.all-btn.active{border-color:rgba(255,193,7,0.5);background:rgba(255,193,7,0.12);}

/* Summary cards */
.summary-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px;}
.sum-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:16px 18px;display:flex;align-items:center;gap:14px;transition:all 0.3s;}
.sum-card:hover{transform:translateY(-3px);border-color:rgba(66,153,225,0.2);}
.sum-icon{width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0;}
.sum-card.sc-blue .sum-icon{background:rgba(66,153,225,0.15);}
.sum-card.sc-green .sum-icon{background:rgba(72,187,120,0.15);}
.sum-card.sc-yellow .sum-icon{background:rgba(255,193,7,0.15);}
.sum-card.sc-red .sum-icon{background:rgba(245,101,101,0.15);}
.sum-num{font-size:20px;font-weight:900;line-height:1;}
.sum-card.sc-blue .sum-num{color:#63b3ed;}
.sum-card.sc-green .sum-num{color:#68d391;}
.sum-card.sc-yellow .sum-num{color:#ffc107;}
.sum-card.sc-red .sum-num{color:#fc8181;}
.sum-lbl{font-size:10px;color:rgba(255,255,255,0.35);margin-top:3px;}

/* Search & Date filter */
.filter-bar{display:flex;gap:12px;align-items:center;flex-wrap:wrap;margin-bottom:24px;}
.search-box{position:relative;flex:1;min-width:250px;max-width:350px;}
.search-box input{width:100%;padding:11px 16px 11px 42px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);border-radius:11px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;}
.search-box input::placeholder{color:rgba(255,255,255,0.2);}
.search-box input:focus{border-color:rgba(66,153,225,0.4);background:rgba(66,153,225,0.04);}
.s-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);font-size:15px;pointer-events:none;}
.date-filter{display:flex;gap:8px;align-items:center;}
.date-filter input{padding:10px 14px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);border-radius:10px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;color-scheme:dark;}
.date-filter input:focus{border-color:rgba(66,153,225,0.4);}
.btn-filter{padding:10px 18px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border:none;border-radius:10px;color:#fff;font-size:13px;font-weight:700;cursor:pointer;transition:all 0.3s;}
.btn-filter:hover{transform:translateY(-2px);box-shadow:0 6px 18px rgba(66,153,225,0.4);}

/* Table */
.card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.card-head{padding:18px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.card-head h3{font-size:15px;font-weight:700;color:#fff;}
.count-badge{background:linear-gradient(135deg,#4299e1,#2b6cb0);color:#fff;padding:5px 14px;border-radius:20px;font-size:11px;font-weight:800;}

table{width:100%;border-collapse:collapse;}
thead th{padding:11px 16px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.3);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1.2px;text-align:left;white-space:nowrap;}
tbody td{padding:0;border-bottom:1px solid rgba(255,255,255,0.04);}
tbody tr:last-child td{border-bottom:none;}
tbody tr{transition:all 0.2s;animation:rowIn 0.3s ease forwards;}
@keyframes rowIn{from{opacity:0;transform:translateX(-8px);}to{opacity:1;transform:translateX(0);}}
tbody tr:hover{background:rgba(66,153,225,0.04);}
.td-p{padding:13px 16px;}

.row-num{font-size:11px;color:rgba(255,255,255,0.2);}
.student-cell{display:flex;align-items:center;gap:10px;}
.student-avatar{width:32px;height:32px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:14px;flex-shrink:0;}
.student-name{font-size:13px;font-weight:700;color:#fff;}
.student-class{font-size:10px;color:rgba(255,255,255,0.35);margin-top:2px;}
.date-cell{font-size:12px;color:rgba(255,255,255,0.5);}
.time-cell{font-size:12px;color:rgba(255,255,255,0.4);font-family:monospace;}
.bus-cell{font-size:12px;font-weight:700;color:#63b3ed;}

.badge-board{background:rgba(72,187,120,0.12);border:1px solid rgba(72,187,120,0.25);color:#68d391;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;}
.badge-drop{background:rgba(66,153,225,0.12);border:1px solid rgba(66,153,225,0.25);color:#63b3ed;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;}
.badge-yes{background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.2);color:#68d391;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-no{background:rgba(245,101,101,0.1);border:1px solid rgba(245,101,101,0.2);color:#fc8181;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}

.empty-state{text-align:center;padding:60px 32px;}
.empty-icon{font-size:56px;display:block;margin-bottom:14px;animation:emptyBounce 2s ease-in-out infinite;}
@keyframes emptyBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-8px);}}
.empty-title{font-size:17px;font-weight:700;color:rgba(255,255,255,0.4);margin-bottom:6px;}
.empty-sub{font-size:12px;color:rgba(255,255,255,0.2);}

::-webkit-scrollbar{width:4px;}
::-webkit-scrollbar-track{background:transparent;}
::-webkit-scrollbar-thumb{background:rgba(66,153,225,0.3);border-radius:4px;}
</style>
</head>
<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
<div class="sb-brand">
<div class="sb-logo">👨‍👩‍👧</div>
<div class="sb-title">SMARTBUS</div>
<div class="sb-sub">Parent Portal</div>
</div>

<div class="sb-parent">
<div class="sb-parent-avatar">👤</div>
<div>
<div class="sb-parent-name">${parent.name}</div>
<div class="sb-parent-role">Parent</div>
</div>
</div>

<div class="sb-menu">
<div class="sb-section">Main</div>
<a href="${pageContext.request.contextPath}/parent/dashboard" class="sb-item">
<span class="sb-ico">🏠</span><span class="label">Dashboard</span>
</a>
<a href="${pageContext.request.contextPath}/parent/attendance" class="sb-item active">
<span class="sb-ico">📋</span><span class="label">Attendance History</span>
</a>
<div class="sb-section">Information</div>
<a href="${pageContext.request.contextPath}/parent/school-info" class="sb-item">
<span class="sb-ico">🏫</span><span class="label">School Info</span>
</a>
<a href="${pageContext.request.contextPath}/parent/contact" class="sb-item">
<span class="sb-ico">📞</span><span class="label">Contact School</span>
</a>
<div class="sb-section">Account</div>
<a href="${pageContext.request.contextPath}/parent/profile" class="sb-item">
<span class="sb-ico">⚙️</span><span class="label">Profile Settings</span>
</a>
</div>

<div class="sb-footer">
<a href="${pageContext.request.contextPath}/parent/logout" class="sb-logout">🚪 Logout</a>
</div>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<div class="topbar">
<div class="topbar-left">
<h1>📋 Attendance History — All Children</h1>
<p>Complete boarding and drop-off records for all your children</p>
</div>
<div class="topbar-right">
<div class="record-badge">📊 ${attendanceList.size()} Total Records</div>
</div>
</div>

<div class="page-body">

<!-- Children filter buttons -->
<div class="children-filter">
<button class="child-btn all-btn active" onclick="filterByChild('all')">👥 All Children</button>
<c:forEach var="child" items="${children}">
<button class="child-btn" onclick="filterByChild(${child.studentId})" data-child-id="${child.studentId}">
🎒 ${child.name}
</button>
</c:forEach>
</div>

<!-- Summary cards -->
<div class="summary-grid">
<div class="sum-card sc-blue">
<div class="sum-icon">📋</div>
<div>
<div class="sum-num">${attendanceList.size()}</div>
<div class="sum-lbl">Total Scans</div>
</div>
</div>
<div class="sum-card sc-green">
<div class="sum-icon">🟢</div>
<div>
<div class="sum-num">
<c:set var="boardCount" value="0"/>
<c:forEach var="a" items="${attendanceList}">
<c:if test="${a.eventType=='BOARDING'}"><c:set var="boardCount" value="${boardCount+1}"/></c:if>
</c:forEach>
${boardCount}
</div>
<div class="sum-lbl">Boardings</div>
</div>
</div>
<div class="sum-card sc-yellow">
<div class="sum-icon">🔵</div>
<div>
<div class="sum-num">
<c:set var="dropCount" value="0"/>
<c:forEach var="a" items="${attendanceList}">
<c:if test="${a.eventType=='DROPOFF'}"><c:set var="dropCount" value="${dropCount+1}"/></c:if>
</c:forEach>
${dropCount}
</div>
<div class="sum-lbl">Dropoffs</div>
</div>
</div>
<div class="sum-card sc-green">
<div class="sum-icon">✉️</div>
<div>
<div class="sum-num">
<c:set var="emailCount" value="0"/>
<c:forEach var="a" items="${attendanceList}">
<c:if test="${a.alertSent}"><c:set var="emailCount" value="${emailCount+1}"/></c:if>
</c:forEach>
${emailCount}
</div>
<div class="sum-lbl">Emails Sent</div>
</div>
</div>
</div>

<!-- Search & date filter -->
<div class="filter-bar">
<div class="search-box">
<span class="s-icon">🔍</span>
<input type="text" id="searchInput" placeholder="Search by student name, bus..." onkeyup="filterTable()"/>
</div>
<div class="date-filter">
<span style="font-size:12px;color:rgba(255,255,255,0.4);">📅 Date:</span>
<input type="date" id="dateFilter" onchange="filterTable()"/>
</div>
</div>

<!-- Table -->
<div class="card">
<div class="card-head">
<h3>Scan Records</h3>
<span class="count-badge" id="visibleCount">${attendanceList.size()} records</span>
</div>
<table id="attTable">
<thead>
<tr>
<th>#</th>
<th>Student</th>
<th>Date</th>
<th>Time</th>
<th>Event</th>
<th>Bus</th>
<th>Email</th>
</tr>
</thead>
<tbody>
<c:forEach var="att" items="${attendanceList}" varStatus="s">
<tr style="animation-delay:${s.index * 0.02}s" data-student-id="${att.student.studentId}">

<td><div class="td-p"><span class="row-num">${s.count}</span></div></td>

<td><div class="td-p">
<div class="student-cell">
<div class="student-avatar">🎒</div>
<div>
<div class="student-name">${att.student.name}</div>
<div class="student-class">${att.student.className}-${att.student.section}</div>
</div>
</div>
</div></td>

<td><div class="td-p"><span class="date-cell">📅 <fmt:formatDate value="${att.scanTime}" pattern="dd-MM-yyyy"/></span></div></td>

<td><div class="td-p"><span class="time-cell">🕐 <fmt:formatDate value="${att.scanTime}" pattern="hh:mm a"/></span></div></td>

<td><div class="td-p">
<c:choose>
<c:when test="${att.eventType=='BOARDING'}"><span class="badge-board">🟢 BOARDING</span></c:when>
<c:otherwise><span class="badge-drop">🔵 DROPOFF</span></c:otherwise>
</c:choose>
</div></td>

<td><div class="td-p"><span class="bus-cell">🚌 ${att.bus.busNumber}</span></div></td>

<td><div class="td-p">
<c:choose>
<c:when test="${att.alertSent}"><span class="badge-yes">✅ Sent</span></c:when>
<c:otherwise><span class="badge-no">❌ No</span></c:otherwise>
</c:choose>
</div></td>

</tr>
</c:forEach>

<c:if test="${empty attendanceList}">
<tr><td colspan="7">
<div class="empty-state">
<span class="empty-icon">📋</span>
<div class="empty-title">No attendance records found</div>
<div class="empty-sub">Records will appear after driver scans student QR codes</div>
</div>
</td></tr>
</c:if>
</tbody>
</table>
</div>

</div>
</div>

<script>
var currentChildFilter = 'all';

// Filter by child
function filterByChild(childId){
currentChildFilter = childId;

// Update button states
document.querySelectorAll('.child-btn').forEach(function(btn){
btn.classList.remove('active');
});
event.target.classList.add('active');

// Show/hide rows
var rows = document.querySelectorAll('#attTable tbody tr');
var visibleCount = 0;
rows.forEach(function(row){
var studentId = row.getAttribute('data-student-id');
if(!studentId) return; // skip empty state row
if(childId === 'all' || studentId == childId){
row.style.display = '';
visibleCount++;
} else {
row.style.display = 'none';
}
});

// Update count badge
document.getElementById('visibleCount').textContent = visibleCount + ' records';

// Re-apply search/date filter
filterTable();
}

// Search & date filter
function filterTable(){
var searchVal = document.getElementById('searchInput').value.toLowerCase();
var dateVal = document.getElementById('dateFilter').value;

var rows = document.querySelectorAll('#attTable tbody tr');
var visibleCount = 0;

rows.forEach(function(row){
var studentId = row.getAttribute('data-student-id');
if(!studentId) return; // skip empty row

// Child filter
if(currentChildFilter !== 'all' && studentId != currentChildFilter){
row.style.display = 'none';
return;
}

// Search filter
var text = row.textContent.toLowerCase();
if(searchVal && !text.includes(searchVal)){
row.style.display = 'none';
return;
}

// Date filter
if(dateVal){
var dateCell = row.cells[2].textContent;
var rowDate = dateCell.match(/\d{2}-\d{2}-\d{4}/);
if(rowDate){
var parts = rowDate[0].split('-');
var rowDateStr = parts[2] + '-' + parts[1] + '-' + parts[0]; // convert to yyyy-mm-dd
if(rowDateStr !== dateVal){
row.style.display = 'none';
return;
}
}
}

row.style.display = '';
visibleCount++;
});

document.getElementById('visibleCount').textContent = visibleCount + ' records';
}

// Row click highlight
document.querySelectorAll('#attTable tbody tr').forEach(function(row){
row.style.cursor = 'pointer';
row.addEventListener('click', function(){
document.querySelectorAll('#attTable tbody tr').forEach(function(r){ r.style.background = ''; });
this.style.background = 'rgba(66,153,225,0.08)';
});
});
</script>
</body>
</html>