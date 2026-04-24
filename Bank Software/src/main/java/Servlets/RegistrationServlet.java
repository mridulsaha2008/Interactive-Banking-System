package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import DataHandlers.Registration;

@WebServlet(urlPatterns = { "/Registration", "/Registration/" })
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = -3307790371517369798L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/Registration/Registration.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Registration handler = new Registration();
			long accountNumber = handler.createAccount(request);

			request.getSession().setAttribute("accountNumber", accountNumber);

			response.sendRedirect(request.getContextPath() + "/Success/Success.jsp");

		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", e.getMessage());

			response.sendRedirect(request.getContextPath() + "/Registration");
		}
	}
}