<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.Map,model.Camp" %>
<%
  if (session.getAttribute("userId") == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
      response.sendRedirect("login.jsp?error=Please+login+as+Admin");
      return;
  }
  List<Camp> camps = (List<Camp>) request.getAttribute("camps");
  Map<Integer,Integer> bookedMap = (Map<Integer,Integer>) request.getAttribute("bookedMap");
  Map<Integer,Integer> allocatedPerCamp = (Map<Integer,Integer>) request.getAttribute("allocatedPerCamp");
  if (camps == null) camps = new java.util.ArrayList<>();
%>
<html>
<head><title>Admin Reports</title>
<style>
/* Admin Reports Page Styles */
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
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    padding: 18px 15px;
    text-align: center;
    font-weight: 600;
    font-size: 16px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

td {
    padding: 15px;
    border-bottom: 1px solid #ecf0f1;
    font-size: 15px;
    text-align: center;
}

tr:nth-child(even) {
    background: rgba(236, 240, 241, 0.5);
}

tr:hover {
    background: rgba(231, 76, 60, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

/* Capacity Column Styling */
td:nth-child(2) {
    font-weight: 600;
    color: #3498db;
    font-size: 16px;
}

/* Booked Column Styling */
td:nth-child(3) {
    font-weight: 600;
    color: #e74c3c;
    font-size: 16px;
}

/* Available Column Styling */
td:nth-child(4) {
    font-weight: 600;
    font-size: 16px;
}

/* Available capacity color coding */
td:nth-child(4):contains("0") {
    color: #e74c3c;
    background: rgba(231, 76, 60, 0.1);
}

td:nth-child(4):not(:contains("0")) {
    color: #27ae60;
}

/* Allocated Supplies Column Styling */
td:nth-child(5) {
    font-weight: 600;
    color: #9b59b6;
    font-size: 16px;
    background: rgba(155, 89, 182, 0.05);
}

/* Camp Name Column */
td:nth-child(1) {
    text-align: left;
    font-weight: 600;
    color: #2c3e50;
}

/* Notes Section */
hr {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
    margin: 30px 0;
}

h3 + p {
    background: rgba(255, 255, 255, 0.95);
    padding: 25px 30px;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    font-size: 15px;
    line-height: 1.6;
    color: #7f8c8d;
    border-left: 4px solid #f39c12;
    font-style: italic;
}

/* Notes section specific styling */
p:contains("This report shows") {
    background: rgba(255, 255, 255, 0.95);
    padding: 25px 30px;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    font-size: 15px;
    line-height: 1.6;
    color: #7f8c8d;
    border-left: 4px solid #f39c12;
    font-style: italic;
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
    
    p a {
        padding: 10px 15px;
        font-size: 14px;
    }
    
    td:nth-child(2),
    td:nth-child(3),
    td:nth-child(4),
    td:nth-child(5) {
        font-size: 14px;
    }
    
    p:contains("This report shows") {
        padding: 20px;
        font-size: 14px;
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

/* Header row styling */
th:nth-child(1) { background: linear-gradient(135deg, #e74c3c, #c0392b); }
th:nth-child(2) { background: linear-gradient(135deg, #3498db, #2980b9); }
th:nth-child(3) { background: linear-gradient(135deg, #e74c3c, #c0392b); }
th:nth-child(4) { background: linear-gradient(135deg, #27ae60, #219a52); }
th:nth-child(5) { background: linear-gradient(135deg, #9b59b6, #8e44ad); }

/* Visual indicators for critical data */
tr:hover td:nth-child(4):contains("0") {
    background: rgba(231, 76, 60, 0.2);
}

tr:hover td:nth-child(4):not(:contains("0")) {
    background: rgba(39, 174, 96, 0.2);
}

/* Notes section icon */
p:contains("This report shows")::before {
    content: "💡 ";
    font-size: 18px;
    vertical-align: middle;
}

/* Performance note emphasis */
p:contains("SQL GROUP BY") {
    font-weight: 600;
    color: #e74c3c;
}
</style>
</head>
<body>
<h2>Admin Reports</h2>
<p><a href="dashboard">Back to Dashboard</a></p>

<h3>Camp Occupancy & Supplies Summary</h3>
<table border="1" cellpadding="6">
  <tr><th>Camp</th><th>Capacity</th><th>Booked</th><th>Available</th><th>Allocated Supplies</th></tr>
  <% for (Camp c : camps) {
       int booked = bookedMap.getOrDefault(c.getId(), 0);
       int available = c.getCapacity() - booked;
       int allocated = allocatedPerCamp.getOrDefault(c.getId(), 0);
  %>
    <tr>
      <td><%= c.getName() %></td>
      <td><%= c.getCapacity() %></td>
      <td><%= booked %></td>
      <td><%= available %></td>
      <td><%= allocated %></td>
    </tr>
  <% } %>
</table>

<hr/>
<h3>Notes</h3>
<p>This report shows current BOOKED slots, available capacity, and allocated supplies (sum of quantities allocated to the camp). For large datasets replace JSP-level aggregation with SQL `GROUP BY` queries.</p>

</body>
</html>
