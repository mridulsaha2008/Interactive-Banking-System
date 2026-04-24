package DataHandlers;

import java.sql.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import DatabaseConnector.SQLConnection;

public class TransactionHandler {

	public boolean transact(HttpServletRequest request) throws ClassNotFoundException {
		HttpSession session = request.getSession();
		Long senderAcc = (Long) session.getAttribute("accountNumber");
		Long recipientAcc = Long.parseLong(request.getParameter("recipient-account"));
		String pinEntered = request.getParameter("transactionPin");
		String pinStored = (String) session.getAttribute("pinHash");
		Double amount = Double.parseDouble(request.getParameter("amount"));

		if (!pinEntered.equals(pinStored)) {
			session.setAttribute("errorMessage", "Incorrect Transaction PIN!");
			return false;
		}
		if (senderAcc.equals(recipientAcc)) {
			session.setAttribute("errorMessage", "Cannot transfer to your own account!");
			return false;
		}

		try (Connection connect = SQLConnection.getConnection()) {
			connect.setAutoCommit(false);

			try {
				double senderBalance = 0;
				String recipientName = "";

				try (PreparedStatement ps = connect.prepareStatement(
						"SELECT FIRST_NAME, LAST_NAME, BALANCE FROM CUSTOMER WHERE ACCOUNT_NUMBER = ? FOR UPDATE")) {
					ps.setLong(1, senderAcc);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							senderBalance = rs.getDouble("BALANCE");
						else
							throw new Exception("Sender account not found!");
					}
				}

				if (senderBalance < amount)
					throw new Exception("Insufficient Balance!");

				try (PreparedStatement ps = connect
						.prepareStatement("SELECT FIRST_NAME, LAST_NAME FROM CUSTOMER WHERE ACCOUNT_NUMBER = ?")) {
					ps.setLong(1, recipientAcc);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next())
							recipientName = rs.getString("FIRST_NAME") + " " + rs.getString("LAST_NAME");
						else
							throw new Exception("Recipient account does not exist!");
					}
				}

				String insertSql = "INSERT INTO TRANSACTION(ACCOUNT_NUMBER, AMOUNT, DESCRIPTION, TRANSACTION_TYPE) VALUES (?,?,?,?)";
				try (PreparedStatement ps = connect.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
					ps.setLong(1, senderAcc);
					ps.setDouble(2, amount);
					ps.setString(3, "Transfer to " + recipientAcc);
					ps.setString(4, "DEBIT");
					ps.executeUpdate();

					try (ResultSet rs = ps.getGeneratedKeys()) {
						if (rs.next())
							session.setAttribute("transactionId", rs.getString(1));
					}
				}
				try (PreparedStatement ps = connect.prepareStatement(insertSql)) {
					ps.setLong(1, recipientAcc);
					ps.setDouble(2, amount);
					ps.setString(3, "Received from " + senderAcc);
					ps.setString(4, "CREDIT");
					ps.executeUpdate();
				}

				connect.commit();

				session.setAttribute("recipientName", recipientName);
				session.setAttribute("recipientAccountNumber", recipientAcc);
				session.setAttribute("transferAmount", amount);
				return true;

			} catch (Exception e) {
				connect.rollback();
				session.setAttribute("errorMessage", e.getMessage());
				return false;
			}
		} catch (SQLException e) {
			session.setAttribute("errorMessage", "Database Error: " + e.getMessage());
			return false;
		}
	}
}