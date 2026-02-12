<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Scan - SmartBus</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/@zxing/library@latest/umd/index.min.js"></script>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Poppins',sans-serif; background:linear-gradient(135deg,#1a1a2e 0%,#0f3460 100%); min-height:100vh; color:#fff; }

        .header { background:rgba(255,255,255,0.05); backdrop-filter:blur(10px); border-bottom:1px solid rgba(255,255,255,0.1); padding:16px 24px; display:flex; align-items:center; justify-content:space-between; }
        .header-brand { display:flex; align-items:center; gap:12px; }
        .header-brand .icon { width:40px; height:40px; background:linear-gradient(135deg,#ffc107,#ff9800); border-radius:10px; display:flex; align-items:center; justify-content:center; font-size:20px; }
        .header-brand h2 { font-size:18px; font-weight:700; }
        .header-brand p  { font-size:12px; color:rgba(255,255,255,0.5); }
        .header a { color:rgba(255,255,255,0.6); text-decoration:none; font-size:13px; padding:8px 14px; border:1px solid rgba(255,255,255,0.2); border-radius:8px; }

        .container { max-width:600px; margin:0 auto; padding:24px 20px; }

        h3 { font-size:16px; font-weight:600; margin-bottom:16px; color:rgba(255,255,255,0.9); }

        /* Step cards */
        .step-card { background:rgba(255,255,255,0.06); border:1px solid rgba(255,255,255,0.1); border-radius:16px; padding:20px; margin-bottom:20px; }

        .step-number { width:28px; height:28px; background:linear-gradient(135deg,#ffc107,#ff9800); border-radius:50%; display:inline-flex; align-items:center; justify-content:center; font-size:13px; font-weight:700; color:#1a1a2e; margin-bottom:12px; }

        .form-group { margin-bottom:16px; }
        .form-group label { display:block; color:rgba(255,255,255,0.7); font-size:13px; font-weight:500; margin-bottom:8px; }
        .form-group select { width:100%; padding:12px 16px; background:rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.15); border-radius:10px; color:#fff; font-size:14px; font-family:'Poppins',sans-serif; outline:none; appearance:none; }
        .form-group select option { background:#1a1a2e; color:#fff; }
        .form-group select:focus { border-color:#ffc107; }

        /* Camera box */
        .camera-box { background:rgba(0,0,0,0.4); border:2px dashed rgba(255,255,255,0.2); border-radius:12px; overflow:hidden; position:relative; text-align:center; min-height:220px; display:flex; align-items:center; justify-content:center; margin-bottom:16px; }
        .camera-box video { width:100%; display:block; border-radius:10px; }
        .camera-placeholder { color:rgba(255,255,255,0.3); font-size:14px; padding:40px; }
        .camera-placeholder span { font-size:48px; display:block; margin-bottom:12px; }

        /* Scan line animation */
        .scan-line { position:absolute; top:0; left:0; right:0; height:3px; background:linear-gradient(90deg,transparent,#ffc107,transparent); animation:scandown 2s linear infinite; display:none; }
        @keyframes scandown { 0%{top:0} 100%{top:100%} }
        .scanning .scan-line { display:block; }

        /* Buttons */
        .btn-start { width:100%; padding:14px; background:linear-gradient(135deg,#ffc107,#ff9800); border:none; border-radius:12px; color:#1a1a2e; font-size:15px; font-weight:700; font-family:'Poppins',sans-serif; cursor:pointer; transition:all 0.2s; box-shadow:0 6px 16px rgba(255,193,7,0.35); }
        .btn-start:hover { transform:translateY(-2px); }
        .btn-stop { width:100%; padding:14px; background:rgba(245,101,101,0.2); border:1px solid rgba(245,101,101,0.4); border-radius:12px; color:#fc8181; font-size:15px; font-weight:700; font-family:'Poppins',sans-serif; cursor:pointer; transition:all 0.2s; display:none; }

        /* Result box */
        .result-box { border-radius:12px; padding:16px 20px; margin-bottom:20px; min-height:60px; display:flex; align-items:center; gap:12px; background:rgba(255,255,255,0.05); border:1px solid rgba(255,255,255,0.1); }
        .result-box.success { background:rgba(72,187,120,0.15); border-color:rgba(72,187,120,0.4); }
        .result-box.error   { background:rgba(245,101,101,0.15); border-color:rgba(245,101,101,0.4); }
        .result-icon { font-size:28px; flex-shrink:0; }
        .result-text h4 { font-size:16px; font-weight:700; }
        .result-text p  { font-size:13px; color:rgba(255,255,255,0.7); margin-top:2px; }

        /* Scanned log */
        .scanned-log { background:rgba(255,255,255,0.06); border:1px solid rgba(255,255,255,0.1); border-radius:16px; overflow:hidden; }
        .log-header { padding:14px 20px; border-bottom:1px solid rgba(255,255,255,0.08); display:flex; align-items:center; justify-content:space-between; }
        .log-header h3 { font-size:14px; font-weight:600; margin:0; }
        .log-count { background:rgba(255,193,7,0.2); color:#ffc107; padding:3px 10px; border-radius:20px; font-size:12px; font-weight:600; }
        table { width:100%; border-collapse:collapse; }
        thead th { padding:10px 16px; background:rgba(0,0,0,0.2); color:rgba(255,255,255,0.5); font-size:11px; font-weight:600; text-transform:uppercase; text-align:left; }
        tbody td { padding:12px 16px; font-size:13px; border-bottom:1px solid rgba(255,255,255,0.06); }
        tbody tr:last-child td { border-bottom:none; }
        .badge-b { background:rgba(72,187,120,0.2); color:#68d391; padding:2px 8px; border-radius:12px; font-size:11px; font-weight:600; }
        .badge-d { background:rgba(66,153,225,0.2); color:#76e4f7; padding:2px 8px; border-radius:12px; font-size:11px; font-weight:600; }
        .empty-log { text-align:center; padding:24px; color:rgba(255,255,255,0.3); font-size:13px; }
    </style>
</head>
<body>

<div class="header">
    <div class="header-brand">
        <div class="icon">🚌</div>
        <div><h2>SmartBus</h2><p>Driver Scan Page</p></div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/dashboard">← Admin</a>
</div>

<div class="container">

    <!-- Step 1 -->
    <div class="step-card">
        <div class="step-number">1</div>
        <h3>Select Bus & Event</h3>
        <div class="form-group">
            <label>🚌 Select Your Bus</label>
            <select id="busId">
                <option value="">-- Select Bus --</option>
                <c:forEach var="bus" items="${buses}">
                    <option value="${bus.busId}">${bus.busNumber} — ${bus.driverName} (${bus.route})</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>📍 Event Type</label>
            <select id="eventType">
                <option value="BOARDING">🟢 BOARDING — Student getting on bus</option>
                <option value="DROPOFF">🔵 DROPOFF — Student getting off bus</option>
            </select>
        </div>
    </div>

    <!-- Step 2 -->
    <div class="step-card">
        <div class="step-number">2</div>
        <h3>Scan Student QR Code</h3>

        <div class="camera-box" id="cameraBox">
            <div class="scan-line" id="scanLine"></div>
            <video id="cameraPreview" style="display:none;"></video>
            <div class="camera-placeholder" id="cameraPlaceholder">
                <span>📷</span>
                Click "Start Camera" to begin scanning
            </div>
        </div>

        <button onclick="startScanner()" id="startBtn" class="btn-start">📷 Start Camera & Scan</button>
        <button onclick="stopScanner()" id="stopBtn" class="btn-stop">⏹ Stop Camera</button>
    </div>

    <!-- Result -->
    <div class="result-box" id="resultBox">
        <span class="result-icon">📡</span>
        <div class="result-text">
            <h4>Waiting for scan...</h4>
            <p>Point the camera at a student's QR code</p>
        </div>
    </div>

    <!-- Scanned log -->
    <div class="scanned-log">
        <div class="log-header">
            <h3>✅ Scanned This Session</h3>
            <span class="log-count" id="scanCount">0 scanned</span>
        </div>
        <table>
            <thead>
                <tr><th>#</th><th>Student</th><th>Event</th><th>Time</th></tr>
            </thead>
            <tbody id="logBody">
                <tr><td colspan="4" class="empty-log">No scans yet this session</td></tr>
            </tbody>
        </table>
    </div>

</div>

<script>
    var codeReader   = new ZXing.BrowserQRCodeReader();
    var scanCount    = 0;
    var lastScanned  = "";
    var firstRow     = true;

    function startScanner() {
        var busId     = document.getElementById("busId").value;
        var eventType = document.getElementById("eventType").value;

        if (!busId) { alert("Please select a bus first!"); return; }

        document.getElementById("startBtn").style.display   = "none";
        document.getElementById("stopBtn").style.display    = "block";
        document.getElementById("cameraPlaceholder").style.display = "none";
        document.getElementById("cameraPreview").style.display     = "block";
        document.getElementById("cameraBox").classList.add("scanning");

        codeReader.decodeFromVideoDevice(null, "cameraPreview", function(result, err) {
            if (result) {
                var qrCode = result.getText();
                if (qrCode === lastScanned) return;
                lastScanned = qrCode;
                setTimeout(function() { lastScanned = ""; }, 3000);
                sendScan(qrCode, busId, eventType);
            }
        });
    }

    function stopScanner() {
        codeReader.reset();
        document.getElementById("cameraPreview").style.display     = "none";
        document.getElementById("cameraPlaceholder").style.display = "block";
        document.getElementById("startBtn").style.display          = "block";
        document.getElementById("stopBtn").style.display           = "none";
        document.getElementById("cameraBox").classList.remove("scanning");
    }

    function sendScan(qrCode, busId, eventType) {
        var box = document.getElementById("resultBox");
        box.className   = "result-box";
        box.innerHTML   = '<span class="result-icon">⏳</span><div class="result-text"><h4>Processing...</h4><p>' + qrCode + '</p></div>';

        fetch("${pageContext.request.contextPath}/attendance/scan", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "qrCode=" + encodeURIComponent(qrCode) + "&busId=" + encodeURIComponent(busId) + "&eventType=" + encodeURIComponent(eventType)
        })
        .then(function(r) { return r.text(); })
        .then(function(text) {
            if (text.startsWith("SUCCESS")) {
                var parts = text.split("|");
                var name  = parts[1];
                var evt   = parts[2];
                var time  = parts[3];

                box.className = "result-box success";
                box.innerHTML = '<span class="result-icon">✅</span><div class="result-text"><h4>' + name + '</h4><p>' + evt + ' recorded at ' + time + '</p></div>';

                // Add to log
                scanCount++;
                document.getElementById("scanCount").textContent = scanCount + " scanned";
                var tbody = document.getElementById("logBody");
                if (firstRow) { tbody.innerHTML = ""; firstRow = false; }
                var badge = evt === "BOARDING" ? '<span class="badge-b">🟢 BOARDING</span>' : '<span class="badge-d">🔵 DROPOFF</span>';
                tbody.insertAdjacentHTML("afterbegin",
                    "<tr><td>" + scanCount + "</td><td><strong>" + name + "</strong></td><td>" + badge + "</td><td>" + time + "</td></tr>"
                );
            } else {
                box.className = "result-box error";
                box.innerHTML = '<span class="result-icon">❌</span><div class="result-text"><h4>Scan Failed</h4><p>' + text + '</p></div>';
            }
        })
        .catch(function(e) {
            box.className = "result-box error";
            box.innerHTML = '<span class="result-icon">❌</span><div class="result-text"><h4>Network Error</h4><p>' + e + '</p></div>';
        });
    }
</script>
</body>
</html>
