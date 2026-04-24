<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dashboard - Mridul's Banking System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Inter', sans-serif;
	background-color: #f0f2f5;
	margin: 0;
	padding: 20px;
	color: #444;
}

.dashboard-container {
	max-width: 1000px;
	margin: auto;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	margin-bottom: 20px;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: white;
	padding: 10px 25px;
	border-radius: 12px;
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.navbar h2 {
	color: #1a73e8;
	margin: 0;
}

.profile-btn {
	background: #f0f2f5;
	border: none;
	border-radius: 50%;
	padding: 8px;
	cursor: pointer;
	transition: 0.3s;
}

.profile-btn:hover {
	background: #e1e4e8;
}

.balance-section {
	display: grid;
	grid-template-columns: 1fr 1.5fr;
	gap: 20px;
}

.balance-display {
	text-align: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.balance-header {
	font-size: 14px;
	color: #666;
	margin-bottom: 5px;
}

.balance-amount {
	font-size: 32px;
	font-weight: bold;
	color: #1a73e8;
	margin: 0;
}

label {
	display: block;
	margin-top: 10px;
	font-weight: 600;
	font-size: 13px;
}

input {
	width: 100%;
	padding: 10px;
	margin-top: 5px;
	border: 1px solid #dadce0;
	border-radius: 6px;
	box-sizing: border-box;
}

.btn-primary {
	background: #1a73e8;
	color: white;
	border: none;
	padding: 12px;
	border-radius: 6px;
	font-weight: bold;
	cursor: pointer;
	width: 100%;
	margin-top: 15px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th {
	text-align: left;
	background: #f8f9fa;
	padding: 12px;
	border-bottom: 2px solid #eee;
}

td {
	padding: 12px;
	border-bottom: 1px solid #eee;
	font-size: 14px;
}

#profileModal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: white;
	margin: 5% auto;
	padding: 30px;
	width: 500px;
	border-radius: 12px;
	position: relative;
}

.close-modal {
	position: absolute;
	right: 20px;
	top: 15px;
	font-size: 24px;
	cursor: pointer;
	color: #666;
}

.detail-row {
	display: flex;
	justify-content: space-between;
	padding: 8px 0;
	border-bottom: 1px solid #f0f0f0;
}

.detail-label {
	font-weight: 600;
	color: #1a73e8;
}

marquee {
	color: #d93025;
	font-weight: bold;
}

#pinModal {
	display: none !important;
	position: fixed;
	z-index: 2000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	backdrop-filter: blur(3px);
}

.pin-content {
	background-color: white;
	margin: 15vh auto;
	padding: 30px;
	width: 350px;
	border-radius: 12px;
	text-align: center;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.pin-input-container {
	position: relative;
	display: flex;
	align-items: center;
	margin: 20px 0;
}

.pin-input-container input {
	width: 100%;
	padding: 12px;
	padding-right: 40px;
	border: 1px solid #dadce0;
	border-radius: 6px;
	text-align: center;
	font-size: 18px;
	letter-spacing: 4px;
}
</style>
</head>
<body>

	<%
	if (session.getAttribute("accountNumber") == null) {
		session.setAttribute("errorMessage", "Unauthorized Access!");
		response.sendRedirect(request.getContextPath() + "/Error/Error.jsp");
		return;
	}
	%>

	<div class="dashboard-container">
		<h1>
			<marquee>Welcome to Mridul's Banking System</marquee>
		</h1>

		<div class="navbar">
			<h2>Dashboard</h2>
			<button class="profile-btn" onclick="toggleModal()" title="Profile">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128"
					width="35" height="35">
                <rect width="128" height="128" fill="#E8EAED" rx="64" />
                <g fill="#9AA0A6">
                    <circle cx="64" cy="46" r="18" />
                    <path
						d="M64 70c-22 0-40 16-40 36v4h80v-4c0-20-18-36-40-36z" />
                </g>
            </svg>
			</button>
		</div>

		<div class="balance-section">
			<div class="card balance-display">
				<span class="balance-header">Available Balance</span>
				<%
				Object balObj = session.getAttribute("balance");
				Double balance = (balObj != null) ? (Double) balObj : 0.00;
				%>
				<p class="balance-amount">
					<fmt:formatNumber value="${balance}" type="currency"
						currencySymbol="₹" />
				</p>
			</div>

			<div class="card">
				<h3 style="margin-top: 0">Quick Transfer</h3>

				<%
				String errorMsg = (String) session.getAttribute("errorMessage");
				if (errorMsg != null) {
				%>
				<div class="alert-error"
					style="background-color: #fce8e6; color: #d93025; padding: 12px; border-radius: 8px; margin-bottom: 15px; border: 1px solid #f5c2c7; font-size: 13px; display: flex; align-items: center; gap: 8px;">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" viewBox="0 0 16 16">
            <path
							d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
        </svg>
					<div style="flex: 1;">
						<strong>Error:</strong>
						<%=errorMsg%>
					</div>
					<button type="button"
						onclick="this.parentElement.style.display='none'"
						style="background: none; border: none; color: #d93025; cursor: pointer; font-weight: bold;">&times;</button>
				</div>
				<%
				session.removeAttribute("errorMessage");
				}
				%>

				<form action="${pageContext.request.contextPath}/Transaction"
					method="POST" id="transferForm">
					<label>Recipient Account</label> <input type="text"
						name="recipient-account" id="recipient-account"
						pattern="^[1-9][0-9]{11}$" placeholder="12-Digit Account Number"
						title="Enter Recipient's 12-Digit Account Number" required>

					<label>Amount (₹)</label> <input type="number" step="0.01"
						name="amount" id="transfer-amount" min="1" placeholder="0.00"
						title="Enter Amount to Transfer" required>

					<button type="button" class="btn-primary" onclick="showPinModal()">Send
						Money</button>

					<input type="hidden" name="transactionPin" id="finalPin">
				</form>
			</div>

			<div id="pinModal">
				<div class="pin-content">
					<h3 style="color: #1a73e8; margin-top: 0;">Enter 6-Digit PIN</h3>
					<p style="font-size: 13px; color: #666;">
						Confirm Your Transaction To <span id="display-recipient"></span>
					</p>

					<div class="pin-input-container">
						<input type="password" id="pin" inputmode="numeric"
							autocomplete="one-time-code" pattern="[0-9]{6}" maxlength="6"
							placeholder="Transaction PIN" required>
					</div>

					<div style="display: flex; gap: 10px;">
						<button class="btn-primary"
							style="background: #eee; color: #444; margin-top: 0;"
							onclick="closePinModal()">Cancel</button>
						<button type="button" class="btn-primary" id="submit-transaction"
							style="margin-top: 0;">Confirm</button>
					</div>
				</div>
			</div>

		</div>

		<div class="card">
			<h3>Recent Transactions</h3>
			<table>
				<thead>
					<tr>
						<th>Date</th>
						<th>Description</th>
						<th>Type</th>
						<th>Amount</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
    <c:when test="${not empty transactionList}">
        <c:forEach var="t" items="${transactionList}">
            <tr>
                <td>
                    <fmt:formatDate value="${t.dateTime}" pattern="dd MMM yyyy, hh:mm a" />
                </td>
                <td><c:out value="${t.description}" /></td>
                <td style="font-weight:600; color: ${t.type == 'DEBIT' ? '#d93025' : '#188038'}">
                    <c:out value="${t.type}" />
                </td>
                <td>
                    ₹ <fmt:formatNumber value="${t.amount}" minFractionDigits="2" maxFractionDigits="2" />
                </td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <tr>
            <td colspan="4" style="text-align: center">No Transactions Found.</td>
        </tr>
    </c:otherwise>
</c:choose>
				</tbody>
			</table>
		</div>
	</div>

	<div id="profileModal">
		<div class="modal-content">
			<span class="close-modal" onclick="toggleModal()">&times;</span>
			<h2 style="text-align: left; margin-bottom: 20px; color: #1a73e8;">Account
				Profile</h2>
			<div class="detail-row">
				<span class="detail-label">Account Number:</span> <span>${accountNumber}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Full Name:</span> <span>${firstName}
					${lastName}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Father's Name:</span> <span>${fatherName}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Date of Birth:</span> <span>${dob}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Contact:</span> <span>${mobileNumber}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Email:</span> <span>${email}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Address:&nbsp;</span> <span
					style="text-align: right;">${address}, ${city}, ${state} -
					${zipcode}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Income:</span> <span>${income}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">Aadhaar:</span> <span>${aadhaarNumber}</span>
			</div>
			<div class="detail-row">
				<span class="detail-label">PAN:</span> <span>${panNumber}</span>
			</div>

			<div class="detail-row"
				style="margin-top: 15px; border-top: 2px solid #f0f2f5; border-bottom: none;">
				<span class="detail-label">Member Since:</span> <span
					style="font-weight: 600; color: #666;"> <c:out
						value="${accountCreationDate}" />
				</span>
			</div>
		</div>
	</div>

	<script>
	function toggleModal() {
	    const modal = document.getElementById('profileModal');
	    modal.style.display = (modal.style.display === 'block') ? 'none' : 'block';
	}

	function showPinModal() {
	    const form = document.getElementById('transferForm');
	    if (!form.checkValidity()) {
	        form.reportValidity();
	        return;
	    }
	    const recipient = document.getElementById('recipient-account').value;
	    document.getElementById('display-recipient').innerText = recipient;
	    const modal = document.getElementById('pinModal');
	    modal.style.setProperty('display', 'block', 'important');
	    
	    setTimeout(() => {
	        const pinInput = document.getElementById('pin');
	        pinInput.focus();
	    }, 100);
	}

	async function sha256(message) {
	    const msgBuffer = new TextEncoder().encode(message);
	    const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);
	    const hashArray = Array.from(new Uint8Array(hashBuffer));
	    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
	    return hashHex;
	}

	document.getElementById('submit-transaction').addEventListener('click', async (e) => {
	    const pinInput = document.getElementById('pin');
	    const btn = e.target;
	    btn.disabled = true;
	    btn.innerText = "Processing...";
	    if (pinInput.value.length !== 6) {
	        alert("Please enter a 6-digit PIN");
	        pinInput.focus();
	        btn.disabled = false;
	        btn.innerText = "Submit";
	        return;
	    }
	    if (!pinInput.checkValidity()) {
	        alert("Please Enter a Valid 6-Digit Numeric PIN.");
	        pinInput.focus();
	        btn.disabled = false;
	        btn.innerText = "Submit";
	        return;
	    }

	    const hashedPin = await sha256(pinInput.value);

	    document.getElementById('finalPin').value = hashedPin;

	    pinInput.value = ""; 
	    
	    btn.disabled = false;
        btn.innerText = "Submit";
        
	    document.getElementById('transferForm').submit();
	});
	function closePinModal() {
	    const modal = document.getElementById('pinModal');
	    modal.style.setProperty('display', 'none', 'important');
	    document.getElementById('pin').value = '';
	}

	window.onclick = function(event) {
	    const profileModal = document.getElementById('profileModal');
	    const pinModal = document.getElementById('pinModal');
	    if (event.target == profileModal) profileModal.style.display = "none";
	    if (event.target == pinModal) closePinModal();
	}
</script>

</body>
</html>