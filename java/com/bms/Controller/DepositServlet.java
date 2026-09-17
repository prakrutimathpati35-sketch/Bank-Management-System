package com.bms.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bms.Connection.ProvideConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DepositServ")
public class DepositServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("accountId") == null) {

            response.sendRedirect("login.html");
            return;
        }

        int accountId = (Integer) session.getAttribute("accountId");

        double amount =
                Double.parseDouble(request.getParameter("amount"));

        try {

            Connection con = ProvideConnection.connectionKodi();

            // 1. Update bank balance
            String updateSql =
                    "UPDATE bank SET balance = balance + ? WHERE accNo = ?";

            PreparedStatement updatePs =
                    con.prepareStatement(updateSql);

            updatePs.setDouble(1, amount);
            updatePs.setInt(2, accountId);

            int result = updatePs.executeUpdate();

            if (result > 0) {

                // 2. Store transaction
                String transactionSql =
                        "INSERT INTO transactions "
                      + "(account_id, type, amount, description) "
                      + "VALUES (?, ?, ?, ?)";

                PreparedStatement transactionPs =
                        con.prepareStatement(transactionSql);

                transactionPs.setInt(1, accountId);
                transactionPs.setString(2, "Deposit");
                transactionPs.setDouble(3, amount);
                transactionPs.setString(4, "Amount deposited");

                transactionPs.executeUpdate();

                transactionPs.close();

                response.sendRedirect(
                        "Deposit.jsp?success=Amount deposited successfully");
            } else {

                response.sendRedirect(
                        "Deposit.jsp?error=Deposit failed");
            }

            updatePs.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Deposit Error: " + e.getMessage());
        }
    }
}