<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BookingDAO,dao.CampDAO,dao.ResourceDAO,model.Booking,model.Camp,model.Resource,java.util.List" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  String userName = (String) session.getAttribute("userName");
  String userRole = (String) session.getAttribute("userRole");
  if (userId == null || !"NGO".equals(userRole)) { response.sendRedirect("login.jsp?error=Please+login+as+NGO"); return; }
%>
<html>
<head><title>NGO Dashboard</title>
<style>
/* NGO Dashboard Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
    color: #333;
}

h2 {
    background: rgba(255, 255, 255, 0.95);
    padding: 20px 30px;
    border-radius: 15px;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    color: #2c3e50;
    font-size: 28px;
    border-left: 5px solid #e67e22;
}

ul {
    list-style: none;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

li {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

li:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

li a {
    display: block;
    padding: 25px 20px;
    text-decoration: none;
    color: #2c3e50;
    font-weight: 600;
    font-size: 16px;
    text-align: center;
    transition: color 0.3s ease;
    border-radius: 12px;
    border: 2px solid transparent;
}

li a:hover {
    color: #e67e22;
    background: rgba(230, 126, 34, 0.1);
    border-color: #e67e22;
}

hr {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
    margin: 30px 0;
}

h3 {
    color: white;
    font-size: 24px;
    margin-bottom: 20px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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
}

/* Status colors */
td:nth-child(3):contains("BOOKED") {
    background: #27ae60;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    display: inline-block;
}

td:nth-child(3):contains("CANCELLED") {
    background: #e74c3c;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    display: inline-block;
}

td:nth-child(3):contains("PENDING") {
    background: #f39c12;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    display: inline-block;
}

td:nth-child(3):contains("CHECKED_IN") {
    background: #3498db;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    display: inline-block;
}

td:nth-child(3) {
    background: #95a5a6;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    display: inline-block;
}

/* Resource Snapshot Styles */
p {
    background: rgba(255, 255, 255, 0.95);
    padding: 20px 25px;
    border-radius: 10px;
    margin-bottom: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    font-size: 16px;
    text-align: center;
}

p strong {
    color: #e67e22;
    font-size: 24px;
    font-weight: 700;
}

/* No bookings message */
p:not(:has(strong)) {
    background: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    font-size: 18px;
    color: #7f8c8d;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin: 20px 0;
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 15px;
    }
    
    h2 {
        font-size: 22px;
        padding: 15px 20px;
    }
    
    ul {
        grid-template-columns: 1fr;
    }
    
    table {
        display: block;
        overflow-x: auto;
    }
    
    th, td {
        padding: 12px 8px;
        font-size: 14px;
    }
    
    p {
        padding: 15px 20px;
        font-size: 15px;
    }
    
    p strong {
        font-size: 20px;
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

/* NGO-specific menu item highlighting */
li a[href="upload_resource.jsp"],
li a[href="allocate_resource.jsp"],
li a[href="resource_report.jsp"] {
    background: rgba(230, 126, 34, 0.05);
    border: 2px dashed #e67e22;
}

li a[href="upload_resource.jsp"]:hover,
li a[href="allocate_resource.jsp"]:hover,
li a[href="resource_report.jsp"]:hover {
    background: rgba(230, 126, 34, 0.15);
}

/* Resource snapshot highlight */
p:has(strong) {
    border-left: 4px solid #e67e22;
    background: rgba(255, 255, 255, 0.95);
}
</style>
</head>
<body>
<h2>Welcome, <%= userName %> (NGO)</h2>

<ul>
  <li><a href="camps">View Camps & Book</a></li>
  <li><a href="bookings.jsp">My Bookings</a></li>
  <li><a href="resources">Resources</a></li>
  <li><a href="upload_resource.jsp">Upload Resource</a></li>
  <li><a href="allocate_resource.jsp">Allocate Resource</a></li>
  <li><a href="resource_report.jsp">Resource Report</a></li>
  <li><a href="logout">Logout</a></li>
</ul>

<hr/>
<h3>My Recent Bookings</h3>
<%
  BookingDAO bdao = new BookingDAO();
  CampDAO cdao = new CampDAO();
  List<Booking> myBookings = bdao.listByUser(userId);
  if (myBookings != null && !myBookings.isEmpty()) {
%>
  <table border="1" cellpadding="6">
    <tr><th>Camp</th><th>Slots</th><th>Status</th></tr>
    <% for (Booking b : myBookings) {
         Camp c = cdao.findById(b.getCampId());
    %>
      <tr>
        <td><%= c != null ? c.getName() : ("Camp #" + b.getCampId()) %></td>
        <td><%= b.getSlots() %></td>
        <td><%= b.getStatus() %></td>
      </tr>
    <% } %>
  </table>
<% } else { %>
  <p>No bookings yet.</p>
<% } %>

<hr/>
<h3>Resource Snapshot (your NGO uploads)</h3>
<%
  ResourceDAO rdao = new ResourceDAO();
  List<Resource> all = rdao.listAll();
  int total = 0;
  for (Resource r : all) { if (r.getNgoId() == userId) total += r.getQuantity(); }
%>
<p>Total items you uploaded: <strong><%= total %></strong></p>

</body>
</html>
