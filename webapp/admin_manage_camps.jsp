<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,model.Camp" %>
<%
  if (session.getAttribute("userId") == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
      response.sendRedirect("login.jsp?error=Please+login+as+Admin");
      return;
  }
  List<Camp> camps = (List<Camp>) request.getAttribute("camps");
  if (camps == null) camps = new java.util.ArrayList<>();
%>
<html>
<head><title>Admin - Manage Camps</title>
<style>
/* Admin Manage Camps Page Styles */
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

h3 {
    color: white;
    font-size: 22px;
    margin: 30px 0 15px 0;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    padding-left: 10px;
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

/* Create Camp Form */
form:first-of-type {
    background: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    margin-bottom: 30px;
    border-left: 4px solid #27ae60;
}

form:first-of-type input[type="text"],
form:first-of-type input[type="number"] {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #e1e8ed;
    border-radius: 8px;
    font-size: 16px;
    margin: 8px 0 20px 0;
    background: #f8f9fa;
    transition: all 0.3s ease;
}

form:first-of-type input:focus {
    outline: none;
    border-color: #27ae60;
    background: white;
    box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
}

form:first-of-type button {
    background: linear-gradient(135deg, #27ae60, #219a52);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 18px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
    width: 100%;
    margin-top: 10px;
}

form:first-of-type button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
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

/* Capacity Column */
td:nth-child(3) {
    font-weight: 600;
    color: #3498db;
    font-size: 16px;
}

/* City Column */
td:nth-child(4) {
    color: #27ae60;
    font-weight: 500;
}

/* Booked Column */
td:nth-child(5) {
    font-weight: 600;
    font-size: 16px;
}

/* Booked slots color coding */
td:nth-child(5):contains("0") {
    color: #27ae60;
}

td:nth-child(5):not(:contains("0")) {
    color: #e67e22;
}

/* Actions Column */
td:nth-child(6) {
    min-width: 400px;
}

/* Inline Edit Forms */
td form {
    display: block;
    margin: 10px 0;
    padding: 15px;
    background: rgba(52, 152, 219, 0.05);
    border-radius: 8px;
    border-left: 3px solid #3498db;
}

td form input[type="text"],
td form input[type="number"] {
    padding: 8px 12px;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    font-size: 14px;
    margin: 0 8px 8px 0;
    background: white;
}

td form input[type="text"] {
    width: 150px;
}

td form input[type="number"] {
    width: 100px;
}

/* Update Button */
td form:first-of-type button {
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    margin-right: 10px;
}

td form:first-of-type button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Delete Button */
td form:last-of-type {
    background: rgba(231, 76, 60, 0.05);
    border-left: 3px solid #e74c3c;
    display: inline-block;
    margin-left: 10px;
}

td form:last-of-type button {
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

td form:last-of-type button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
}

/* Hidden Inputs */
input[type="hidden"] {
    display: none;
}

/* Horizontal Rule */
hr {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
    margin: 30px 0;
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
    
    h3 {
        font-size: 20px;
        margin: 20px 0 10px 0;
    }
    
    table {
        display: block;
        overflow-x: auto;
    }
    
    th, td {
        padding: 12px 8px;
        font-size: 14px;
    }
    
    td:nth-child(6) {
        min-width: 300px;
    }
    
    td form {
        padding: 10px;
    }
    
    td form input[type="text"],
    td form input[type="number"] {
        width: 100%;
        margin: 5px 0;
        display: block;
    }
    
    form:first-of-type {
        padding: 20px;
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

/* Capacity utilization warning */
tr:has(td:nth-child(5):not(:contains("0"))) {
    background: rgba(231, 76, 60, 0.03);
}

/* Create form labels */
form:first-of-type {
    position: relative;
    color: #2c3e50;
    font-weight: 600;
}

/* Section headers with icons */
h3::before {
    content: "🏕️ ";
}

h3 + form::before {
    content: "➕ Create New Camp";
    display: block;
    font-size: 18px;
    font-weight: 700;
    color: #27ae60;
    margin-bottom: 20px;
    text-align: center;
}
</style>
</head>
<body>
<h2>Manage Camps</h2>
<p><a href="dashboard">Back to Dashboard</a></p>

<h3>Create New Camp</h3>
<form method="post" action="admin/camp-action">
  <input type="hidden" name="action" value="create"/>
  Name: <input type="text" name="name" required/><br/>
  Capacity: <input type="number" name="capacity" min="1" required/><br/>
  Address: <input type="text" name="address"/><br/>
  City: <input type="text" name="city"/><br/>
  State: <input type="text" name="state"/><br/>
  Facilities: <input type="text" name="facilities"/><br/>
  Contact: <input type="text" name="contact"/><br/>
  <button type="submit">Create Camp</button>
</form>

<hr/>
<h3>Existing Camps</h3>
<table border="1" cellpadding="6">
  <tr><th>ID</th><th>Name</th><th>Capacity</th><th>City</th><th>Booked</th><th>Actions</th></tr>
  <% for (Camp c : camps) {
       int booked = 0;
       try { booked = new dao.CampDAO().currentBookedSlots(c.getId()); } catch (Exception e) {}
  %>
    <tr>
      <td><%= c.getId() %></td>
      <td><%= c.getName() %></td>
      <td><%= c.getCapacity() %></td>
      <td><%= c.getCity() %></td>
      <td><%= booked %></td>
      <td>
        <!-- Inline edit form -->
        <form method="post" action="admin/camp-action" style="display:inline">
          <input type="hidden" name="action" value="update"/>
          <input type="hidden" name="id" value="<%= c.getId() %>"/>
          Name: <input type="text" name="name" value="<%= c.getName() %>" required/>
          Capacity: <input type="number" name="capacity" value="<%= c.getCapacity() %>" min="1" required/>
          <button type="submit">Update</button>
        </form>

        <form method="post" action="admin/camp-action" style="display:inline" onsubmit="return confirm('Delete camp?');">
          <input type="hidden" name="action" value="delete"/>
          <input type="hidden" name="id" value="<%= c.getId() %>"/>
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
