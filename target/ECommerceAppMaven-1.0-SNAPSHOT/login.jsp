<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login | TechBoutique</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .header {
            background: linear-gradient(to right, #4b6cb7, #182848);
            color: white;
            padding: 25px;
            text-align: center;
        }
        
        .header h2 {
            font-weight: 600;
            font-size: 24px;
            margin-bottom: 5px;
        }
        
        .header p {
            opacity: 0.8;
            font-size: 14px;
        }
        
        .form-container {
            padding: 25px;
        }
        
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
            font-size: 14px;
        }
        
        .input-group input {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: #4b6cb7;
            box-shadow: 0 0 0 2px rgba(75, 108, 183, 0.2);
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 42px;
            color: #777;
        }
        
        .error {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            animation: shake 0.4s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .error i {
            margin-right: 10px;
        }
        
        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(to right, #4b6cb7, #182848);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
            background: linear-gradient(to right, #405ca0, #141e3c);
        }
        
        .footer {
            text-align: center;
            padding: 20px;
            border-top: 1px solid #eee;
            font-size: 14px;
            color: #666;
        }
        
        .footer a {
            color: #4b6cb7;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .footer a:hover {
            color: #182848;
            text-decoration: underline;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            color: #777;
        }
        
        @media (max-width: 480px) {
            .container {
                max-width: 100%;
            }
            
            .header {
                padding: 20px;
            }
            
            .form-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Welcome Back</h2>
            <p>Sign in to access your account</p>
        </div>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <c:if test="${not empty errorMessage}">
                    <div class="error">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                
                <div class="input-group">
                    <label for="email">Email Address</label>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                
                <div class="input-group">
                    <label for="password">Password</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <span class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
                
                <button type="submit">Sign In</button>
            </form>
        </div>
        
        <div class="footer">
            New to TechBoutique? <a href="register.jsp">Create an account</a>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.password-toggle i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Add focus effects to inputs
        const inputs = document.querySelectorAll('input');
        inputs.forEach(input => {
            input.addEventListener('focus', () => {
                input.parentElement.querySelector('i').style.color = '#4b6cb7';
            });
            
            input.addEventListener('blur', () => {
                input.parentElement.querySelector('i').style.color = '#777';
            });
        });
    </script>
</body>
</html>