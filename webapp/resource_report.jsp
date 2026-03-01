<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Resource" %>
<%@ page import="model.Allocation" %>
<%@ page import="dao.ResourceDAO" %>
<%@ page import="dao.AllocationDAO" %>
<%@ page import="dao.CampDAO" %>
<%@ page import="model.Camp" %>

<%
  List<Resource> resources = (List<Resource>) request.getAttribute("resources");
  List<Allocation> allocations = (List<Allocation>) request.getAttribute("allocations");
  if (resources == null) {
      ResourceDAO rdao = new ResourceDAO();
      resources = rdao.listAll();
  }
  if (allocations == null) {
      AllocationDAO adao = new AllocationDAO();
      allocations = adao.listAll();
  }
%>
<html>
<head><title>Resource Report</title>
<style>
<style>
/* Resource Report Page Styles */
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
    border-left: 5px solid #8e44ad;
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
    text-align: center;
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
    margin: 0 5px;
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
    margin-bottom: 30px;
}

th {
    background: linear-gradient(135deg, #8e44ad, #9b59b6);
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
    background: rgba(142, 68, 173, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

/* Summary Table Specific Styles */
table:first-of-type th {
    background: linear-gradient(135deg, #8e44ad, #9b59b6);
}

table:first-of-type tr:hover {
    background: rgba(142, 68, 173, 0.1);
}

/* Allocation Log Table Specific Styles */
table:nth-of-type(2) th {
    background: linear-gradient(135deg, #34495e, #2c3e50);
}

table:nth-of-type(2) tr:hover {
    background: rgba(52, 73, 94, 0.1);
}

/* Quantity Columns Styling */
td:nth-child(3), td:nth-child(4) {
    font-weight: 600;
    text-align: center;
}

/* Available vs Distributed Colors */
table:first-of-type td:nth-child(3) {
    color: #27ae60;
    font-size: 16px;
}

table:first-of-type td:nth-child(4) {
    color: #e74c3c;
    font-size: 16px;
}

/* Allocation Log Quantity */
table:nth-of-type(2) td:nth-child(3) {
    color: #e67e22;
    font-size: 16px;
}

/* User ID and Timestamp Styling */
table:nth-of-type(2) td:nth-child(4) {
    font-family: 'Courier New', monospace;
    background: rgba(52, 152, 219, 0.1);
    font-weight: 600;
    color: #2980b9;
    text-align: center;
}

table:nth-of-type(2) td:nth-child(5) {
    font-family: 'Courier New', monospace;
    font-size: 14px;
    color: #7f8c8d;
    text-align: center;
}

/* Resource Type Styling */
td:nth-child(2) {
    text-transform: capitalize;
    font-weight: 500;
}

/* Message Styles */
p[style*="color:green"] {
    background: rgba(39, 174, 96, 0.1);
    color: #27ae60 !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #27ae60;
    font-weight: 600;
    margin: 20px auto;
    text-align: center;
    max-width: 800px;
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
    
    p a {
        display: block;
        margin: 5px 0;
    }
    
    table:first-of-type td:nth-child(3),
    table:first-of-type td:nth-child(4),
    table:nth-of-type(2) td:nth-child(3) {
        font-size: 14px;
    }
    
    table:nth-of-type(2) td:nth-child(4),
    table:nth-of-type(2) td:nth-child(5) {
        font-size: 12px;
    }
}

/* Animation for table rows */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

tr {
    animation: fadeIn 0.5s ease-out;
}

/* Custom scrollbar for tables */
table::-webkit-scrollbar {
    height: 8px;
}

table::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

table:first-of-type::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #8e44ad, #9b59b6);
    border-radius: 10px;
}

table:nth-of-type(2)::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #34495e, #2c3e50);
    border-radius: 10px;
}

/* Section spacing */
h3 + table {
    margin-top: 10px;
}

/* Header navigation styling */
p:has(a) {
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
}

/* Visual indicators for data */
table:first-of-type tr:hover td:nth-child(3) {
    background: rgba(39, 174, 96, 0.2);
}

table:first-of-type tr:hover td:nth-child(4) {
    background: rgba(231, 76, 60, 0.2);
}

table:nth-of-type(2) tr:hover td:nth-child(3) {
    background: rgba(230, 126, 34, 0.2);
}
</style>
</style>
</head>
<body>
<h2>Resource Distribution Report</h2>
<p><a href="dashboard.jsp">Dashboard</a> | <a href="resources">Resources</a></p>

<h3>Resources Summary</h3>
<table border="1" cellpadding="6">
  <tr><th>Resource</th><th>Type</th><th>Available</th><th>Distributed (sum)</th></tr>
  <% 
     // compute distributed per resource
     for (Resource r : resources) {
         int distributed = 0;
         for (Allocation a : allocations) {
             if (a.getResourceId() == r.getId()) distributed += a.getQuantity();
         }
  %>
    <tr>
      <td><%= r.getName() %></td>
      <td><%= r.getType() %></td>
      <td><%= r.getQuantity() %></td>
      <td><%= distributed %></td>
    </tr>
  <% } %>
</table>

<h3>Allocation Log (Recent)</h3>
<table border="1" cellpadding="6">
  <tr><th>Resource</th><th>Camp</th><th>Quantity</th><th>Allocated By (user id)</th><th>When</th></tr>
  <% 
    CampDAO cdao = new CampDAO();
    for (Allocation a : allocations) {
        Resource r = new ResourceDAO().findById(a.getResourceId());
        Camp c = cdao.findById(a.getCampId());
  %>
    <tr>
      <td><%= r != null ? r.getName() : ("Res#" + a.getResourceId()) %></td>
      <td><%= c != null ? c.getName() : ("Camp#" + a.getCampId()) %></td>
      <td><%= a.getQuantity() %></td>
      <td><%= a.getAllocatedBy() %></td>
      <td><%= a.getAllocatedAt() %></td>
    </tr>
  <% } %>
</table>

<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
</body>
</html>
