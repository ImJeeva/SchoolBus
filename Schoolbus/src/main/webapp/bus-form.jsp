<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Bus Form - SmartBus</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#0f0f1a;color:#fff;display:flex;min-height:100vh;}

/* ===== SIDEBAR ===== */
.sidebar{width:260px;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);border-right:1px solid rgba(255,193,7,0.1);display:flex;flex-direction:column;position:fixed;top:0;left:0;height:100vh;z-index:100;overflow:hidden;}
.sb-brand{padding:28px 24px 24px;border-bottom:1px solid rgba(255,193,7,0.1);}
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
.btn-back{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;color:rgba(255,255,255,0.6);font-size:13px;font-weight:500;text-decoration:none;transition:all 0.3s;}
.btn-back:hover{border-color:rgba(255,193,7,0.4);color:#ffc107;background:rgba(255,193,7,0.05);}

/* ===== PAGE BODY ===== */
.page-body{padding:32px 36px;flex:1;}

/* ===== FORM LAYOUT ===== */
.form-layout{display:grid;grid-template-columns:1fr 280px;gap:24px;align-items:start;}

/* ===== FORM CARD ===== */
.form-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:32px;animation:fadeSlideIn 0.4s ease;}
@keyframes fadeSlideIn{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}
.form-section-title{font-size:11px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:20px;padding-bottom:14px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;gap:8px;}

/* Form groups */
.form-group{margin-bottom:20px;}
.form-group label{display:flex;align-items:center;gap:7px;color:rgba(255,255,255,0.55);font-size:11px;font-weight:600;letter-spacing:0.8px;text-transform:uppercase;margin-bottom:9px;}
.req{color:#fc8181;}

/* Input wrap with icon */
.input-wrap{position:relative;}
.input-wrap input{width:100%;padding:13px 16px 13px 44px;background:rgba(255,255,255,0.05);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;}
.input-wrap input::placeholder{color:rgba(255,255,255,0.2);}
.input-wrap input:focus{border-color:rgba(255,193,7,0.5);background:rgba(255,193,7,0.04);box-shadow:0 0 0 4px rgba(255,193,7,0.07);}
.input-wrap .i-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);font-size:16px;pointer-events:none;}

/* Two col row */
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}

/* Form actions */
.form-actions{display:flex;gap:12px;margin-top:8px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);}
.btn-submit{display:inline-flex;align-items:center;gap:10px;padding:13px 28px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-submit::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-submit:hover::before{left:100%;}
.btn-submit:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}
.btn-cancel{display:inline-flex;align-items:center;gap:8px;padding:13px 20px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.1);border-radius:12px;color:rgba(255,255,255,0.5);font-size:14px;font-weight:500;text-decoration:none;transition:all 0.3s;}
.btn-cancel:hover{border-color:rgba(245,101,101,0.4);color:#fc8181;background:rgba(245,101,101,0.05);}

/* ===== RIGHT PREVIEW CARD ===== */
.preview-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:24px;position:sticky;top:100px;animation:fadeSlideIn 0.5s ease;}
.preview-title{font-size:11px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:18px;}

