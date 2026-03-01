<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Register - DisasterRelief</title>
  <style>
  /* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                url('https://images.unsplash.com/photo-1548013142-0c64e2a0491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') no-repeat center center fixed;
    background-size: cover;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.overlay {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.page.auth {
    width: 100%;
    max-width: 450px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 0 10px;
}

.brand {
    font-size: 24px;
    font-weight: bold;
    color: white;
}

.nav a {
    color: white;
    text-decoration: none;
    padding: 8px 16px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 4px;
    transition: background 0.3s ease;
}

.nav a:hover {
    background: rgba(255, 255, 255, 0.3);
}

.content {
    background: white;
    border-radius: 10px;
    padding: 40px 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.content h2 {
    color: #2c3e50;
    margin-bottom: 10px;
    text-align: center;
    font-size: 24px;
}

.subtle {
    color: #7f8c8d;
    text-align: center;
    margin-bottom: 30px;
    font-size: 14px;
}

.card {
    background: transparent;
    padding: 0;
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin-top: 15px;
    margin-bottom: 5px;
    font-weight: 600;
    color: #2c3e50;
    font-size: 14px;
}

input[type="text"],
input[type="email"],
input[type="password"],
select {
    padding: 12px 15px;
    border: 2px solid #e1e8ed;
    border-radius: 6px;
    font-size: 14px;
    width: 100%;
    transition: border-color 0.3s ease;
    background: #f8f9fa;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="password"]:focus,
select:focus {
    outline: none;
    border-color: #3498db;
    background: white;
}

select {
    cursor: pointer;
}

/* Button container styling */
form br + br {
    display: none;
}

/* Button styles */
button[type="submit"] {
    background: #e74c3c;
    color: white;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s ease;
    margin-top: 20px;
    width: 48%;
    display: inline-block;
    margin-right: 4%;
}

.btn {
    display: inline-block;
    padding: 12px;
    background: #6c7a89;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    transition: background 0.3s ease;
    cursor: pointer;
    width: 48%;
    margin-top: 20px;
}

button[type="submit"]:hover {
    background: #c0392b;
}

.btn:hover {
    background: #56606b;
}

.alert {
    padding: 12px;
    border-radius: 6px;
    margin-top: 20px;
    font-weight: 500;
    text-align: center;
    font-size: 14px;
}

.alert.err {
    background: #e74c3c;
    color: white;
}

.alert.ok {
    background: #27ae60;
    color: white;
}

/* Responsive design */
@media (max-width: 480px) {
    .content {
        padding: 30px 20px;
    }
    
    .header {
        flex-direction: column;
        gap: 15px;
        text-align: center;
    }
    
    button[type="submit"],
    .btn {
        width: 100%;
        margin: 5px 0;
    }
}
  </style>
</head>
<body>
<div class="overlay">
  <div class="page auth">
    <div class="header">
      <div class="brand">🌏 DisasterRelief</div>
      <div class="nav"><a href="login.jsp">Login</a></div>
    </div>
    <div class="content">
      <h2>Create your account</h2>
      <p class="subtle">Join as Citizen, NGO Staff, Donor, or Admin.</p>

      <div class="card">
        <form method="post" action="register">
          <label>Name</label>
          <input type="text" name="name" required/>
          <label>Email</label>
          <input type="email" name="email" required/>
          <label>Role</label>
          <select name="role">
            <option value="CITIZEN">Citizen</option>
            <option value="NGO">NGO Staff</option>
            <option value="DONOR">Donor</option>
            <option value="ADMIN">Admin</option>
          </select>
          <label>Password</label>
          <input type="password" name="password" required/>
          <br/><br/>
          <button type="submit">Register</button>
          <a class="btn" style="margin-left:8px;background:#6c7a89" href="login.jsp">Back to login</a>
        </form>
      </div>

      <% if(request.getParameter("error") != null) { %>
      <div class="alert err"><%= request.getParameter("error") %></div>
      <% } %>
      <% if(request.getParameter("msg") != null) { %>
      <div class="alert ok"><%= request.getParameter("msg") %></div>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>
