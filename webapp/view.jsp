<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Account</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        background: #f4f7fb;
        min-height: 100vh;
    }

    /* Header */
    .header {
        background: #1976d2;
        color: white;
        padding: 20px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }

    .header h1 {
        font-size: 26px;
    }

    .header a {
        color: white;
        text-decoration: none;
        background: #1565c0;
        padding: 10px 18px;
        border-radius: 6px;
        font-size: 14px;
    }

    .header a:hover {
        background: #0d47a1;
    }

    /* Main Container */
    .container {
        width: 90%;
        max-width: 850px;
        margin: 40px auto;
    }

    .title {
        text-align: center;
        margin-bottom: 25px;
    }

    .title h2 {
        color: #1976d2;
        font-size: 28px;
        margin-bottom: 8px;
    }

    .title p {
        color: #777;
        font-size: 15px;
    }

    /* Account Card */
    .account-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.10);
        overflow: hidden;
    }

    .card-header {
        background: #1976d2;
        color: white;
        padding: 20px;
        text-align: center;
    }

    .card-header h3 {
        font-size: 22px;
    }

    .account-details {
        padding: 30px 40px;
    }

    .detail-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 17px 10px;
        border-bottom: 1px solid #eeeeee;
    }

    .detail-row:last-child {
        border-bottom: none;
    }

    .label {
        font-weight: bold;
        color: #555;
    }

    .value {
        color: #222;
        font-size: 16px;
    }

    .balance {
        color: #2e7d32;
        font-weight: bold;
        font-size: 20px;
    }

    /* Buttons */
    .buttons {
        text-align: center;
        padding: 0 30px 30px;
    }

    .btn {
        display: inline-block;
        padding: 12px 25px;
        margin: 5px;
        border-radius: 7px;
        text-decoration: none;
        color: white;
        font-size: 15px;
        font-weight: bold;
    }

    .dashboard-btn {
        background: #1976d2;
    }

    .dashboard-btn:hover {
        background: #0d47a1;
    }

    .logout-btn {
        background: #d32f2f;
    }

    .logout-btn:hover {
        background: #b71c1c;
    }

    /* Footer */
    .footer {
        text-align: center;
        color: #777;
        font-size: 14px;
        margin-top: 30px;
        padding-bottom: 20px;
    }

    /* Mobile Design */
    @media (max-width: 600px) {

        .header {
            padding: 18px 20px;
        }

        .header h1 {
            font-size: 20px;
        }

        .container {
            width: 95%;
            margin: 25px auto;
        }

        .account-details {
            padding: 20px;
        }

        .detail-row {
            flex-direction: column;
            align-items: flex-start;
            gap: 6px;
        }
    }
</style>

</head>

<body>

<!-- Header -->
<div class="header">

    <h1>🏦 Bank Management System</h1>

    <a href="dashboard.jsp">Dashboard</a>

</div>


<!-- Main Content -->
<div class="container">

    <div class="title">
        <h2>Account Details</h2>
        <p>View your registered bank account information</p>
    </div>


    <!-- Account Card -->
    <div class="account-card">

        <div class="card-header">
            <h3>👤 Account Information</h3>
        </div>


        <div class="account-details">

            <div class="detail-row">
                <span class="label">Account Number</span>
                <span class="value">
                    <%= request.getAttribute("accNo") %>
                </span>
            </div>


            <div class="detail-row">
                <span class="label">Account Holder Name</span>
                <span class="value">
                    <%= request.getAttribute("name") %>
                </span>
            </div>


            <div class="detail-row">
                <span class="label">Email</span>
                <span class="value">
                    <%= request.getAttribute("email") %>
                </span>
            </div>


            <div class="detail-row">
                <span class="label">Phone Number</span>
                <span class="value">
                    <%= request.getAttribute("phone") %>
                </span>
            </div>


            <div class="detail-row">
                <span class="label">Available Balance</span>
                <span class="value balance">
                    ₹ <%= request.getAttribute("balance") %>
                </span>
            </div>

        </div>


        <!-- Buttons -->
        <div class="buttons">

            <a href="Dashboard.jsp" class="btn dashboard-btn">
                ← Back to Dashboard
            </a>

            <a href="logout.jsp" class="btn logout-btn">
                Logout
            </a>

        </div>

    </div>

</div>


<!-- Footer -->
<div class="footer">
    © 2026 Bank Management System | All Rights Reserved
</div>

</body>
</html>