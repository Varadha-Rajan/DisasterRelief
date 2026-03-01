<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,model.Donation" %>
<%
  java.util.List<Donation> donations = (java.util.List<Donation>) request.getAttribute("donations");
  if (donations == null) donations = new java.util.ArrayList<>();
%>
<html>
<head><title>My Donations</title>
<style>
/* My Donations Page Styles */
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
    margin: 0 5px 10px 0;
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Make another donation button */
p a[href="donate.jsp"] {
    background: linear-gradient(135deg, #27ae60, #219a52);
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
}

p a[href="donate.jsp"]:hover {
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
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

/* Amount column styling */
td:nth-child(3) {
    font-weight: 600;
}

/* Money amount styling */
td:contains("₹") {
    color: #27ae60;
    font-size: 16px;
    font-family: 'Courier New', monospace;
    font-weight: 700;
}

/* Material description styling */
td:not(:contains("₹")):nth-child(3) {
    color: #e67e22;
    font-style: italic;
}

/* Status badges */
td:nth-child(4) {
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    padding: 6px 12px;
    border-radius: 20px;
    display: inline-block;
}

td:nth-child(4):contains("COMPLETED") {
    background: #27ae60;
    color: white;
}

td:nth-child(4):contains("PENDING") {
    background: #f39c12;
    color: white;
}

td:nth-child(4):contains("CANCELLED") {
    background: #e74c3c;
    color: white;
}

td:nth-child(4):contains("PROCESSING") {
    background: #3498db;
    color: white;
}

td:nth-child(4) {
    background: #95a5a6;
    color: white;
}

/* Receipt link styling */
td:nth-child(5) a {
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
    color: white;
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(155, 89, 182, 0.3);
    display: inline-block;
}

td:nth-child(5) a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(155, 89, 182, 0.4);
    background: linear-gradient(135deg, #8e44ad, #7d3c98);
}

/* No receipt dash */
td:nth-child(5):contains("-") {
    color: #bdc3c7;
    font-style: italic;
}

/* Date column styling */
td:nth-child(1) {
    font-family: 'Courier New', monospace;
    font-size: 14px;
    color: #7f8c8d;
}

/* Type column styling */
td:nth-child(2) {
    text-transform: capitalize;
    font-weight: 500;
}

/* No donations message */
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
    
    td:nth-child(4) {
        font-size: 11px;
        padding: 4px 8px;
    }
    
    td:nth-child(5) a {
        padding: 6px 12px;
        font-size: 12px;
    }
    
    td:contains("₹") {
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
    background: linear-gradient(135deg, #27ae60, #219a52);
    border-radius: 10px;
}

/* Navigation container */
p:has(a) {
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
}
</style>
</head>
<body>
<h2>My Donations</h2>
<p><a href="dashboard">Back to Dashboard</a> | <a href="donate.jsp">Make another donation</a></p>

<% if (donations.isEmpty()) { %>
  <p>No donations yet.</p>
<% } else { %>
  <table border="1" cellpadding="6">
    <tr><th>When</th><th>Type</th><th>Amount / Material</th><th>Status</th><th>Receipt</th></tr>
    <% for (Donation d : donations) { %>
      <tr>
        <td><%= d.getCreatedAt() %></td>
        <td><%= d.getDonationType() %></td>
        <td>
          <% if ("MONEY".equals(d.getDonationType())) { %>
            ₹ <%= d.getAmount() %>
          <% } else { %>
            <%= d.getMaterialDescription() %>
          <% } %>
        </td>
        <td><%= d.getStatus() %></td>
        <td>
          <% if ("COMPLETED".equals(d.getStatus())) { %>
            <a href="receipt?id=<%= d.getId() %>">View Receipt</a>
          <% } else { %>
            -
          <% } %>
        </td>
      </tr>
    <% } %>
  </table>
<% } %>

<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
</body>
</html>
