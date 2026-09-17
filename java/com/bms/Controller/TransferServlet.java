package com.bms.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bms.Connection.ProvideConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TransferServ")
public class TransferServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("accountId") == null) {

            response.sendRedirect("login.html");
            return;
        }

        int senderAccount =
                (Integer) session.getAttribute("accountId");

        String receiverAccountText =
                request.getParameter("receiverAccount");

        String amountText =
                request.getParameter("amount");

        try {

            int receiverAccount =
                    Integer.parseInt(receiverAccountText);

            double amount =
                    Double.parseDouble(amountText);

            // Amount validation
            if (amount <= 0) {
                response.sendRedirect(
                    "transfer.jsp?error=Enter a valid amount");
                return;
            }

            // Sender and receiver cannot be same
            if (senderAccount == receiverAccount) {
                response.sendRedirect(
                    "transfer.jsp?error=Cannot transfer to your own account");
                return;
            }

            Connection con =
                    ProvideConnection.connectionKodi();

            // Start database transaction
            con.setAutoCommit(false);

            try {

                // ------------------------------------
                // 1. Check sender balance
                // ------------------------------------

                String senderSql =
                        "SELECT balance FROM bank WHERE accNo=?";

                PreparedStatement senderPs =
                        con.prepareStatement(senderSql);

                senderPs.setInt(1, senderAccount);

                ResultSet senderRs =
                        senderPs.executeQuery();

                if (!senderRs.next()) {

                    con.rollback();

                    response.sendRedirect(
                        "transfer.jsp?error=Sender account not found");

                    senderRs.close();
                    senderPs.close();
                    con.close();
                    return;
                }

                double senderBalance =
                        senderRs.getDouble("balance");

                senderRs.close();
                senderPs.close();


                // ------------------------------------
                // 2. Check sufficient balance
                // ------------------------------------

                if (senderBalance < amount) {

                    con.rollback();

                    response.sendRedirect(
                        "transfer.jsp?error=Insufficient balance");

                    con.close();
                    return;
                }


                // ------------------------------------
                // 3. Check receiver account
                // ------------------------------------

                String receiverCheckSql =
                        "SELECT accNo FROM bank WHERE accNo=?";

                PreparedStatement receiverCheckPs =
                        con.prepareStatement(receiverCheckSql);

                receiverCheckPs.setInt(1, receiverAccount);

                ResultSet receiverRs =
                        receiverCheckPs.executeQuery();

                if (!receiverRs.next()) {

                    con.rollback();

                    response.sendRedirect(
                        "transfer.jsp?error=Receiver account not found");

                    receiverRs.close();
                    receiverCheckPs.close();
                    con.close();
                    return;
                }

                receiverRs.close();
                receiverCheckPs.close();


                // ------------------------------------
                // 4. Deduct from sender
                // ------------------------------------

                String senderUpdateSql =
                        "UPDATE bank " +
                        "SET balance = balance - ? " +
                        "WHERE accNo=?";

                PreparedStatement senderUpdatePs =
                        con.prepareStatement(senderUpdateSql);

                senderUpdatePs.setDouble(1, amount);
                senderUpdatePs.setInt(2, senderAccount);

                int senderResult =
                        senderUpdatePs.executeUpdate();

                senderUpdatePs.close();


                // ------------------------------------
                // 5. Add to receiver
                // ------------------------------------

                String receiverUpdateSql =
                        "UPDATE bank " +
                        "SET balance = balance + ? " +
                        "WHERE accNo=?";

                PreparedStatement receiverUpdatePs =
                        con.prepareStatement(receiverUpdateSql);

                receiverUpdatePs.setDouble(1, amount);
                receiverUpdatePs.setInt(2, receiverAccount);

                int receiverResult =
                        receiverUpdatePs.executeUpdate();

                receiverUpdatePs.close();


                // ------------------------------------
                // 6. Store sender transaction
                // ------------------------------------

                if (senderResult > 0 &&
                    receiverResult > 0) {

                    String transactionSql =
                            "INSERT INTO transactions " +
                            "(account_id, type, amount, description) " +
                            "VALUES (?, ?, ?, ?)";

                    PreparedStatement transactionPs =
                            con.prepareStatement(transactionSql);

                    transactionPs.setInt(1, senderAccount);
                    transactionPs.setString(2, "Transfer");
                    transactionPs.setDouble(3, amount);

                    transactionPs.setString(
                            4,
                            "Transferred to Account No: "
                            + receiverAccount);

                    transactionPs.executeUpdate();

                    transactionPs.close();


                    // ------------------------------------
                    // 7. Store receiver transaction
                    // ------------------------------------

                    PreparedStatement receiverTransactionPs =
                            con.prepareStatement(transactionSql);

                    receiverTransactionPs.setInt(
                            1, receiverAccount);

                    receiverTransactionPs.setString(
                            2, "Transfer Received");

                    receiverTransactionPs.setDouble(
                            3, amount);

                    receiverTransactionPs.setString(
                            4,
                            "Received from Account No: "
                            + senderAccount);

                    receiverTransactionPs.executeUpdate();

                    receiverTransactionPs.close();


                    // Everything successful
                    con.commit();


                    response.sendRedirect(
                        "transfer.jsp?success=Amount transferred successfully");

                } else {

                    // Something failed
                    con.rollback();

                    response.sendRedirect(
                        "transfer.jsp?error=Transfer failed");
                }

            } catch (Exception e) {

                // Undo all changes if any error occurs
                con.rollback();

                throw e;

            } finally {

                con.setAutoCommit(true);
                con.close();
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "transfer.jsp?error=Enter valid account number and amount");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Transfer Error: " + e.getMessage());
        }
    }
}