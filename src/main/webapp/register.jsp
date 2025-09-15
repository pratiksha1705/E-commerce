<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register | TechBoutique</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            width: 100%;
            max-width: 480px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }
        
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
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
            opacity: 0.9;
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
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            color: #777;
        }
        
        .password-requirements {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 12px 15px;
            margin-top: 5px;
            font-size: 12px;
            color: #666;
            border-left: 3px solid #4b6cb7;
        }
        
        .password-requirements ul {
            padding-left: 20px;
            margin-top: 5px;
        }
        
        .password-requirements li {
            margin-bottom: 3px;
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
            margin-top: 10px;
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
        
        .progress-bar {
            height: 5px;
            background-color: #eee;
            border-radius: 5px;
            margin-bottom: 20px;
            overflow: hidden;
        }
        
        .progress {
            height: 100%;
            width: 0%;
            background: linear-gradient(to right, #4b6cb7, #182848);
            transition: width 0.3s ease;
        }
        
        @media (max-width: 520px) {
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
        
        .error-message {
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
        
        .error-message i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Create Your Account</h2>
            <p>Join our community and start shopping today</p>
        </div>
        
        <div class="progress-bar">
            <div class="progress" id="form-progress"></div>
        </div>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/user/register" method="post" id="registration-form">
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                
                <div class="input-group">
                    <label for="name">Full Name</label>
                    <i class="fas fa-user"></i>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                
                <div class="input-group">
                    <label for="email">Email Address</label>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>
                
                <div class="input-group">
                    <label for="password">Password</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Create a strong password" required 
                           onkeyup="checkPasswordStrength(this.value)">
                    <span class="password-toggle" onclick="togglePassword('password')">
                        <i class="fas fa-eye"></i>
                    </span>
                    
                    <div class="password-requirements">
                        <strong>Password must include:</strong>
                        <ul>
                            <li id="length-req">At least 8 characters</li>
                            <li id="number-req">At least one number</li>
                            <li id="special-req">At least one special character</li>
                        </ul>
                    </div>
                </div>
                
                <div class="input-group">
                    <label for="phone">Phone Number (Optional)</label>
                    <i class="fas fa-phone"></i>
                    <input type="tel" id="phone" name="phone" placeholder="Enter your phone number">
                </div>
                
                <button type="submit">Create Account</button>
            </form>
        </div>
        
        <div class="footer">
            Already have an account? <a href="login.jsp">Sign in here</a>
        </div>
    </div>

    <script>
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleIcon = passwordInput.parentElement.querySelector('.password-toggle i');
            
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
        
        function checkPasswordStrength(password) {
            // Update progress bar
            let strength = 0;
            if (password.length >= 8) {
                document.getElementById('length-req').style.color = '#4CAF50';
                strength += 33;
            } else {
                document.getElementById('length-req').style.color = '#666';
            }
            
            if (/\d/.test(password)) {
                document.getElementById('number-req').style.color = '#4CAF50';
                strength += 33;
            } else {
                document.getElementById('number-req').style.color = '#666';
            }
            
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                document.getElementById('special-req').style.color = '#4CAF50';
                strength += 34;
            } else {
                document.getElementById('special-req').style.color = '#666';
            }
            
            document.getElementById('form-progress').style.width = strength + '%';
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
        
        // Form validation
        document.getElementById('registration-form').addEventListener('submit', function(e) {
            let isValid = true;
            const password = document.getElementById('password').value;
            
            if (password.length < 8) {
                isValid = false;
                alert('Password must be at least 8 characters long');
            }
            
            if (!/\d/.test(password)) {
                isValid = false;
                alert('Password must contain at least one number');
            }
            
            if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                isValid = false;
                alert('Password must contain at least one special character');
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>