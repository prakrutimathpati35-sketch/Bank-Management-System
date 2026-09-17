<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfer Money</title>
</head>

<body style="
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #ede7f6, #d1c4e9);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
">

    <div style="
        width: 420px;
        background: white;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    ">

        <!-- Heading -->

        <h1 style="
            text-align: center;
            color: #6a1b9a;
            margin-bottom: 10px;
        ">
            🔄 Transfer Money
        </h1>

        <p style="
            text-align: center;
            color: #777;
            margin-bottom: 30px;
        ">
            Transfer money securely to another account
        </p>


        <form action="TransferServ" method="post">

            <!-- Sender Account Number -->

            <label style="
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            ">
                Your Account Number
            </label>

            <input type="number"
                   name="senderAccount"
                   placeholder="Enter your account number"
                   required
                   style="
                       width: 100%;
                       padding: 13px;
                       margin-bottom: 20px;
                       border: 1px solid #ccc;
                       border-radius: 8px;
                       box-sizing: border-box;
                       font-size: 15px;
                   ">


            <!-- Receiver Account Number -->

            <label style="
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            ">
                Receiver Account Number
            </label>

            <input type="number"
                   name="receiverAccount"
                   placeholder="Enter receiver account number"
                   required
                   style="
                       width: 100%;
                       padding: 13px;
                       margin-bottom: 20px;
                       border: 1px solid #ccc;
                       border-radius: 8px;
                       box-sizing: border-box;
                       font-size: 15px;
                   ">


            <!-- Amount -->

            <label style="
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            ">
                Transfer Amount
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
                   ">


            <!-- Transfer Button -->

            <button type="submit"
                    style="
                        width: 100%;
                        padding: 14px;
                        border: none;
                        border-radius: 8px;
                        background: linear-gradient(135deg, #6a1b9a, #ab47bc);
                        color: white;
                        font-size: 16px;
                        font-weight: bold;
                        cursor: pointer;
                    ">
                🔄 Transfer Money
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