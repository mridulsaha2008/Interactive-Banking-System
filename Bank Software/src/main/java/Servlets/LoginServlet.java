package Servlets;

import java.io.IOException;
import DataHandlers.Login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/Login", "/Login/" ,"/"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = -7353239861907761534L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/Login/Login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Login loginHandler = new Login();
		boolean success = loginHandler.authenticate(request);

		if (success) {
			response.sendRedirect(request.getContextPath() + "/Dashboard");
		} else {
			response.sendRedirect(request.getContextPath() + "/Login");
		}
	}
}