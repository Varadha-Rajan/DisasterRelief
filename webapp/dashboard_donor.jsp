<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verify session and role
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userId == null || !"DONOR".equals(userRole)) {
        response.sendRedirect("login.jsp?error=Please+login+as+Donor");
        return;
    }
%>
<html>
<head>
    <title>Donor Dashboard - DisasterRelief</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #dff1ff, #f0fff0);
            margin: 30px;
        }
        h2 {
            color: #2c3e50;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin-bottom: 8px;
        }
        a {
            text-decoration: none;
            color: #0056b3;
            font-weight: bold;
        }
        a:hover {
            color: #0088ff;
        }
        .container {
            border: 1px solid #ccc;
            background: white;
            border-radius: 10px;
            padding: 20px;
            width: 70%;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .info-box {
            background: #e8f6ff;
            border-left: 5px solid #0099cc;
            padding: 15px;
            margin: 15px 0;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Welcome, <%= userName %> (Donor)</h2>

    <div class="info-box">
        <p>Thank you for contributing to disaster relief efforts.  
           You can donate money or materials, view your donation history,  
           and print official receipts for your records.</p>
    </div>

    <h3>Dashboard Menu</h3>
    <ul>
        <li><a href="donate.jsp">💰 Donate Now</a></li>
        <li><a href="donation-history">📜 View Donation History</a></li>
        <li><a href="resources">📦 View Resources</a></li>
        <li><a href="logout">🚪 Logout</a></li>
    </ul>

    <hr/>

    <h3>Quick Summary</h3>
    <%
        dao.DonationDAO donationDAO = new dao.DonationDAO();
        java.util.List<model.Donation> myDonations = new java.util.ArrayList<>();
        try {
            myDonations = donationDAO.listByDonor(userId);
        } catch (Exception e) { }
        int totalDonations = myDonations.size();
        double totalMoney = 0;
        for (model.Donation d : myDonations) {
            if ("MONEY".equals(d.getDonationType()) && d.getAmount() != null) {
                totalMoney += d.getAmount();
            }
        }
    %>
    <p><strong>Total Donations:</strong> <%= totalDonations %></p>
    <p><strong>Total Money Donated:</strong> ₹<%= String.format("%.2f", totalMoney) %></p>

    <%
        if (totalDonations > 0) {
    %>
        <h4>Recent Donations:</h4>
        <table border="1" cellpadding="6" cellspacing="0">
            <tr style="background:#f2f2f2;"><th>Date</th><th>Type</th><th>Amount / Material</th><th>Status</th><th>Receipt</th></tr>
            <%
                int count = 0;
                for (model.Donation d : myDonations) {
                    if (count++ == 3) break; // show only latest 3
            %>
                <tr>
                    <td><%= d.getCreatedAt() %></td>
                    <td><%= d.getDonationType() %></td>
                    <td>
                        <% if ("MONEY".equals(d.getDonationType())) { %>
                            ₹ <%= d.getAmount() %>
                        <% } else { %>
                            <%= d.getMaterialDescription() %>
                        <% } %>
                    </td>
                    <td><%= d.getStatus() %></td>
                    <td>
                        <% if ("COMPLETED".equals(d.getStatus())) { %>
                            <a href="receipt?id=<%= d.getId() %>">🧾 View</a>
                        <% } else { %> - <% } %>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>You haven’t made any donations yet. <a href="donate.jsp">Start now!</a></p>
    <% } %>

</div>

</body>
</html>
