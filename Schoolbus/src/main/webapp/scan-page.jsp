<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Driver Scan - SmartBus</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="https://unpkg.com/@zxing/library@latest/umd/index.min.js"></script>
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
.sb-badge{background:linear-gradient(135deg,#ffc107,#ff9800);color:#1a0a00;padding:2px 8px;border-radius:20px;font-size:10px;font-weight:700;}
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
.live-badge{display:flex;align-items:center;gap:8px;background:rgba(72,187,120,0.1);border:1px solid rgba(72,187,120,0.3);padding:8px 16px;border-radius:20px;font-size:12px;font-weight:600;color:#68d391;}
.live-dot{width:8px;height:8px;background:#68d391;border-radius:50%;animation:livePulse 1.5s ease-in-out infinite;}
@keyframes livePulse{0%,100%{box-shadow:0 0 0 0 rgba(104,211,145,0.6);}50%{box-shadow:0 0 0 8px rgba(104,211,145,0);}}

/* ===== PAGE BODY ===== */
.page-body{padding:28px 36px;flex:1;}

/* ===== TWO COLUMN LAYOUT ===== */
.scan-layout{display:grid;grid-template-columns:1fr 1fr;gap:24px;align-items:start;}

/* ===== STEP CARDS ===== */
.step-card{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:20px;padding:24px;margin-bottom:20px;transition:border-color 0.3s;}
.step-card:hover{border-color:rgba(255,193,7,0.15);}
.step-card.active-step{border-color:rgba(255,193,7,0.3);background:rgba(255,193,7,0.03);}
.step-header{display:flex;align-items:center;gap:12px;margin-bottom:18px;}
.step-num{width:32px;height:32px;background:linear-gradient(135deg,#ffc107,#ff6b00);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:14px;font-weight:800;color:#1a0a00;box-shadow:0 4px 12px rgba(255,193,7,0.4);flex-shrink:0;}
.step-title{font-size:15px;font-weight:700;color:#fff;}
.step-sub{font-size:11px;color:rgba(255,255,255,0.35);margin-top:2px;}

/* Form groups */
.form-group{margin-bottom:16px;}
.form-group:last-child{margin-bottom:0;}
.form-group label{display:flex;align-items:center;gap:6px;color:rgba(255,255,255,0.5);font-size:11px;font-weight:600;letter-spacing:1px;text-transform:uppercase;margin-bottom:8px;}
.form-group select{width:100%;padding:13px 16px;background:rgba(255,255,255,0.06);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;color:#fff;font-size:13px;font-family:'Poppins',sans-serif;outline:none;appearance:none;transition:all 0.3s;cursor:pointer;}
.form-group select option{background:#0d1b3e;color:#fff;}
.form-group select:focus{border-color:rgba(255,193,7,0.5);background:rgba(255,193,7,0.05);box-shadow:0 0 0 3px rgba(255,193,7,0.08);}

/* ===== CAMERA BOX ===== */
.camera-wrap{position:relative;border-radius:16px;overflow:hidden;margin-bottom:16px;background:#000;border:2px solid rgba(255,255,255,0.06);min-height:220px;}
.camera-wrap.scanning{border-color:rgba(255,193,7,0.5);box-shadow:0 0 30px rgba(255,193,7,0.12);}
.cam-corner{position:absolute;width:22px;height:22px;z-index:5;}
.cam-corner.tl{top:10px;left:10px;border-top:3px solid #ffc107;border-left:3px solid #ffc107;border-radius:3px 0 0 0;}
.cam-corner.tr{top:10px;right:10px;border-top:3px solid #ffc107;border-right:3px solid #ffc107;border-radius:0 3px 0 0;}
.cam-corner.bl{bottom:10px;left:10px;border-bottom:3px solid #ffc107;border-left:3px solid #ffc107;border-radius:0 0 0 3px;}
.cam-corner.br{bottom:10px;right:10px;border-bottom:3px solid #ffc107;border-right:3px solid #ffc107;border-radius:0 0 3px 0;}
.scan-laser{position:absolute;left:10px;right:10px;height:2px;background:linear-gradient(90deg,transparent,#ffc107,rgba(255,193,7,0.8),#ffc107,transparent);display:none;z-index:4;border-radius:2px;box-shadow:0 0 12px rgba(255,193,7,0.8);}
.camera-wrap.scanning .scan-laser{display:block;animation:laserScan 2s ease-in-out infinite;}
@keyframes laserScan{0%{top:10px;}50%{top:calc(100% - 12px);}100%{top:10px;}}
video#cameraPreview{width:100%;display:block;object-fit:cover;}
.cam-placeholder{min-height:220px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;padding:32px;}
.cam-ph-icon{font-size:48px;animation:camBounce 2s ease-in-out infinite;}
@keyframes camBounce{0%,100%{transform:scale(1);}50%{transform:scale(1.1);}}
.cam-ph-text{font-size:13px;color:rgba(255,255,255,0.3);text-align:center;line-height:1.6;}

/* Buttons */
.btn-start{width:100%;padding:14px;background:linear-gradient(135deg,#ffc107,#ff6b00);border:none;border-radius:12px;color:#1a0a00;font-size:14px;font-weight:800;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;box-shadow:0 6px 20px rgba(255,193,7,0.35);position:relative;overflow:hidden;}
.btn-start::before{content:'';position:absolute;top:0;left:-100%;width:100%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transition:left 0.4s;}
.btn-start:hover::before{left:100%;}
.btn-start:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(255,193,7,0.5);}
.btn-stop{width:100%;padding:14px;background:rgba(245,101,101,0.1);border:1.5px solid rgba(245,101,101,0.3);border-radius:12px;color:#fc8181;font-size:14px;font-weight:700;font-family:'Poppins',sans-serif;cursor:pointer;transition:all 0.3s;display:none;margin-top:10px;}
.btn-stop:hover{background:rgba(245,101,101,0.18);}

/* ===== RESULT BOX ===== */
.result-box{border-radius:16px;padding:16px 20px;margin-bottom:20px;display:flex;align-items:center;gap:14px;background:rgba(255,255,255,0.04);border:1.5px solid rgba(255,255,255,0.08);transition:all 0.4s;min-height:70px;}
.result-box.success{background:rgba(72,187,120,0.1);border-color:rgba(72,187,120,0.35);box-shadow:0 6px 20px rgba(72,187,120,0.1);}
.result-box.error{background:rgba(245,101,101,0.1);border-color:rgba(245,101,101,0.35);}
.result-box.processing{background:rgba(255,193,7,0.07);border-color:rgba(255,193,7,0.3);}
.res-icon{font-size:32px;flex-shrink:0;animation:resIconPop 0.3s ease;}
@keyframes resIconPop{0%{transform:scale(0.5);}100%{transform:scale(1);}}
.res-info{flex:1;}
.res-name{font-size:15px;font-weight:800;color:#fff;margin-bottom:3px;}
.res-detail{font-size:12px;color:rgba(255,255,255,0.45);line-height:1.5;}
.res-time{font-size:11px;font-weight:600;color:rgba(255,255,255,0.3);white-space:nowrap;flex-shrink:0;}

/* ===== SCAN LOG ===== */
.scan-log{background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;}
.log-head{padding:16px 20px;border-bottom:1px solid rgba(255,255,255,0.06);display:flex;align-items:center;justify-content:space-between;}
.log-head h3{font-size:14px;font-weight:700;color:#fff;}
.log-count-badge{background:linear-gradient(135deg,#ffc107,#ff9800);color:#1a0a00;padding:3px 12px;border-radius:20px;font-size:11px;font-weight:800;}
table{width:100%;border-collapse:collapse;}
thead th{padding:10px 16px;background:rgba(0,0,0,0.25);color:rgba(255,255,255,0.3);font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1px;text-align:left;}
tbody td{padding:12px 16px;font-size:13px;border-bottom:1px solid rgba(255,255,255,0.04);color:rgba(255,255,255,0.75);vertical-align:middle;}
tbody tr:last-child td{border-bottom:none;}
tbody tr{transition:background 0.2s;animation:rowIn 0.3s ease;}
@keyframes rowIn{from{opacity:0;transform:translateX(-8px);}to{opacity:1;transform:translateX(0);}}
tbody tr:hover{background:rgba(255,193,7,0.04);}
.log-name{font-weight:700;color:#fff;}
.badge-board{background:rgba(72,187,120,0.15);border:1px solid rgba(72,187,120,0.25);color:#68d391;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:700;}
.badge-drop{background:rgba(66,153,225,0.15);border:1px solid rgba(66,153,225,0.25);color:#63b3ed;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:700;}
.log-time{font-size:11px;color:rgba(255,255,255,0.4);}
.log-num{color:rgba(255,255,255,0.2);font-size:11px;}
.empty-log{text-align:center;padding:28px;color:rgba(255,255,255,0.2);font-size:13px;}
.empty-log span{display:block;font-size:28px;margin-bottom:8px;}

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
<a href="${pageContext.request.contextPath}/admin/student/list" class="sb-item"><span class="sb-ico">🎒</span><span class="label">Students</span></a>
<a href="${pageContext.request.contextPath}/admin/parent/list"  class="sb-item"><span class="sb-ico">👨‍👩‍👧</span><span class="label">Parents</span></a>
<a href="${pageContext.request.contextPath}/admin/bus/list"     class="sb-item"><span class="sb-ico">🚌</span><span class="label">Buses</span></a>
<div class="sb-section">Reports</div>
<a href="${pageContext.request.contextPath}/attendance/list"      class="sb-item"><span class="sb-ico">📋</span><span class="label">Attendance Log</span></a>
<div class="sb-section">Driver</div>
<a href="${pageContext.request.contextPath}/attendance/scan-page" class="sb-item active"><span class="sb-ico">📷</span><span class="label">QR Scan Page</span></a>
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
<h1>📷 Driver QR Scanner</h1>
<p>Scan student QR codes for boarding and dropoff tracking</p>
</div>
<div class="live-badge"><div class="live-dot"></div>System Live</div>
</div>

<div class="page-body">

<!-- Two column layout -->
<div class="scan-layout">

<!-- LEFT COLUMN -->
<div>
<!-- Step 1 -->
<div class="step-card" id="step1Card">
<div class="step-header">
<div class="step-num">1</div>
<div>
<div class="step-title">Select Bus &amp; Event</div>
<div class="step-sub">Choose your bus and event type</div>
</div>
</div>
<div class="form-group">
<label>🚌 Your Bus</label>
<select id="busId" onchange="checkStep1()">
<option value="">-- Select Bus --</option>
<c:forEach var="bus" items="${buses}">
<option value="${bus.busId}">${bus.busNumber} — ${bus.driverName} (${bus.route})</option>
</c:forEach>
</select>
</div>
<div class="form-group">
<label>📍 Event Type</label>
<select id="eventType">
<option value="BOARDING">🟢 BOARDING — Getting on bus</option>
<option value="DROPOFF">🔵 DROPOFF — Getting off bus</option>
</select>
</div>
</div>

<!-- Step 2 -->
<div class="step-card" id="step2Card">
<div class="step-header">
<div class="step-num">2</div>
<div>
<div class="step-title">Scan Student QR Code</div>
<div class="step-sub">Point camera at student QR card</div>
</div>
</div>
<div class="camera-wrap" id="cameraBox">
<div class="cam-corner tl"></div>
<div class="cam-corner tr"></div>
<div class="cam-corner bl"></div>
<div class="cam-corner br"></div>
<div class="scan-laser"></div>
<video id="cameraPreview" style="display:none;" playsinline></video>
<div class="cam-placeholder" id="camPlaceholder">
<div class="cam-ph-icon">📷</div>
<div class="cam-ph-text">Click <strong>Start Camera</strong> below<br/>to begin scanning QR codes</div>
</div>
</div>
<button onclick="startScanner()" id="startBtn" class="btn-start">📷 Start Camera &amp; Scan</button>
<button onclick="stopScanner()" id="stopBtn" class="btn-stop">⏹ Stop Camera</button>
</div>
</div>

<!-- RIGHT COLUMN -->
<div>
<!-- Result box -->
<div class="result-box" id="resultBox">
<span class="res-icon">📡</span>
<div class="res-info">
<div class="res-name">Waiting for scan...</div>
<div class="res-detail">Select bus → Start camera → Point at QR card</div>
</div>
</div>

<!-- Scan log -->
<div class="scan-log">
<div class="log-head">
<h3>✅ Scanned This Session</h3>
<span class="log-count-badge" id="scanCount">0 scanned</span>
</div>
<table>
<thead>
<tr><th>#</th><th>Student</th><th>Event</th><th>Time</th></tr>
</thead>
<tbody id="logBody">
<tr><td colspan="4" class="empty-log"><span>📋</span>No scans yet this session</td></tr>
</tbody>
</table>
</div>
</div>

</div>
</div>
</div>
</div>

<script>
var codeReader  = new ZXing.BrowserQRCodeReader();
var scanCount   = 0;
var lastScanned = "";
var firstRow    = true;

function checkStep1(){
var busId = document.getElementById('busId').value;
document.getElementById('step2Card').classList.toggle('active-step', busId !== '');
}

function startScanner(){
var busId     = document.getElementById('busId').value;
var eventType = document.getElementById('eventType').value;
if(!busId){ alert('⚠️ Please select your bus first!'); return; }
document.getElementById('startBtn').style.display      = 'none';
document.getElementById('stopBtn').style.display       = 'block';
document.getElementById('camPlaceholder').style.display= 'none';
document.getElementById('cameraPreview').style.display = 'block';
document.getElementById('cameraBox').classList.add('scanning');
codeReader.decodeFromVideoDevice(null,'cameraPreview',function(result,err){
if(result){
var qrCode = result.getText();
if(qrCode === lastScanned) return;
lastScanned = qrCode;
setTimeout(function(){ lastScanned = ''; }, 3000);
sendScan(qrCode, busId, eventType);
}
});
}

function stopScanner(){
codeReader.reset();
document.getElementById('cameraPreview').style.display  = 'none';
document.getElementById('camPlaceholder').style.display = 'block';
document.getElementById('startBtn').style.display       = 'block';
document.getElementById('stopBtn').style.display        = 'none';
document.getElementById('cameraBox').classList.remove('scanning');
}

function sendScan(qrCode, busId, eventType){
var box = document.getElementById('resultBox');
box.className = 'result-box processing';
box.innerHTML = '<span class="res-icon">⏳</span><div class="res-info"><div class="res-name">Processing...</div><div class="res-detail">' + qrCode + '</div></div>';
fetch('${pageContext.request.contextPath}/attendance/scan',{
method:'POST',
headers:{'Content-Type':'application/x-www-form-urlencoded'},
body:'qrCode='+encodeURIComponent(qrCode)+'&busId='+encodeURIComponent(busId)+'&eventType='+encodeURIComponent(eventType)
})
.then(function(r){ return r.text(); })
.then(function(text){
if(text.startsWith('SUCCESS')){
var parts = text.split('|');
var name  = parts[1];
var evt   = parts[2];
var time  = parts[3];
box.className = 'result-box success';
box.innerHTML = '<span class="res-icon">✅</span><div class="res-info"><div class="res-name">'+name+'</div><div class="res-detail">'+(evt==='BOARDING'?'🟢 Boarded successfully':'🔵 Dropped off successfully')+' • Parent email sent ✉️</div></div><div class="res-time">'+time+'</div>';
scanCount++;
document.getElementById('scanCount').textContent = scanCount+' scanned';
var tbody = document.getElementById('logBody');
if(firstRow){ tbody.innerHTML=''; firstRow=false; }
var badge = evt==='BOARDING' ? '<span class="badge-board">🟢 BOARDING</span>' : '<span class="badge-drop">🔵 DROPOFF</span>';
tbody.insertAdjacentHTML('afterbegin','<tr><td class="log-num">'+scanCount+'</td><td class="log-name">'+name+'</td><td>'+badge+'</td><td class="log-time">'+time+'</td></tr>');
} else {
box.className = 'result-box error';
box.innerHTML = '<span class="res-icon">❌</span><div class="res-info"><div class="res-name">Scan Failed</div><div class="res-detail">'+text+'</div></div>';
}
})
.catch(function(e){
box.className = 'result-box error';
box.innerHTML = '<span class="res-icon">❌</span><div class="res-info"><div class="res-name">Network Error</div><div class="res-detail">'+e+'</div></div>';
});
}
</script>
</body>
</html>