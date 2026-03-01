<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,model.User" %>
<%
  // security check
  if (session.getAttribute("userId") == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
      response.sendRedirect("login.jsp?error=Please+login+as+Admin");
      return;
  }
  List<User> users = (List<User>) request.getAttribute("users");
  if (users == null) users = new java.util.ArrayList<>();
%>
<html>
<head><title>Admin - Manage Users</title></head>
<body>
<h2>Manage Users</h2>
<p><a href="dashboard">Back to Dashboard</a></p>

<table border="1" cellpadding="6">
  <tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Actions</th></tr>
  <% for (User u : users) { %>
    <tr>
      <td><%= u.getId() %></td>
      <td><%= u.getName() %></td>
      <td><%= u.getEmail() %></td>
      <td><%= u.getRole() %></td>
      <td>
        <form method="post" action="admin/user-action" style="display:inline">
          <input type="hidden" name="userId" value="<%= u.getId() %>"/>
          <select name="newRole">
            <option value="CITIZEN" <%= "CITIZEN".equals(u.getRole()) ? "selected":"" %>>Citizen</option>
            <option value="NGO" <%= "NGO".equals(u.getRole()) ? "selected":"" %>>NGO</option>
            <option value="DONOR" <%= "DONOR".equals(u.getRole()) ? "selected":"" %>>Donor</option>
            <option value="ADMIN" <%= "ADMIN".equals(u.getRole()) ? "selected":"" %>>Admin</option>
          </select>
          <input type="hidden" name="action" value="changeRole"/>
          <button type="submit">Update Role</button>
        </form>

        <form method="post" action="admin/user-action" style="display:inline" onsubmit="return confirm('Delete user?');">
          <input type="hidden" name="userId" value="<%= u.getId() %>"/>
          <input type="hidden" name="action" value="delete"/>
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
