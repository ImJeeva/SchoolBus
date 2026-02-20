<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Student Form - SmartBus</title>
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

/* Topbar */
.topbar{background:rgba(255,255,255,0.03);border-bottom:1px solid rgba(255,255,255,0.05);padding:20px 36px;display:flex;align-items:center;justify-content:space-between;backdrop-filter:blur(10px);position:sticky;top:0;z-index:50;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}
.btn-back{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;color:rgba(255,255,255,0.6);font-size:13px;font-weight:500;text-decoration:none;transition:all 0.3s;}
.btn-back:hover{border-color:rgba(255,193,7,0.4);color:#ffc107;background:rgba(255,193,7,0.05);}

/* ===== PAGE BODY ===== */
.page-body{padding:32px 36px;flex:1;}

/* ===== QR INFO NOTE ===== */
.info-note{display:flex;align-items:center;gap:14px;background:rgba(255,193,7,0.07);border:1px solid rgba(255,193,7,0.2);border-radius:14px;padding:16px 20px;margin-bottom:28px;animation:fadeSlideIn 0.5s ease;}
@keyframes fadeSlideIn{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}
.info-note-icon{font-size:28px;flex-shrink:0;}
.info-note-text h4{font-size:13px;font-weight:700;color:#ffc107;}
.info-note-text p{font-size:12px;color:rgba(255,193,7,0.6);margin-top:2px;}

/* ===== FORM LAYOUT ===== */
.form-layout{display:grid;grid-template-columns:1fr 300px;gap:24px;align-items:start;}

/* ===== FORM CARD ===== */
.form-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:32px;animation:fadeSlideIn 0.4s ease;}

.form-card-title{font-size:14px;font-weight:700;color:rgba(255,255,255,0.5);text-transform:uppercase;letter-spacing:2px;margin-bottom:24px;padding-bottom:16px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;gap:10px;}

/* Form groups */
.form-group{margin-bottom:22px;}
.form-group label{display:flex;align-items:center;gap:8px;color:rgba(255,255,255,0.6);font-size:12px;font-weight:600;letter-spacing:0.8px;text-transform:uppercase;margin-bottom:10px;}
.label-icon{font-size:14px;}
.required-star{color:#fc8181;font-size:14px;}

/* Inputs */
.form-group input,.form-group select{width:100%;padding:13px 16px;background:rgba(255,255,255,0.05);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;appearance:none;}
.form-group input::placeholder{color:rgba(255,255,255,0.2);}
.form-group select option{background:#0d1b3e;color:#fff;}
.form-group input:focus,.form-group select:focus{border-color:rgba(255,193,7,0.5);background:rgba(255,193,7,0.05);box-shadow:0 0 0 4px rgba(255,193,7,0.08);}

/* Input with icon wrapper */
.input-wrap{position:relative;}
.input-wrap input,.input-wrap select{padding-left:44px;}
.input-wrap .i-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);font-size:16px;pointer-events:none;}

/* Two column row */
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}

/* QR display box */
.qr-box{background:rgba(255,193,7,0.05);border:1px solid rgba(255,193,7,0.2);border-radius:12px;padding:14px 16px;display:flex;align-items:center;gap:12px;}
.qr-box-icon{font-size:24px;}
.qr-box-text{font-family:monospace;font-size:13px;font-weight:700;color:#ffc107;letter-spacing:1px;}
.qr-box-label{font-size:10px;color:rgba(255,193,7,0.4);text-transform:uppercase;letter-spacing:1px;margin-top:2px;}

/* Form actions */
.form-actions{display:flex;gap:12px;margin-top:8px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);}
.btn-submit{display:inline-flex;align-items:center;gap:10px;padding:13px 28px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-submit::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-submit:hover::before{left:100%;}
.btn-submit:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}
.btn-cancel{display:inline-flex;align-items:center;gap:8px;padding:13px 20px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.1);border-radius:12px;color:rgba(255,255,255,0.5);font-size:14px;font-weight:500;text-decoration:none;transition:all 0.3s;}
.btn-cancel:hover{border-color:rgba(245,101,101,0.4);color:#fc8181;background:rgba(245,101,101,0.05);}

/* ===== RIGHT SIDE PANEL — Preview Card ===== */
.preview-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:24px;animation:fadeSlideIn 0.5s ease;position:sticky;top:100px;}
.preview-title{font-size:12px;font-weight:700;color:rgba(255,255,255,0.3);text-transform:uppercase;letter-spacing:2px;margin-bottom:20px;}

