# Bank Management System (Jakarta EE)

A full-stack banking application built with **Java Jakarta EE**, focusing on transaction integrity, secure session management, and MVC architecture. This system handles the full user lifecycle, from KYC-compliant registration to real-time fund transfers using atomic SQL operations.

## 🛠 Core Tech Stack
- **Backend:** Java Servlets (Jakarta EE 10+), JDBC
- **Frontend:** JSP, JSTL, CSS3 (Inter UI), JavaScript (Web Crypto API)
- **Database:** MySQL/Oracle
- **Server:** Apache Tomcat 10.1+

## 🏗 System Architecture
The project follows a strict **MVC (Model-View-Controller)** pattern to ensure a clean separation between business logic and the presentation layer:

1. **Model (DataHandlers):** Contains the core business logic. All database interactions, SQL transaction management (Commit/Rollback), and data validation occur here.
2. **View (JSP):** Dynamic web pages using JSTL for data rendering and standard CSS for the UI.
3. **Controller (Servlets):** Acts as the traffic cop, managing request routing, session validation, and navigation flow.



## 🔒 Security Implementation
- **Client-Side Hashing:** Passwords and Transaction PINs are hashed using **SHA-256** via the browser's Web Crypto API before they ever hit the network.
- **Transaction Integrity:** Implements **ACID properties**. Fund transfers are atomic; if the credit to the recipient fails, the debit from the sender is automatically rolled back.
- **Concurrency Control:** Utilizes SQL row-level locking (`FOR UPDATE`) to prevent race conditions and "double-spending" during simultaneous transactions.
- **Session Guarding:** All dashboard and transaction routes are protected by session filters to prevent unauthorized directory traversal.

## 📂 Directory Structure
```text
├── src/main/java/
│   ├── DatabaseConnector/    # JDBC Singleton connection logic
│   ├── DataHandlers/         # Model: Business logic & SQL execution
│   └── Servlets/             # Controller: Routing & Path management
├── webapp/
│   ├── Dashboard/            # Account summary & Recent transactions
│   ├── Login/                # Auth modules
│   ├── Registration/         # KYC & Account creation
│   ├── Success/              # Dynamic receipts
│   └── Error/                # Context-aware error handling
```
## ⚙️ Setup & Installation

1. **Database**: 
   Execute the SQL schema located in the `/database/schema.sql` directory to set up the required tables (Customer, Login_Info, and Transactions).

2. **Credentials**: 
   Update your database URL, username, and password in the following file:  
   `src/main/java/DatabaseConnector/SQLConnection.java`

3. **Deployment**:
   * Ensure the **Tomcat 10+** runtime is configured in your IDE (Eclipse or IntelliJ).
   * Clean and build the project to generate the artifacts.
   * Deploy the project to the server.
   * Access the application via: `http://localhost:8080/[ProjectName]/Login`

---

## 📌 Usage

* **Registration**: Navigate to the registration page and create an account. Ensure you provide valid formats for your PAN and [Aadhaar Redacted].
* **Dashboard**: After a successful login, you can view your real-time balance, account profile, and a complete history of recent transactions.
* **Transfers**: Use the **"Quick Transfer"** tool on the dashboard. Simply enter the recipient's account number and the amount. You will be prompted to enter your secure **6-digit PIN** to authorize and finalize the transfer.
