package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import DataHandlers.TransactionHandler;

@WebServlet(urlPatterns = { "/Transaction", "/Transaction/" })
public class TransactionServlet extends HttpServlet {

	private static final long serialVersionUID = 6577193023770192532L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().setAttribute("errorMessage", "Direct access to transactions is not allowed.");
		response.sendRedirect(request.getContextPath() + "/Dashboard");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TransactionHandler handler = new TransactionHandler();

		try {
			if (handler.transact(request)) {
				response.sendRedirect(request.getContextPath() + "/Transaction/Successful.jsp");
			} else {
				response.sendRedirect(request.getContextPath() + "/Dashboard");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Transaction System Error: " + e.getMessage());
			response.sendRedirect(request.getContextPath() + "/Error/Error.jsp");
		}
	}
}