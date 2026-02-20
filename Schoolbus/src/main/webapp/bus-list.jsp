<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Buses - SmartBus</title>
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
.btn-add{display:inline-flex;align-items:center;gap:10px;padding:12px 24px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:700;font-family:'Poppins',sans-serif;cursor:pointer;text-decoration:none;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-add::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-add:hover::before{left:100%;}
.btn-add:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}

/* ===== PAGE BODY ===== */
.page-body{padding:28px 36px;flex:1;}

/* Toolbar */
.toolbar{display:flex;align-items:center;gap:16px;margin-bottom:24px;}
.search-box{position:relative;flex:1;max-width:360px;}
.search-box input{width:100%;padding:11px 16px 11px 42px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;}
.search-box input::placeholder{color:rgba(255,255,255,0.2);}
.search-box input:focus{border-color:rgba(255,193,7,0.4);background:rgba(255,193,7,0.05);box-shadow:0 0 0 3px rgba(255,193,7,0.08);}
.search-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);font-size:16px;pointer-events:none;}
.total-pill{background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.2);color:#68d391;padding:8px 18px;border-radius:20px;font-size:12px;font-weight:700;}

/* ===== BUS STAT MINI CARDS ===== */
.mini-stats{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:24px;}
.mini-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:18px 20px;display:flex;align-items:center;gap:14px;transition:all 0.3s;}
.mini-card:hover{transform:translateY(-3px);border-color:rgba(255,193,7,0.2);}
.mini-card-icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;}
.mini-card.green .mini-card-icon{background:rgba(72,187,120,0.15);}
.mini-card.yellow .mini-card-icon{background:rgba(255,193,7,0.15);}
.mini-card.blue .mini-card-icon{background:rgba(66,153,225,0.15);}
.mini-card-num{font-size:24px;font-weight:900;line-height:1;}
.mini-card.green .mini-card-num{color:#68d391;}
.mini-card.yellow .mini-card-num{color:#ffc107;}
.mini-card.blue .mini-card-num{color:#63b3ed;}
.mini-card-label{font-size:11px;color:rgba(255,255,255,0.4);margin-top:2px;}

/* ===== TABLE CARD ===== */
.card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.card-head{padding:18px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.card-head h3{font-size:15px;font-weight:700;color:#fff;}
.card-head span{font-size:12px;color:rgba(255,255,255,0.3);}
table{width:100%;border-collapse:collapse;}
thead th{padding:12px 18px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.3);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1.5px;text-align:left;white-space:nowrap;}
tbody td{padding:0;border-bottom:1px solid rgba(255,255,255,0.04);vertical-align:middle;}
tbody tr:last-child td{border-bottom:none;}
tbody tr{transition:all 0.25s;animation:rowSlideIn 0.3s ease forwards;}
@keyframes rowSlideIn{from{opacity:0;transform:translateX(-10px);}to{opacity:1;transform:translateX(0);}}
tbody tr:hover{background:rgba(72,187,120,0.04);}
.td-inner{padding:14px 18px;display:flex;align-items:center;}

/* Row number */
.row-num{font-size:12px;color:rgba(255,255,255,0.2);font-weight:600;}

/* Bus number cell */
.bus-cell{display:flex;align-items:center;gap:12px;}
.bus-icon-wrap{width:42px;height:42px;border-radius:12px;background:linear-gradient(135deg,rgba(255,193,7,0.25),rgba(255,107,0,0.15));border:1px solid rgba(255,193,7,0.25);display:flex;align-items:center;justify-content:center;flex-shrink:0;position:relative;overflow:hidden;}
/* mini animated bus wheels */
.bus-icon-wrap::after{content:'🚌';font-size:22px;}
.bus-number{font-size:14px;font-weight:800;color:#ffc107;letter-spacing:1px;}
.bus-id{font-size:10px;color:rgba(255,255,255,0.3);margin-top:1px;}

/* Driver cell */
.driver-cell{display:flex;flex-direction:column;gap:2px;}
.driver-name{font-size:13px;font-weight:600;color:#fff;}
.driver-phone{font-size:11px;color:rgba(255,255,255,0.4);font-family:monospace;}

/* Route badge */
.route-badge{display:inline-flex;align-items:center;gap:6px;background:rgba(147,112,219,0.1);border:1px solid rgba(147,112,219,0.2);color:#c4a0ff;padding:5px 12px;border-radius:20px;font-size:11px;font-weight:600;max-width:180px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}

/* Capacity bar */
.capacity-wrap{display:flex;flex-direction:column;gap:5px;}
.capacity-num{font-size:12px;font-weight:700;color:#fff;}
.capacity-bar{width:80px;height:5px;background:rgba(255,255,255,0.08);border-radius:10px;overflow:hidden;}
.capacity-fill{height:100%;background:linear-gradient(90deg,#ffc107,#ff6b00);border-radius:10px;}

/* Status badge */
.status-on{background:rgba(72,187,120,0.15);border:1px solid rgba(72,187,120,0.25);color:#68d391;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;}

/* Action buttons */
.actions{display:flex;align-items:center;gap:6px;}
.act-btn{display:inline-flex;align-items:center;gap:5px;padding:6px 12px;border-radius:8px;font-size:11px;font-weight:600;text-decoration:none;transition:all 0.2s;white-space:nowrap;border:1px solid transparent;}
.act-btn.edit{background:rgba(66,153,225,0.1);border-color:rgba(66,153,225,0.2);color:#63b3ed;}
.act-btn.del{background:rgba(245,101,101,0.1);border-color:rgba(245,101,101,0.2);color:#fc8181;}
.act-btn.edit:hover{background:rgba(66,153,225,0.2);transform:translateY(-1px);}
.act-btn.del:hover{background:rgba(245,101,101,0.2);transform:translateY(-1px);}

/* Empty state */
.empty-state{text-align:center;padding:64px 32px;}
.empty-icon{font-size:64px;display:block;margin-bottom:16px;animation:emptyBounce 2s ease-in-out infinite;}
@keyframes emptyBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-10px);}}
.empty-title{font-size:18px;font-weight:700;color:rgba(255,255,255,0.5);margin-bottom:8px;}
.empty-sub{font-size:13px;color:rgba(255,255,255,0.25);margin-bottom:24px;}
.empty-link{display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:10px;color:#1a0a00;font-size:13px;font-weight:700;text-decoration:none;}

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
<a href="${pageContext.request.contextPath}/admin/bus/list"     class="sb-item active"><span class="sb-ico">🚌</span><span class="label">Buses</span></a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list"      class="sb-item"><span class="sb-ico">📋</span><span class="label">Attendance Log</span></a>
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
<h1>🚌 Bus Management</h1>
<p>View, add, edit and manage all school buses and drivers</p>
</div>
<a href="${pageContext.request.contextPath}/admin/bus/add" class="btn-add">➕ Add New Bus</a>
</div>

<div class="page-body">

<!-- Mini stat cards -->
<div class="mini-stats">
<div class="mini-card green">
<div class="mini-card-icon">🚌</div>
<div>
<div class="mini-card-num">${buses.size()}</div>
<div class="mini-card-label">Total Buses</div>
</div>
</div>
<div class="mini-card yellow">
<div class="mini-card-icon">👨‍✈️</div>
<div>
<div class="mini-card-num">${buses.size()}</div>
<div class="mini-card-label">Active Drivers</div>
</div>
</div>
<div class="mini-card blue">
<div class="mini-card-icon">🛣️</div>
<div>
<div class="mini-card-num">${buses.size()}</div>
<div class="mini-card-label">Active Routes</div>
</div>
</div>
</div>

<!-- Toolbar -->
<div class="toolbar">
<div class="search-box">
<span class="search-icon">🔍</span>
<input type="text" id="searchInput" placeholder="Search bus number, driver, route..." onkeyup="filterTable()"/>
</div>
<div class="total-pill">🚌 ${buses.size()} Buses Total</div>
</div>

<!-- Table Card -->
<div class="card">
<div class="card-head">
<h3>All Registered Buses</h3>
<span>Click row to highlight • Search to filter</span>
</div>
<table id="busTable">
<thead>
<tr>
<th style="width:50px;">#</th>
<th>Bus</th>
<th>Driver</th>
<th>Route</th>
<th>Capacity</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<c:forEach var="bus" items="${buses}" varStatus="s">
<tr style="animation-delay:${s.index * 0.05}s">

<td><div class="td-inner"><span class="row-num">${s.count}</span></div></td>

<td><div class="td-inner">
<div class="bus-cell">
<div class="bus-icon-wrap"></div>
<div>
<div class="bus-number">${bus.busNumber}</div>
<div class="bus-id">Bus ID #${bus.busId}</div>
</div>
</div>
</div></td>

<td><div class="td-inner">
<div class="driver-cell">
<span class="driver-name">👨‍✈️ ${bus.driverName}</span>
<span class="driver-phone">📞 ${bus.driverPhone}</span>
</div>
</div></td>

<td><div class="td-inner">
<span class="route-badge">🛣️ ${bus.route}</span>
</div></td>

<td><div class="td-inner">
<div class="capacity-wrap">
<span class="capacity-num">${bus.capacity} seats</span>
<div class="capacity-bar">
<div class="capacity-fill" style="width:${bus.capacity > 60 ? 100 : (bus.capacity * 100 / 60)}%"></div>
</div>
</div>
</div></td>

<td><div class="td-inner">
<span class="status-on">🟢 Active</span>
</div></td>

<td><div class="td-inner">
<div class="actions">
<a href="${pageContext.request.contextPath}/admin/bus/edit/${bus.busId}"   class="act-btn edit">✏️ Edit</a>
<a href="${pageContext.request.contextPath}/admin/bus/delete/${bus.busId}" class="act-btn del" onclick="return confirm('Delete bus ${bus.busNumber}?')">🗑️ Del</a>
</div>
</div></td>

</tr>
</c:forEach>

<c:if test="${empty buses}">
<tr><td colspan="7">
<div class="empty-state">
<span class="empty-icon">🚌</span>
<div class="empty-title">No buses registered yet!</div>
<div class="empty-sub">Add your first bus to start assigning students and tracking routes</div>
<a href="${pageContext.request.contextPath}/admin/bus/add" class="empty-link">➕ Add First Bus</a>
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
var rows  = document.querySelectorAll('#busTable tbody tr');
rows.forEach(function(row){
row.style.display = row.textContent.toLowerCase().includes(input) ? '' : 'none';
});
}
document.querySelectorAll('#busTable tbody tr').forEach(function(row){
row.style.cursor = 'pointer';
row.addEventListener('click',function(e){
if(e.target.tagName==='A') return;
document.querySelectorAll('#busTable tbody tr').forEach(function(r){ r.style.background=''; });
this.style.background='rgba(72,187,120,0.08)';
});
});
</script>
</body>
</html>