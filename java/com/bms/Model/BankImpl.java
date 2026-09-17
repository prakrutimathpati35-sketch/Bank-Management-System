package com.bms.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bms.Connection.ProvideConnection;
import com.bms.DTO.Customer;

public class BankImpl {
	 public static boolean createAccount(
	            String name,
	            String email,
	            long phone,
	            String pass)
	            throws ClassNotFoundException, SQLException {

	        Connection con = ProvideConnection.connectionKodi();

	        String query =
	                "INSERT INTO bank(name,email,phone,password) VALUES(?,?,?,?)";

	        PreparedStatement ps = con.prepareStatement(query);

	        ps.setString(1, name);
	        ps.setString(2, email);
	        ps.setLong(3, phone);
	        ps.setString(4, pass);

	        int result = ps.executeUpdate();

	        con.close();

	        return result > 0;
	    }

	 public static Customer login(String email,String pass) throws ClassNotFoundException, SQLException {
			Connection con=ProvideConnection.connectionKodi();
			String sqry="select * from bank where email=? and password=?";
			PreparedStatement ps=con.prepareStatement(sqry);
			ps.setString(1, email);
			ps.setString(2, pass);
			
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				int accNo=rs.getInt(1);
				String name=rs.getString(2);
				String email1=rs.getString(3);
				long phone=rs.getLong(4);
				double  bal=rs.getDouble(5);
				String passw=rs.getString(6);
				
				Customer c=new Customer();
				c.setAccNo(accNo);
				c.setName(name);
				c.setEmail(email1);
				c.setPhone(phone);
				c.setBalance(bal);
				c.setPassword(passw);
				return c;
			}
			else {
				return null;
			}

		}
	 public static boolean deposit(int accNo, double amount)
		        throws ClassNotFoundException, SQLException {

		    Connection con = ProvideConnection.connectionKodi();

		    String query = "UPDATE bank SET balance = balance + ? WHERE accNo = ?";

		    PreparedStatement ps = con.prepareStatement(query);

		    ps.setDouble(1, amount);
		    ps.setInt(2, accNo);

		    int result = ps.executeUpdate();

		    ps.close();
		    con.close();

		    return result > 0;
		}
	 public static boolean withdraw(int accNo, double amount)
		        throws ClassNotFoundException, SQLException {

		    Connection con = ProvideConnection.connectionKodi();

		    String query =
		        "UPDATE bank SET balance = balance - ? " +
		        "WHERE accNo = ? AND balance >= ?";

		    PreparedStatement ps = con.prepareStatement(query);

		    ps.setDouble(1, amount);
		    ps.setInt(2, accNo);
		    ps.setDouble(3, amount);

		    int result = ps.executeUpdate();

		    ps.close();
		    con.close();

		    return result > 0;
		}
	 public static boolean transfer(int senderAccNo, int receiverAccNo, double amount)
		        throws ClassNotFoundException, SQLException {

		    Connection con = ProvideConnection.connectionKodi();

		    try {

		        // Start transaction
		        con.setAutoCommit(false);

		        // Don't allow invalid transfer
		        if (amount <= 0 || senderAccNo == receiverAccNo) {
		            con.rollback();
		            return false;
		        }

		        // Check sender balance
		        String checkQuery =
		                "SELECT balance FROM bank WHERE accNo=?";

		        PreparedStatement checkPs =
		                con.prepareStatement(checkQuery);

		        checkPs.setInt(1, senderAccNo);

		        ResultSet rs = checkPs.executeQuery();

		        if (!rs.next()) {
		            rs.close();
		            checkPs.close();
		            con.rollback();
		            return false;
		        }

		        double senderBalance = rs.getDouble("balance");

		        rs.close();
		        checkPs.close();

		        // Check sufficient balance
		        if (senderBalance < amount) {
		            con.rollback();
		            return false;
		        }

		        // Check receiver exists
		        String receiverCheck =
		                "SELECT accNo FROM bank WHERE accNo=?";

		        PreparedStatement receiverPs =
		                con.prepareStatement(receiverCheck);

		        receiverPs.setInt(1, receiverAccNo);

		        ResultSet receiverRs = receiverPs.executeQuery();

		        if (!receiverRs.next()) {
		            receiverRs.close();
		            receiverPs.close();
		            con.rollback();
		            return false;
		        }

		        receiverRs.close();
		        receiverPs.close();


		        // Deduct money from sender
		        String senderQuery =
		                "UPDATE bank SET balance=balance-? WHERE accNo=?";

		        PreparedStatement senderPs =
		                con.prepareStatement(senderQuery);

		        senderPs.setDouble(1, amount);
		        senderPs.setInt(2, senderAccNo);

		        int senderResult = senderPs.executeUpdate();

		        senderPs.close();


		        if (senderResult == 0) {
		            con.rollback();
		            return false;
		        }


		        // Add money to receiver
		        String receiverQuery =
		                "UPDATE bank SET balance=balance+? WHERE accNo=?";

		        PreparedStatement receiverUpdatePs =
		                con.prepareStatement(receiverQuery);

		        receiverUpdatePs.setDouble(1, amount);
		        receiverUpdatePs.setInt(2, receiverAccNo);

		        int receiverResult =
		                receiverUpdatePs.executeUpdate();

		        receiverUpdatePs.close();


		        if (receiverResult == 0) {
		            con.rollback();
		            return false;
		        }


		        // Both operations successful
		        con.commit();

		        return true;

		    } catch (SQLException e) {

		        con.rollback();
		        throw e;

		    } finally {

		        con.setAutoCommit(true);
		        con.close();
		    }
		}
}



	   
