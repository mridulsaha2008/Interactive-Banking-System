package DataHandlers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import DatabaseConnector.SQLConnection;

public class Dashboard {
	public boolean fetchData(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("accountNumber") == null) {
			return false;
		}

		long accNum = Long.parseLong(session.getAttribute("accountNumber").toString());

		try (Connection connect = SQLConnection.getConnection()) {
			String customerSql = "SELECT * FROM CUSTOMER WHERE ACCOUNT_NUMBER = ?";
			try (PreparedStatement custStmt = connect.prepareStatement(customerSql)) {
				custStmt.setLong(1, accNum);
				try (ResultSet rs = custStmt.executeQuery()) {
					if (rs.next()) {
						session.setAttribute("fatherName", rs.getString("FATHER_NAME"));
						session.setAttribute("income", rs.getString("INCOME"));
						session.setAttribute("aadhaarNumber", rs.getString("AADHAAR_NUMBER"));
						session.setAttribute("email", rs.getString("EMAIL"));
						session.setAttribute("panNumber", rs.getString("PAN_NUMBER"));
						session.setAttribute("dob", rs.getDate("DOB"));
						session.setAttribute("mobileNumber", rs.getString("MOBILE_NUMBER"));
						session.setAttribute("firstName", rs.getString("FIRST_NAME"));
						session.setAttribute("lastName", rs.getString("LAST_NAME"));
						session.setAttribute("balance", rs.getDouble("BALANCE"));
						session.setAttribute("city", rs.getString("CITY"));
						session.setAttribute("state", rs.getString("STATE"));
						session.setAttribute("zipcode", rs.getString("ZIPCODE"));
						session.setAttribute("address", rs.getString("ADDRESS"));
						session.setAttribute("accountCreationDate", rs.getTimestamp("CREATION_DATE"));
					} else {
						return false;
					}
				}
			}

			String transSql = "SELECT * FROM TRANSACTION WHERE ACCOUNT_NUMBER = ? ORDER BY DATE_TIME DESC";
			try (PreparedStatement transStmt = connect.prepareStatement(transSql)) {
				transStmt.setLong(1, accNum);
				try (ResultSet rs2 = transStmt.executeQuery()) {
					List<Transaction> transactions = new ArrayList<>();
					while (rs2.next()) {
						Transaction t = new Transaction();
					    t.setId(rs2.getString("TRANSACTION_ID"));
					    t.setDateTime(rs2.getTimestamp("DATE_TIME"));
					    t.setType(rs2.getString("TRANSACTION_TYPE"));
					    t.setDescription(rs2.getString("DESCRIPTION"));
					    t.setAmount(rs2.getDouble("AMOUNT"));
					    transactions.add(t);
					}
					session.setAttribute("transactionList", transactions);
				}
			}
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}