<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SmartLib - Login</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #0f172a;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 900px;
            min-height: 520px;
            background: white;
            border-radius: 18px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        /* LEFT SIDE */

        .login-left {
            width: 50%;
            background: #101828;
            color: white;
            padding: 60px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .logo span {
            color: #38bdf8;
        }

        .login-left h1 {
            font-size: 38px;
            margin-bottom: 18px;
        }

        .login-left p {
            color: #cbd5e1;
            line-height: 1.7;
            font-size: 16px;
        }

        .features {
            margin-top: 30px;
        }

        .features p {
            margin: 12px 0;
        }

        /* RIGHT SIDE */

        .login-right {
            width: 50%;
            padding: 55px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right h2 {
            font-size: 30px;
            margin-bottom: 8px;
            color: #101828;
        }

        .login-subtitle {
            color: #667085;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #344054;
        }

        input,
        select {
            width: 100%;
            padding: 13px;
            margin-bottom: 20px;
            border: 1px solid #d0d5dd;
            border-radius: 7px;
            font-size: 15px;
            outline: none;
        }

        input:focus,
        select:focus {
            border-color: #38bdf8;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 7px;
            background: #38bdf8;
            color: #101828;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #0ea5e9;
            color: white;
        }

        .back {
            text-align: center;
            margin-top: 20px;
        }

        .back a {
            color: #0ea5e9;
            text-decoration: none;
        }

        @media (max-width: 700px) {

            .login-container {
                width: 95%;
                flex-direction: column;
            }

            .login-left,
            .login-right {
                width: 100%;
            }

            .login-left {
                padding: 35px;
            }

            .login-right {
                padding: 35px;
            }

        }

    </style>

</head>


<body>


<div class="login-container">


    <!-- LEFT SIDE -->

    <div class="login-left">

        <div class="logo">
            Smart<span>Lib</span>
        </div>

        <h1>
            Welcome Back!
        </h1>

        <p>
            Login to access your SmartLib account and
            manage your library activities easily.
        </p>


        <div class="features">

            <p>📚 Manage your books</p>

            <p>🔄 Track issue and return</p>

            <p>💰 Monitor fines and overdue books</p>

            <p>🤖 Get smart book recommendations</p>

        </div>

    </div>


    <!-- RIGHT SIDE -->

    <div class="login-right">

        <h2>Login</h2>

        <p class="login-subtitle">
            Enter your details to continue
        </p>


        <form action="LoginServlet" method="post">

            <label>
                Email
            </label>

            <input
                    type="email"
                    name="email"
                    placeholder="Enter your email"
                    required
            >


            <label>
                Password
            </label>

            <input
                    type="password"
                    name="password"
                    placeholder="Enter your password"
                    required
            >


            <label>
                Login As
            </label>

            <select name="role">

                <option value="student">
                    Student
                </option>

                <option value="admin">
                    Admin
                </option>

            </select>


            <button type="submit" class="login-btn">
                Login
            </button>

        </form>


        <div class="back">

            <a href="index.jsp">
                ← Back to Home
            </a>

        </div>

    </div>


</div>


</body>

</html>