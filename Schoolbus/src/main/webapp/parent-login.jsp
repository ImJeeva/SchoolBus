<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Parent Login - SmartBus</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;min-height:100vh;overflow:hidden;background:#0a0a1a;display:flex;align-items:center;justify-content:center;}

/* ===== ANIMATED SKY - BLUE NIGHT ===== */
.bg{position:fixed;top:0;left:0;width:100%;height:100%;background:linear-gradient(180deg,#020818 0%,#0a1628 40%,#0d2347 70%,#1a3a2a 100%);z-index:0;}

/* Stars */
.stars{position:fixed;top:0;left:0;width:100%;height:60%;z-index:1;}
.star{position:absolute;background:#fff;border-radius:50%;animation:twinkle 2s infinite;}
@keyframes twinkle{0%,100%{opacity:1;transform:scale(1);}50%{opacity:0.2;transform:scale(0.5);}}

/* Blue glowing orb in sky */
.moon{position:fixed;top:40px;right:120px;width:60px;height:60px;background:radial-gradient(circle at 35% 35%,#fffff0,#f5f0d0,#e8dfa0,#d4c870);border-radius:50%;box-shadow:0 0 25px rgba(240,220,130,0.4),0 0 60px rgba(220,200,100,0.15),0 0 100px rgba(200,180,80,0.08);z-index:2;animation:moonPulse 4s ease-in-out infinite;}
@keyframes moonPulse{0%,100%{opacity:0.9;transform:scale(1);}50%{opacity:1;transform:scale(1.04);}}
/* Road */
.road{position:fixed;bottom:0;left:0;width:100%;height:120px;background:linear-gradient(180deg,#111827,#1f2937);z-index:2;}
.road-line{position:absolute;top:50%;left:0;width:100%;height:6px;background:repeating-linear-gradient(90deg,#4299e1 0px,#4299e1 60px,transparent 60px,transparent 120px);animation:roadMove 1s linear infinite;}
@keyframes roadMove{from{background-position:0 0;}to{background-position:-120px 0;}}
.road-line2{position:absolute;bottom:20px;left:0;width:100%;height:3px;background:#374151;}
.road-line3{position:absolute;top:20px;left:0;width:100%;height:3px;background:#374151;}

/* Trees - same as admin but slightly blue tinted */
.tree{position:fixed;bottom:100px;z-index:3;animation:treemove linear infinite;}
@keyframes treemove{from{right:-100px;}to{right:110%;}}

/* BUS CONTAINER - Blue bus! */
.bus-container{position:fixed;bottom:60px;left:50px;z-index:10;animation:busRock 0.5s ease-in-out infinite;}
@keyframes busRock{0%,100%{transform:translateY(0) rotate(0deg);}50%{transform:translateY(-4px) rotate(0.5deg);}}

/* Wheel spin */
.wheel{animation:spin 0.4s linear infinite;}
@keyframes spin{from{transform:rotate(0deg);}to{transform:rotate(360deg);}}

/* Bus headlight beam - blue tint */
.headlight-beam{position:fixed;bottom:95px;left:210px;width:200px;height:40px;background:linear-gradient(90deg,rgba(180,220,255,0.5),transparent);border-radius:0 50% 50% 0;z-index:9;animation:flicker 0.1s infinite;}
@keyframes flicker{0%,100%{opacity:1;}50%{opacity:0.85;}}

/* Clouds */
.cloud{position:fixed;z-index:3;animation:cloudmove linear infinite;}
@keyframes cloudmove{from{right:-300px;}to{right:110%;}}

/* ===== LOGIN CARD ===== */
.login-wrapper{position:fixed;top:45%;left:50%;transform:translate(-50%,-50%);z-index:20;width:90%;max-width:450px;margin-top:20px;}
.login-card{background:rgba(66,153,225,0.07);backdrop-filter:blur(35px);-webkit-backdrop-filter:blur(35px);border:1.5px solid rgba(66,153,225,0.25);border-radius:26px;padding:28px 34px 32px;box-shadow:0 35px 90px rgba(0,0,0,0.7),inset 0 1px 0 rgba(99,179,237,0.1);position:relative;overflow:hidden;}

/* Blue top glow line */
.login-card::before{content:'';position:absolute;top:-2px;left:15%;right:15%;height:3px;background:linear-gradient(90deg,transparent,#4299e1,#63b3ed,#4299e1,transparent);border-radius:2px;}

/* Card inner glow */
.login-card::after{content:'';position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:350px;height:350px;background:radial-gradient(circle,rgba(66,153,225,0.07) 0%,transparent 70%);border-radius:50%;pointer-events:none;z-index:0;}

.card-content{position:relative;z-index:1;}

.brand-area{text-align:center;margin-bottom:20px;}
.logo-icon{width:65px;height:65px;background:linear-gradient(135deg,#4299e1,#2b6cb0);border-radius:20px;display:inline-flex;align-items:center;justify-content:center;font-size:34px;margin-bottom:10px;box-shadow:0 15px 45px rgba(66,153,225,0.55);animation:logoPulse 2.5s ease-in-out infinite;}
@keyframes logoPulse{0%,100%{transform:scale(1) rotate(0deg);box-shadow:0 15px 45px rgba(66,153,225,0.55);}50%{transform:scale(1.06) rotate(-4deg);box-shadow:0 18px 55px rgba(66,153,225,0.75);}}
.brand-title{font-size:26px;font-weight:900;color:#fff;letter-spacing:2px;text-shadow:0 0 35px rgba(66,153,225,0.6);margin-bottom:3px;}
.brand-sub{color:rgba(255,255,255,0.5);font-size:11px;letter-spacing:2.5px;text-transform:uppercase;}

.form-header{text-align:center;margin-bottom:20px;}
.card-heading{color:#fff;font-size:19px;font-weight:700;margin-bottom:3px;letter-spacing:0.5px;}
.card-sub{color:rgba(255,255,255,0.45);font-size:12.5px;}

/* Error */
.error-msg{background:rgba(255,80,80,0.18);border:1.5px solid rgba(255,80,80,0.45);border-radius:14px;padding:12px 16px;color:#ff9090;font-size:13px;margin-bottom:18px;display:flex;align-items:center;gap:10px;animation:slideDown 0.4s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}

/* Inputs */
.input-wrap{position:relative;margin-bottom:14px;}
.input-wrap label{display:block;color:rgba(255,255,255,0.65);font-size:11.5px;font-weight:600;letter-spacing:1px;text-transform:uppercase;margin-bottom:7px;}
.input-wrap input{width:100%;padding:13px 46px 13px 46px;background:rgba(255,255,255,0.06);border:1.5px solid rgba(66,153,225,0.2);border-radius:13px;color:#fff;font-size:14px;font-family:'Poppins',sans-serif;outline:none;transition:all 0.35s ease;}
.input-wrap input::placeholder{color:rgba(255,255,255,0.25);}
.input-wrap input:focus{border-color:#4299e1;background:rgba(66,153,225,0.1);box-shadow:0 0 0 4px rgba(66,153,225,0.12);transform:translateY(-2px);}
.input-icon{position:absolute;bottom:13px;left:15px;font-size:18px;pointer-events:none;opacity:0.7;}
.password-toggle{position:absolute;bottom:13px;right:15px;font-size:18px;cursor:pointer;opacity:0.6;transition:all 0.3s;user-select:none;z-index:5;}
.password-toggle:hover{opacity:1;transform:scale(1.1);}

/* Login button - BLUE */
.btn-login{width:100%;padding:14px;background:linear-gradient(135deg,#4299e1 0%,#3182ce 50%,#2b6cb0 100%);border:none;border-radius:13px;color:#fff;font-size:15px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;letter-spacing:0.8px;position:relative;overflow:hidden;transition:all 0.35s;box-shadow:0 10px 30px rgba(66,153,225,0.5);margin-top:4px;}
.btn-login::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.6s;}
.btn-login:hover::before{left:100%;}
.btn-login:hover{transform:translateY(-4px);box-shadow:0 16px 40px rgba(66,153,225,0.7);}
.btn-login:active{transform:translateY(-1px);}

.divider{display:flex;align-items:center;gap:12px;margin:18px 0 16px;}
.divider hr{flex:1;border:none;border-top:1.5px solid rgba(255,255,255,0.08);}
.divider span{color:rgba(255,255,255,0.3);font-size:10.5px;letter-spacing:1.5px;font-weight:600;}

.admin-link{text-align:center;}
.admin-link a{color:#ffc107;text-decoration:none;font-size:14px;font-weight:600;transition:all 0.3s;display:inline-flex;align-items:center;gap:6px;}
.admin-link a:hover{color:#fff;text-shadow:0 0 25px rgba(255,193,7,0.9);transform:translateX(5px);}

@media(max-height:750px){.login-wrapper{top:42%;}.login-card{padding:22px 30px 26px;}.logo-icon{width:55px;height:55px;font-size:28px;}.brand-title{font-size:22px;}.brand-area{margin-bottom:14px;}.form-header{margin-bottom:14px;}.input-wrap{margin-bottom:10px;}}
@media(max-height:600px){.login-wrapper{top:40%;}.login-card{padding:18px 26px 22px;}.brand-area{margin-bottom:10px;}.form-header{margin-bottom:10px;}}
</style>
</head>
<body>

<!-- BACKGROUND -->
<div class="bg"></div>
<div class="stars" id="stars"></div>
<div class="moon"></div>

<!-- CLOUDS -->
<div class="cloud" style="top:8%;animation-duration:20s;animation-delay:0s;">
<svg width="120" height="50" viewBox="0 0 120 50"><ellipse cx="60" cy="35" rx="55" ry="18" fill="rgba(66,153,225,0.06)"/><ellipse cx="40" cy="28" rx="28" ry="20" fill="rgba(66,153,225,0.06)"/><ellipse cx="80" cy="30" rx="22" ry="16" fill="rgba(66,153,225,0.06)"/></svg>
</div>
<div class="cloud" style="top:16%;animation-duration:28s;animation-delay:-10s;">
<svg width="90" height="40" viewBox="0 0 90 40"><ellipse cx="45" cy="28" rx="40" ry="14" fill="rgba(99,179,237,0.05)"/><ellipse cx="30" cy="22" rx="22" ry="16" fill="rgba(99,179,237,0.05)"/><ellipse cx="62" cy="24" rx="18" ry="13" fill="rgba(99,179,237,0.05)"/></svg>
</div>

<!-- ROAD -->
<div class="road">
<div class="road-line"></div>
<div class="road-line2"></div>
<div class="road-line3"></div>
</div>

<!-- HEADLIGHT BEAM -->
<div class="headlight-beam"></div>

<!-- BLUE BUS -->
<div class="bus-container">
<svg width="200" height="90" viewBox="0 0 200 90" xmlns="http://www.w3.org/2000/svg">
<!-- Bus body - BLUE -->
<rect x="10" y="10" width="175" height="60" rx="10" ry="10" fill="#4299e1"/>
<rect x="10" y="10" width="175" height="20" rx="10" ry="4" fill="#63b3ed"/>
<!-- Windows -->
<rect x="25" y="18" width="28" height="20" rx="4" fill="#ebf8ff" opacity="0.9"/>
<rect x="62" y="18" width="28" height="20" rx="4" fill="#ebf8ff" opacity="0.9"/>
<rect x="99" y="18" width="28" height="20" rx="4" fill="#ebf8ff" opacity="0.9"/>
<rect x="136" y="18" width="28" height="20" rx="4" fill="#ebf8ff" opacity="0.9"/>
<!-- Kids in windows -->
<circle cx="39" cy="26" r="6" fill="#ffccbc"/>
<circle cx="76" cy="26" r="6" fill="#ffe0b2"/>
<circle cx="113" cy="26" r="6" fill="#ffccbc"/>
<!-- Door -->
<rect x="152" y="35" width="22" height="30" rx="3" fill="#2b6cb0"/>
<line x1="163" y1="35" x2="163" y2="65" stroke="#1a4a8a" stroke-width="2"/>
<!-- Front -->
<rect x="185" y="25" width="10" height="35" rx="4" fill="#2b6cb0"/>
<!-- Headlights - blue white -->
<rect x="186" y="28" width="8" height="8" rx="2" fill="#ebf8ff"/>
<rect x="186" y="40" width="8" height="6" rx="1" fill="#bee3f8" opacity="0.9"/>
<!-- SMARTBUS text -->
<text x="65" y="58" font-family="Arial" font-weight="bold" font-size="11" fill="#ebf8ff">SMART BUS</text>
<!-- Wheels -->
<g transform="translate(40,70)"><circle r="16" fill="#1a202c"/><circle r="10" fill="#2d3748"/><circle r="4" fill="#4a5568" class="wheel"/><line x1="0" y1="-10" x2="0" y2="10" stroke="#4a5568" stroke-width="2" class="wheel"/><line x1="-10" y1="0" x2="10" y2="0" stroke="#4a5568" stroke-width="2" class="wheel"/></g>
<g transform="translate(155,70)"><circle r="16" fill="#1a202c"/><circle r="10" fill="#2d3748"/><circle r="4" fill="#4a5568" class="wheel"/><line x1="0" y1="-10" x2="0" y2="10" stroke="#4a5568" stroke-width="2" class="wheel"/><line x1="-10" y1="0" x2="10" y2="0" stroke="#4a5568" stroke-width="2" class="wheel"/></g>
<!-- Exhaust -->
<circle cx="8" cy="30" r="5" fill="rgba(180,210,240,0.25)"/>
<circle cx="2" cy="22" r="7" fill="rgba(180,210,240,0.15)"/>
</svg>
</div>

<!-- TREES -->
<div class="tree" style="animation-duration:6s;animation-delay:0s;bottom:115px;">
<svg width="40" height="70" viewBox="0 0 40 70"><rect x="17" y="45" width="6" height="25" fill="#5d4037"/><polygon points="20,0 2,30 10,28 4,50 20,45 36,50 30,28 38,30" fill="#1a4731"/><polygon points="20,5 4,32 12,30 6,52 20,47 34,52 28,30 36,32" fill="#22543d"/></svg>
</div>
<div class="tree" style="animation-duration:8s;animation-delay:-3s;bottom:108px;">
<svg width="32" height="55" viewBox="0 0 32 55"><rect x="14" y="36" width="5" height="19" fill="#5d4037"/><polygon points="16,0 1,24 8,22 3,40 16,36 29,40 24,22 31,24" fill="#1c4532"/></svg>
</div>
<div class="tree" style="animation-duration:10s;animation-delay:-6s;bottom:112px;">
<svg width="45" height="75" viewBox="0 0 45 75"><rect x="19" y="48" width="7" height="27" fill="#4e342e"/><polygon points="22,0 2,34 12,31 5,55 22,50 39,55 32,31 42,34" fill="#276749"/></svg>
</div>

<!-- LOGIN CARD -->
<div class="login-wrapper">
<div class="login-card">
<div class="card-content">

<div class="brand-area">
<div class="logo-icon">👨‍👩‍👧</div>
<div class="brand-title">SMARTBUS</div>
<div class="brand-sub">Parent Portal</div>
</div>

<div class="form-header">
<div class="card-heading">Parent Login</div>
<div class="card-sub">Track your child's bus in real-time</div>
</div>

<c:if test="${not empty error}">
<div class="error-msg">⚠️ <span>${error}</span></div>
</c:if>

<form action="${pageContext.request.contextPath}/parent/login" method="post">
<div class="input-wrap">
<label>Email Address</label>
<span class="input-icon">✉️</span>
<input type="email" name="email" placeholder="parent@email.com" required autofocus/>
</div>
<div class="input-wrap">
<label>Password</label>
<span class="input-icon">🔒</span>
<input type="password" id="password" name="password" placeholder="Enter your password" required/>
<span class="password-toggle" onclick="togglePassword()">👁️</span>
</div>

<button type="submit" class="btn-login">🚌 SIGN IN TO PARENT PORTAL</button>
</form>

<div class="divider"><hr/><span>OR</span><hr/></div>
<div class="admin-link">
<a href="${pageContext.request.contextPath}/admin/login">🔐 Admin Login →</a>
</div>

</div>
</div>
</div>

<script>
// Generate stars
var starsEl = document.getElementById('stars');
for(var i=0;i<120;i++){
var s=document.createElement('div');
s.className='star';
var size=Math.random()*3+1;
s.style.cssText='width:'+size+'px;height:'+size+'px;top:'+Math.random()*100+'%;left:'+Math.random()*100+'%;animation-delay:'+Math.random()*3+'s;animation-duration:'+(Math.random()*2+1)+'s;';
starsEl.appendChild(s);
}
function togglePassword(){
var p=document.getElementById('password');
var t=document.querySelector('.password-toggle');
if(p.type==='password'){p.type='text';t.textContent='🙈';}
else{p.type='password';t.textContent='👁️';}
}
</script>
</body>
</html>