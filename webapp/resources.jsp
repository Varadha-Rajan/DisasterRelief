<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Resource" %>
<html>
<head><title>Resources</title>
<style>
<style>
/* Resources Page Styles */
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
    border-left: 5px solid #e67e22;
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
    margin: 0 5px 10px 0;
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Specific link colors */
p a[href="upload_resource.jsp"] {
    background: linear-gradient(135deg, #27ae60, #219a52);
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
}

p a[href="upload_resource.jsp"]:hover {
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
}

p a[href="allocate_resource.jsp"] {
    background: linear-gradient(135deg, #e67e22, #d35400);
    box-shadow: 0 4px 15px rgba(230, 126, 34, 0.3);
}

p a[href="allocate_resource.jsp"]:hover {
    box-shadow: 0 6px 20px rgba(230, 126, 34, 0.4);
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
    background: linear-gradient(135deg, #e67e22, #d35400);
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
    background: rgba(230, 126, 34, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

/* Quantity highlighting */
td:nth-child(3) {
    font-weight: 600;
    color: #e74c3c;
    font-size: 16px;
}

/* Type column styling */
td:nth-child(2) {
    text-transform: capitalize;
    font-weight: 500;
}

/* Unit column styling */
td:nth-child(4) {
    color: #7f8c8d;
    font-style: italic;
}

/* NGO ID column styling */
td:nth-child(5) {
    font-family: 'Courier New', monospace;
    background: rgba(52, 152, 219, 0.1);
    font-weight: 600;
    color: #2980b9;
}

/* No resources message */
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

p[style*="color:red"] {
    background: rgba(231, 76, 60, 0.1);
    color: #c0392b !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #e74c3c;
    font-weight: 600;
    margin-top: 20px;
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
    
    p a {
        display: block;
        margin: 5px 0;
        text-align: center;
    }
    
    td:nth-child(3) {
        font-size: 14px;
    }
    
    td:nth-child(5) {
        font-size: 12px;
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
    background: linear-gradient(135deg, #e67e22, #d35400);
    border-radius: 10px;
}

/* Link separator styling */
p:has(a) {
    text-align: center;
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Pipe separator between links */
p:has(a)::before {
    content: "";
    display: none;
}
</style>
</style>
</head>
<body>
<h2>All Resources</h2>
<p><a href="dashboard.jsp">Back to Dashboard</a> | <a href="upload_resource.jsp">Upload Resource</a> | <a href="allocate_resource.jsp">Allocate Resource</a></p>

<% List<Resource> resources = (List<Resource>) request.getAttribute("resources");
   if (resources == null || resources.isEmpty()) { %>
  <p>No resources found.</p>
<% } else { %>
  <table border="1" cellpadding="6">
    <tr><th>Name</th><th>Type</th><th>Available</th><th>Unit</th><th>Uploaded By (NGO ID)</th></tr>
    <% for (Resource r : resources) { %>
      <tr>
        <td><%= r.getName() %></td>
        <td><%= r.getType() %></td>
        <td><%= r.getQuantity() %></td>
        <td><%= r.getUnit() %></td>
        <td><%= r.getNgoId() %></td>
      </tr>
    <% } %>
  </table>
<% } %>

<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
<% if(request.getParameter("error")!=null){ %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
