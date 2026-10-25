<!DOCTYPE html>
<html>
<head>
    <title>Add New Book - SmartLib</title>

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
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
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
            width: 90%;
            max-width: 700px;
            margin: 50px auto;
        }

        .card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        h1 {
            margin-bottom: 8px;
        }

        .subtitle {
            color: #64748b;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #2563eb;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button {
            border: none;
            padding: 13px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
        }

        .save {
            background: #2563eb;
            color: white;
        }

        .cancel {
            background: #e2e8f0;
            color: #334155;
        }
    </style>
</head>

<body>

<div class="navbar">
    <div class="logo">📚 SmartLib</div>

    <a href="BooksServlet" class="back">
        ← Back to Books
    </a>
</div>

<div class="container">

    <div class="card">

        <h1>Add New Book</h1>

        <p class="subtitle">
            Enter the book details to add it to the SmartLib library.
        </p>

        <form action="AddBookServlet" method="post">

            <div class="form-group">
                <label>Book Title</label>
                <input type="text"
                       name="title"
                       placeholder="Enter book title"
                       required>
            </div>

            <div class="form-group">
                <label>Author</label>
                <input type="text"
                       name="author"
                       placeholder="Enter author name"
                       required>
            </div>

            <div class="form-group">
                <label>Category</label>
                <input type="text"
                       name="category"
                       placeholder="e.g. Programming, Database, Data Science"
                       required>
            </div>

            <div class="form-group">
                <label>Quantity</label>
                <input type="number"
                       name="quantity"
                       min="1"
                       placeholder="Enter quantity"
                       required>
            </div>

            <div class="buttons">

                <button type="submit" class="save">
                    ➕ Add Book
                </button>

                <button type="button"
                        class="cancel"
                        onclick="window.location.href='BooksServlet'">
                    Cancel
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>