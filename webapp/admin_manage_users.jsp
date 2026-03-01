<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,model.User" %>
<%
  // security check
  if (session.getAttribute("userId") == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
      response.sendRedirect("login.jsp?error=Please+login+as+Admin");
      return;
  }
  List<User> users = (List<User>) request.getAttribute("users");
  if (users == null) users = new java.util.ArrayList<>();
%>
<html>
<head><title>Admin - Manage Users</title>
<style>
/* Admin Manage Users Page Styles */
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
}

h2 {
    background: rgba(255, 255, 255, 0.95);
    padding: 20px 30px;
    border-radius: 15px;
    margin-bottom: 20px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    color: #2c3e50;
    font-size: 28px;
    border-left: 5px solid #e74c3c;
    text-align: center;
}

p {
    margin-bottom: 20px;
}

p a {
    display: inline-block;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Table Styles */
table {
    width: 100%;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    border-collapse: collapse;
    margin-bottom: 20px;
}

th {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    padding: 18px 15px;
    text-align: left;
    font-weight: 600;
    font-size: 16px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

td {
    padding: 15px;
    border-bottom: 1px solid #ecf0f1;
    font-size: 15px;
    vertical-align: top;
}

tr:nth-child(even) {
    background: rgba(236, 240, 241, 0.5);
}

tr:hover {
    background: rgba(231, 76, 60, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

/* ID Column */
td:nth-child(1) {
    font-family: 'Courier New', monospace;
    font-weight: 600;
    color: #7f8c8d;
    font-size: 14px;
}

/* Name Column */
td:nth-child(2) {
    font-weight: 600;
    color: #2c3e50;
}

/* Email Column */
td:nth-child(3) {
    color: #3498db;
    font-weight: 500;
}

/* Role Column Styling */
td:nth-child(4) {
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    padding: 6px 12px;
    border-radius: 20px;
    display: inline-block;
    margin-top: 5px;
}

td:nth-child(4):contains("ADMIN") {
    background: #e74c3c;
    color: white;
}

td:nth-child(4):contains("NGO") {
    background: #e67e22;
    color: white;
}

td:nth-child(4):contains("DONOR") {
    background: #9b59b6;
    color: white;
}

td:nth-child(4):contains("CITIZEN") {
    background: #3498db;
    color: white;
}

/* Actions Column */
td:nth-child(5) {
    min-width: 300px;
}

/* Form Styles in Actions Column */
form {
    display: inline-block;
    margin: 5px 10px 5px 0;
    vertical-align: top;
}

form select {
    padding: 8px 12px;
    border: 2px solid #e1e8ed;
    border-radius: 6px;
    font-size: 14px;
    background: #f8f9fa;
    margin-right: 8px;
    cursor: pointer;
    font-weight: 500;
}

form select:focus {
    outline: none;
    border-color: #3498db;
    background: white;
}

/* Update Role Button */
form:first-of-type button {
    background: linear-gradient(135deg, #27ae60, #219a52);
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
}

form:first-of-type button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
    background: linear-gradient(135deg, #219a52, #1e8449);
}

/* Delete Button */
form:last-of-type button {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
}

form:last-of-type button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
    background: linear-gradient(135deg, #c0392b, #a93226);
}

/* Hidden Inputs */
input[type="hidden"] {
    display: none;
}

/* Message Styles */
p[style*="color:green"] {
    background: rgba(39, 174, 96, 0.1);
    color: #27ae60 !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #27ae60;
    font-weight: 600;
    margin-top: 20px;
    text-align: center;
}

/* Navigation container */
p:has(a) {
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
    text-align: center;
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
    }
    
    h2 {
        font-size: 22px;
        padding: 15px 20px;
    }
    
    table {
        display: block;
        overflow-x: auto;
    }
    
    th, td {
        padding: 12px 8px;
        font-size: 14px;
    }
    
    td:nth-child(5) {
        min-width: 250px;
    }
    
    form {
        display: block;
        margin: 10px 0;
    }
    
    form select {
        width: 100%;
        margin-bottom: 8px;
    }
    
    form button {
        width: 100%;
        padding: 10px;
    }
    
    p a {
        padding: 10px 15px;
        font-size: 14px;
    }
}

/* Animation for table rows */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

tr {
    animation: fadeIn 0.5s ease-out;
}

/* Custom scrollbar for table */
table::-webkit-scrollbar {
    height: 8px;
}

table::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

table::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    border-radius: 10px;
}

/* Role-specific row highlighting */
tr:has(td:nth-child(4):contains("ADMIN")) {
    background: rgba(231, 76, 60, 0.05);
}

tr:has(td:nth-child(4):contains("NGO")) {
    background: rgba(230, 126, 34, 0.05);
}

/* Security warning for admin actions */
td:nth-child(5)::before {
    content: "⚙️ Admin Actions";
    display: block;
    font-size: 12px;
    color: #e74c3c;
    font-weight: 600;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
</style>
</head>
<body>
<h2>Manage Users</h2>
<p><a href="dashboard">Back to Dashboard</a></p>

<table border="1" cellpadding="6">
  <tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Actions</th></tr>
  <% for (User u : users) { %>
    <tr>
      <td><%= u.getId() %></td>
      <td><%= u.getName() %></td>
      <td><%= u.getEmail() %></td>
      <td><%= u.getRole() %></td>
      <td>
        <form method="post" action="admin/user-action" style="display:inline">
          <input type="hidden" name="userId" value="<%= u.getId() %>"/>
          <select name="newRole">
            <option value="CITIZEN" <%= "CITIZEN".equals(u.getRole()) ? "selected":"" %>>Citizen</option>
            <option value="NGO" <%= "NGO".equals(u.getRole()) ? "selected":"" %>>NGO</option>
            <option value="DONOR" <%= "DONOR".equals(u.getRole()) ? "selected":"" %>>Donor</option>
            <option value="ADMIN" <%= "ADMIN".equals(u.getRole()) ? "selected":"" %>>Admin</option>
          </select>
          <input type="hidden" name="action" value="changeRole"/>
          <button type="submit">Update Role</button>
        </form>

        <form method="post" action="admin/user-action" style="display:inline" onsubmit="return confirm('Delete user?');">
          <input type="hidden" name="userId" value="<%= u.getId() %>"/>
          <input type="hidden" name="action" value="delete"/>
          <button type="submit">Delete</button>
        </form>
      </td>
    </tr>
  <% } %>
</table>

<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
</body>
</html>
