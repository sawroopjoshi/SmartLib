<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>

    <title>Books - SmartLib</title>

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

        .top-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 30px;
            margin-bottom: 6px;
        }

        .heading p {
            color: #64748b;
        }

        .add-btn {
            background: #2563eb;
            color: white;
            border: none;
            padding: 13px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .search-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-form input {
            flex: 1;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }

        .search-form button {
            background: #0f172a;
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 8px;
            cursor: pointer;
        }

        .table-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            padding: 16px;
            text-align: left;
            font-size: 14px;
            color: #475569;
        }

        td {
            padding: 16px;
            border-top: 1px solid #e2e8f0;
        }

        .available {
            color: #15803d;
            font-weight: bold;
        }

        .unavailable {
            color: #dc2626;
            font-weight: bold;
        }

        .action-btn {
            padding: 7px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            margin-right: 5px;
        }

        .edit {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .delete {
            background: #fee2e2;
            color: #dc2626;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15,23,42,0.65);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background: white;
            width: 500px;
            max-width: 90%;
            padding: 30px;
            border-radius: 15px;
        }

        .modal-content h2 {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 11px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
        }

        .form-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .save-btn {
            background: #2563eb;
            color: white;
            border: none;
            padding: 11px 20px;
            border-radius: 7px;
            cursor: pointer;
        }

        .cancel-btn {
            background: #e2e8f0;
            border: none;
            padding: 11px 20px;
            border-radius: 7px;
            cursor: pointer;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #64748b;
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

    <div class="top-section">

        <div class="heading">

            <h1>Book Management</h1>

            <p>
                Manage library books, search records and update inventory.
            </p>

        </div>

        <button class="add-btn" onclick="openAddModal()">
            + Add New Book
        </button>

    </div>


    <!-- SEARCH -->

    <div class="search-box">

        <form action="BooksServlet"
              method="get"
              class="search-form">

            <input
                    type="text"
                    name="search"
                    placeholder="Search by title, author or category..."
            >

            <button type="submit">
                🔍 Search
            </button>

        </form>

    </div>


    <!-- BOOK TABLE -->

    <div class="table-card">

        <table>

            <thead>

            <tr>

                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Available</th>
                <th>Action</th>

            </tr>

            </thead>

            <tbody>

            <%

                ResultSet books =
                        (ResultSet) request.getAttribute("books");

                boolean found = false;

                if (books != null) {

                    while (books.next()) {

                        found = true;

            %>

            <tr>

                <td>
                    <%= books.getInt("book_id") %>
                </td>

                <td>
                    <strong>
                        <%= books.getString("title") %>
                    </strong>
                </td>

                <td>
                    <%= books.getString("author") %>
                </td>

                <td>
                    <%= books.getString("category") %>
                </td>

                <td>
                    <%= books.getInt("quantity") %>
                </td>

                <td>

                    <%
                        int available =
                                books.getInt("available_quantity");

                        if (available > 0) {
                    %>

                    <span class="available">
                            <%= available %>
                        </span>

                    <%
                    } else {
                    %>

                    <span class="unavailable">
                            0
                        </span>

                    <%
                        }
                    %>

                </td>

                <td>

                    <!-- UPDATE -->

                    <button
                            class="action-btn edit"
                            onclick="openEditModal(
                                    '<%= books.getInt("book_id") %>',
                                    '<%= books.getString("title").replace("'", "\\'") %>',
                                    '<%= books.getString("author").replace("'", "\\'") %>',
                                    '<%= books.getString("category").replace("'", "\\'") %>',
                                    '<%= books.getInt("quantity") %>'
                                    )">

                        ✏️ Edit

                    </button>


                    <!-- DELETE -->

                    <button
                            class="action-btn delete"
                            onclick="deleteBook(
                                    '<%= books.getInt("book_id") %>'
                                    )">

                        🗑️ Delete

                    </button>

                </td>

            </tr>

            <%

                    }

                }

                if (!found) {

            %>

            <tr>

                <td colspan="7" class="empty">
                    No books found.
                </td>

            </tr>

            <%

                }

            %>

            </tbody>

        </table>

    </div>

</div>


<!-- ADD BOOK MODAL -->

<div id="addModal" class="modal">

    <div class="modal-content">

        <h2>➕ Add New Book</h2>

        <form action="BooksServlet" method="post">

            <input type="hidden"
                   name="action"
                   value="add">

            <div class="form-group">

                <label>Book Title</label>

                <input
                        type="text"
                        name="title"
                        required
                        placeholder="Enter book title">

            </div>

            <div class="form-group">

                <label>Author</label>

                <input
                        type="text"
                        name="author"
                        required
                        placeholder="Enter author name">

            </div>

            <div class="form-group">

                <label>Category</label>

                <input
                        type="text"
                        name="category"
                        required
                        placeholder="Programming / Database / Data Science">

            </div>

            <div class="form-group">

                <label>Quantity</label>

                <input
                        type="number"
                        name="quantity"
                        min="1"
                        required
                        placeholder="Enter quantity">

            </div>

            <div class="form-buttons">

                <button type="submit" class="save-btn">
                    Add Book
                </button>

                <button
                        type="button"
                        class="cancel-btn"
                        onclick="closeAddModal()">

                    Cancel

                </button>

            </div>

        </form>

    </div>

</div>


<!-- EDIT BOOK MODAL -->

<div id="editModal" class="modal">

    <div class="modal-content">

        <h2>✏️ Update Book</h2>

        <form action="BooksServlet" method="post">

            <input type="hidden"
                   name="action"
                   value="update">

            <input type="hidden"
                   id="editBookId"
                   name="bookId">


            <div class="form-group">

                <label>Book Title</label>

                <input
                        type="text"
                        id="editTitle"
                        name="title"
                        required>

            </div>


            <div class="form-group">

                <label>Author</label>

                <input
                        type="text"
                        id="editAuthor"
                        name="author"
                        required>

            </div>


            <div class="form-group">

                <label>Category</label>

                <input
                        type="text"
                        id="editCategory"
                        name="category"
                        required>

            </div>


            <div class="form-group">

                <label>Quantity</label>

                <input
                        type="number"
                        id="editQuantity"
                        name="quantity"
                        min="1"
                        required>

            </div>


            <div class="form-buttons">

                <button type="submit"
                        class="save-btn">

                    Update Book

                </button>

                <button
                        type="button"
                        class="cancel-btn"
                        onclick="closeEditModal()">

                    Cancel

                </button>

            </div>

        </form>

    </div>

</div>


<script>

    function openAddModal() {

        document.getElementById("addModal").style.display = "flex";

    }


    function closeAddModal() {

        document.getElementById("addModal").style.display = "none";

    }


    function openEditModal(id, title, author, category, quantity) {

        document.getElementById("editBookId").value = id;

        document.getElementById("editTitle").value = title;

        document.getElementById("editAuthor").value = author;

        document.getElementById("editCategory").value = category;

        document.getElementById("editQuantity").value = quantity;

        document.getElementById("editModal").style.display = "flex";

    }


    function closeEditModal() {

        document.getElementById("editModal").style.display = "none";

    }


    function deleteBook(id) {

        let confirmDelete =
            confirm("Are you sure you want to delete this book?");

        if (confirmDelete) {

            window.location.href =
                "BooksServlet?action=delete&id=" + id;

        }

    }

</script>

</body>
</html>