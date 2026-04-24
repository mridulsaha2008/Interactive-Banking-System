package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import DataHandlers.Dashboard;

@WebServlet(urlPatterns = { "/Dashboard", "/Dashboard/" })
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 8070263199455257885L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null && session.getAttribute("accountNumber") != null) {
			Dashboard dashboard = new Dashboard();
			if (dashboard.fetchData(request)) {
				request.getRequestDispatcher("/Dashboard/Dashboard.jsp").forward(request, response);
			} else {
				session.setAttribute("errorMessage", "Unable to retrieve details.");
				request.getRequestDispatcher("/Error/Error.jsp").forward(request, response);
			}
		} else {
			if (session == null)
				session = request.getSession();
			session.setAttribute("errorMessage", "Unauthorized Access!");
			request.getRequestDispatcher("/Error/Error.jsp").forward(request, response);
		}
	}
}