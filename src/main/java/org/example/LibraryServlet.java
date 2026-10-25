package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/LibraryServlet")
public class LibraryServlet extends HttpServlet {

    // =========================
    // ISSUE BOOK
    // =========================

    private void issueBook(HttpServletRequest request,
                           HttpServletResponse response)
            throws Exception {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        int days = Integer.parseInt(request.getParameter("days"));

        LocalDate issueDate = LocalDate.now();
        LocalDate dueDate = issueDate.plusDays(days);

        Connection con = DBConnection.getConnection();

        String checkBook =
                "SELECT available_quantity FROM books WHERE book_id=?";

        PreparedStatement bookPs =
                con.prepareStatement(checkBook);

        bookPs.setInt(1, bookId);

        ResultSet bookRs = bookPs.executeQuery();

        if (!bookRs.next()) {
            response.getWriter().println("Book not found.");
            return;
        }

        int available =
                bookRs.getInt("available_quantity");

        if (available <= 0) {
            response.getWriter().println("Book is not available.");
            return;
        }

        // Create transaction
        String transactionSql =
                "INSERT INTO transactions " +
                        "(book_id, user_id, issue_date, due_date, status) " +
                        "VALUES (?, ?, ?, ?, 'Issued')";

        PreparedStatement transactionPs =
                con.prepareStatement(transactionSql);

        transactionPs.setInt(1, bookId);
        transactionPs.setInt(2, userId);
        transactionPs.setDate(
                3,
                Date.valueOf(issueDate)
        );
        transactionPs.setDate(
                4,
                Date.valueOf(dueDate)
        );

        transactionPs.executeUpdate();

        // Reduce available books
        String updateBook =
                "UPDATE books SET available_quantity = " +
                        "available_quantity - 1 WHERE book_id=?";

        PreparedStatement updatePs =
                con.prepareStatement(updateBook);

        updatePs.setInt(1, bookId);
        updatePs.executeUpdate();

        response.sendRedirect("LibraryServlet?action=history");
    }


    // =========================
    // RETURN BOOK
    // =========================

    private void returnBook(HttpServletRequest request,
                            HttpServletResponse response)
            throws Exception {

        int transactionId =
                Integer.parseInt(
                        request.getParameter("transactionId")
                );

        Connection con = DBConnection.getConnection();

        // Get transaction information
        String transactionSql =
                "SELECT book_id, due_date, status " +
                        "FROM transactions WHERE transaction_id=?";

        PreparedStatement transactionPs =
                con.prepareStatement(transactionSql);

        transactionPs.setInt(1, transactionId);

        ResultSet rs =
                transactionPs.executeQuery();

        if (!rs.next()) {
            response.getWriter().println("Transaction not found.");
            return;
        }

        int bookId = rs.getInt("book_id");

        Date dueDate = rs.getDate("due_date");

        String status = rs.getString("status");

        if ("Returned".equalsIgnoreCase(status)) {
            response.getWriter().println("Book already returned.");
            return;
        }

        LocalDate returnDate = LocalDate.now();

        // Calculate overdue days
        long overdueDays = 0;

        if (returnDate.isAfter(dueDate.toLocalDate())) {

            overdueDays =
                    ChronoUnit.DAYS.between(
                            dueDate.toLocalDate(),
                            returnDate
                    );
        }

        // Fine = ₹10 per overdue day
        double fineAmount = overdueDays * 10;

        // Update transaction
        String updateTransaction =
                "UPDATE transactions SET " +
                        "return_date=?, status='Returned' " +
                        "WHERE transaction_id=?";

        PreparedStatement updatePs =
                con.prepareStatement(updateTransaction);

        updatePs.setDate(
                1,
                Date.valueOf(returnDate)
        );

        updatePs.setInt(2, transactionId);

        updatePs.executeUpdate();


        // Increase available quantity
        String updateBook =
                "UPDATE books SET " +
                        "available_quantity = available_quantity + 1 " +
                        "WHERE book_id=?";

        PreparedStatement bookPs =
                con.prepareStatement(updateBook);

        bookPs.setInt(1, bookId);

        bookPs.executeUpdate();


        // Add fine if applicable
        if (fineAmount > 0) {

            String fineSql =
                    "INSERT INTO fines " +
                            "(transaction_id, amount, status) " +
                            "VALUES (?, ?, 'Unpaid')";

            PreparedStatement finePs =
                    con.prepareStatement(fineSql);

            finePs.setInt(1, transactionId);
            finePs.setDouble(2, fineAmount);

            finePs.executeUpdate();
        }

        response.sendRedirect("LibraryServlet?action=history");
    }


    // =========================
    // HISTORY
    // =========================

    private void showHistory(HttpServletRequest request,
                             HttpServletResponse response)
            throws Exception {

        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT t.transaction_id, " +
                        "b.title, " +
                        "u.name, " +
                        "t.issue_date, " +
                        "t.due_date, " +
                        "t.return_date, " +
                        "t.status " +
                        "FROM transactions t " +
                        "JOIN books b ON t.book_id=b.book_id " +
                        "JOIN users u ON t.user_id=u.user_id " +
                        "ORDER BY t.transaction_id DESC";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        request.setAttribute("history", rs);

        request.getRequestDispatcher(
                "library.jsp"
        ).forward(request, response);
    }


    // =========================
    // OVERDUE BOOKS
    // =========================

    private void showOverdue(HttpServletRequest request,
                             HttpServletResponse response)
            throws Exception {

        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT t.transaction_id, " +
                        "b.title, " +
                        "u.name, " +
                        "t.issue_date, " +
                        "t.due_date, " +
                        "DATEDIFF(CURDATE(), t.due_date) AS overdue_days " +
                        "FROM transactions t " +
                        "JOIN books b ON t.book_id=b.book_id " +
                        "JOIN users u ON t.user_id=u.user_id " +
                        "WHERE t.status='Issued' " +
                        "AND t.due_date < CURDATE() " +
                        "ORDER BY t.due_date";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        request.setAttribute("overdue", rs);

        request.getRequestDispatcher(
                "library.jsp"
        ).forward(request, response);
    }


    // =========================
    // GET REQUEST
    // =========================

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        try {

            if ("history".equals(action)) {

                showHistory(request, response);

            } else if ("overdue".equals(action)) {

                showOverdue(request, response);

            } else {

                showHistory(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error: " +
                            e.getMessage()
            );
        }
    }


    // =========================
    // POST REQUEST
    // =========================

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        try {

            if ("issue".equals(action)) {

                issueBook(request, response);

            } else if ("return".equals(action)) {

                returnBook(request, response);

            } else {

                response.getWriter().println(
                        "Invalid action."
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error: " +
                            e.getMessage()
            );
        }
    }
}