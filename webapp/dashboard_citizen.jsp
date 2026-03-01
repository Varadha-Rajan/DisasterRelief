<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BookingDAO,dao.CampDAO,model.Booking,model.Camp,java.util.List" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  String userName = (String) session.getAttribute("userName");
  if (userId == null) { response.sendRedirect("login.jsp?error=Please+login"); return; }
%>
<html>
<head><title>Citizen Dashboard</title>
<style>
<style>
/* Citizen Dashboard Internal CSS */
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
    border-left: 5px solid #3498db;
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
    color: #3498db;
    background: rgba(52, 152, 219, 0.1);
    border-color: #3498db;
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
    text-align: center;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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
    background: linear-gradient(135deg, #3498db, #2980b9);
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
    background: rgba(52, 152, 219, 0.1);
}

button {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
}

form {
    display: inline;
}

p {
    background: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    font-size: 18px;
    color: #7f8c8d;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    margin: 20px 0;
}

/* Status colors based on text content */
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

/* Default status style */
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
    
    button {
        padding: 8px 16px;
        font-size: 13px;
    }
}
</style>
</style>
</head>
<body>
<h2>Welcome, <%= userName %> (CITIZEN)</h2>

<ul>
  <li><a href="camps">View Camps & Book</a></li>
  <li><a href="bookings.jsp">My Bookings</a></li>
  <li><a href="resources">Resources</a></li>
  <li><a href="logout">Logout</a></li>
</ul>

<hr/>
<h3>Quick Bookings Preview</h3>
<%
  BookingDAO bdao = new BookingDAO();
  CampDAO cdao = new CampDAO();
  List<Booking> myBookings = bdao.listByUser(userId);
  if (myBookings != null && !myBookings.isEmpty()) {
%>
  <table border="1" cellpadding="6">
    <tr><th>Camp</th><th>Slots</th><th>Status</th><th>Action</th></tr>
    <% for (Booking b : myBookings) {
         Camp c = cdao.findById(b.getCampId());
    %>
      <tr>
        <td><%= c != null ? c.getName() : ("Camp #" + b.getCampId()) %></td>
        <td><%= b.getSlots() %></td>
        <td><%= b.getStatus() %></td>
        <td>
          <% if ("BOOKED".equals(b.getStatus())) { %>
            <form method="post" action="cancel-booking" style="display:inline">
              <input type="hidden" name="bookingId" value="<%= b.getId() %>"/>
              <button type="submit">Cancel</button>
            </form>
          <% } else { %>
            -
          <% } %>
        </td>
      </tr>
    <% } %>
  </table>
<% } else { %>
  <p>You have no bookings.</p>
<% } %>

</body>
</html>