/* Bus preview card */
.bus-preview{background:linear-gradient(135deg,#1a1a2e,#0d1b3e);border:1px solid rgba(255,193,7,0.2);border-radius:16px;padding:20px;text-align:center;position:relative;overflow:hidden;}
.bus-preview::before{content:'';position:absolute;top:-20px;right:-20px;width:90px;height:90px;background:radial-gradient(circle,rgba(255,193,7,0.08),transparent);border-radius:50%;}

/* Animated bus SVG in preview */
.bus-anim-wrap{margin:0 auto 16px;width:100px;animation:busRock 1s ease-in-out infinite;}
@keyframes busRock{0%,100%{transform:translateY(0) rotate(0deg);}50%{transform:translateY(-4px) rotate(0.5deg);}}

/* Road in preview */
.preview-road{background:#111827;border-radius:8px;height:28px;position:relative;overflow:hidden;margin-bottom:14px;}
.preview-road-dash{position:absolute;top:50%;left:0;width:100%;height:2px;margin-top:-1px;background:repeating-linear-gradient(90deg,rgba(255,193,7,0.5) 0px,rgba(255,193,7,0.5) 14px,transparent 14px,transparent 28px);animation:dashAnim 0.5s linear infinite;}
@keyframes dashAnim{from{background-position:0 0;}to{background-position:-28px 0;}}

.bp-number{font-size:20px;font-weight:900;color:#ffc107;margin-bottom:4px;min-height:28px;text-shadow:0 0 20px rgba(255,193,7,0.4);}
.bp-driver{font-size:12px;color:rgba(255,255,255,0.5);margin-bottom:12px;min-height:18px;}
.bp-route{background:rgba(255,193,7,0.08);border:1px solid rgba(255,193,7,0.15);border-radius:8px;padding:8px 12px;font-size:11px;color:rgba(255,193,7,0.7);min-height:34px;word-break:break-word;}

/* Capacity bar in preview */
.preview-cap{margin-top:14px;}
.cap-label{display:flex;justify-content:space-between;font-size:10px;color:rgba(255,255,255,0.3);margin-bottom:6px;}
.cap-bar{height:6px;background:rgba(255,255,255,0.06);border-radius:10px;overflow:hidden;}
.cap-fill{height:100%;background:linear-gradient(90deg,#ffc107,#ff6b00);border-radius:10px;transition:width 0.5s ease;}

/* Tips */
.tips-box{margin-top:16px;background:rgba(72,187,120,0.06);border:1px solid rgba(72,187,120,0.15);border-radius:12px;padding:16px;}
.tips-title{font-size:11px;font-weight:700;color:#68d391;text-transform:uppercase;letter-spacing:1px;margin-bottom:10px;}
.tip-item{display:flex;align-items:flex-start;gap:7px;font-size:11px;color:rgba(255,255,255,0.4);margin-bottom:7px;line-height:1.5;}
.tip-item:last-child{margin-bottom:0;}
.tip-dot{color:#68d391;flex-shrink:0;}

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
<h1>
<c:choose>
<c:when test="${bus.busId == 0}">➕ Add New Bus</c:when>
<c:otherwise>✏️ Edit Bus</c:otherwise>
</c:choose>
</h1>
<p>Enter the bus details and driver information below</p>
</div>
<a href="${pageContext.request.contextPath}/admin/bus/list" class="btn-back">← Back to Buses</a>
</div>

<div class="page-body">
<div class="form-layout">

<!-- LEFT: FORM -->
<div class="form-card">

<c:choose>
<c:when test="${bus.busId == 0}">
<form action="${pageContext.request.contextPath}/admin/bus/save" method="post" id="busForm">
</c:when>
<c:otherwise>
<form action="${pageContext.request.contextPath}/admin/bus/update" method="post" id="busForm">
<input type="hidden" name="busId" value="${bus.busId}"/>
</c:otherwise>
</c:choose>

<!-- Bus Info Section -->
<div class="form-section-title">🚌 Bus Information</div>
<div class="form-row">
<div class="form-group">
<label><span>🔢</span> Bus Number <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">🚌</span>
<input type="text" name="busNumber" id="inBusNum" value="${bus.busNumber}" placeholder="e.g. BUS-01" required onkeyup="updatePreview()"/>
</div>
</div>
<div class="form-group">
<label><span>💺</span> Capacity</label>
<div class="input-wrap">
<span class="i-icon">👥</span>
<input type="number" name="capacity" id="inCapacity" value="${bus.capacity}" placeholder="e.g. 40" min="1" max="100" onkeyup="updatePreview()"/>
</div>
</div>
</div>

<!-- Driver Info Section -->
<div class="form-section-title" style="margin-top:8px;">👨‍✈️ Driver Information</div>
<div class="form-row">
<div class="form-group">
<label><span>👤</span> Driver Name <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">👨‍✈️</span>
<input type="text" name="driverName" id="inDriver" value="${bus.driverName}" placeholder="Driver full name" required onkeyup="updatePreview()"/>
</div>
</div>
<div class="form-group">
<label><span>📞</span> Driver Phone</label>
<div class="input-wrap">
<span class="i-icon">📱</span>
<input type="text" name="driverPhone" value="${bus.driverPhone}" placeholder="+91XXXXXXXXXX"/>
</div>
</div>
</div>

<!-- Route Section -->
<div class="form-section-title" style="margin-top:8px;">🛣️ Route Details</div>
<div class="form-group">
<label><span>🗺️</span> Route Description</label>
<div class="input-wrap">
<span class="i-icon">📍</span>
<input type="text" name="route" id="inRoute" value="${bus.route}" placeholder="e.g. School → Anna Nagar → T.Nagar" onkeyup="updatePreview()"/>
</div>
</div>

<!-- Actions -->
<div class="form-actions">
<button type="submit" class="btn-submit">
<c:choose>
<c:when test="${bus.busId == 0}">🚀 Save Bus</c:when>
<c:otherwise>✅ Update Bus</c:otherwise>
</c:choose>
</button>
<a href="${pageContext.request.contextPath}/admin/bus/list" class="btn-cancel">✕ Cancel</a>
</div>

</form>
</div>

<!-- RIGHT: PREVIEW -->
<div>
<div class="preview-card">
<div class="preview-title">👁️ Live Preview</div>

<!-- Animated bus -->
<div class="bus-preview">
<div class="bus-anim-wrap">
<svg width="100" height="46" viewBox="0 0 100 46"><rect x="2" y="2" width="88" height="32" rx="8" fill="#ffc107"/><rect x="6" y="5" width="16" height="16" rx="2" fill="#e3f2fd" opacity="0.9"/><rect x="26" y="5" width="16" height="16" rx="2" fill="#e3f2fd" opacity="0.9"/><rect x="46" y="5" width="16" height="16" rx="2" fill="#e3f2fd" opacity="0.9"/><rect x="66" y="5" width="16" height="16" rx="2" fill="#e3f2fd" opacity="0.9"/><rect x="90" y="8" width="8" height="18" rx="3" fill="#ff8f00"/><rect x="91" y="9" width="6" height="6" rx="1" fill="#fff9c4"/><circle cx="20" cy="40" r="6" fill="#222"/><circle cx="20" cy="40" r="3" fill="#555"/><circle cx="76" cy="40" r="6" fill="#222"/><circle cx="76" cy="40" r="3" fill="#555"/></svg>
</div>

<!-- Road -->
<div class="preview-road"><div class="preview-road-dash"></div></div>

<div class="bp-number" id="pvNum">
<c:choose><c:when test="${not empty bus.busNumber}">${bus.busNumber}</c:when><c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:14px;">Bus Number</span></c:otherwise></c:choose>
</div>
<div class="bp-driver" id="pvDriver">
<c:choose><c:when test="${not empty bus.driverName}">👨‍✈️ ${bus.driverName}</c:when><c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:11px;">Driver Name</span></c:otherwise></c:choose>
</div>
<div class="bp-route" id="pvRoute">
<c:choose><c:when test="${not empty bus.route}">🛣️ ${bus.route}</c:when><c:otherwise><span style="color:rgba(255,193,7,0.25);">Route will appear here...</span></c:otherwise></c:choose>
</div>

<!-- Capacity bar -->
<div class="preview-cap">
<div class="cap-label">
<span>Capacity</span>
<span id="pvCapLabel"><c:choose><c:when test="${bus.capacity > 0}">${bus.capacity} seats</c:when><c:otherwise>0 seats</c:otherwise></c:choose></span>
</div>
<div class="cap-bar">
<div class="cap-fill" id="pvCapBar" style="width:${bus.capacity > 0 ? (bus.capacity > 60 ? 100 : bus.capacity * 100 / 60) : 0}%"></div>
</div>
</div>
</div>

<!-- Tips -->
<div class="tips-box">
<div class="tips-title">💡 Quick Tips</div>
<div class="tip-item"><span class="tip-dot">✓</span>Bus number must be unique e.g. BUS-01</div>
<div class="tip-item"><span class="tip-dot">✓</span>Driver receives scan alerts from system</div>
<div class="tip-item"><span class="tip-dot">✓</span>Route helps parents know the bus path</div>
<div class="tip-item"><span class="tip-dot">✓</span>Assign students to this bus after saving</div>
</div>

</div>
</div>

</div>
</div>
</div>
</div>

<script>
function updatePreview(){
var num    = document.getElementById('inBusNum').value;
var driver = document.getElementById('inDriver').value;
var route  = document.getElementById('inRoute').value;
var cap    = parseInt(document.getElementById('inCapacity').value) || 0;

var pvNum    = document.getElementById('pvNum');
var pvDriver = document.getElementById('pvDriver');
var pvRoute  = document.getElementById('pvRoute');
var pvCapLbl = document.getElementById('pvCapLabel');
var pvCapBar = document.getElementById('pvCapBar');

pvNum.textContent    = num    || 'Bus Number';
pvNum.style.color    = num    ? '#ffc107' : 'rgba(255,255,255,0.2)';
pvDriver.textContent = driver ? '👨‍✈️ ' + driver : 'Driver Name';
pvDriver.style.color = driver ? 'rgba(255,255,255,0.5)' : 'rgba(255,255,255,0.2)';
pvRoute.textContent  = route  ? '🛣️ ' + route : 'Route will appear here...';
pvRoute.style.color  = route  ? 'rgba(255,193,7,0.7)' : 'rgba(255,193,7,0.25)';
pvCapLbl.textContent = cap > 0 ? cap + ' seats' : '0 seats';
pvCapBar.style.width = cap > 0 ? Math.min(cap * 100 / 60, 100) + '%' : '0%';
}
</script>
</body>
</html>