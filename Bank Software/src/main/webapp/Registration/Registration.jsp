<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="Error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration - Mridul's Banking System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="style.css" />
<style>
body {
	font-family: 'Inter', sans-serif;
	background-color: #f0f2f5;
	padding: 40px;
}

.form-card {
	max-width: 600px;
	margin: auto;
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

#login {
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

#login:hover {
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

input, select {
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

.mobile-container {
	display: flex;
	gap: 10px;
}

.mobile-container select {
	width: 35%;
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
	<div class="form-card">
		<h1 id="runningHeading">
			<marquee>Welcome to Mridul's Banking System</marquee>
		</h1>
		<h2>Account Registration</h2>
		<%
		String errorMsg = (String) session.getAttribute("errorMessage");
		if (errorMsg != null) {
		%>
		<div class="alert"
			style="background-color: #fce8e6; color: #d93025; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #f5c2c7;">
			<div
				style="display: flex; align-items: center; gap: 10px; justify-content: center;">
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
					fill="currentColor" viewBox="0 0 16 16">
            <path
						d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
        </svg>
				<span><strong>Registration Error:</strong> <%=errorMsg%></span>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					style="background: none; border: none; color: #d93025; cursor: pointer; font-weight: bold;">&times;</button>
			</div>
		</div>
		<%
		session.removeAttribute("errorMessage");
		}
		%>
		<form action="${pageContext.request.contextPath}/Registration"
			method="POST" id="registrationForm">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" id="firstName" placeholder="First Name"
				pattern="^[A-Za-z]{1,20}$" title="Letters Only, Max 20 Characters"
				oninput="this.value = this.value.toUpperCase()" required> <label
				for="middleName">Middle Name (Optional)</label> <input type="text"
				name="middleName" id="middleName" placeholder="Middle Name"
				pattern="^[A-Za-z]{0,20}$" title="Letters Only, Max 20 Characters"
				oninput="this.value = this.value.toUpperCase()"> <label
				for="lastName">Last Name</label> <input type="text" name="lastName"
				id="lastName" placeholder="Last Name" pattern="^[A-Za-z]{1,20}$"
				title="Letters Only, Max 20 Characters"
				oninput="this.value = this.value.toUpperCase()" required> <label
				for="fatherName">Father Name</label> <input type="text"
				name="fatherName" id="fatherName" placeholder="Father Name"
				pattern="^[A-Za-z\s]{1,60}$" title="Letters Only, Max 60 Characters"
				oninput="this.value = this.value.toUpperCase()" required> <label
				for="dob">Date of Birth</label> <input type="date" name="dob"
				id="dob" required> <label for="aadhaarNumber">Aadhaar
				Number</label> <input type="text" inputmode="numeric" name="aadhaarNumber"
				id="aadhaarNumber" placeholder="12-Digit Number"
				pattern="^[2-9][0-9]{11}$" maxlength="12"
				title="Enter a Valid Aadhaar Number"
				oninput="this.value = this.value.trim()" required> <label
				for="panNumber">PAN Number</label> <input type="text"
				name="panNumber" id="panNumber" placeholder="ABCDE1234F"
				pattern="^[A-Z]{3}[ABCFGHLJPT]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$"
				oninput="this.value = this.value.toUpperCase().trim()"
				maxlength="10" title="Enter a Valid PAN Number" required> <label
				for="mobileNumber">Mobile Number</label>
			<div class="mobile-container">
				<select name="countryCode">
					<option value="+91" selected>+91 (IN)</option>
					<option value="+1">+1 (US)</option>
					<option value="+44">+44 (UK)</option>
				</select> <input type="tel" inputmode="numeric" name="mobileNumber"
					id="mobileNumber" pattern="[0-9]{7,12}" placeholder="Mobile Number"
					oninput="this.value = this.value.trim()"
					title="Enter a Valid Mobile Number" required>
			</div>

			<label for="email">Email Address</label> <input type="email"
				name="email" id="email" placeholder="name@example.com"
				pattern="^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$"
				oninput="this.value = this.value.toUpperCase().trim()"
				title="Enter a Valid Email" required> <label for="address">Residential
				Address</label> <input type="text" name="address" id="address"
				placeholder="Flat, Street, Area"
				pattern="^[A-Za-z0-9\s,.\-]{1,200}$" title="Max 200 Characters"
				oninput="this.value = this.value.toUpperCase()" required> <label
				for="city">City</label> <input type="text" name="city" id="city"
				placeholder="City" pattern="^[A-Za-z\s]{1,50}$"
				oninput="this.value = this.value.toUpperCase()"
				title="Enter a Valid City" required> <label for="state">State/UT</label>
			<select name="state" id="state"
				title="Select a State or Union Territory" required>
				<option value="" disabled selected>Select State</option>

				<optgroup label="States">
					<option value="AP">ANDHRA PRADESH</option>
					<option value="AR">ARUNACHAL PRADESH</option>
					<option value="AS">ASSAM</option>
					<option value="BR">BIHAR</option>
					<option value="CG">CHHATTISGARH</option>
					<option value="GA">GOA</option>
					<option value="GJ">GUJARAT</option>
					<option value="HR">HARYANA</option>
					<option value="HP">HIMACHAL PRADESH</option>
					<option value="JH">JHARKHAND</option>
					<option value="KA">KARNATAKA</option>
					<option value="KL">KERALA</option>
					<option value="MP">MADHYA PRADESH</option>
					<option value="MH">MAHARASHTRA</option>
					<option value="MN">MANIPUR</option>
					<option value="ML">MEGHALAYA</option>
					<option value="MZ">MIZORAM</option>
					<option value="NL">NAGALAND</option>
					<option value="OD">ODISHA</option>
					<option value="PB">PUNJAB</option>
					<option value="RJ">RAJASTHAN</option>
					<option value="SK">SIKKIM</option>
					<option value="TN">TAMIL NADU</option>
					<option value="TG">TELANGANA</option>
					<option value="TR">TRIPURA</option>
					<option value="UP">UTTAR PRADESH</option>
					<option value="UT">UTTARAKHAND</option>
					<option value="WB">WEST BENGAL</option>
				</optgroup>

				<optgroup label="Union Territories">
					<option value="AN">ANDAMAN AND NICOBAR ISLANDS</option>
					<option value="CH">CHANDIGARH</option>
					<option value="DH">DADRA AND NAGAR HAVELI AND DAMAN AND
						DIU</option>
					<option value="DL">DELHI (NCT)</option>
					<option value="JK">JAMMU AND KASHMIR</option>
					<option value="LA">LADAKH</option>
					<option value="LD">LAKSHADWEEP</option>
					<option value="PY">PUDUCHERRY</option>
				</optgroup>
			</select> <label for="zipcode">Zipcode</label> <input type="text"
				inputmode="numeric" name="zipcode" id="zipcode"
				placeholder="6-digit PIN" pattern="^[1-9][0-9]{5}$" maxlength="6"
				oninput="this.value = this.value.trim()"
				title="Enter a Valid Zipcode" required> <label for="income">Annual
				Yearly Income</label> <select name="income" id="income" required>
				<option value="" disabled selected>Select Income Range</option>
				<option value="BELOW_2.5L">BELOW ₹2,50,000</option>
				<option value="2.5L_5L">₹2,50,000 - ₹5,00,000</option>
				<option value="5L_10L">₹5,00,000 - ₹10,00,000</option>
				<option value="10L_25L">₹10,00,000 - ₹25,00,000</option>
				<option value="ABOVE_25L">ABOVE ₹25,00,000</option>
			</select> <label for="password">Create Password (Case Sensitive)</label>
			<div class="input-wrapper">
				<input type="password" id="password" name="password"
					pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
					placeholder="Password" title="Enter a Strong Password" required>
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

			<label for="pin">Create 6-Digit Transaction PIN</label>
			<div class="input-wrapper">
				<input type="password" id="pin" name="pin" inputmode="numeric"
					pattern="[0-9]{6}" maxlength="6" placeholder="Transaction PIN"
					oninput="this.value = this.value.trim()" required> <span
					class="toggle-eye" onclick="toggleVisibility('pin', this)">
					<svg xmlns="http://www.w3.org/2000/svg" fill="none"
						viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round"
							d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                  <path stroke-linecap="round" stroke-linejoin="round"
							d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>
				</span>
			</div>

			<button type="submit">Open Secure Account</button>
			<p>Already Have Account</p>
			<a href="${pageContext.request.contextPath}/Login" class="login"
				id="login" name="login">Login Now</a>
		</form>
	</div>
	<script>
	document.getElementById('dob').max = new Date().toISOString().split("T")[0];
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

	const form = document.getElementById('registrationForm');

	form.addEventListener('submit', async (e) => {
	    e.preventDefault();
	    const fatherName = document.getElementById('fatherName');
	    fatherName.value = fatherName.value.trim();
	    const city = document.getElementById('city');
	    city.value = city.value.trim();
	    const address = document.getElementById('address');
	    address.value = address.value.trim();
	    const firstName = document.getElementById('firstName');
	    firstName.value = firstName.value.replaceAll(' ', '');
	    const middleName = document.getElementById('middleName');
	    middleName.value = middleName.value.replaceAll(' ', '');
	    const lastName = document.getElementById('lastName');
	    lastName.value = lastName.value.replaceAll(' ', '');
	    const panNumber = document.getElementById('panNumber');
	    panNumber.value = panNumber.value.replaceAll(' ', '');
	    const aadhaarNumber = document.getElementById('aadhaarNumber');
	    aadhaarNumber.value = aadhaarNumber.value.replaceAll(' ', '');
	    const zipcode = document.getElementById('zipcode');
	    zipcode.value = zipcode.value.replaceAll(' ', '');
	    const email = document.getElementById('email');
	    email.value = email.value.replaceAll(' ', '');
	    const passwordInput = document.getElementById('password');
	    const pinInput = document.getElementById('pin');
	    const hashedPassword = await sha256(passwordInput.value);
	    const hashedPin = await sha256(pinInput.value);
	    passwordInput.value = hashedPassword;
	    pinInput.value = hashedPin;
	    form.submit();
	});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>