<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String token = request.getParameter("token");
  if (token == null) {
%>
  <script>location.href='reset_request.jsp';</script>
<%
    return;
  }
%>
<html>
<head><title>Reset Password - DisasterRelief</title>
<style>
/* Reset Password Form Page Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 40px 20px;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
}

h2 {
    background: rgba(255, 255, 255, 0.95);
    padding: 25px 30px;
    border-radius: 15px;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    color: #2c3e50;
    font-size: 28px;
    border-left: 5px solid #e74c3c;
    text-align: center;
}

form {
    background: rgba(255, 255, 255, 0.95);
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    margin-bottom: 20px;
    text-align: center;
    max-width: 500px;
    width: 100%;
}

form input[type="password"] {
    width: 100%;
    padding: 15px 20px;
    border: 2px solid #e1e8ed;
    border-radius: 8px;
    font-size: 16px;
    margin: 15px 0 25px 0;
    background: #f8f9fa;
    transition: all 0.3s ease;
    font-weight: 500;
}

form input[type="password"]:focus {
    outline: none;
    border-color: #e74c3c;
    background: white;
    box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
    transform: translateY(-2px);
}

form input[type="hidden"] {
    display: none;
}

form br {
    display: none;
}

form button {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 18px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
    width: 100%;
    margin-top: 10px;
}

form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
    background: linear-gradient(135deg, #c0392b, #a93226);
}

p {
    text-align: center;
    margin: 15px 0;
}

p a {
    display: inline-block;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    text-decoration: none;
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Message Styles */
p[style*="color:red"] {
    background: rgba(231, 76, 60, 0.1);
    color: #c0392b !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #e74c3c;
    font-weight: 600;
    margin: 20px auto;
    text-align: center;
    max-width: 500px;
}

/* Form label styling */
form {
    position: relative;
    color: #2c3e50;
    font-weight: 600;
    font-size: 16px;
}

/* Container for centering */
body > * {
    max-width: 500px;
    width: 100%;
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
        display: block;
    }
    
    h2 {
        font-size: 24px;
        padding: 20px;
        margin-bottom: 20px;
    }
    
    form {
        padding: 30px 20px;
        margin-bottom: 15px;
    }
    
    form input[type="password"] {
        padding: 12px 15px;
        font-size: 16px;
        margin: 10px 0 20px 0;
    }
    
    form button {
        padding: 12px 30px;
        font-size: 16px;
    }
    
    p a {
        padding: 10px 20px;
        font-size: 14px;
    }
}

/* Animation for form */
form {
    animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Focus states for accessibility */
form input[type="password"]:focus {
    outline: 2px solid #e74c3c;
    outline-offset: 2px;
}

/* Placeholder styling */
form input::placeholder {
    color: #bdc3c7;
    font-style: italic;
}

/* Password input specific styling */
form input[type="password"] {
    letter-spacing: 1px;
    font-family: 'Courier New', monospace;
}

/* Back to login link container */
p:has(a[href="login.jsp"]) {
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Security indicator */
form:after {
    content: "🔒 Choose a strong password";
    display: block;
    margin-top: 15px;
    font-size: 14px;
    color: #7f8c8d;
    font-style: italic;
}
</style>
</head>
<body>
<h2>Reset Password</h2>
<form method="post" action="reset-password">
  <input type="hidden" name="token" value="<%= token %>"/>
  New Password: <input type="password" name="password" required/><br/>
  <button type="submit">Change Password</button>
</form>
<p><a href="login.jsp">Back to Login</a></p>
<% if(request.getParameter("error") != null) { %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
