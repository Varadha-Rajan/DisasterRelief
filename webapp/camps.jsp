<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Camp" %>
<html>
<head><title>Available Camps</title>
<style>
/* Available Camps Page Styles */
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
    border-left: 5px solid #27ae60;
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
    background: linear-gradient(135deg, #27ae60, #219a52);
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
}

tr:nth-child(even) {
    background: rgba(236, 240, 241, 0.5);
}

tr:hover {
    background: rgba(39, 174, 96, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

td a {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    display: inline-block;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
}

td a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
    background: linear-gradient(135deg, #c0392b, #a93226);
}

p[style*="color:red"] {
    background: rgba(231, 76, 60, 0.1);
    color: #c0392b !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #e74c3c;
    font-weight: 600;
    margin-top: 20px;
}

/* No camps message */
p:not(:has(a)):not([style]) {
    background: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    font-size: 18px;
    color: #7f8c8d;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin: 20px 0;
}

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
    
    p a, td a {
        padding: 10px 15px;
        font-size: 13px;
    }
}

/* Animation for table rows */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

tr {
    animation: fadeInUp 0.5s ease-out;
}
</style>
</head>
<body>
<h2>Available Relief Camps</h2>
<p><a href="dashboard.jsp">Back to Dashboard</a></p>

<% 
  List<Camp> camps = (List<Camp>) request.getAttribute("camps");
  if (camps == null || camps.isEmpty()) {
%>
  <p>No camps available.</p>
<% } else { %>
  <table border="1" cellpadding="6" cellspacing="0">
    <tr><th>Name</th><th>Capacity</th><th>City</th><th>Facilities</th><th>Action</th></tr>
    <% for (Camp c : camps) { %>
      <tr>
        <td><%= c.getName() %></td>
        <td><%= c.getCapacity() %></td>
        <td><%= c.getCity() %></td>
        <td><%= c.getFacilities() %></td>
        <td><a href="camp?id=<%= c.getId() %>">View / Book</a></td>
      </tr>
    <% } %>
  </table>
<% } %>

<% if(request.getParameter("error")!=null){ %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
