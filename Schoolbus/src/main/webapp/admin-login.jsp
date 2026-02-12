<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - SmartBus System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body::before {
            content: '';
            position: fixed;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(255,193,7,0.15) 0%, transparent 70%);
            top: -100px; right: -100px;
            border-radius: 50%;
            animation: pulse 4s ease-in-out infinite;
        }

        body::after {
            content: '';
            position: fixed;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(255,193,7,0.10) 0%, transparent 70%);
            bottom: -80px; left: -80px;
            border-radius: 50%;
            animation: pulse 4s ease-in-out infinite reverse;
        }

        @keyframes pulse {
            0%,100% { transform:scale(1); opacity:0.7; }
            50%      { transform:scale(1.1); opacity:1; }
        }

        @keyframes float {
            0%,100% { transform:translateY(0); }
            50%      { transform:translateY(-8px); }
        }

        .login-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 440px;
            padding: 20px;
        }

        .brand {
            text-align: center;
            margin-bottom: 28px;
        }

        .brand-icon {
            width: 70px; height: 70px;
            background: linear-gradient(135deg, #ffc107, #ff9800);
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin-bottom: 12px;
            box-shadow: 0 10px 30px rgba(255,193,7,0.4);
            animation: float 3s ease-in-out infinite;
        }

        .brand h1 { color:#fff; font-size:24px; font-weight:700; letter-spacing:1px; }
        .brand p  { color:rgba(255,255,255,0.5); font-size:13px; margin-top:4px; }

        .login-card {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 24px;
            padding: 40px 36px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
        }

        .login-card h2    { color:#fff; font-size:22px; font-weight:600; margin-bottom:6px; }
        .login-card .sub  { color:rgba(255,255,255,0.45); font-size:13px; margin-bottom:28px; }

        .error-msg {
            background: rgba(244,67,54,0.15);
            border: 1px solid rgba(244,67,54,0.4);
            color: #ff6b6b;
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .input-group            { margin-bottom:20px; }
        .input-group label      { display:block; color:rgba(255,255,255,0.7); font-size:13px; font-weight:500; margin-bottom:8px; }
        .input-group input {
            width: 100%;
            padding: 14px 18px;
            background: rgba(255,255,255,0.07);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 12px;
            color: #fff;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
            outline: none;
        }
        .input-group input::placeholder { color:rgba(255,255,255,0.25); }
        .input-group input:focus {
            border-color: #ffc107;
            background: rgba(255,193,7,0.08);
            box-shadow: 0 0 0 3px rgba(255,193,7,0.15);
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #ffc107, #ff9800);
            border: none;
            border-radius: 12px;
            color: #1a1a2e;
            font-size: 15px;
            font-weight: 700;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 8px;
            box-shadow: 0 8px 20px rgba(255,193,7,0.35);
        }
        .btn-login:hover { transform:translateY(-2px); box-shadow:0 12px 28px rgba(255,193,7,0.5); }

        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 24px 0 16px;
        }
        .divider hr   { flex:1; border:none; border-top:1px solid rgba(255,255,255,0.1); }
        .divider span { color:rgba(255,255,255,0.3); font-size:12px; }

        .bottom-link { text-align:center; }
        .bottom-link a { color:#ffc107; text-decoration:none; font-size:13px; font-weight:500; }
        .bottom-link a:hover { text-decoration:underline; }
    </style>
</head>
<body>

<div class="login-wrapper">

    <div class="brand">
        <div class="brand-icon">🚌</div>
        <h1>SmartBus</h1>
        <p>School Children Transportation System</p>
    </div>

    <div class="login-card">
        <h2>Admin Login</h2>
        <p class="sub">Sign in to manage the system</p>

        <c:if test="${not empty error}">
            <div class="error-msg">⚠️ ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="input-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter admin username" required />
            </div>
            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required />
            </div>
            <button type="submit" class="btn-login">Login to Dashboard →</button>
        </form>

        <div class="divider"><hr/><span>OR</span><hr/></div>

        <div class="bottom-link">
            <a href="${pageContext.request.contextPath}/parent/login">Are you a Parent? Login here →</a>
        </div>
    </div>

</div>
</body>
</html>
