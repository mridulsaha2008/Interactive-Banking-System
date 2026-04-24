package DataHandlers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import DatabaseConnector.SQLConnection;

public class Login {

	public boolean authenticate(HttpServletRequest request) {
		String accountNumberStr = request.getParameter("accountNumber");
		String pass = request.getParameter("password");
		HttpSession session = request.getSession();

		if (accountNumberStr == null || pass == null)
			return false;

		String query = "SELECT PASSWORD_HASH, PIN_HASH FROM LOGIN_INFO WHERE ACCOUNT_NUMBER = ?";

		try (Connection connect = SQLConnection.getConnection();
				PreparedStatement loginInfo = connect.prepareStatement(query)) {

			long accountNumber = Long.parseLong(accountNumberStr);
			loginInfo.setLong(1, accountNumber);

			try (ResultSet res = loginInfo.executeQuery()) {
				if (res.next()) {
					String dbPass = res.getString("PASSWORD_HASH");

					if (dbPass.equals(pass)) {
						session.setAttribute("accountNumber", accountNumber);
						session.setAttribute("pinHash", res.getString("PIN_HASH"));
						return true;
					} else {
						session.setAttribute("errorMessage", "Invalid password.");
					}
				} else {
					session.setAttribute("errorMessage", "Account not found.");
				}
			}
		} catch (Exception e) {
			session.setAttribute("errorMessage", "Database Error: " + e.getMessage());
		}
		return false;
	}
}