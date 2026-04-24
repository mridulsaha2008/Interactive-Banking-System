<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Transaction Successful - Mridul's Banking System</title>
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
	min-height: 100vh;
	margin: 0;
	padding: 20px;
}

.success-card {
	max-width: 500px;
	width: 100%;
	background: white;
	padding: 40px;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
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
	margin: 0 0 10px;
	font-size: 24px;
}

.subtitle {
	color: #5f6368;
	margin-bottom: 30px;
	font-size: 15px;
}

.details-container {
	margin-bottom: 30px;
}

.info-box {
	background-color: #f8f9fa;
	border: 1px solid #e8eaed;
	padding: 15px;
	border-radius: 10px;
	margin-bottom: 12px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.info-label {
	font-size: 11px;
	text-transform: uppercase;
	font-weight: 600;
	letter-spacing: 0.8px;
	color: #70757a;
	margin-bottom: 4px;
}

.info-value {
	font-size: 18px;
	font-weight: 700;
	color: #3c4043;
}

.amount-value {
	color: #1e8e3e;
	font-size: 24px;
}

.transaction-id {
	color: #1a73e8;
	font-family: monospace;
}

.action-group {
	display: flex;
	flex-direction: column;
	gap: 12px;
	margin-top: 25px;
}

.btn {
	padding: 14px 24px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 600;
	font-size: 16px;
	transition: all 0.2s ease;
}

.btn-home {
	background-color: #1a73e8;
	color: white;
}

.btn-home:hover {
	background-color: #1557b0;
	box-shadow: 0 4px 12px rgba(26, 115, 232, 0.3);
}

.note {
	font-size: 12px;
	color: #9aa0a6;
	margin-top: 20px;
	line-height: 1.4;
}
</style>
</head>
<body>
	<%
	if (session.getAttribute("accountNumber") == null) {
		request.getSession().setAttribute("errorMessage", "Unauthorized Access!");
		response.sendRedirect(request.getContextPath() + "/Error/Error.jsp");
		return;
	}
	%>
	<div class="success-card">
		<div class="icon-circle">
			<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
				fill="currentColor" viewBox="0 0 16 16">
            <path
					d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
        </svg>
		</div>

		<h1>Payment Successful!</h1>
		<p class="subtitle">Your transaction has been processed securely.</p>

		<div class="details-container">
			<div class="info-box">
				<span class="info-label">Amount Sent</span> <span
					class="info-value amount-value">₹ ${not empty transferAmount ? transferAmount : '0.00'}/-</span>
			</div>

			<div class="info-box">
				<span class="info-label">Transaction ID</span> <span
					class="info-value transaction-id">${not empty transactionId ? transactionId : 'TID-XXXXXXXXXX'}</span>
			</div>

			<div class="info-box">
				<span class="info-label">Recipient</span> <span class="info-value">${not empty recipientName ? recipientName : 'N/A'}</span>
				<span style="font-size: 12px; color: #70757a;">A/C:
					${recipientAccountNumber}</span>
			</div>
		</div>

		<div class="action-group">
			<a href="${pageContext.request.contextPath}/Dashboard"
				class="btn btn-home">Return to Dashboard</a>
		</div>

		<p class="note">Please save the Transaction ID for future support.
		</p>
	</div>
	<c:remove var="transactionId" scope="session" />
</body>
</html>