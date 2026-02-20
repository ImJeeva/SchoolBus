<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Contact School - SmartBus</title>
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

.page-body{padding:28px 36px;flex:1;position:relative;z-index:5;display:grid;grid-template-columns:1fr 350px;gap:24px;}

/* Contact form */
.contact-card{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:32px;}
.form-note{background:rgba(66,153,225,0.07);border:1px solid rgba(66,153,225,0.2);border-radius:12px;padding:14px 18px;margin-bottom:24px;font-size:12px;color:rgba(255,255,255,0.45);line-height:1.6;}
.form-note strong{color:#63b3ed;}

.form-group{margin-bottom:20px;}
.form-group label{display:flex;align-items:center;gap:7px;color:rgba(255,255,255,0.55);font-size:11px;font-weight:600;letter-spacing:0.8px;text-transform:uppercase;margin-bottom:9px;}
.input-wrap{position:relative;}
.input-wrap input,.input-wrap textarea,.input-wrap select{width:100%;padding:13px 16px;background:rgba(255,255,255,0.05);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.3s;resize:vertical;}
.input-wrap textarea{min-height:140px;}
.input-wrap input::placeholder,.input-wrap textarea::placeholder{color:rgba(255,255,255,0.2);}
.input-wrap input:focus,.input-wrap textarea:focus,.input-wrap select:focus{border-color:rgba(66,153,225,0.5);background:rgba(66,153,225,0.04);box-shadow:0 0 0 4px rgba(66,153,225,0.07);}
.input-wrap select{cursor:pointer;}
.input-wrap select option{background:#1a1a2e;color:#fff;}

.btn-submit{width:100%;padding:14px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border:none;border-radius:12px;color:#fff;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(66,153,225,0.35);}
.btn-submit:hover{transform:translateY(-3px);box-shadow:0 10px 28px rgba(66,153,225,0.5);}

/* Contact info sidebar */
.info-sidebar{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:24px;}
.info-title{font-size:15px;font-weight:700;color:#fff;margin-bottom:18px;}
.contact-item{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.06);border-radius:12px;padding:16px;margin-bottom:12px;}
.contact-item:last-child{margin-bottom:0;}
.ci-icon{font-size:24px;margin-bottom:8px;}
.ci-label{font-size:10px;font-weight:700;color:rgba(255,255,255,0.25);text-transform:uppercase;letter-spacing:1.5px;margin-bottom:6px;}
.ci-value{font-size:13px;font-weight:600;color:#fff;}
.ci-value a{color:#63b3ed;text-decoration:none;}
.ci-value a:hover{color:#4299e1;}

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
<a href="${pageContext.request.contextPath}/parent/school-info" class="sb-item">
<span class="sb-ico">🏫</span><span class="label">School Info</span>
</a>
<a href="${pageContext.request.contextPath}/parent/contact" class="sb-item active">
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
<h1>📞 Contact School</h1>
<p>Get in touch with the school administration</p>
</div>
</div>

<div class="page-body">

<!-- Contact form -->
<div class="contact-card">
<div class="form-note">
📧 This form will send an email to <strong>${schoolInfo.email}</strong>. 
The school administration will respond to your message as soon as possible.
</div>

<form action="${pageContext.request.contextPath}/parent/contact/send" method="post">

<div class="form-group">
<label>📧 Subject</label>
<div class="input-wrap">
<select name="subject" required>
<option value="">Select a topic...</option>
<option value="Bus Service Inquiry">Bus Service Inquiry</option>
<option value="Attendance Issue">Attendance Issue</option>
<option value="General Question">General Question</option>
<option value="Feedback">Feedback</option>
<option value="Other">Other</option>
</select>
</div>
</div>

<div class="form-group">
<label>✍️ Your Message</label>
<div class="input-wrap">
<textarea name="message" placeholder="Type your message here..." required></textarea>
</div>
</div>

<button type="submit" class="btn-submit">📤 Send Message</button>

</form>
</div>

<!-- Contact info sidebar -->
<div class="info-sidebar">
<div class="info-title">📞 Contact Information</div>

<div class="contact-item">
<div class="ci-icon">📞</div>
<div class="ci-label">Phone</div>
<div class="ci-value"><a href="tel:${schoolInfo.phone}">${schoolInfo.phone}</a></div>
</div>

<div class="contact-item">
<div class="ci-icon">✉️</div>
<div class="ci-label">Email</div>
<div class="ci-value"><a href="mailto:${schoolInfo.email}">${schoolInfo.email}</a></div>
</div>

<div class="contact-item">
<div class="ci-icon">📍</div>
<div class="ci-label">Address</div>
<div class="ci-value">${schoolInfo.address}</div>
</div>

<div class="contact-item">
<div class="ci-icon">🕐</div>
<div class="ci-label">Office Hours</div>
<div class="ci-value">${schoolInfo.schoolTimings}</div>
</div>

</div>

</div>
</div>

</body>
</html>