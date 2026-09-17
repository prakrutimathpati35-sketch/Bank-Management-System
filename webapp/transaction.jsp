<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.bms.Model.Transaction" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Transaction History</title>

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
    width: 92%;
    max-width: 1100px;

    margin: 40px auto;
}


/* Title */

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


/* Transaction Card */

.transaction-card {
    background: white;

    border-radius: 12px;

    box-shadow: 0 4px 15px rgba(0,0,0,0.10);

    overflow: hidden;
}


/* Card Header */

.card-header {
    background: #1976d2;

    color: white;

    padding: 20px;

    text-align: center;
}

.card-header h3 {
    font-size: 22px;
}


/* Table Container */

.table-container {
    width: 100%;

    overflow-x: auto;

    padding: 25px;
}


/* Table */

table {
    width: 100%;

    border-collapse: collapse;

    min-width: 750px;
}

th {
    background: #e3f2fd;

    color: #1565c0;

    padding: 15px;

    text-align: center;

    font-size: 15px;

    border-bottom: 2px solid #1976d2;
}

td {
    padding: 14px;

    text-align: center;

    color: #444;

    border-bottom: 1px solid #eeeeee;

    font-size: 14px;
}

tr:hover {
    background: #f8fbff;
}


/* Transaction Type */

.deposit {
    color: #2e7d32;

    font-weight: bold;
}

.withdraw {
    color: #d32f2f;

    font-weight: bold;
}

.transfer {
    color: #1976d2;

    font-weight: bold;
}


/* Amount */

.amount {
    font-weight: bold;

    color: #333;
}


/* No Transactions */

.no-transactions {
    text-align: center;

    padding: 50px;

    color: #777;

    font-size: 16px;
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


/* Mobile */

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

    .table-container {
        padding: 15px;
    }

}

</style>

</head>


<body>


<!-- Header -->

<div class="header">

    <h1>🏦 Bank Management System</h1>

    <a href="dashboard.jsp">
        Dashboard
    </a>

</div>



<!-- Main Container -->

<div class="container">


    <!-- Title -->

    <div class="title">

        <h2>Transaction History</h2>

        <p>
            View all your recent banking transactions
        </p>

    </div>



    <!-- Transaction Card -->

    <div class="transaction-card">


        <!-- Card Header -->

        <div class="card-header">

            <h3>📋 Transaction Details</h3>

        </div>



        <!-- Table -->

        <div class="table-container">

            <%
                List<Transaction> transactions =
                    (List<Transaction>) request.getAttribute("transactions");
            %>


            <% if (transactions != null && !transactions.isEmpty()) { %>


                <table>

                    <thead>

                        <tr>

                            <th>Transaction ID</th>

                            <th>Type</th>

                            <th>Amount</th>

                            <th>Description</th>

                            <th>Date & Time</th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (Transaction t : transactions) { %>

                        <tr>

                            <td>
                                <%= t.getTransactionId() %>
                            </td>


                            <td>

                                <%
                                    String type = t.getType();

                                    if ("Deposit".equalsIgnoreCase(type)) {
                                %>

                                    <span class="deposit">
                                        ⬆ Deposit
                                    </span>

                                <%
                                    } else if ("Withdraw".equalsIgnoreCase(type)) {
                                %>

                                    <span class="withdraw">
                                        ⬇ Withdraw
                                    </span>

                                <%
                                    } else {
                                %>

                                    <span class="transfer">
                                        ↔ <%= type %>
                                    </span>

                                <%
                                    }
                                %>

                            </td>


                            <td class="amount">

                                ₹ <%= String.format("%.2f",
                                        t.getAmount()) %>

                            </td>


                            <td>

                                <%= t.getDescription() %>

                            </td>


                            <td>

                                <%= t.getDate() %>

                            </td>

                        </tr>


                    <% } %>


                    </tbody>

                </table>


            <% } else { %>


                <!-- No Transactions -->

                <div class="no-transactions">

                    <h3>📭 No Transactions Found</h3>

                    <br>

                    <p>
                        You have not made any transactions yet.
                    </p>

                </div>


            <% } %>


        </div>



        <!-- Buttons -->

        <div class="buttons">

            <a href="Dashboard.jsp"
               class="btn dashboard-btn">

                ← Back to Dashboard

            </a>


            <a href="logout.jsp"
               class="btn logout-btn">

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