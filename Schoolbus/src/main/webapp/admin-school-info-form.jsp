<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>School Info - SmartBus</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#0a0a1a;color:#fff;display:flex;min-height:100vh;}

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
.topbar{background:rgba(255,255,255,0.03);backdrop-filter:blur(10px);border-bottom:1px solid rgba(255,255,255,0.05);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}

/* Page body */
.page-body{padding:32px 36px;flex:1;}

/* Success message */
.success-msg{background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.3);border-radius:12px;padding:14px 18px;color:#68d391;font-size:13px;margin-bottom:24px;display:flex;align-items:center;gap:10px;animation:slideDown 0.4s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}

/* Form card */
.form-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:32px;max-width:900px;animation:fadeIn 0.4s ease;}
@keyframes fadeIn{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}

.form-section-title{font-size:11px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:20px;padding-bottom:14px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;gap:8px;}

.form-group{margin-bottom:20px;}
.form-group label{display:flex;align-items:center;gap:7px;color:rgba(255,255,255,0.55);font-size:11px;font-weight:600;letter-spacing:0.8px;text-transform:uppercase;margin-bottom:9px;}
.req{color:#fc8181;}

.input-wrap{position:relative;}
.input-wrap input,.input-wrap textarea{width:100%;padding:13px 16px 13px 44px;background:rgba(255,255,255,0.05);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;resize:vertical;}
.input-wrap textarea{padding-top:13px;min-height:100px;}
.input-wrap input::placeholder,.input-wrap textarea::placeholder{color:rgba(255,255,255,0.2);}
.input-wrap input:focus,.input-wrap textarea:focus{border-color:rgba(255,193,7,0.5);background:rgba(255,193,7,0.04);box-shadow:0 0 0 4px rgba(255,193,7,0.07);}
.input-wrap .i-icon{position:absolute;left:14px;top:14px;font-size:16px;pointer-events:none;}

.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}

.form-actions{display:flex;gap:12px;margin-top:8px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);}
.btn-submit{display:inline-flex;align-items:center;gap:10px;padding:13px 28px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-submit::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-submit:hover::before{left:100%;}
.btn-submit:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}

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
<a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-item">
<span class="sb-ico">📊</span><span class="label">Dashboard</span>
</a>
<div class="sb-section">Manage</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item">
<span class="sb-ico">🎒</span><span class="label">Students</span>
</a>
<a href="${pageContext.request.contextPath}/admin/parent/list" class="sb-item">
<span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span>
</a>
<a href="${pageContext.request.contextPath}/admin/bus/list" class="sb-item">
<span class="sb-ico">🚌</span><span class="label">Buses</span>
</a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list" class="sb-item">
<span class="sb-ico">📋</span><span class="label">Attendance Log</span>
</a>
<div class="sb-section">Settings</div>
<a href="${pageContext.request.contextPath}/admin/school-info" class="sb-item active">
<span class="sb-ico">🏫</span><span class="label">School Info</span>
</a>
<div class="sb-section">Driver</div>
<a href="${pageContext.request.contextPath}/attendance/scan-page" class="sb-item">
<span class="sb-ico">📷</span><span class="label">QR Scan Page</span>
</a>
</div>
<div class="sb-footer">
<div class="sb-admin">
<div class="sb-avatar">👨‍💼</div>
<div>
<div class="sb-admin-name">Administrator</div>
<div class="sb-admin-role">System Admin</div>
</div>
</div>
<a href="${pageContext.request.contextPath}/admin/logout" class="sb-logout">🚪 Logout</a>
</div>
</div>

<!-- ===== MAIN ===== -->
<div class="main">
<div class="topbar">
<div class="topbar-left">
<h1>🏫 School Information Settings</h1>
<p>Update school details shown to parents</p>
</div>
</div>

<div class="page-body">

<c:if test="${not empty success}">
<div class="success-msg">✅ ${success}</div>
</c:if>

<div class="form-card">
<form action="${pageContext.request.contextPath}/admin/school-info/save" method="post">
<input type="hidden" name="infoId" value="${schoolInfo.infoId}"/>

<div class="form-section-title">🏫 Basic Information</div>

<div class="form-group">
<label>🏫 School Name <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">🏫</span>
<input type="text" name="schoolName" value="${schoolInfo.schoolName}" placeholder="e.g. SmartBus School" required/>
</div>
</div>

<div class="form-group">
<label>📍 Address</label>
<div class="input-wrap">
<span class="i-icon">📍</span>
<textarea name="address" placeholder="Enter complete school address...">${schoolInfo.address}</textarea>
</div>
</div>

<div class="form-section-title" style="margin-top:8px;">📞 Contact Details</div>

<div class="form-row">
<div class="form-group">
<label>📞 Phone Number</label>
<div class="input-wrap">
<span class="i-icon">📱</span>
<input type="text" name="phone" value="${schoolInfo.phone}" placeholder="+91-9876543210"/>
</div>
</div>
<div class="form-group">
<label>✉️ Email Address</label>
<div class="input-wrap">
<span class="i-icon">✉️</span>
<input type="email" name="email" value="${schoolInfo.email}" placeholder="info@school.edu"/>
</div>
</div>
</div>

<div class="form-section-title" style="margin-top:8px;">👔 Administration</div>

<div class="form-row">
<div class="form-group">
<label>👤 Principal Name</label>
<div class="input-wrap">
<span class="i-icon">👤</span>
<input type="text" name="principalName" value="${schoolInfo.principalName}" placeholder="e.g. Dr. Principal Name"/>
</div>
</div>
<div class="form-group">
<label>🕐 School Timings</label>
<div class="input-wrap">
<span class="i-icon">🕐</span>
<input type="text" name="schoolTimings" value="${schoolInfo.schoolTimings}" placeholder="e.g. 8:00 AM - 3:00 PM"/>
</div>
</div>
</div>

<div class="form-actions">
<button type="submit" class="btn-submit">💾 Save School Information</button>
</div>

</form>
</div>

</div>
</div>

</body>
</html>