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

@WebServlet("/LoginServ")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = ProvideConnection.connectionKodi();

            String sql = "SELECT accNo, name, email, phone, password, balance "
                       + "FROM bank WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();

                // Store account number
                session.setAttribute("accountId",
                        rs.getInt("accNo"));

                session.setAttribute("name",
                        rs.getString("name"));

                session.setAttribute("email",
                        rs.getString("email"));

                session.setAttribute("phone",
                        rs.getString("phone"));

                session.setAttribute("balance",
                        rs.getDouble("balance"));

                response.sendRedirect("Dashboard.jsp");

            } else {

                response.sendRedirect(
                    "login.html?error=Invalid email or password"
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Login Error: " + e.getMessage()
            );
        }
    }
}