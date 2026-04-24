<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login - Mridul's Banking System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="style.css" />
<style>
body {
	font-family: 'Inter', sans-serif;
	background-color: #f0f2f5;
	padding: 40px;
}

.login-container {
	max-width: 600px;
	margin: auto;
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

#createAccountButton {
	display: block;
	width: 100%;
	background: #1a73e8;
	color: white;
	padding: 14px;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	font-weight: bold;
	margin-top: 15px;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	box-sizing: border-box;
}

#createAccountButton:hover {
	background: #1557b0;
}

h2 {
	color: #1a73e8;
	text-align: center;
}

label, p {
	display: block;
	margin-top: 15px;
	font-weight: 600;
	font-size: 14px;
	color: #444;
}

input {
	width: 100%;
	padding: 12px;
	margin-top: 5px;
	border: 1px solid #dadce0;
	border-radius: 6px;
	box-sizing: border-box;
	transition: 0.3s;
	font-weight: 400;
}

input:focus {
	border-color: #1a73e8;
	outline: none;
	box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.2);
}

.input-wrapper {
	position: relative;
	display: flex;
	align-items: center;
}

.toggle-eye {
	position: absolute;
	right: 12px;
	top: 55%;
	transform: translateY(-50%);
	cursor: pointer;
	color: #666;
	width: 20px;
	height: 20px;
	display: flex;
	align-items: center;
}

button {
	width: 100%;
	background: #1a73e8;
	color: white;
	padding: 14px;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	font-weight: bold;
	margin-top: 25px;
	cursor: pointer;
}

button:hover {
	background: #1557b0;
}

marquee {
	color: #d93025;
	font-weight: bold;
}

input::-ms-reveal, input::-ms-clear {
	display: none;
}

input::-webkit-contacts-auto-fill-button, input::-webkit-credentials-auto-fill-button
	{
	visibility: hidden;
	pointer-events: none;
	position: absolute;
	right: 0;
}
</style>
</head>
<body>
	<div class="login-container">
		<h1>
			<marquee>Welcome to Mridul's Banking System</marquee>
		</h1>
		<h2>Account Login</h2>
		<%
		String errorMsg = (String) session.getAttribute("errorMessage");
		if (errorMsg != null) {
		%>
		<div class="alert"
			style="background-color: #fce8e6; color: #d93025; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #f5c2c7;">
			<div style="display: flex; align-items: center; gap: 10px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
					fill="currentColor" viewBox="0 0 16 16">
            <path
						d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
        </svg>
				<span style="flex-grow: 1;"><strong>Login Error:</strong> <%=errorMsg%></span>
				<button type="button" class="btn-close"
					style="background: none; border: none; cursor: pointer; font-size: 18px; color: #d93025;">&times;</button>
			</div>
		</div>
		<%
		session.removeAttribute("errorMessage");
		}
		%>
		<form action="${pageContext.request.contextPath}/Login" method="POST"
			id="form">
			<label for="accountNumber">Account Number</label> <input type="text"
				inputmode="numeric" id="accountNumber" name="accountNumber"
				placeholder="Enter Your Account Number"
				title="Enter a Valid 12 Digit Account Number"
				pattern="^[1-9][0-9]{11}$" oninput="this.value = this.value.trim()"
				required /> <label for="password">Password</label>
			<div class="input-wrapper">
				<input type="password" id="password" name="password"
					pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&amp;])[A-Za-z\d@$!%*?&amp;]{8,}$"
					placeholder="Password" title="Enter a Valid Password" required>
				<span class="toggle-eye"
					onclick="toggleVisibility('password', this)"> <svg
						xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round"
							d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                  <path stroke-linecap="round" stroke-linejoin="round"
							d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>
				</span>
			</div>
			<button type="submit">Login</button>
			<p>Don't Have Account</p>
			<a href="${pageContext.request.contextPath}/Registration"
				id="createAccountButton">Open New Account</a>
		</form>
	</div>
	<script type="text/javascript">
	document.addEventListener('click', function (event) {
	    if (event.target.classList.contains('btn-close')) {
	        event.target.closest('.alert').style.display = 'none';
	    }
	});
function toggleVisibility(inputId, iconElement) {
    const input = document.getElementById(inputId);

    if (input.type === "password") {
        input.type = "text";
        iconElement.innerHTML = `
	                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
	                  <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223a11.055 11.055 0 0 0-1.944 3.458 1.014 1.014 0 0 0 0 .639C3.423 16.49 7.36 19.5 12 19.5c1.258 0 2.443-.223 3.535-.626m2.956-2.03c1.41-1.348 2.513-3.118 3.208-5.022a1.017 1.017 0 0 0 0-.639C20.577 7.51 16.64 4.5 12 4.5c-1.258 0-2.443.223-3.535.626M9.172 9.172a3 3 0 0 1 4.242 4.242M9.172 9.172 5.146 5.146m13.708 13.708-4.102-4.102" />
	                </svg>`;
    } else {
        input.type = "password";
        iconElement.innerHTML = `
	                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
	                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
	                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
	                </svg>`;
    }
}
async function sha256(message) {
    const msgBuffer = new TextEncoder().encode(message);
    const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
    return hashHex;
}
const form = document.getElementById('form');

form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const passwordInput = document.getElementById('password');
    const hashedPassword = await sha256(passwordInput.value);
    passwordInput.removeAttribute('pattern');
    passwordInput.value = hashedPassword;
    form.submit();
});
	</script>
</body>
</html>