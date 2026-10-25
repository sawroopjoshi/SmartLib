<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SmartLib - Smart Library</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            color: #172033;
        }

        /* NAVBAR */

        nav {
            height: 70px;
            background: #101828;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 7%;
        }

        .logo {
            color: white;
            font-size: 26px;
            font-weight: bold;
        }

        .logo span {
            color: #38bdf8;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        .nav-links a:hover {
            color: #38bdf8;
        }

        /* HERO */

        .hero {
            min-height: 500px;
            background: #0f172a;
            display: flex;
            align-items: center;
            padding: 60px 7%;
        }

        .hero-content {
            max-width: 700px;
        }

        .hero h1 {
            color: white;
            font-size: 52px;
            margin-bottom: 20px;
        }

        .hero h1 span {
            color: #38bdf8;
        }

        .hero p {
            color: #d5deeb;
            font-size: 18px;
            line-height: 1.7;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 13px 25px;
            background: #38bdf8;
            color: #101828;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
            margin-right: 10px;
        }

        .btn:hover {
            background: white;
        }

        .btn-outline {
            background: transparent;
            color: white;
            border: 1px solid #38bdf8;
        }

        /* FEATURES */

        .features {
            padding: 60px 7%;
            text-align: center;
        }

        .features h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #667085;
            margin-bottom: 40px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 22px;
        }

        .card {
            background: white;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .icon {
            font-size: 35px;
            margin-bottom: 15px;
        }

        .card h3 {
            margin-bottom: 12px;
        }

        .card p {
            color: #667085;
            font-size: 14px;
            line-height: 1.6;
        }

        /* ABOUT */

        .about {
            background: #eaf6fc;
            padding: 60px 7%;
            text-align: center;
        }

        .about h2 {
            font-size: 30px;
            margin-bottom: 15px;
        }

        .about p {
            max-width: 750px;
            margin: auto;
            color: #52606d;
            line-height: 1.7;
        }

        /* FOOTER */

        footer {
            background: #101828;
            color: #cbd5e1;
            text-align: center;
            padding: 25px;
        }

    </style>

</head>


<body>

<!-- NAVIGATION -->

<nav>

    <div class="logo">
        Smart<span>Lib</span>
    </div>

    <div class="nav-links">

        <a href="index.jsp">Home</a>

        <a href="#features">Features</a>

        <a href="#about">About</a>

        <a href="login.jsp">Login</a>

    </div>

</nav>


<!-- HERO SECTION -->

<section class="hero">

    <div class="hero-content">

        <h1>
            Welcome to <span>SmartLib</span>
        </h1>

        <p>
            A modern library management system that makes
            book discovery, borrowing, returning and
            library management simple and intelligent.
        </p>

        <a href="login.jsp" class="btn">
            Get Started
        </a>

        <a href="#features" class="btn btn-outline">
            Explore Features
        </a>

    </div>

</section>


<!-- FEATURES -->

<section class="features" id="features">

    <h2>Smart Library Features</h2>

    <p class="subtitle">
        Everything you need for a modern digital library
    </p>


    <div class="cards">

        <div class="card">

            <div class="icon">📚</div>

            <h3>Book Management</h3>

            <p>
                Add, update, delete, search and manage
                books from one place.
            </p>

        </div>


        <div class="card">

            <div class="icon">🔄</div>

            <h3>Issue & Return</h3>

            <p>
                Manage book issuing and returning with
                automatic availability updates.
            </p>

        </div>


        <div class="card">

            <div class="icon">💰</div>

            <h3>Fine Tracking</h3>

            <p>
                Track overdue books and calculate
                applicable fines automatically.
            </p>

        </div>


        <div class="card">

            <div class="icon">🤖</div>

            <h3>Smart Recommendations</h3>

            <p>
                Get book recommendations based on
                previous borrowing activity.
            </p>

        </div>

    </div>

</section>


<!-- ABOUT -->

<section class="about" id="about">

    <h2>Why SmartLib?</h2>

    <p>
        SmartLib combines library management with smart
        features such as recommendations, analytics,
        overdue tracking and activity monitoring.
    </p>

</section>


<!-- FOOTER -->

<footer>

    <p>
        © 2026 SmartLib | Smart Library Management System
    </p>

</footer>


</body>

</html>
```