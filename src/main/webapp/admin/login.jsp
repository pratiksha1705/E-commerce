<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Login | Control Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #2c3e50 0%, #1a1f25 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23000000" fill-opacity="0.1" d="M0,128L48,117.3C96,107,192,85,288,112C384,139,480,213,576,218.7C672,224,768,160,864,138.7C960,117,1056,139,1152,149.3C1248,160,1344,160,1392,160L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
            background-size: cover;
            opacity: 0.7;
        }
        
        .admin-login-container {
            width: 100%;
            max-width: 400px;
            background: rgba(30, 35, 42, 0.9);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
            z-index: 1;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px) scale(0.95); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }
        
        .admin-header {
            background: linear-gradient(to right, #243949 0%, #517fa4 100%);
            color: white;
            padding: 25px;
            text-align: center;
            position: relative;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .admin-header h2 {
            font-weight: 600;
            font-size: 24px;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }
        
        .admin-header p {
            opacity: 0.8;
            font-size: 14px;
            font-weight: 300;
        }
        
        .admin-header::after {
            content: '\f023';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
            opacity: 0.3;
        }
        
        .admin-form-container {
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
            color: #a0aec0;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .input-group input {
            width: 100%;
            padding: 14px 14px 14px 45px;
            background: rgba(40, 45, 52, 0.8);
            border: 1px solid #2d3748;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s ease;
            color: #e2e8f0;
            caret-color: #4299e1;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
            background: rgba(45, 50, 57, 0.9);
        }
        
        .input-group input::placeholder {
            color: #718096;
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 42px;
            color: #718096;
            transition: color 0.3s;
        }
        
        .input-group input:focus + i {
            color: #4299e1;
        }
        
        .error {
            background-color: rgba(254, 215, 215, 0.1);
            color: #fc8181;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            animation: shake 0.4s ease;
            border-left: 3px solid #fc8181;
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
            background: linear-gradient(to right, #243949 0%, #517fa4 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            letter-spacing: 0.5px;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
        }
        
        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }
        
        button:hover::before {
            left: 100%;
        }
        
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        
        button:active {
            transform: translateY(0);
        }
        
        .security-notice {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #718096;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .security-notice i {
            margin-right: 8px;
            color: #48bb78;
        }
        
        .admin-footer {
            text-align: center;
            padding: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 12px;
            color: #718096;
        }
        
        @media (max-width: 480px) {
            .admin-login-container {
                max-width: 100%;
            }
            
            .admin-header {
                padding: 20px;
            }
            
            .admin-form-container {
                padding: 20px;
            }
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            color: #718096;
            transition: color 0.3s;
        }
        
        .password-toggle:hover {
            color: #4299e1;
        }
    </style>
</head>
<body>
    <div class="admin-login-container">
        <div class="admin-header">
            <h2>Admin Control Panel</h2>
            <p>Restricted Access - Authorized Personnel Only</p>
        </div>
        
        <div class="admin-form-container">
            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <c:if test="${not empty errorMessage}">
                    <div class="error">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                
                <div class="input-group">
                    <label for="email">Admin Email</label>
                    <input type="email" id="email" name="email" placeholder="admin@example.com" required>
                    <i class="fas fa-user-shield"></i>
                </div>
                
                <div class="input-group">
                    <label for="password">Security Key</label>
                    <input type="password" id="password" name="password" placeholder="Enter your secure password" required>
                    <i class="fas fa-key"></i>
                    <span class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
                
                <button type="submit">Authenticate</button>
                
                <div class="security-notice">
                    <i class="fas fa-shield-alt"></i> Secure SSL Encryption
                </div>
            </form>
        </div>
        
        <div class="admin-footer">
            &copy; 2023 TechWorld Admin System • v2.4.1
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
                input.parentElement.querySelector('i').style.color = '#4299e1';
            });
            
            input.addEventListener('blur', () => {
                input.parentElement.querySelector('i').style.color = '#718096';
            });
        });
        
        // Add subtle background particles effect for security ambiance
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('body');
            const particleCount = 20;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.style.position = 'absolute';
                particle.style.width = '2px';
                particle.style.height = '2px';
                particle.style.background = 'rgba(66, 153, 225, 0.5)';
                particle.style.borderRadius = '50%';
                particle.style.zIndex = '0';
                
                // Random position
                particle.style.left = Math.random() * 100 + 'vw';
                particle.style.top = Math.random() * 100 + 'vh';
                
                // Add animation
                particle.style.animation = `floatParticle ${15 + Math.random() * 10}s infinite ease-in-out`;
                particle.style.animationDelay = Math.random() * 5 + 's';
                
                container.appendChild(particle);
            }
            
            // Add the animation keyframes
            const style = document.createElement('style');
            style.textContent = `
                @keyframes floatParticle {
                    0% { transform: translate(0, 0) scale(1); opacity: 0; }
                    50% { transform: translate(${Math.random() * 100 - 50}px, ${Math.random() * 100 - 50}px) scale(1.5); opacity: 0.7; }
                    100% { transform: translate(0, 0) scale(1); opacity: 0; }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>