/* Student ID card preview */
.id-card{background:linear-gradient(135deg,#1a1a2e,#0d1b3e);border:1px solid rgba(255,193,7,0.2);border-radius:16px;padding:20px;text-align:center;position:relative;overflow:hidden;}
.id-card::before{content:'';position:absolute;top:-30px;right:-30px;width:100px;height:100px;background:radial-gradient(circle,rgba(255,193,7,0.1),transparent);border-radius:50%;}
.id-card-logo{width:44px;height:44px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:22px;margin:0 auto 12px;box-shadow:0 6px 16px rgba(255,193,7,0.3);}
.id-school{font-size:10px;font-weight:700;color:rgba(255,255,255,0.4);text-transform:uppercase;letter-spacing:2px;margin-bottom:16px;}
.id-avatar{width:60px;height:60px;background:linear-gradient(135deg,rgba(255,193,7,0.2),rgba(255,107,0,0.1));border:2px solid rgba(255,193,7,0.3);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;}
.id-name{font-size:15px;font-weight:800;color:#fff;margin-bottom:4px;min-height:22px;}
.id-class{font-size:11px;color:rgba(255,255,255,0.4);margin-bottom:16px;min-height:16px;}
.id-qr-area{background:rgba(0,0,0,0.3);border-radius:10px;padding:12px;margin-bottom:12px;}
.id-qr-placeholder{width:70px;height:70px;background:rgba(255,255,255,0.05);border:1px dashed rgba(255,193,7,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 6px;}
.id-qr-text{font-size:9px;color:rgba(255,255,255,0.3);font-family:monospace;}
.id-footer{font-size:9px;color:rgba(255,193,7,0.4);text-transform:uppercase;letter-spacing:1px;}

/* Tips section */
.tips-box{margin-top:16px;background:rgba(72,187,120,0.06);border:1px solid rgba(72,187,120,0.15);border-radius:12px;padding:16px;}
.tips-title{font-size:11px;font-weight:700;color:#68d391;text-transform:uppercase;letter-spacing:1px;margin-bottom:10px;}
.tip-item{display:flex;align-items:flex-start;gap:8px;margin-bottom:8px;font-size:11px;color:rgba(255,255,255,0.4);line-height:1.5;}
.tip-item:last-child{margin-bottom:0;}
.tip-dot{color:#68d391;flex-shrink:0;margin-top:1px;}

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
<a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-item"><span class="sb-ico">📊</span><span class="label">Dashboard</span></a>
<div class="sb-section">Manage</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item active"><span class="sb-ico">🎒</span><span class="label">Students</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/list"  class="sb-item"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span></a>
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

<!-- Topbar -->
<div class="topbar">
<div class="topbar-left">
<h1>
<c:choose>
<c:when test="${student.studentId == 0}">➕ Add New Student</c:when>
<c:otherwise>✏️ Edit Student</c:otherwise>
</c:choose>
</h1>
<p>Fill in the details below — QR code is auto-generated after save</p>
</div>
<a href="${pageContext.request.contextPath}/admin/student/list" class="btn-back">← Back to Students</a>
</div>

<div class="page-body">

<!-- Info note for new student -->
<c:if test="${student.studentId == 0}">
<div class="info-note">
<div class="info-note-icon">🤖</div>
<div class="info-note-text">
<h4>Auto QR Generation</h4>
<p>A unique QR code will be automatically created after saving. You can print it from the student list.</p>
</div>
</div>
</c:if>

<!-- Two column layout: Form + Preview -->
<div class="form-layout">

<!-- LEFT: FORM CARD -->
<div class="form-card">
<div class="form-card-title">📝 Student Information</div>

<c:choose>
<c:when test="${student.studentId == 0}">
<form action="${pageContext.request.contextPath}/admin/student/save" method="post" id="studentForm">
</c:when>
<c:otherwise>
<form action="${pageContext.request.contextPath}/admin/student/update" method="post" id="studentForm">
<input type="hidden" name="studentId" value="${student.studentId}"/>
<input type="hidden" name="qrCode"    value="${student.qrCode}"/>
</c:otherwise>
</c:choose>

<!-- Student Name -->
<div class="form-group">
<label><span class="label-icon">👤</span> Student Full Name <span class="required-star">*</span></label>
<div class="input-wrap">
<span class="i-icon">🎒</span>
<input type="text" name="name" id="inputName" value="${student.name}" placeholder="e.g. Ravi Kumar" required onkeyup="updatePreview()"/>
</div>
</div>

<!-- Class + Section row -->
<div class="form-row">
<div class="form-group">
<label><span class="label-icon">🏫</span> Class <span class="required-star">*</span></label>
<div class="input-wrap">
<span class="i-icon">📚</span>
<input type="text" name="className" id="inputClass" value="${student.className}" placeholder="e.g. 6" required onkeyup="updatePreview()"/>
</div>
</div>
<div class="form-group">
<label><span class="label-icon">🔤</span> Section</label>
<div class="input-wrap">
<span class="i-icon">🏷️</span>
<input type="text" name="section" id="inputSection" value="${student.section}" placeholder="e.g. A" onkeyup="updatePreview()"/>
</div>
</div>
</div>

<!-- Parent select -->
<div class="form-group">
<label><span class="label-icon">👨‍👩‍👧</span> Assign Parent <span class="required-star">*</span></label>
<div class="input-wrap">
<span class="i-icon">👤</span>
<select name="parent.parentId" required>
<option value="">-- Select Parent --</option>
<c:forEach var="parent" items="${parents}">
<option value="${parent.parentId}" <c:if test="${not empty student.parent && student.parent.parentId == parent.parentId}">selected</c:if>>
${parent.name} — ${parent.phone}
</option>
</c:forEach>
</select>
</div>
</div>

<!-- Bus select -->
<div class="form-group">
<label><span class="label-icon">🚌</span> Assign Bus <span class="required-star">*</span></label>
<div class="input-wrap">
<span class="i-icon">🚌</span>
<select name="bus.busId" required>
<option value="">-- Select Bus --</option>
<c:forEach var="bus" items="${buses}">
<option value="${bus.busId}" <c:if test="${not empty student.bus && student.bus.busId == bus.busId}">selected</c:if>>
${bus.busNumber} — ${bus.driverName} (${bus.route})
</option>
</c:forEach>
</select>
</div>
</div>

<!-- QR display (edit mode) -->
<c:if test="${student.studentId != 0}">
<div class="form-group">
<label><span class="label-icon">📷</span> QR Code</label>
<div class="qr-box">
<div class="qr-box-icon">📷</div>
<div>
<div class="qr-box-text">${student.qrCode}</div>
<div class="qr-box-label">Auto-generated • Cannot be changed</div>
</div>
</div>
</div>
</c:if>

<!-- Actions -->
<div class="form-actions">
<button type="submit" class="btn-submit">
<c:choose>
<c:when test="${student.studentId == 0}">🚀 Save Student</c:when>
<c:otherwise>✅ Update Student</c:otherwise>
</c:choose>
</button>
<a href="${pageContext.request.contextPath}/admin/student/list" class="btn-cancel">✕ Cancel</a>
</div>

</form>
</div>

<!-- RIGHT: PREVIEW CARD -->
<div>
<div class="preview-card">
<div class="preview-title">👁️ Live Preview</div>

<!-- Student ID Card Preview -->
<div class="id-card">
<div class="id-card-logo">🚌</div>
<div class="id-school">SmartBus Student ID</div>
<div class="id-avatar">🎒</div>
<div class="id-name" id="previewName">
<c:choose>
<c:when test="${not empty student.name}">${student.name}</c:when>
<c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:13px;">Student Name</span></c:otherwise>
</c:choose>
</div>
<div class="id-class" id="previewClass">
<c:choose>
<c:when test="${not empty student.className}">Class ${student.className} — ${student.section}</c:when>
<c:otherwise><span style="color:rgba(255,255,255,0.2);font-size:10px;">Class — Section</span></c:otherwise>
</c:choose>
</div>
<div class="id-qr-area">
<div class="id-qr-placeholder">📷</div>
<div class="id-qr-text">
<c:choose>
<c:when test="${not empty student.qrCode}">${student.qrCode}</c:when>
<c:otherwise>QR auto-generated on save</c:otherwise>
</c:choose>
</div>
</div>
<div class="id-footer">SmartBus Transportation System</div>
</div>

<!-- Tips box -->
<div class="tips-box">
<div class="tips-title">💡 Quick Tips</div>
<div class="tip-item"><span class="tip-dot">✓</span>Name must match school records exactly</div>
<div class="tip-item"><span class="tip-dot">✓</span>Parent email gets boarding/dropoff alerts</div>
<div class="tip-item"><span class="tip-dot">✓</span>QR code is printed on student ID card</div>
<div class="tip-item"><span class="tip-dot">✓</span>Driver scans QR at boarding and dropoff</div>
</div>
</div>
</div>

</div>
</div>
</div>
</div>

<script>
// Live preview update as user types
function updatePreview(){
var name    = document.getElementById('inputName').value;
var cls     = document.getElementById('inputClass').value;
var section = document.getElementById('inputSection').value;
var nameEl  = document.getElementById('previewName');
var classEl = document.getElementById('previewClass');
nameEl.textContent  = name    || 'Student Name';
classEl.textContent = cls ? 'Class ' + cls + (section ? ' — ' + section : '') : 'Class — Section';
nameEl.style.color  = name ? '#fff' : 'rgba(255,255,255,0.2)';
classEl.style.color = cls  ? 'rgba(255,255,255,0.4)' : 'rgba(255,255,255,0.2)';
}
</script>
</body>
</html>