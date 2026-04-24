<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error - Mridul's Banking System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap"
	rel="stylesheet">
<style>
body {
	background-color: #d93025;
	color: white;
	font-family: 'Inter', sans-serif;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	overflow: hidden;
}

marquee {
	font-weight: 800;
	font-size: 120px;
	width: 100vw;
}

.error-container {
	text-align: center;
	z-index: 10;
}

.technical-details {
	font-size: 14px;
	opacity: 0.8;
	margin-top: 30px;
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
</style>
</head>
<body>
	<div class="error-container">
		<marquee scrollamount="20">ERROR OCCURRED</marquee>

		<h2>Something went wrong with your request.</h2>
		<%
		String errorMsg = (String) session.getAttribute("errorMessage");
		session.removeAttribute("errorMessage");
		%>
		<p class="technical-details">
			Message:
			<%=(errorMsg != null) ? errorMsg : "Unknown Technical Issue"%>
		</p>

		<a href="${pageContext.request.contextPath}/Login" class="btn-home">Login
			Now</a>
	</div>
</body>
</html>