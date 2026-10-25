<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>

    <title>Library Management - SmartLib</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            color: #1e293b;
        }

        .navbar {
            background: #0f172a;
            color: white;
            padding: 20px 45px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .back {
            color: white;
            text-decoration: none;
            background: #2563eb;
            padding: 10px 18px;
            border-radius: 8px;
        }

        .container {
            width: 92%;
            margin: 35px auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 30px;
        }

        .header p {
            color: #64748b;
            margin-top: 7px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }

        .tab {
            text-decoration: none;
            padding: 11px 18px;
            border-radius: 8px;
            background: white;
            color: #334155;
            box-shadow: 0 3px 12px rgba(0,0,0,0.05);
        }

        .tab:hover {
            background: #2563eb;
            color: white;
        }

        .card {
            background: white;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .card h2 {
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr auto;
            gap: 12px;
        }

        input {
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
        }

        button {
            border: none;
            cursor: pointer;
            border-radius: 7px;
            padding: 12px 18px;
            font-weight: bold;
        }

        .issue-btn {
            background: #2563eb;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            padding: 14px;
            text-align: left;
            color: #475569;
        }

        td {
            padding: 14px;
            border-top: 1px solid #e2e8f0;
        }

        .return-btn {
            background: #dcfce7;
            color: #15803d;
            padding: 7px 12px;
        }

        .status-issued {
            color: #2563eb;
            font-weight: bold;
        }

        .status-returned {
            color: #15803d;
            font-weight: bold;
        }

        .overdue {
            color: #dc2626;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }

        .fine {
            color: #dc2626;
            font-weight: bold;
        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">
        📚 SmartLib
    </div>

    <a href="dashboard.jsp" class="back">
        ← Dashboard
    </a>

</div>


<div class="container">


    <!-- HEADER -->

    <div class="header">

        <div>

            <h1>Library Management</h1>

            <p>
                Issue, return and track library books.
            </p>

        </div>

    </div>


    <!-- TABS -->

    <div class="tabs">

        <a href="LibraryServlet?action=history"
           class="tab">

            📋 All Transactions

        </a>

        <a href="LibraryServlet?action=overdue"
           class="tab">

            ⚠️ Overdue Books

        </a>

    </div>


    <!-- ISSUE BOOK -->

    <div class="card">

        <h2>📖 Issue Book</h2>

        <form action="LibraryServlet"
              method="post">

            <input type="hidden"
                   name="action"
                   value="issue">


            <div class="form-grid">

                <input
                        type="number"
                        name="bookId"
                        placeholder="Book ID"
                        required>


                <input
                        type="number"
                        name="userId"
                        placeholder="Student/User ID"
                        required>


                <input
                        type="number"
                        name="days"
                        placeholder="Days"
                        value="14"
                        min="1"
                        required>


                <button
                        type="submit"
                        class="issue-btn">

                    Issue Book

                </button>

            </div>

        </form>

    </div>


    <!-- TRANSACTION HISTORY -->

    <div class="card">

        <h2>📋 Transaction History</h2>

        <table>

            <thead>

            <tr>

                <th>ID</th>
                <th>Book</th>
                <th>Student</th>
                <th>Issue Date</th>
                <th>Due Date</th>
                <th>Return Date</th>
                <th>Status</th>
                <th>Action</th>

            </tr>

            </thead>


            <tbody>

            <%

                ResultSet history =
                        (ResultSet) request.getAttribute("history");

                boolean found = false;

                if (history != null) {

                    while (history.next()) {

                        found = true;

            %>

            <tr>

                <td>
                    <%= history.getInt("transaction_id") %>
                </td>

                <td>
                    <strong>
                        <%= history.getString("title") %>
                    </strong>
                </td>

                <td>
                    <%= history.getString("name") %>
                </td>

                <td>
                    <%= history.getDate("issue_date") %>
                </td>

                <td>
                    <%= history.getDate("due_date") %>
                </td>

                <td>

                    <%
                        if (history.getDate("return_date") != null) {
                    %>

                    <%= history.getDate("return_date") %>

                    <%
                    } else {
                    %>

                    -

                    <%
                        }
                    %>

                </td>

                <td>

                    <%
                        String status =
                                history.getString("status");

                        if ("Issued".equalsIgnoreCase(status)) {
                    %>

                    <span class="status-issued">
                            Issued
                        </span>

                    <%
                    } else {
                    %>

                    <span class="status-returned">
                            Returned
                        </span>

                    <%
                        }
                    %>

                </td>

                <td>

                    <%
                        if ("Issued".equalsIgnoreCase(status)) {
                    %>

                    <form action="LibraryServlet"
                          method="post">

                        <input type="hidden"
                               name="action"
                               value="return">

                        <input type="hidden"
                               name="transactionId"
                               value="<%= history.getInt("transaction_id") %>">

                        <button
                                type="submit"
                                class="return-btn">

                            ↩ Return

                        </button>

                    </form>

                    <%
                    } else {
                    %>

                    ✓ Completed

                    <%
                        }
                    %>

                </td>

            </tr>

            <%

                    }

                }

                if (!found) {

            %>

            <tr>

                <td colspan="8"
                    class="empty">

                    No transactions found.

                </td>

            </tr>

            <%

                }

            %>

            </tbody>

        </table>

    </div>


    <!-- OVERDUE BOOKS -->

    <div class="card">

        <h2>⚠️ Overdue Books</h2>

        <table>

            <thead>

            <tr>

                <th>Transaction ID</th>
                <th>Book</th>
                <th>Student</th>
                <th>Issue Date</th>
                <th>Due Date</th>
                <th>Overdue Days</th>
                <th>Estimated Fine</th>

            </tr>

            </thead>


            <tbody>

            <%

                ResultSet overdue =
                        (ResultSet) request.getAttribute("overdue");

                boolean overdueFound = false;

                if (overdue != null) {

                    while (overdue.next()) {

                        overdueFound = true;

                        int overdueDays =
                                overdue.getInt("overdue_days");

                        double estimatedFine =
                                overdueDays * 10;

            %>

            <tr>

                <td>
                    <%= overdue.getInt("transaction_id") %>
                </td>

                <td>
                    <strong>
                        <%= overdue.getString("title") %>
                    </strong>
                </td>

                <td>
                    <%= overdue.getString("name") %>
                </td>

                <td>
                    <%= overdue.getDate("issue_date") %>
                </td>

                <td class="overdue">
                    <%= overdue.getDate("due_date") %>
                </td>

                <td class="overdue">
                    <%= overdueDays %> days
                </td>

                <td class="fine">
                    ₹<%= estimatedFine %>
                </td>

            </tr>

            <%

                    }

                }

                if (!overdueFound) {

            %>

            <tr>

                <td colspan="7"
                    class="empty">

                    🎉 No overdue books!

                </td>

            </tr>

            <%

                }

            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>