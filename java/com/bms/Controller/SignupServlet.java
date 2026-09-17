package com.bms.Controller;

import java.io.IOException;

import com.bms.Model.BankImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/SignupServ")
public class SignupServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {

	        String name = req.getParameter("name");
	        String email = req.getParameter("email");
	        long phone = Long.parseLong(req.getParameter("phone"));
	        String password = req.getParameter("password");

	        try {

	            boolean result =
	                    BankImpl.createAccount(
	                            name,
	                            email,
	                            phone,
	                            password
	                    );

	            if (result) {
	                resp.sendRedirect("login.html");
	            } else {
	                resp.getWriter()
	                        .println("Account creation failed");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            resp.getWriter()
	                    .println("Database Error: " + e.getMessage());
	        }
	    }
	}


