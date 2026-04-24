package DataHandlers;

import java.sql.*;
import jakarta.servlet.http.HttpServletRequest;
import DatabaseConnector.SQLConnection;

public class Registration {

	public long createAccount(HttpServletRequest request) throws Exception {
		String firstName = request.getParameter("firstName");
		String middleName = request.getParameter("middleName");
		if (middleName != null && !middleName.isEmpty()) {
			firstName += " " + middleName;
		}
		String lastName = request.getParameter("lastName");
		String fatherName = request.getParameter("fatherName");
		String aadhaarNumber = request.getParameter("aadhaarNumber");
		String panNumber = request.getParameter("panNumber");
		String email = request.getParameter("email");
		String mobileNumber = request.getParameter("countryCode") + " " + request.getParameter("mobileNumber");
		String income = request.getParameter("income");
		String zipcode = request.getParameter("zipcode");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String password = request.getParameter("password");
		String pin = request.getParameter("pin");
		String address = request.getParameter("address");
		String dob = request.getParameter("dob");

		try (Connection connection = SQLConnection.getConnection()) {
			connection.setAutoCommit(false);

			try {
				if (isDuplicate(connection, "AADHAAR_NUMBER", aadhaarNumber))
					throw new Exception("Account exists with this Aadhaar!");
				if (isDuplicate(connection, "PAN_NUMBER", panNumber))
					throw new Exception("Account exists with this PAN!");
				if (isDuplicate(connection, "MOBILE_NUMBER", mobileNumber))
					throw new Exception("Account exists with this Mobile Number!");

				String insertCustomer = "INSERT INTO CUSTOMER (FIRST_NAME, LAST_NAME, FATHER_NAME, DOB, AADHAAR_NUMBER, PAN_NUMBER, MOBILE_NUMBER, EMAIL, ADDRESS, CITY, STATE, ZIPCODE, INCOME) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				long generatedAccountNumber = -1;

				try (PreparedStatement psCust = connection.prepareStatement(insertCustomer,
						Statement.RETURN_GENERATED_KEYS)) {
					psCust.setString(1, firstName);
					psCust.setString(2, lastName);
					psCust.setString(3, fatherName);
					psCust.setDate(4, java.sql.Date.valueOf(dob));
					psCust.setString(5, aadhaarNumber);
					psCust.setString(6, panNumber);
					psCust.setString(7, mobileNumber);
					psCust.setString(8, email);
					psCust.setString(9, address);
					psCust.setString(10, city);
					psCust.setString(11, state);
					psCust.setString(12, zipcode);
					psCust.setString(13, income);
					psCust.executeUpdate();

					try (ResultSet rs = psCust.getGeneratedKeys()) {
						if (rs.next())
							generatedAccountNumber = rs.getLong(1);
					}
				}

				String insertLogin = "INSERT INTO LOGIN_INFO (ACCOUNT_NUMBER, PASSWORD_HASH, PIN_HASH) VALUES (?, ?, ?)";
				try (PreparedStatement psLog = connection.prepareStatement(insertLogin)) {
					psLog.setLong(1, generatedAccountNumber);
					psLog.setString(2, password);
					psLog.setString(3, pin);
					psLog.executeUpdate();
				}

				connection.commit();
				return generatedAccountNumber;

			} catch (Exception e) {
				connection.rollback();
				throw e;
			}
		}
	}

	private boolean isDuplicate(Connection conn, String column, String value) throws SQLException {
		String query = "SELECT 1 FROM CUSTOMER WHERE " + column + " = ?";
		try (PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, value);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		}
	}
}