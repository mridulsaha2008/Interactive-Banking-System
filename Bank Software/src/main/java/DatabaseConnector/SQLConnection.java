package DatabaseConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLConnection {
	private static final String url = "jdbc:mysql://localhost:9203/bank";
	private static final String username = "";
	private static final String password = "";

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(url, username, password);
	}
}