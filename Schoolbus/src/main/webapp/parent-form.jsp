<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Parent Form - SmartBus</title>
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

/* Info note */
.info-note{display:flex;align-items:flex-start;gap:14px;background:rgba(66,153,225,0.07);border:1px solid rgba(66,153,225,0.2);border-radius:14px;padding:16px 20px;margin-bottom:28px;animation:fadeIn 0.5s ease;}
@keyframes fadeIn{from{opacity:0;transform:translateY(-8px);}to{opacity:1;transform:translateY(0);}}
.info-note-icon{font-size:26px;flex-shrink:0;}
.info-note-text h4{font-size:13px;font-weight:700;color:#63b3ed;}
.info-note-text p{font-size:12px;color:rgba(99,179,237,0.6);margin-top:3px;line-height:1.6;}

/* ===== FORM LAYOUT ===== */
.form-layout{display:grid;grid-template-columns:1fr 280px;gap:24px;align-items:start;}

/* ===== FORM CARD ===== */
.form-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:32px;animation:fadeIn 0.4s ease;}
.form-section-title{font-size:11px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:20px;padding-bottom:14px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;gap:8px;}

/* Form groups */
.form-group{margin-bottom:20px;}
.form-group label{display:flex;align-items:center;gap:7px;color:rgba(255,255,255,0.55);font-size:11px;font-weight:600;letter-spacing:0.8px;text-transform:uppercase;margin-bottom:9px;}
.req{color:#fc8181;}

/* Input wrap */
.input-wrap{position:relative;}
.input-wrap input,.input-wrap textarea{width:100%;padding:13px 16px 13px 44px;background:rgba(255,255,255,0.05);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;resize:vertical;}
.input-wrap textarea{padding-top:13px;min-height:90px;}
.input-wrap input::placeholder,.input-wrap textarea::placeholder{color:rgba(255,255,255,0.2);}
.input-wrap input:focus,.input-wrap textarea:focus{border-color:rgba(66,153,225,0.5);background:rgba(66,153,225,0.04);box-shadow:0 0 0 4px rgba(66,153,225,0.07);}
.input-wrap .i-icon{position:absolute;left:14px;top:14px;font-size:16px;pointer-events:none;}

/* Two col */
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}

/* Password hint */
.pw-hint{font-size:11px;color:rgba(255,255,255,0.25);margin-top:6px;display:flex;align-items:center;gap:5px;}

/* Form actions */
.form-actions{display:flex;gap:12px;margin-top:8px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);}
.btn-submit{display:inline-flex;align-items:center;gap:10px;padding:13px 28px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-submit::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-submit:hover::before{left:100%;}
.btn-submit:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}
.btn-cancel{display:inline-flex;align-items:center;gap:8px;padding:13px 20px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.1);border-radius:12px;color:rgba(255,255,255,0.5);font-size:14px;font-weight:500;text-decoration:none;transition:all 0.3s;}
.btn-cancel:hover{border-color:rgba(245,101,101,0.4);color:#fc8181;background:rgba(245,101,101,0.05);}

/* ===== RIGHT PREVIEW CARD ===== */
.preview-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:24px;position:sticky;top:100px;animation:fadeIn 0.5s ease;}
.preview-title{font-size:11px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:18px;}

