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

@WebServlet("/ViewAccountServlet")
public class ViewAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("accountId") == null) {

            response.sendRedirect("login.html");
            return;
        }

        int accNo = (Integer) session.getAttribute("accountId");

        try {

            Connection con =
                    ProvideConnection.connectionKodi();

            String sql =
                    "SELECT accNo, name, email, phone, balance "
                  + "FROM bank WHERE accNo=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, accNo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute(
                    "accNo",
                    rs.getInt("accNo")
                );

                request.setAttribute(
                    "name",
                    rs.getString("name")
                );

                request.setAttribute(
                    "email",
                    rs.getString("email")
                );

                request.setAttribute(
                    "phone",
                    rs.getString("phone")
                );

                request.setAttribute(
                    "balance",
                    rs.getDouble("balance")
                );

                request.getRequestDispatcher(
                    "view.jsp"
                ).forward(request, response);

            } else {

                response.getWriter().println(
                    "Account not found."
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "View Account Error: " + e.getMessage()
            );
        }
    }
}