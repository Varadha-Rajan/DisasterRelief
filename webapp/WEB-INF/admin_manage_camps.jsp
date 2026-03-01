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
<head><title>Admin - Manage Camps</title></head>
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