/* Parent profile card */
.profile-card{background:linear-gradient(135deg,#1a1a2e,#0d1b3e);border:1px solid rgba(66,153,225,0.2);border-radius:16px;padding:20px;text-align:center;position:relative;overflow:hidden;}
.profile-card::before{content:'';position:absolute;top:-20px;right:-20px;width:90px;height:90px;background:radial-gradient(circle,rgba(66,153,225,0.08),transparent);border-radius:50%;}
.profile-avatar{width:64px;height:64px;background:linear-gradient(135deg,rgba(66,153,225,0.3),rgba(66,153,225,0.1));border:2px solid rgba(66,153,225,0.3);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:30px;margin:0 auto 14px;}
.pv-name{font-size:16px;font-weight:800;color:#fff;margin-bottom:4px;min-height:24px;}
.pv-phone{font-size:12px;color:rgba(255,255,255,0.4);margin-bottom:14px;min-height:18px;font-family:monospace;}

/* Info rows in preview */
.pv-row{display:flex;align-items:center;gap:10px;background:rgba(255,255,255,0.04);border-radius:8px;padding:9px 12px;margin-bottom:8px;text-align:left;}
.pv-row:last-child{margin-bottom:0;}
.pv-row-icon{font-size:14px;flex-shrink:0;}
.pv-row-text{font-size:11px;color:rgba(255,255,255,0.45);word-break:break-all;min-height:16px;}

/* Email alert badge */
.alert-badge{display:inline-flex;align-items:center;gap:6px;background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.2);color:#68d391;padding:6px 14px;border-radius:20px;font-size:11px;font-weight:700;margin-top:12px;}

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
<a href="${pageContext.request.contextPath}/admin/parent/list"  class="sb-item active"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/list"     class="sb-item"><span class="sb-ico">🚌</span><span class="label">Buses</span></a>
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
<c:when test="${parent.parentId == 0}">➕ Add New Parent</c:when>
<c:otherwise>✏️ Edit Parent</c:otherwise>
</c:choose>
</h1>
<p>Fill in the parent details — email is used for student boarding alerts</p>
</div>
<a href="${pageContext.request.contextPath}/admin/parent/list" class="btn-back">← Back to Parents</a>
</div>

<div class="page-body">

<!-- Info note -->
<div class="info-note">
<div class="info-note-icon">📧</div>
<div class="info-note-text">
<h4>Email Alert System</h4>
<p>Parent's email will receive instant alerts when their child boards or exits the bus. Phone must include country code e.g. +919876543210</p>
</div>
</div>

<!-- Two column layout -->
<div class="form-layout">

<!-- LEFT: FORM -->
<div class="form-card">

<c:choose>
<c:when test="${parent.parentId == 0}">
<form action="${pageContext.request.contextPath}/admin/parent/save" method="post" id="parentForm">
</c:when>
<c:otherwise>
<form action="${pageContext.request.contextPath}/admin/parent/update" method="post" id="parentForm">
<input type="hidden" name="parentId" value="${parent.parentId}"/>
</c:otherwise>
</c:choose>

<!-- Personal Info -->
<div class="form-section-title">👤 Personal Information</div>
<div class="form-row">
<div class="form-group">
<label>👤 Full Name <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">👨‍👩‍👧</span>
<input type="text" name="name" id="inName" value="${parent.name}" placeholder="e.g. Suresh Kumar" required onkeyup="updatePreview()"/>
</div>
</div>
<div class="form-group">
<label>📞 Phone <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">📱</span>
<input type="text" name="phone" id="inPhone" value="${parent.phone}" placeholder="+919876543210" required onkeyup="updatePreview()"/>
</div>
</div>
</div>

<!-- Login Info -->
<div class="form-section-title" style="margin-top:8px;">🔐 Login Credentials</div>
<div class="form-row">
<div class="form-group">
<label>✉️ Email <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">✉️</span>
<input type="email" name="email" id="inEmail" value="${parent.email}" placeholder="parent@email.com" required onkeyup="updatePreview()"/>
</div>
</div>
<div class="form-group">
<label>🔒 Password <span class="req">*</span></label>
<div class="input-wrap">
<span class="i-icon">🔑</span>
<input type="password" name="password" value="${parent.password}" placeholder="Set login password" required/>
</div>
<c:if test="${parent.parentId != 0}">
<div class="pw-hint">ℹ️ Leave blank to keep existing password</div>
</c:if>
</div>
</div>

<!-- Address -->
<div class="form-section-title" style="margin-top:8px;">🏠 Address</div>
<div class="form-group">
<label>📍 Home Address</label>
<div class="input-wrap">
<span class="i-icon">🏠</span>
<textarea name="address" id="inAddress" placeholder="Enter home address..." onkeyup="updatePreview()">${parent.address}</textarea>
</div>
</div>

<!-- Actions -->
<div class="form-actions">
<button type="submit" class="btn-submit">
<c:choose>
<c:when test="${parent.parentId == 0}">🚀 Save Parent</c:when>
<c:otherwise>✅ Update Parent</c:otherwise>
</c:choose>
</button>
<a href="${pageContext.request.contextPath}/admin/parent/list" class="btn-cancel">✕ Cancel</a>
</div>

</form>
</div>

<!-- RIGHT: PREVIEW -->
<div>
<div class="preview-card">
<div class="preview-title">👁️ Live Preview</div>

<div class="profile-card">
<div class="profile-avatar">👤</div>
<div class="pv-name" id="pvName">
<c:choose>
<c:when test="${not empty parent.name}">${parent.name}</c:when>
<c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:13px;">Parent Name</span></c:otherwise>
</c:choose>
</div>
<div class="pv-phone" id="pvPhone">
<c:choose>
<c:when test="${not empty parent.phone}">📞 ${parent.phone}</c:when>
<c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:11px;">Phone Number</span></c:otherwise>
</c:choose>
</div>

<div class="pv-row">
<span class="pv-row-icon">✉️</span>
<span class="pv-row-text" id="pvEmail">
<c:choose>
<c:when test="${not empty parent.email}">${parent.email}</c:when>
<c:otherwise>email@example.com</c:otherwise>
</c:choose>
</span>
</div>

<div class="pv-row">
<span class="pv-row-icon">📍</span>
<span class="pv-row-text" id="pvAddr">
<c:choose>
<c:when test="${not empty parent.address}">${parent.address}</c:when>
<c:otherwise>Address will appear here</c:otherwise>
</c:choose>
</span>
</div>

<div class="alert-badge">✉️ Will receive boarding alerts</div>
</div>

<!-- Tips -->
<div class="tips-box">
<div class="tips-title">💡 Quick Tips</div>
<div class="tip-item"><span class="tip-dot">✓</span>Email must be valid — alerts go here</div>
<div class="tip-item"><span class="tip-dot">✓</span>Phone with country code for SMS</div>
<div class="tip-item"><span class="tip-dot">✓</span>Parent uses email+password to login</div>
<div class="tip-item"><span class="tip-dot">✓</span>Assign children after saving parent</div>
</div>

</div>
</div>

</div>
</div>
</div>
</div>

<script>
function updatePreview(){
var name  = document.getElementById('inName').value;
var phone = document.getElementById('inPhone').value;
var email = document.getElementById('inEmail').value;
var addr  = document.getElementById('inAddress').value;

var pvName  = document.getElementById('pvName');
var pvPhone = document.getElementById('pvPhone');
var pvEmail = document.getElementById('pvEmail');
var pvAddr  = document.getElementById('pvAddr');

pvName.textContent  = name  || 'Parent Name';
pvName.style.color  = name  ? '#fff' : 'rgba(255,255,255,0.2)';
pvPhone.textContent = phone ? '📞 ' + phone : 'Phone Number';
pvPhone.style.color = phone ? 'rgba(255,255,255,0.4)' : 'rgba(255,255,255,0.2)';
pvEmail.textContent = email || 'email@example.com';
pvEmail.style.color = email ? 'rgba(255,255,255,0.45)' : 'rgba(255,255,255,0.2)';
pvAddr.textContent  = addr  || 'Address will appear here';
pvAddr.style.color  = addr  ? 'rgba(255,255,255,0.45)' : 'rgba(255,255,255,0.2)';
}
</script>
</body>
</html>