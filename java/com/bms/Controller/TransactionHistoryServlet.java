package com.bms.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bms.Connection.ProvideConnection;
import com.bms.Model.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TransactionHistoryServlet")
public class TransactionHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("accountId") == null) {

            response.sendRedirect("login.HTML");
            return;
        }

        int accountId =
                (Integer) session.getAttribute("accountId");

        List<Transaction> transactions =
                new ArrayList<>();

        try {

            Connection con =
                    ProvideConnection.connectionKodi();

            String sql =
                    "SELECT transaction_id, type, amount, "
                  + "description, transaction_date "
                  + "FROM transactions "
                  + "WHERE account_id = ? "
                  + "ORDER BY transaction_date DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, accountId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Transaction transaction =
                        new Transaction(
                                rs.getInt("transaction_id"),
                                rs.getString("type"),
                                rs.getDouble("amount"),
                                rs.getString("description"),
                                rs.getString("transaction_date")
                        );

                transactions.add(transaction);
            }

            request.setAttribute(
                    "transactions", transactions);

            request.getRequestDispatcher(
                    "transaction.jsp")
                    .forward(request, response);

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Transaction History Error: "
                    + e.getMessage());
        }
    }
}