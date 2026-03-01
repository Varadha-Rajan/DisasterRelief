<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  String userName = (String) session.getAttribute("userName");
  String userRole = (String) session.getAttribute("userRole");
  if (userId == null || !"ADMIN".equals(userRole)) { response.sendRedirect("login.jsp?error=Please+login+as+Admin"); return; }
%>
<html>
<head><title>Admin Dashboard - DisasterRelief</title>
<style>
/* Admin Dashboard Styles */
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
    border-left: 5px solid #e74c3c;
}

ul {
    list-style: none;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
    transition: all 0.3s ease;
    border-radius: 12px;
    border: 2px solid transparent;
}

li a:hover {
    color: #e74c3c;
    background: rgba(231, 76, 60, 0.1);
    border-color: #e74c3c;
}

hr {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
    margin: 30px 0;
}

p {
    background: rgba(255, 255, 255, 0.95);
    padding: 25px 30px;
    border-radius: 15px;
    margin-bottom: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    font-size: 17px;
    text-align: center;
    color: #2c3e50;
    line-height: 1.6;
    border-left: 4px solid #e74c3c;
}

/* Admin-specific menu item highlighting */
li a[href*="admin/"] {
    background: rgba(231, 76, 60, 0.05);
    border: 2px dashed #e74c3c;
    position: relative;
}

li a[href*="admin/"]:hover {
    background: rgba(231, 76, 60, 0.15);
}

/* Admin badge for admin-only features */
li a[href*="admin/"]::before {
    content: "⚙️";
    position: absolute;
    top: 8px;
    right: 8px;
    font-size: 14px;
    opacity: 0.7;
}

/* Special styling for critical admin functions */
li a[href="admin/users"] {
    background: rgba(231, 76, 60, 0.08);
    border: 2px solid #e74c3c;
}

li a[href="admin/users"]::before {
    content: "👥";
}

li a[href="admin/camps"]::before {
    content: "🏕️";
}

li a[href="admin/reports"]::before {
    content: "📊";
}

/* Report links styling */
li a[href="resource_report.jsp"],
li a[href="admin/reports"] {
    background: rgba(155, 89, 182, 0.05);
    border: 2px dashed #9b59b6;
}

li a[href="resource_report.jsp"]:hover,
li a[href="admin/reports"]:hover {
    background: rgba(155, 89, 182, 0.15);
}

li a[href="resource_report.jsp"]::before,
li a[href="admin/reports"]::before {
    content: "📈";
}

/* Donations link styling */
li a[href="donation-history"] {
    background: rgba(39, 174, 96, 0.05);
    border: 2px dashed #27ae60;
}

li a[href="donation-history"]:hover {
    background: rgba(39, 174, 96, 0.15);
}

li a[href="donation-history"]::before {
    content: "💰";
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
    
    li a {
        padding: 20px 15px;
        font-size: 15px;
    }
    
    p {
        padding: 20px;
        font-size: 16px;
    }
    
    li a[href*="admin/"]::before {
        top: 5px;
        right: 5px;
        font-size: 12px;
    }
}

/* Animation for menu items */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

li {
    animation: fadeInUp 0.5s ease-out;
}

/* Stagger animation for list items */
li:nth-child(1) { animation-delay: 0.1s; }
li:nth-child(2) { animation-delay: 0.2s; }
li:nth-child(3) { animation-delay: 0.3s; }
li:nth-child(4) { animation-delay: 0.4s; }
li:nth-child(5) { animation-delay: 0.5s; }
li:nth-child(6) { animation-delay: 0.6s; }
li:nth-child(7) { animation-delay: 0.7s; }
li:nth-child(8) { animation-delay: 0.8s; }

/* Welcome message styling */
p:contains("Use the links above") {
    background: rgba(255, 255, 255, 0.95);
    font-weight: 500;
    text-align: center;
    border-left: 4px solid #3498db;
}

/* Security emphasis for admin features */
li a[href*="admin/"] {
    font-weight: 700;
}

/* Hover effects for different categories */
li a[href*="admin/"]:hover {
    transform: translateY(-3px) scale(1.02);
}

/* Special emphasis on user management */
li a[href="admin/users"] {
    background: linear-gradient(135deg, rgba(255,255,255,0.95), rgba(231, 76, 60, 0.1));
}

/* Footer-like styling for the instruction paragraph */
p:contains("Use the links above")::before {
    content: "💡 ";
    font-size: 18px;
}

p:contains("Use the links above")::after {
    content: " 🚀";
    font-size: 18px;
}
</style>
</head>
<body>
<h2>Welcome, <%= userName %> (ADMIN)</h2>

<ul>
  <li><a href="admin/users">Manage Users</a></li>
  <li><a href="admin/camps">Manage Camps</a></li>
  <li><a href="resources">Resources</a></li>
  <li><a href="resource_report.jsp">Resource Report</a></li>
  <li><a href="admin/reports">Occupancy & Supplies Report</a></li>
  <li><a href="bookings.jsp">Bookings</a></li>
  <li><a href="donation-history">Donations</a></li>
  <li><a href="logout">Logout</a></li>
</ul>

<hr/>
<p>Use the links above to manage users, camps, and generate reports for your partners.</p>

</body>
</html>
