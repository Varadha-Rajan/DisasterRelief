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
<head><title>Admin Reports</title></head>
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
