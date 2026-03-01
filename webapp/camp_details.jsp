<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Camp" %>
<html>
<head><title>Camp Details</title>
<style>
<style>
/* Camp Details Page Styles */
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
    padding: 25px 30px;
    border-radius: 15px;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    color: #2c3e50;
    font-size: 32px;
    border-left: 5px solid #e74c3c;
    text-align: center;
}

p {
    background: rgba(255, 255, 255, 0.95);
    padding: 15px 25px;
    border-radius: 10px;
    margin-bottom: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    font-size: 16px;
    line-height: 1.6;
}

p strong {
    color: #2c3e50;
    font-weight: 600;
    display: inline-block;
    min-width: 150px;
}

hr {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
    margin: 30px 0;
}

/* Form Styles */
form {
    background: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    margin-bottom: 25px;
    text-align: center;
}

form input[type="number"] {
    padding: 12px 15px;
    border: 2px solid #e1e8ed;
    border-radius: 8px;
    font-size: 16px;
    margin: 0 15px;
    width: 120px;
    background: #f8f9fa;
    font-weight: 600;
    text-align: center;
}

form input[type="number"]:focus {
    outline: none;
    border-color: #3498db;
    background: white;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

form button {
    background: linear-gradient(135deg, #27ae60, #219a52);
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 16px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
}

form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
    background: linear-gradient(135deg, #219a52, #1e8449);
}

/* Link Styles */
p a {
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    text-decoration: none;
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-block;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    margin: 10px 5px;
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* Login prompt link */
p:has(a[href="login.jsp"]) {
    text-align: center;
    background: rgba(255, 255, 255, 0.95);
    padding: 25px;
}

p:has(a[href="login.jsp"]) a {
    background: linear-gradient(135deg, #f39c12, #e67e22);
    box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
}

p:has(a[href="login.jsp"]) a:hover {
    box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
}

/* Back to camps link */
p:has(a[href="camps"]):not(:has(a[href="login.jsp"])) {
    text-align: center;
    background: rgba(255, 255, 255, 0.95);
}

/* Message Styles */
p[style*="color:red"] {
    background: rgba(231, 76, 60, 0.1);
    color: #c0392b !important;
    padding: 15px 25px;
    border-radius: 8px;
    border-left: 4px solid #e74c3c;
    font-weight: 600;
    margin: 20px 0;
    text-align: center;
}

p[style*="color:green"] {
    background: rgba(39, 174, 96, 0.1);
    color: #27ae60 !important;
    padding: 15px 25px;
    border-radius: 8px;
    border-left: 4px solid #27ae60;
    font-weight: 600;
    margin: 20px 0;
    text-align: center;
}

/* Capacity indicators */
p:contains("Available") {
    border-left: 4px solid #27ae60;
    font-weight: 600;
}

p:contains("Available") strong {
    color: #27ae60;
}

p:contains("Currently Booked") {
    border-left: 4px solid #f39c12;
}

p:contains("Capacity") {
    border-left: 4px solid #3498db;
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
    }
    
    h2 {
        font-size: 24px;
        padding: 20px;
    }
    
    p {
        padding: 12px 20px;
        font-size: 15px;
    }
    
    p strong {
        min-width: 120px;
        display: block;
        margin-bottom: 5px;
    }
    
    form {
        padding: 20px;
    }
    
    form input[type="number"] {
        width: 100px;
        margin: 10px 0;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    
    form button {
        padding: 12px 25px;
        font-size: 15px;
    }
    
    p a {
        padding: 10px 20px;
        font-size: 14px;
        display: block;
        margin: 10px 0;
    }
}

/* Animation for form */
form {
    animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</style>
</head>
<body>
<%
  Camp camp = (Camp) request.getAttribute("camp");
  Integer booked = (Integer) request.getAttribute("booked");
  if (camp == null) { response.sendRedirect("camps"); return; }
%>

<h2><%= camp.getName() %></h2>
<p><strong>Address:</strong> <%= camp.getAddress() %>, <%= camp.getCity() %>, <%= camp.getState() %></p>
<p><strong>Contact:</strong> <%= camp.getContact() %></p>
<p><strong>Facilities:</strong> <%= camp.getFacilities() %></p>
<p><strong>Capacity:</strong> <%= camp.getCapacity() %></p>
<p><strong>Currently Booked:</strong> <%= booked %></p>
<p><strong>Available:</strong> <%= (camp.getCapacity() - booked) %></p>

<hr/>
<% if(session.getAttribute("userId") == null) { %>
  <p><a href="login.jsp">Login to book</a></p>
<% } else { %>
  <form method="post" action="book-camp">
    <input type="hidden" name="campId" value="<%= camp.getId() %>"/>
    Slots to book: <input type="number" name="slots" min="1" max="<%= (camp.getCapacity()-booked) %>" required />
    <button type="submit">Book</button>
  </form>
<% } %>

<p><a href="camps">Back to Camps</a></p>

<% if(request.getParameter("error")!=null){ %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
<% if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
</body>
</html>
