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

@WebServlet("/WithdrawServ")
public class WithdrawServlet extends HttpServlet {

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

            // Check balance
            String checkSql =
                    "SELECT balance FROM bank WHERE accNo = ?";

            PreparedStatement checkPs =
                    con.prepareStatement(checkSql);

            checkPs.setInt(1, accountId);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {

                double balance = rs.getDouble("balance");

                if (balance >= amount) {

                    // Update balance
                    String updateSql =
                            "UPDATE bank "
                          + "SET balance = balance - ? "
                          + "WHERE accNo = ?";

                    PreparedStatement updatePs =
                            con.prepareStatement(updateSql);

                    updatePs.setDouble(1, amount);
                    updatePs.setInt(2, accountId);

                    int result = updatePs.executeUpdate();

                    if (result > 0) {

                        // Store transaction
                        String transactionSql =
                                "INSERT INTO transactions "
                              + "(account_id, type, amount, description) "
                              + "VALUES (?, ?, ?, ?)";

                        PreparedStatement transactionPs =
                                con.prepareStatement(transactionSql);

                        transactionPs.setInt(1, accountId);
                        transactionPs.setString(2, "Withdraw");
                        transactionPs.setDouble(3, amount);
                        transactionPs.setString(4, "Amount withdrawn");

                        transactionPs.executeUpdate();

                        transactionPs.close();

                        response.sendRedirect(
                                "withdraw.jsp?success=Amount withdrawn successfully");
                    }

                    updatePs.close();

                } else {

                    response.sendRedirect(
                            "withdraw.jsp?error=Insufficient balance");
                }
            }

            rs.close();
            checkPs.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Withdraw Error: " + e.getMessage());
        }
    }
}