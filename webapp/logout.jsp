<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Get current session
    session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>

<body style="
    margin: 0;
    padding: 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    display: flex;
    justify-content: center;
    align-items: center;
">

    <div style="
        width: 400px;
        background: white;
        padding: 45px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    ">

        <div style="
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #e8f5e9;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 40px;
        ">
            ✓
        </div>

        <h1 style="
            color: #2e7d32;
            margin-bottom: 10px;
        ">
            Logout Successful
        </h1>

        <p style="
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        ">
            You have been successfully logged out.
        </p>

        <a href="login.html"
           style="
               display: inline-block;
               padding: 13px 30px;
               background: linear-gradient(135deg, #1565c0, #42a5f5);
               color: white;
               text-decoration: none;
               border-radius: 8px;
               font-weight: bold;
           ">
            🔐 Login Again
        </a>

    </div>

</body>
</html>