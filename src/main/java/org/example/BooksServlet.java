package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/BooksServlet")
public class BooksServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            // DELETE
            if ("delete".equals(action)) {

                int bookId = Integer.parseInt(request.getParameter("id"));

                String sql = "DELETE FROM books WHERE book_id=?";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, bookId);
                ps.executeUpdate();

                response.sendRedirect("BooksServlet");
                return;
            }

            // SEARCH / VIEW
            String search = request.getParameter("search");

            String sql;

            if (search == null || search.trim().isEmpty()) {

                sql = "SELECT * FROM books";

            } else {

                sql = "SELECT * FROM books " +
                        "WHERE title LIKE ? OR author LIKE ? OR category LIKE ?";
            }

            PreparedStatement ps = con.prepareStatement(sql);

            if (search != null && !search.trim().isEmpty()) {

                String value = "%" + search + "%";

                ps.setString(1, value);
                ps.setString(2, value);
                ps.setString(3, value);
            }

            ResultSet rs = ps.executeQuery();

            request.setAttribute("books", rs);

            request.getRequestDispatcher("books.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error: " + e.getMessage()
            );
        }
    }


    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {

            Connection con = DBConnection.getConnection();

            // ADD BOOK
            if ("add".equals(action)) {

                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String category = request.getParameter("category");

                int quantity =
                        Integer.parseInt(request.getParameter("quantity"));

                String sql =
                        "INSERT INTO books " +
                                "(title, author, category, quantity, available_quantity) " +
                                "VALUES (?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, title);
                ps.setString(2, author);
                ps.setString(3, category);
                ps.setInt(4, quantity);
                ps.setInt(5, quantity);

                ps.executeUpdate();

                response.sendRedirect("BooksServlet");
            }


            // UPDATE BOOK
            else if ("update".equals(action)) {

                int bookId =
                        Integer.parseInt(request.getParameter("bookId"));

                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String category = request.getParameter("category");

                int quantity =
                        Integer.parseInt(request.getParameter("quantity"));

                String sql =
                        "UPDATE books SET title=?, author=?, " +
                                "category=?, quantity=? WHERE book_id=?";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, title);
                ps.setString(2, author);
                ps.setString(3, category);
                ps.setInt(4, quantity);
                ps.setInt(5, bookId);

                ps.executeUpdate();

                response.sendRedirect("BooksServlet");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error: " + e.getMessage()
            );
        }
    }
}