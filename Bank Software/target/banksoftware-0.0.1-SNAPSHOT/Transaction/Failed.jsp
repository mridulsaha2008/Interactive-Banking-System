<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transaction Failed - Mridul's Banking System</title>
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

.failed-card {
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
	background-color: #feefee;
	color: #d93025;
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
	padding: 15px;
	border-radius: 8px;
	margin: 15px 0;
}

.account-label {
	font-size: 11px;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #70757a;
	margin-bottom: 3px;
	display: block;
}

.account-number {
	font-size: 22px;
	font-weight: 800;
	color: #d93025;
	letter-spacing: 1px;
}

.btn-retry {
	display: inline-block;
	background-color: #1a73e8;
	color: white;
	padding: 12px 30px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 600;
	margin-top: 20px;
	transition: background 0.3s;
}

.btn-retry:hover {
	background-color: #1557b0;
}

.error-note {
	font-size: 14px;
	color: #d93025;
	font-weight: 600;
	margin-top: 10px;
}
</style>
</head>
<body>

	<div class="failed-card">
		<div class="icon-circle">
			<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48"
				fill="currentColor" viewBox="0 0 16 16">
                <path
					d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z" />
            </svg>
		</div>

		<%
		if (session.getAttribute("accountNumber") == null) {
			session.setAttribute("errorMessage", "Unauthorized Access!");
			response.sendRedirect(request.getContextPath() + "/Error/Error.jsp");
			return;
		}
		%>

		<h1>Transaction Failed</h1>
		<p>We couldn't process your request. No money was deducted from
			your account.</p>

		<div class="account-box">
			<span class="account-label">Your Account Number</span> <span
				class="account-number"> <%=(session.getAttribute("accountNumber") != null) ? session.getAttribute("accountNumber") : "XXXXXXXXXXXX"%>
			</span>
		</div>

		<div class="account-box">
			<span class="account-label">Recipient Name</span> <span
				class="account-number"> ${not empty recipientName ? recipientName : 'N/A'}
			</span>
		</div>

		<div class="account-box">
			<span class="account-label">Recipient Account Number</span> <span
				class="account-number"> <%=(session.getAttribute("recipientAccountNumber") != null) ? session.getAttribute("recipientAccountNumber")
		: "XXXXXXXXXXXX"%>
			</span>
		</div>

		<div class="account-box">
			<span class="account-label">Attempted Amount</span> <span
				class="account-number">₹ ${not empty transferAmount ? transferAmount : '0.00'}/-</span>
		</div>
		<a href="${pageContext.request.contextPath}/Dashboard"
			class="btn-retry">Back to Dashboard</a>
		<p class="error-note">Please check your balance or PIN and try
			again.</p>
	</div>

</body>
</html>