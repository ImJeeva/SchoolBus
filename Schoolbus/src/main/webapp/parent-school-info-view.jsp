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

.topbar{position:relative;z-index:10;background:rgba(255,255,255,0.03);backdrop-filter:blur(20px);border-bottom:1px solid rgba(66,153,225,0.1);padding:20px 36px;}
.topbar-left h1{font-size:24px;font-weight:800;color:#fff;}
.topbar-left p{font-size:13px;color:rgba(255,255,255,0.4);margin-top:2px;}

.page-body{padding:28px 36px;flex:1;position:relative;z-index:5;}

/* School card */
.school-card{background:rgba(255,255,255,0.03);border:1px solid rgba(66,153,225,0.2);border-left:4px solid #4299e1;border-radius:20px;padding:32px;margin-bottom:24px;animation:fadeIn 0.4s ease;}
@keyframes fadeIn{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}

.school-header{text-align:center;margin-bottom:32px;padding-bottom:24px;border-bottom:1px solid rgba(255,255,255,0.06);}
.school-logo{width:80px;height:80px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:20px;display:flex;align-items:center;justify-content:center;font-size:40px;margin:0 auto 16px;box-shadow:0 8px 24px rgba(66,153,225,0.4);}
.school-name{font-size:28px;font-weight:900;color:#fff;margin-bottom:4px;}
.school-tagline{font-size:13px;color:rgba(255,255,255,0.4);}

.info-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px;margin-bottom:28px;}
.info-box{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.06);border-radius:14px;padding:20px;transition:all 0.3s;}
.info-box:hover{border-color:rgba(66,153,225,0.2);background:rgba(66,153,225,0.04);}
.info-icon{font-size:28px;margin-bottom:12px;}
.info-label{font-size:10px;font-weight:700;color:rgba(255,255,255,0.25);text-transform:uppercase;letter-spacing:1.5px;margin-bottom:8px;}
.info-value{font-size:15px;font-weight:600;color:#fff;line-height:1.6;}
.info-value a{color:#63b3ed;text-decoration:none;transition:all 0.3s;}
.info-value a:hover{color:#4299e1;}

.contact-btn{display:inline-flex;align-items:center;gap:10px;padding:14px 28px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:12px;color:#fff;font-size:14px;font-weight:800;text-decoration:none;transition:all 0.3s;box-shadow:0 6px 20px rgba(66,153,225,0.35);}
.contact-btn:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(66,153,225,0.5);}

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
<a href="${pageContext.request.contextPath}/parent/attendance" class="sb-item">
<span class="sb-ico">📋</span><span class="label">Attendance History</span>
</a>
<div class="sb-section">Information</div>
<a href="${pageContext.request.contextPath}/parent/school-info" class="sb-item active">
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
<h1>🏫 School Information</h1>
<p>Complete details about the school</p>
</div>
</div>

<div class="page-body">

<div class="school-card">

<div class="school-header">
<div class="school-logo">🏫</div>
<div class="school-name">${schoolInfo.schoolName}</div>
<div class="school-tagline">Your child's educational institution</div>
</div>

<div class="info-grid">

<div class="info-box">
<div class="info-icon">📍</div>
<div class="info-label">Address</div>
<div class="info-value">${schoolInfo.address}</div>
</div>

<div class="info-box">
<div class="info-icon">📞</div>
<div class="info-label">Phone</div>
<div class="info-value"><a href="tel:${schoolInfo.phone}">${schoolInfo.phone}</a></div>
</div>

<div class="info-box">
<div class="info-icon">✉️</div>
<div class="info-label">Email</div>
<div class="info-value"><a href="mailto:${schoolInfo.email}">${schoolInfo.email}</a></div>
</div>

<div class="info-box">
<div class="info-icon">👤</div>
<div class="info-label">Principal</div>
<div class="info-value">${schoolInfo.principalName}</div>
</div>

<div class="info-box">
<div class="info-icon">🕐</div>
<div class="info-label">School Timings</div>
<div class="info-value">${schoolInfo.schoolTimings}</div>
</div>

<div class="info-box" style="display:flex;align-items:center;justify-content:center;">
<a href="${pageContext.request.contextPath}/parent/contact" class="contact-btn">
📞 Contact School
</a>
</div>

</div>

</div>

</div>
</div>

</body>
</html>