<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ResourceDAO" %>
<%@ page import="dao.CampDAO" %>
<%@ page import="model.Resource" %>
<%@ page import="model.Camp" %>
<%@ page import="java.util.List" %>

<%
  ResourceDAO rdao = new ResourceDAO();
  CampDAO cdao = new CampDAO();
  List<Resource> resources = rdao.listAll();
  List<Camp> camps = cdao.listAll();
%>
<html>
<head><title>Allocate Resource</title>
<style>
/* Allocate Resource Page Styles */
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
    border-left: 5px solid #3498db;
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
    margin: 0 5px;
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Report link specific styling */
p a[href="resource_report.jsp"] {
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
    box-shadow: 0 4px 15px rgba(155, 89, 182, 0.3);
}

p a[href="resource_report.jsp"]:hover {
    box-shadow: 0 6px 20px rgba(155, 89, 182, 0.4);
}

/* Form Styles */
form {
    background: rgba(255, 255, 255, 0.95);
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    margin: 0 auto;
    max-width: 600px;
}

form select,
form input[type="number"] {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #e1e8ed;
    border-radius: 8px;
    font-size: 16px;
    margin: 8px 0 20px 0;
    background: #f8f9fa;
    transition: all 0.3s ease;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

form select:focus,
form input[type="number"]:focus {
    outline: none;
    border-color: #3498db;
    background: white;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

form select {
    cursor: pointer;
    background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23333' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 15px center;
    background-size: 12px;
    appearance: none;
}

form br {
    display: none;
}

/* Form Labels */
form {
    position: relative;
    color: #2c3e50;
    font-weight: 600;
    font-size: 16px;
}

/* Resource dropdown specific styling */
select[name="resourceId"] {
    border-left: 4px solid #e74c3c;
    background: rgba(231, 76, 60, 0.05);
}

select[name="resourceId"]:focus {
    border-color: #e74c3c;
    box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
}

/* Camp dropdown specific styling */
select[name="campId"] {
    border-left: 4px solid #27ae60;
    background: rgba(39, 174, 96, 0.05);
}

select[name="campId"]:focus {
    border-color: #27ae60;
    box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
}

/* Quantity input specific styling */
input[name="quantity"] {
    border-left: 4px solid #3498db;
    background: rgba(52, 152, 219, 0.05);
    font-weight: 700;
    text-align: center;
    font-family: 'Courier New', monospace;
    font-size: 18px;
}

input[name="quantity"]:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

/* Button Styles */
form button {
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 18px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    width: 100%;
    margin-top: 10px;
}

form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
    background: linear-gradient(135deg, #2980b9, #1f618d);
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
    max-width: 600px;
}

p[style*="color:red"] {
    background: rgba(231, 76, 60, 0.1);
    color: #c0392b !important;
    padding: 15px 20px;
    border-radius: 8px;
    border-left: 4px solid #e74c3c;
    font-weight: 600;
    margin: 20px auto;
    text-align: center;
    max-width: 600px;
}

/* Option styling for dropdowns */
select option {
    padding: 10px;
    font-size: 14px;
}

/* Availability and capacity info in dropdowns */
select option:contains("Avail:") {
    font-weight: 600;
}

select option:contains("Cap:") {
    font-weight: 600;
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
    
    form {
        padding: 30px 20px;
    }
    
    form select,
    form input[type="number"] {
        padding: 10px 12px;
        font-size: 16px;
    }
    
    form button {
        padding: 12px 30px;
        font-size: 16px;
    }
    
    p a {
        display: block;
        margin: 5px 0;
    }
    
    input[name="quantity"] {
        font-size: 16px;
    }
}

/* Animation for form */
form {
    animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Focus states for accessibility */
form select:focus,
form input:focus {
    outline: 2px solid #3498db;
    outline-offset: 2px;
}

/* Placeholder styling */
form input::placeholder {
    color: #bdc3c7;
    font-style: italic;
}

/* Section labels with icons */
form::before {
    content: "📦 Allocate Resources to Camps";
    display: block;
    text-align: center;
    font-size: 20px;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid #ecf0f1;
}

/* Visual indicators for form sections */
form > *:nth-child(2)::before {
    content: "🔄 ";
}

form > *:nth-child(4)::before {
    content: "🏕️ ";
}

form > *:nth-child(6)::before {
    content: "📊 ";
}
</style>
</head>
<body>
<h2>Allocate Resource to Camp</h2>
<p><a href="resource_report.jsp">Report</a> | <a href="resources">Resources</a> | <a href="dashboard.jsp">Dashboard</a></p>

<form method="post" action="allocate-resource">
  Resource:
  <select name="resourceId">
    <% for (Resource r : resources) { %>
      <option value="<%= r.getId() %>"><%= r.getName() %> (Avail: <%= r.getQuantity() %> <%= r.getUnit()%>)</option>
    <% } %>
  </select><br/>
  Camp:
  <select name="campId">
    <% for (Camp c : camps) { %>
      <option value="<%= c.getId() %>"><%= c.getName() %> (Cap: <%= c.getCapacity() %>)</option>
    <% } %>
  </select><br/>
  Quantity to allocate: <input type="number" name="quantity" min="1" required/><br/>
  <button type="submit">Allocate</button>
</form>

<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } else if(request.getParameter("error")!=null) { %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
