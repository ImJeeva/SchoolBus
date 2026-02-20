<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Parent Dashboard - SmartBus</title>
<meta http-equiv="refresh" content="60">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#0a0a1a;color:#fff;display:flex;min-height:100vh;}

/* ===== SIDEBAR ===== */
.sidebar{width:260px;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);border-right:1px solid rgba(66,153,225,0.15);display:flex;flex-direction:column;position:fixed;top:0;left:0;height:100vh;z-index:100;overflow:hidden;}
.sb-brand{padding:28px 24px 24px;border-bottom:1px solid rgba(66,153,225,0.15);position:relative;}
.sb-logo{width:52px;height:52px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:26px;margin-bottom:12px;box-shadow:0 8px 24px rgba(66,153,225,0.4);animation:logoBounce 2s ease-in-out infinite;}
@keyframes logoBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-5px);}}
.sb-title{font-size:22px;font-weight:900;letter-spacing:2px;background:linear-gradient(135deg,#63b3ed,#fff);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.sb-sub{font-size:10px;color:rgba(255,255,255,0.3);letter-spacing:3px;text-transform:uppercase;margin-top:2px;}

.sb-parent{display:flex;align-items:center;gap:12px;padding:12px 20px;margin:16px;background:rgba(66,153,225,0.08);border:1px solid rgba(66,153,225,0.15);border-radius:12px;}
.sb-parent-avatar{width:40px;height:40px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.sb-parent-name{font-size:13px;font-weight:600;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
.sb-parent-role{font-size:10px;color:rgba(255,255,255,0.35);text-transform:uppercase;letter-spacing:1px;}
/* Menu */
.sb-menu{flex:1;padding:20px 0;overflow-y:auto;}
.sb-section{padding:8px 24px 4px;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:rgba(66,153,225,0.4);}
.sb-item{display:flex;align-items:center;gap:14px;padding:13px 24px;color:rgba(255,255,255,0.5);text-decoration:none;font-size:13px;font-weight:500;transition:all 0.3s;border-left:3px solid transparent;position:relative;overflow:hidden;}
.sb-item::before{content:'';position:absolute;top:0;left:0;right:0;bottom:0;background:linear-gradient(90deg,rgba(66,153,225,0.1),transparent);opacity:0;transition:opacity 0.3s;}
.sb-item:hover::before,.sb-item.active::before{opacity:1;}
.sb-item:hover,.sb-item.active{color:#63b3ed;border-left-color:#4299e1;}
.sb-item.active{color:#fff;background:rgba(66,153,225,0.12);}
.sb-ico{font-size:20px;width:26px;text-align:center;flex-shrink:0;}
.sb-item span.label{flex:1;}

/* Footer */
.sb-footer{padding:20px 24px;border-top:1px solid rgba(66,153,225,0.15);}
.sb-logout{display:flex;align-items:center;gap:8px;width:100%;color:rgba(255,100,100,0.7);text-decoration:none;font-size:13px;font-weight:500;padding:10px 14px;border-radius:10px;border:1px solid rgba(255,100,100,0.2);transition:all 0.3s;justify-content:center;}
.sb-logout:hover{color:#ff6b6b;border-color:rgba(255,100,100,0.5);background:rgba(255,100,100,0.08);}

/* ===== MAIN ===== */
.main{margin-left:260px;flex:1;display:flex;flex-direction:column;min-height:100vh;background:linear-gradient(180deg,#0a0a1a 0%,#0d1b3e 60%,#0a0a1a 100%);position:relative;}

/* Animated BG orbs */
.main::before{content:'';position:fixed;width:500px;height:500px;background:radial-gradient(circle,rgba(66,153,225,0.05) 0%,transparent 70%);top:-100px;right:-100px;border-radius:50%;animation:bgPulse 6s ease-in-out infinite;z-index:0;}
.main::after{content:'';position:fixed;width:400px;height:400px;background:radial-gradient(circle,rgba(66,153,225,0.03) 0%,transparent 70%);bottom:-80px;left:-80px;border-radius:50%;animation:bgPulse 6s ease-in-out infinite reverse;z-index:0;}
@keyframes bgPulse{0%,100%{transform:scale(1);}50%{transform:scale(1.2);}}

/* Topbar */
.topbar{position:relative;z-index:10;background:rgba(255,255,255,0.03);backdrop-filter:blur(20px);border-bottom:1px solid rgba(66,153,225,0.1);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:12px;}
.live-clock{display:inline-flex;align-items:center;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);padding:8px 16px;border-radius:10px;font-size:15px;font-weight:700;color:#63b3ed;font-family:monospace;letter-spacing:1.5px;}
.refresh-badge{display:inline-flex;align-items:center;gap:7px;background:rgba(66,153,225,0.1);border:1px solid rgba(66,153,225,0.25);color:#63b3ed;padding:8px 14px;border-radius:20px;font-size:11px;font-weight:600;}
.refresh-dot{width:6px;height:6px;background:#63b3ed;border-radius:50%;animation:rdPulse 1.5s ease-in-out infinite;}
@keyframes rdPulse{0%,100%{box-shadow:0 0 0 0 rgba(66,153,225,0.6);}50%{box-shadow:0 0 0 6px rgba(66,153,225,0);}}

/* Page body */
.page-body{padding:28px 36px;flex:1;position:relative;z-index:5;}

/* Summary cards */
.summary-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:28px;}
.sum-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:16px;padding:18px 20px;display:flex;align-items:center;gap:14px;transition:all 0.3s;}
.sum-card:hover{transform:translateY(-3px);border-color:rgba(66,153,225,0.2);box-shadow:0 8px 24px rgba(0,0,0,0.3);}
.sum-icon{width:42px;height:42px;border-radius:11px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.sum-card.sc-blue .sum-icon{background:rgba(66,153,225,0.15);}
.sum-card.sc-green .sum-icon{background:rgba(72,187,120,0.15);}
.sum-card.sc-yellow .sum-icon{background:rgba(255,193,7,0.15);}
.sum-num{font-size:22px;font-weight:900;line-height:1;}
.sum-card.sc-blue .sum-num{color:#63b3ed;}
.sum-card.sc-green .sum-num{color:#68d391;}
.sum-card.sc-yellow .sum-num{color:#ffc107;}
.sum-lbl{font-size:11px;color:rgba(255,255,255,0.35);margin-top:3px;}

/* Info banner */
.info-banner{background:rgba(66,153,225,0.07);border:1px solid rgba(66,153,225,0.2);border-radius:14px;padding:16px 20px;margin-bottom:24px;display:flex;align-items:center;gap:14px;}
.info-banner-icon{font-size:24px;flex-shrink:0;}
.info-banner-text{font-size:12px;color:rgba(255,255,255,0.45);line-height:1.6;}
.info-banner-text strong{color:#63b3ed;}

/* Child cards */
.child-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:20px;margin-bottom:24px;overflow:hidden;transition:all 0.3s;animation:cardIn 0.4s ease;}
@keyframes cardIn{from{opacity:0;transform:translateY(10px);}to{opacity:1;transform:translateY(0);}}
.child-card:hover{border-color:rgba(66,153,225,0.2);box-shadow:0 8px 32px rgba(0,0,0,0.3);}
.child-card.status-boarding{border-left:4px solid #68d391;}
.child-card.status-dropoff{border-left:4px solid #63b3ed;}
.child-card.status-none{border-left:4px solid rgba(255,255,255,0.1);}

.cc-head{padding:20px 24px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;gap:16px;}
.cc-name{font-size:18px;font-weight:800;color:#fff;}
.cc-class{font-size:12px;color:rgba(255,255,255,0.4);margin-top:3px;}

.status-badge{display:inline-flex;align-items:center;gap:8px;padding:10px 18px;border-radius:20px;font-size:13px;font-weight:800;white-space:nowrap;}
.sb-onbus{background:rgba(72,187,120,0.15);border:1px solid rgba(72,187,120,0.35);color:#68d391;box-shadow:0 4px 16px rgba(72,187,120,0.15);}
.sb-dropped{background:rgba(66,153,225,0.15);border:1px solid rgba(66,153,225,0.35);color:#63b3ed;box-shadow:0 4px 16px rgba(66,153,225,0.15);}
.sb-none{background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:rgba(255,255,255,0.4);}
.status-pulse{width:8px;height:8px;border-radius:50%;flex-shrink:0;}
.sb-onbus .status-pulse{background:#68d391;animation:rdPulse 1.5s infinite;}
.sb-dropped .status-pulse{background:#63b3ed;}
.sb-none .status-pulse{background:rgba(255,255,255,0.3);}

.cc-body{padding:20px 24px;display:grid;grid-template-columns:repeat(3,1fr);gap:16px;}
.info-mini{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.06);border-radius:12px;padding:14px 16px;transition:all 0.3s;}
.info-mini:hover{border-color:rgba(66,153,225,0.2);background:rgba(66,153,225,0.04);}
.info-label{font-size:10px;font-weight:700;color:rgba(255,255,255,0.25);text-transform:uppercase;letter-spacing:1.5px;margin-bottom:8px;}
.info-val{font-size:13px;font-weight:700;color:#fff;}
.info-val.empty{color:rgba(255,255,255,0.2);font-style:italic;font-weight:400;}

.cc-foot{padding:14px 24px;background:rgba(0,0,0,0.15);border-top:1px solid rgba(255,255,255,0.05);display:flex;align-items:center;justify-content:space-between;}
.cc-foot-note{font-size:11px;color:rgba(255,255,255,0.25);}
.btn-history{display:inline-flex;align-items:center;gap:8px;padding:9px 18px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:10px;color:#fff;font-size:12px;font-weight:800;text-decoration:none;transition:all 0.3s;box-shadow:0 4px 14px rgba(66,153,225,0.3);}
.btn-history:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(66,153,225,0.45);}

/* Empty state */
.empty-state{text-align:center;padding:72px 32px;}
.empty-icon{font-size:64px;display:block;margin-bottom:18px;animation:emptyBounce 2s ease-in-out infinite;}
@keyframes emptyBounce{0%,100%{transform:translateY(0);}50%{transform:translateY(-10px);}}
.empty-title{font-size:20px;font-weight:700;color:rgba(255,255,255,0.4);margin-bottom:8px;}
.empty-sub{font-size:13px;color:rgba(255,255,255,0.2);}

/* Bus tracker */
.bus-tracker{background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.05);border-radius:16px;padding:18px 24px;margin-top:8px;overflow:hidden;}
.bt-label{font-size:11px;color:rgba(255,255,255,0.25);text-transform:uppercase;letter-spacing:2px;margin-bottom:12px;}
.bt-road{background:#0d1117;border-radius:8px;height:36px;position:relative;overflow:hidden;}
.bt-grass-top{position:absolute;top:0;left:0;right:0;height:5px;background:linear-gradient(90deg,#1a4a2e,#22543d,#1a4a2e);}
.bt-grass-bot{position:absolute;bottom:0;left:0;right:0;height:5px;background:linear-gradient(90deg,#1a4a2e,#22543d,#1a4a2e);}
.bt-dashes{position:absolute;top:50%;left:0;width:100%;height:2px;margin-top:-1px;background:repeating-linear-gradient(90deg,rgba(66,153,225,0.6) 0px,rgba(66,153,225,0.6) 20px,transparent 20px,transparent 40px);animation:dashMove 0.6s linear infinite;}
@keyframes dashMove{from{background-position:0 0;}to{background-position:-40px 0;}}
.bt-bus{position:absolute;top:50%;transform:translateY(-50%);animation:busMove 5s linear infinite;font-size:24px;}
@keyframes busMove{0%{left:-60px;opacity:0;}5%{opacity:1;}90%{opacity:1;}100%{left:110%;opacity:0;}}

/* Scrollbar */
::-webkit-scrollbar{width:4px;}
::-webkit-scrollbar-track{background:transparent;}
::-webkit-scrollbar-thumb{background:rgba(66,153,225,0.3);border-radius:4px;}
</style>
</head>
<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">

<!-- Brand -->
<div class="sb-brand">
<div class="sb-logo">👨‍👩‍👧</div>
<div class="sb-title">SMARTBUS</div>
<div class="sb-sub">Parent Portal</div>
</div>

<!-- Parent info card -->
<!-- Parent info -->
<div class="sb-parent">
<div class="sb-parent-avatar">👤</div>
<div>
<div class="sb-parent-name">${parent.name}</div>
<div class="sb-parent-role">Parent</div>
</div>
</div>

<!-- Menu -->
<div class="sb-menu">
<div class="sb-section">Main</div>
<a href="${pageContext.request.contextPath}/parent/dashboard" class="sb-item active">
<span class="sb-ico">🏠</span><span class="label">Dashboard</span>
</a>
<a href="${pageContext.request.contextPath}/parent/attendance" class="sb-item active"><span class="sb-ico">📋</span><span class="label">Attendance History</span>
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

<!-- Footer -->
<div class="sb-footer">
<a href="${pageContext.request.contextPath}/parent/logout" class="sb-logout">
🚪 Logout
</a>
</div>

</div>

<!-- ===== MAIN ===== -->
<div class="main">

<!-- Topbar -->
<div class="topbar">
<div class="topbar-left">
<h1>🎒 Your Children's Bus Status</h1>
<p>Real-time boarding and drop-off information</p>
</div>
<div class="topbar-right">
<div class="refresh-badge"><div class="refresh-dot"></div>Auto-refresh: 60s</div>
<div class="live-clock" id="liveClock">--:-- --</div>
</div>
</div>

<!-- Page body -->
<div class="page-body">

<!-- Summary cards -->
<div class="summary-grid">
<div class="sum-card sc-blue">
<div class="sum-icon">🎒</div>
<div>
<div class="sum-num">${children.size()}</div>
<div class="sum-lbl">Total Children</div>
</div>
</div>
<div class="sum-card sc-green">
<div class="sum-icon">🟢</div>
<div>
<div class="sum-num">
<c:set var="onBus" value="0"/>
<c:forEach var="c" items="${children}">
<c:if test="${not empty c.lastEvent && c.lastEvent.eventType=='BOARDING'}">
<c:set var="onBus" value="${onBus+1}"/>
</c:if>
</c:forEach>
${onBus}
</div>
<div class="sum-lbl">On Bus Now</div>
</div>
</div>
<div class="sum-card sc-yellow">
<div class="sum-icon">🔵</div>
<div>
<div class="sum-num">
<c:set var="dropped" value="0"/>
<c:forEach var="c" items="${children}">
<c:if test="${not empty c.lastEvent && c.lastEvent.eventType=='DROPOFF'}">
<c:set var="dropped" value="${dropped+1}"/>
</c:if>
</c:forEach>
${dropped}
</div>
<div class="sum-lbl">Dropped Off</div>
</div>
</div>
</div>

<!-- Info banner -->
<div class="info-banner">
<div class="info-banner-icon">📧</div>
<div class="info-banner-text">
You receive <strong>instant email alerts</strong> every time your child boards or exits the bus. Check <strong>${parent.email}</strong> for notifications.
</div>
</div>

<!-- Empty state -->
<c:if test="${empty children}">
<div class="empty-state">
<span class="empty-icon">🎒</span>
<div class="empty-title">No children assigned yet</div>
<div class="empty-sub">Contact the school admin to link your children to your account</div>
</div>
</c:if>

<!-- Children cards -->
<c:forEach var="child" items="${children}" varStatus="cs">
<div class="child-card <c:choose><c:when test="${not empty child.lastEvent && child.lastEvent.eventType=='BOARDING'}">status-boarding</c:when><c:when test="${not empty child.lastEvent && child.lastEvent.eventType=='DROPOFF'}">status-dropoff</c:when><c:otherwise>status-none</c:otherwise></c:choose>" style="animation-delay:${cs.index*0.1}s">

<div class="cc-head">
<div>
<div class="cc-name">🎒 ${child.name}</div>
<div class="cc-class">Class ${child.className} — ${child.section} • QR: ${child.qrCode}</div>
</div>
<c:choose>
<c:when test="${not empty child.lastEvent && child.lastEvent.eventType=='BOARDING'}">
<span class="status-badge sb-onbus"><div class="status-pulse"></div>🟢 ON BUS</span>
</c:when>
<c:when test="${not empty child.lastEvent && child.lastEvent.eventType=='DROPOFF'}">
<span class="status-badge sb-dropped"><div class="status-pulse"></div>🔵 DROPPED OFF</span>
</c:when>
<c:otherwise>
<span class="status-badge sb-none"><div class="status-pulse"></div>⚪ No Scan Today</span>
</c:otherwise>
</c:choose>
</div>

<div class="cc-body">
<div class="info-mini">
<div class="info-label">🚌 Bus Number</div>
<div class="info-val">
<c:choose>
<c:when test="${not empty child.bus}">🚌 ${child.bus.busNumber}</c:when>
<c:otherwise><span class="empty">Not assigned</span></c:otherwise>
</c:choose>
</div>
</div>
<div class="info-mini">
<div class="info-label">👨‍✈️ Driver</div>
<div class="info-val">
<c:choose>
<c:when test="${not empty child.bus}">👨‍✈️ ${child.bus.driverName}</c:when>
<c:otherwise><span class="empty">—</span></c:otherwise>
</c:choose>
</div>
</div>
<div class="info-mini">
<div class="info-label">🕐 Last Scan</div>
<div class="info-val">
<c:choose>
<c:when test="${not empty child.lastEvent}">
<div>
<div>🕐 <fmt:formatDate value="${child.lastEvent.scanTime}" pattern="hh:mm a"/></div>
<div style="font-size:10px;color:rgba(255,255,255,0.35);margin-top:2px;"><fmt:formatDate value="${child.lastEvent.scanTime}" pattern="dd MMM yyyy"/></div>
</div>
</c:when>
<c:otherwise><span class="empty">No scan yet</span></c:otherwise>
</c:choose>
</div>
</div>
</div>

<div class="cc-foot">
<span class="cc-foot-note">
<c:choose>
<c:when test="${not empty child.lastEvent}">
Last: <c:choose><c:when test="${child.lastEvent.eventType=='BOARDING'}">🟢 Boarded</c:when><c:otherwise>🔵 Dropped off</c:otherwise></c:choose> • Email sent ✉️
</c:when>
<c:otherwise>⏳ Waiting for driver scan...</c:otherwise>
</c:choose>
</span>
<a href="${pageContext.request.contextPath}/attendance/student/${child.studentId}" class="btn-history">📋 Full History</a>
</div>

</div>
</c:forEach>

<!-- Bus tracker -->
<div class="bus-tracker">
<div class="bt-label">🚌 Live Bus Tracker</div>
<div class="bt-road">
<div class="bt-grass-top"></div>
<div class="bt-dashes"></div>
<div class="bt-bus">🚌</div>
<div class="bt-grass-bot"></div>
</div>
</div>

</div>
</div>

<script>
function updateClock(){
var now=new Date();
var h=now.getHours(),m=now.getMinutes(),s=now.getSeconds();
var ampm=h>=12?'PM':'AM';
h=h%12;h=h?h:12;
document.getElementById('liveClock').textContent=(h<10?'0':'')+h+':'+(m<10?'0':'')+m+':'+(s<10?'0':'')+s+' '+ampm;
}
updateClock();
setInterval(updateClock,1000);
</script>
</body>
</html>