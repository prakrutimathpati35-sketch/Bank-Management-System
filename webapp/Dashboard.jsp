<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Get logged-in user's email from session
    String email = (String) session.getAttribute("email");

    // If user is not logged in, redirect to login
    if (email == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Dashboard</title>
</head>

<body style="
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    min-height: 100vh;
">

    <!-- Header -->

    <div style="
        background: linear-gradient(135deg, #0d47a1, #1976d2);
        color: white;
        padding: 20px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    ">

        <div>
            <h1 style="
                margin: 0;
                font-size: 26px;
            ">
                🏦 Bank Management System
            </h1>

            <p style="
                margin: 5px 0 0;
                font-size: 14px;
                opacity: 0.9;
            ">
                Secure Banking Dashboard
            </p>
        </div>

        <div style="
            text-align: right;
        ">
            <span style="
                font-size: 14px;
            ">
                Welcome
            </span>

            <br>

            <strong style="
                font-size: 15px;
            ">
                <%= email %>
            </strong>
        </div>

    </div>


    <!-- Main Content -->

    <div style="
        max-width: 1100px;
        margin: 50px auto;
        padding: 0 25px;
    ">

        <h2 style="
            color: #0d47a1;
            text-align: center;
            margin-bottom: 10px;
        ">
            Welcome to Your Dashboard
        </h2>

        <p style="
            text-align: center;
            color: #666;
            margin-bottom: 40px;
        ">
            Manage your bank account easily and securely
        </p>


        <!-- Cards -->

        <div style="
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        ">


            <!-- View Account -->

            <a href="ViewAccountServlet"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        👤
                    </div>

                    <h3 style="
                        color: #1565c0;
                        margin: 10px 0;
                    ">
                        View Account
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        View your account details and balance
                    </p>

                </div>

            </a>


            <!-- Deposit -->

            <a href="Deposit.jsp"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        💰
                    </div>

                    <h3 style="
                        color: #2e7d32;
                        margin: 10px 0;
                    ">
                        Deposit
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        Add money to your bank account
                    </p>

                </div>

            </a>


            <!-- Withdraw -->

            <a href="withdraw.jsp"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        💸
                    </div>

                    <h3 style="
                        color: #ef6c00;
                        margin: 10px 0;
                    ">
                        Withdraw
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        Withdraw money from your account
                    </p>

                </div>

            </a>


            <!-- Transfer -->

            <a href="transfer.jsp"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        🔄
                    </div>

                    <h3 style="
                        color: #6a1b9a;
                        margin: 10px 0;
                    ">
                        Transfer Money
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        Transfer money to another account
                    </p>

                </div>

            </a>


            <!-- Transaction History -->

            <a href="TransactionHistoryServlet"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        📋
                    </div>

                    <h3 style="
                        color: #00838f;
                        margin: 10px 0;
                    ">
                        Transaction History
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        View your previous transactions
                    </p>

                </div>

            </a>


            <!-- Logout -->

            <a href="logout.jsp"
               style="
                   text-decoration: none;
                   color: inherit;
               ">

                <div style="
                    background: white;
                    padding: 30px 20px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.12);
                ">

                    <div style="
                        font-size: 42px;
                        margin-bottom: 15px;
                    ">
                        🚪
                    </div>

                    <h3 style="
                        color: #c62828;
                        margin: 10px 0;
                    ">
                        Logout
                    </h3>

                    <p style="
                        color: #777;
                        font-size: 14px;
                    ">
                        Logout securely from your account
                    </p>

                </div>

            </a>

        </div>

    </div>


    <!-- Footer -->

    <div style="
        text-align: center;
        padding: 25px;
        color: #777;
        font-size: 13px;
    ">
        © 2026 Bank Management System | Secure Banking
    </div>

</body>
</html>