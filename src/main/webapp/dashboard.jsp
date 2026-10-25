<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.DBConnection" %>

<%
    String userName = (String) session.getAttribute("userName");
    String role = (String) session.getAttribute("role");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalBooks = 0;
    int availableBooks = 0;
    int issuedBooks = 0;
    int overdueBooks = 0;
    double totalFines = 0;

    try {

        Connection con = DBConnection.getConnection();

        // Total books
        PreparedStatement ps1 =
                con.prepareStatement(
                        "SELECT COALESCE(SUM(quantity),0) FROM books"
                );

        ResultSet rs1 = ps1.executeQuery();

        if (rs1.next()) {
            totalBooks = rs1.getInt(1);
        }


        // Available books
        PreparedStatement ps2 =
                con.prepareStatement(
                        "SELECT COALESCE(SUM(available_quantity),0) FROM books"
                );

        ResultSet rs2 = ps2.executeQuery();

        if (rs2.next()) {
            availableBooks = rs2.getInt(1);
        }


        // Issued books
        PreparedStatement ps3 =
                con.prepareStatement(
                        "SELECT COUNT(*) FROM transactions " +
                                "WHERE status='Issued'"
                );

        ResultSet rs3 = ps3.executeQuery();

        if (rs3.next()) {
            issuedBooks = rs3.getInt(1);
        }


        // Overdue books
        PreparedStatement ps4 =
                con.prepareStatement(
                        "SELECT COUNT(*) FROM transactions " +
                                "WHERE status='Issued' " +
                                "AND due_date < CURDATE()"
                );

        ResultSet rs4 = ps4.executeQuery();

        if (rs4.next()) {
            overdueBooks = rs4.getInt(1);
        }


        // Total unpaid fines
        PreparedStatement ps5 =
                con.prepareStatement(
                        "SELECT COALESCE(SUM(amount),0) " +
                                "FROM fines WHERE status='Unpaid'"
                );

        ResultSet rs5 = ps5.executeQuery();

        if (rs5.next()) {
            totalFines = rs5.getDouble(1);
        }

        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>


<!DOCTYPE html>
<html>

<head>

    <title>Admin Dashboard - SmartLib</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            color: #1e293b;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */

        .sidebar {
            width: 250px;
            background: #0f172a;
            color: white;
            padding: 25px 18px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            padding: 10px 15px 30px;
        }

        .menu-title {
            font-size: 12px;
            color: #94a3b8;
            margin: 15px;
            text-transform: uppercase;
        }

        .menu a {
            display: block;
            color: #cbd5e1;
            text-decoration: none;
            padding: 13px 15px;
            margin: 5px 0;
            border-radius: 8px;
            transition: 0.2s;
        }

        .menu a:hover {
            background: #1e293b;
            color: white;
        }

        .menu a.active {
            background: #2563eb;
            color: white;
        }

        .logout {
            margin-top: 30px;
            border-top: 1px solid #334155;
            padding-top: 20px;
        }

        .logout a {
            color: #fca5a5;
        }


        /* MAIN */

        .main {
            flex: 1;
            padding: 30px 40px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .welcome h1 {
            font-size: 28px;
            margin-bottom: 6px;
        }

        .welcome p {
            color: #64748b;
        }

        .user {
            background: white;
            padding: 10px 18px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

        .role {
            color: #2563eb;
            font-size: 13px;
            font-weight: bold;
        }


        /* STATS */

        .stats {
            display: grid;
            grid-template-columns:
                repeat(4, 1fr);

            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 22px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .stat-card .icon {
            font-size: 28px;
            margin-bottom: 12px;
        }

        .stat-card h3 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .stat-card p {
            color: #64748b;
        }


        /* SECTIONS */

        .section {
            background: white;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h2 {
            font-size: 20px;
        }

        .view-btn {
            text-decoration: none;
            background: #eff6ff;
            color: #2563eb;
            padding: 8px 14px;
            border-radius: 7px;
            font-size: 14px;
        }


        /* QUICK ACTIONS */

        .actions {
            display: grid;
            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;
        }

        .action {
            text-decoration: none;
            color: #1e293b;
            background: #f8fafc;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            transition: 0.2s;
        }

        .action:hover {
            border-color: #2563eb;
            transform: translateY(-2px);
        }

        .action-icon {
            font-size: 25px;
            margin-bottom: 10px;
        }

        .action h3 {
            margin-bottom: 5px;
        }

        .action p {
            color: #64748b;
            font-size: 13px;
        }


        /* INFO */

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-box {
            padding: 20px;
            border-radius: 10px;
            background: #f8fafc;
        }

        .info-box h3 {
            margin-bottom: 8px;
        }

        .info-box p {
            color: #64748b;
        }

        .fine {
            color: #dc2626;
            font-size: 24px;
            font-weight: bold;
        }

        .overdue {
            color: #dc2626;
        }


        @media(max-width: 900px) {

            .sidebar {
                width: 210px;
            }

            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .actions {
                grid-template-columns: repeat(2, 1fr);
            }

        }

    </style>

</head>


<body>


<div class="layout">


    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="logo">
            📚 SmartLib
        </div>


        <div class="menu-title">
            Main Menu
        </div>


        <div class="menu">

            <a href="dashboard.jsp"
               class="active">

                🏠 Dashboard

            </a>


            <a href="BooksServlet">

                📚 Books

            </a>


            <a href="LibraryServlet?action=history">

                📖 Library Management

            </a>


            <a href="LibraryServlet?action=overdue">

                ⚠️ Overdue & Fines

            </a>


            <a href="#students">

                👥 Students

            </a>


            <div class="menu-title">
                Reports
            </div>


            <a href="#analytics">

                📊 Analytics

            </a>


            <a href="#notifications">

                🔔 Notifications

            </a>


            <div class="logout">

                <a href="logout">

                    🚪 Logout

                </a>

            </div>

        </div>

    </aside>


    <!-- MAIN -->

    <main class="main">


        <!-- TOPBAR -->

        <div class="topbar">

            <div class="welcome">

                <h1>
                    Welcome, <%= userName %> 👋
                </h1>

                <p>
                    Here's what's happening in your library today.
                </p>

            </div>


            <div class="user">

                <strong>
                    <%= userName %>
                </strong>

                <br>

                <span class="role">
                    <%= role %>
                </span>

            </div>

        </div>


        <!-- STAT CARDS -->

        <div class="stats">


            <div class="stat-card">

                <div class="icon">
                    📚
                </div>

                <h3>
                    <%= totalBooks %>
                </h3>

                <p>
                    Total Books
                </p>

            </div>


            <div class="stat-card">

                <div class="icon">
                    📖
                </div>

                <h3>
                    <%= issuedBooks %>
                </h3>

                <p>
                    Issued Books
                </p>

            </div>


            <div class="stat-card">

                <div class="icon">
                    ⚠️
                </div>

                <h3 class="overdue">
                    <%= overdueBooks %>
                </h3>

                <p>
                    Overdue Books
                </p>

            </div>


            <div class="stat-card">

                <div class="icon">
                    💰
                </div>

                <h3 class="fine">
                    ₹<%= totalFines %>
                </h3>

                <p>
                    Unpaid Fines
                </p>

            </div>

        </div>


        <!-- QUICK ACTIONS -->

        <div class="section">

            <div class="section-header">

                <h2>
                    Quick Actions
                </h2>

            </div>


            <div class="actions">


                <a href="BooksServlet"
                   class="action">

                    <div class="action-icon">
                        📚
                    </div>

                    <h3>
                        Manage Books
                    </h3>

                    <p>
                        Add, update, delete and search books.
                    </p>

                </a>


                <a href="LibraryServlet?action=history"
                   class="action">

                    <div class="action-icon">
                        📖
                    </div>

                    <h3>
                        Issue / Return
                    </h3>

                    <p>
                        Manage book transactions.
                    </p>

                </a>


                <a href="LibraryServlet?action=overdue"
                   class="action">

                    <div class="action-icon">
                        ⚠️
                    </div>

                    <h3>
                        Overdue & Fines
                    </h3>

                    <p>
                        Track overdue books and fines.
                    </p>

                </a>


                <a href="#analytics"
                   class="action">

                    <div class="action-icon">
                        📊
                    </div>

                    <h3>
                        Analytics
                    </h3>

                    <p>
                        View library statistics and reports.
                    </p>

                </a>

            </div>

        </div>


        <!-- LIBRARY STATUS -->

        <div class="section">

            <div class="section-header">

                <h2>
                    Library Status
                </h2>

                <a href="BooksServlet"
                   class="view-btn">

                    View Books

                </a>

            </div>


            <div class="info-grid">


                <div class="info-box">

                    <h3>
                        Available Books
                    </h3>

                    <p>
                        <strong>
                            <%= availableBooks %>
                        </strong>
                        books are currently available.
                    </p>

                </div>


                <div class="info-box">

                    <h3>
                        Overdue Books
                    </h3>

                    <p class="overdue">

                        <strong>
                            <%= overdueBooks %>
                        </strong>

                        books need attention.

                    </p>

                </div>


            </div>

        </div>


        <!-- FUTURE ANALYTICS SECTION -->

        <div class="section"
             id="analytics">

            <div class="section-header">

                <h2>
                    📊 Analytics
                </h2>

            </div>

            <p style="color:#64748b;">

                Detailed charts and popular-book analytics
                will appear here.

            </p>

        </div>


        <!-- FUTURE NOTIFICATIONS -->

        <div class="section"
             id="notifications">

            <div class="section-header">

                <h2>
                    🔔 Notifications
                </h2>

            </div>

            <p style="color:#64748b;">

                Overdue alerts and important library
                notifications will appear here.

            </p>

        </div>


    </main>

</div>


</body>

</html>