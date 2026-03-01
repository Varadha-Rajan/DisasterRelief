<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BookingDAO" %>
<%@ page import="model.Booking" %>
<%@ page import="dao.CampDAO" %>
<%@ page import="model.Camp" %>
<%@ page import="java.util.List" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  if (userId == null) { response.sendRedirect("login.jsp?error=Please+login"); return; }

  BookingDAO bdao = new BookingDAO();
  CampDAO cdao = new CampDAO();
  List<Booking> bookings = bdao.listByUser(userId);
%>
<html>
<head><title>My Bookings</title>
<style>
<style>
/* My Bookings Page Styles */
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
    border-left: 5px solid #9b59b6;
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
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
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
    background: rgba(155, 89, 182, 0.1);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

/* Button Styles */
button {
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

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
    background: linear-gradient(135deg, #c0392b, #a93226);
}

form {
    display: inline;
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

td:nth-child(3):contains("COMPLETED") {
    background: #9b59b6;
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

/* No bookings message */
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

/* Date column styling */
td:nth-child(4) {
    font-family: 'Courier New', monospace;
    font-size: 14px;
    color: #7f8c8d;
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
    
    p a, button {
        padding: 10px 15px;
        font-size: 13px;
    }
    
    td:nth-child(4) {
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

/* Action column styling */
td:last-child {
    text-align: center;
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
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
    border-radius: 10px;
}
</style>
</style>
</head>
<body>
<h2>My Bookings</h2>
<p><a href="dashboard.jsp">Back to Dashboard</a></p>

<% if(bookings == null || bookings.isEmpty()) { %>
  <p>No bookings found.</p>
<% } else { %>
  <table border="1" cellpadding="6" cellspacing="0">
    <tr><th>Camp</th><th>Slots</th><th>Status</th><th>Booked At</th><th>Action</th></tr>
    <% for(Booking b : bookings) {
         Camp c = cdao.findById(b.getCampId());
    %>
      <tr>
        <td><%= c != null ? c.getName() : ("Camp #" + b.getCampId()) %></td>
        <td><%= b.getSlots() %></td>
        <td><%= b.getStatus() %></td>
        <td><%= b.getBookedAt() %></td>
        <td>
          <% if("BOOKED".equals(b.getStatus())) { %>
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
<% } %>

<% if(request.getParameter("msg")!=null) { %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
<% if(request.getParameter("error")!=null) { %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
