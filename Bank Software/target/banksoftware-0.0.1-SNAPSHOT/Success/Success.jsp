<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Successful - Mridul's Banking System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Inter', sans-serif;
	background-color: #f0f2f5;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.success-card {
	max-width: 500px;
	width: 90%;
	background: white;
	padding: 40px;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.icon-circle {
	width: 80px;
	height: 80px;
	background-color: #e6f4ea;
	color: #1e8e3e;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 auto 20px;
}

h1 {
	color: #202124;
	margin-bottom: 10px;
}

p {
	color: #5f6368;
	line-height: 1.6;
}

.account-box {
	background-color: #f8f9fa;
	border: 2px dashed #dadce0;
	padding: 20px;
	border-radius: 8px;
	margin: 25px 0;
}

.account-label {
	font-size: 12px;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #70757a;
	margin-bottom: 5px;
	display: block;
}

.account-number {
	font-size: 28px;
	font-weight: 800;
	color: #1a73e8;
	letter-spacing: 2px;
}

.btn-home {
	display: inline-block;
	background-color: #1a73e8;
	color: white;
	padding: 12px 30px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 600;
	transition: background 0.3s;
}

.btn-home:hover {
	background-color: #1557b0;
}

.note {
	font-size: 12px;
	color: #9aa0a6;
	margin-top: 20px;
}
</style>
</head>
<body>

	<div class="success-card">
		<div class="icon-circle">

			<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48"
				fill="currentColor" viewBox="0 0 16 16">

<path
					d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />

</svg>

		</div>

		<%
		if (session.getAttribute("accountNumber") == null) {
			session.setAttribute("errorMessage", "Unauthorized Access!");
			response.sendRedirect(request.getContextPath() + "/Error/Error.jsp");
			return;
		}
		%>

		<h1>Registration Successful!</h1>
		<p>Welcome to Mridul's Banking System. Your account has been
			created successfully.</p>

		<div class="account-box">
			<span class="account-label">Your New Account Number</span> <span
				class="account-number"> <%-- Using JSTL or EL is cleaner than Expression Tags --%>
				${not empty accountNumber ? accountNumber : 'XXXXXXXXXXXX'}
			</span>
		</div>

		<%
		session.removeAttribute("accountNumber");
		%>

		<a href="${pageContext.request.contextPath}/Login" class="btn-home">Login
			Now</a>

		<p class="note">Please keep this number safe for your future
			transactions.</p>
	</div>

</body>
</html>