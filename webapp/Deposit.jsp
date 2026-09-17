<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Money</title>
</head>

<body style="
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #e3f2fd, #90caf9);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
">

    <div style="
        width: 400px;
        background: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    ">

        <h1 style="
            text-align: center;
            color: #1565c0;
            margin-bottom: 10px;
        ">
            🏦 Deposit Money
        </h1>

        <p style="
            text-align: center;
            color: #777;
            margin-bottom: 30px;
        ">
            Add money to your bank account
        </p>


        <form action="DepositServ" method="post">

            <!-- Account Number -->

            <label style="
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            ">
                Account Number
            </label>

            <input type="number"
                   name="accountNumber"
                   placeholder="Enter account number"
                   required
                   style="
                       width: 100%;
                       padding: 13px;
                       margin-bottom: 20px;
                       border: 1px solid #ccc;
                       border-radius: 8px;
                       box-sizing: border-box;
                       font-size: 15px;
                       outline: none;
                   ">


            <!-- Amount -->

            <label style="
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            ">
                Amount
            </label>

            <input type="number"
                   name="amount"
                   placeholder="Enter amount"
                   min="1"
                   step="0.01"
                   required
                   style="
                       width: 100%;
                       padding: 13px;
                       margin-bottom: 25px;
                       border: 1px solid #ccc;
                       border-radius: 8px;
                       box-sizing: border-box;
                       font-size: 15px;
                       outline: none;
                   ">


            <!-- Deposit Button -->

            <button type="submit"
                    style="
                        width: 100%;
                        padding: 14px;
                        border: none;
                        border-radius: 8px;
                        background: linear-gradient(135deg, #1565c0, #42a5f5);
                        color: white;
                        font-size: 16px;
                        font-weight: bold;
                        cursor: pointer;
                    ">
                💰 Deposit Money
            </button>

        </form>


        <!-- Back to Dashboard -->

        <div style="
            text-align: center;
            margin-top: 25px;
        ">

            <a href="Dashboard.jsp"
               style="
                   color: #1565c0;
                   text-decoration: none;
                   font-weight: bold;
               ">
                ← Back to Dashboard
            </a>

        </div>

    </div>

</body>
</html>