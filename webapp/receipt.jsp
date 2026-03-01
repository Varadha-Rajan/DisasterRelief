<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Donation" %>
<%
  Donation d = (Donation) request.getAttribute("donation");
  if (d == null) { response.sendRedirect("donation_history.jsp?error=Receipt+not+found"); return; }
%>
<html>
<head><title>Receipt - DisasterRelief</title>
<style>
/* Donation Receipt Page Styles */
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
    display: flex;
    align-items: center;
    justify-content: center;
}

h2 {
    background: linear-gradient(135deg, #27ae60, #219a52);
    color: white;
    padding: 25px 30px;
    border-radius: 15px 15px 0 0;
    margin-bottom: 0;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    font-size: 32px;
    text-align: center;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
}

/* Receipt Container */
body > * {
    max-width: 600px;
    width: 100%;
    background: white;
    border-radius: 15px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    overflow: hidden;
}

/* Receipt Content */
body > h2,
body > p,
body > hr,
body > button {
    margin-left: 0;
    margin-right: 0;
}

p {
    padding: 20px 30px;
    margin: 0;
    border-bottom: 1px solid #ecf0f1;
    font-size: 16px;
    line-height: 1.6;
}

p strong {
    color: #2c3e50;
    font-weight: 600;
    display: inline-block;
    min-width: 120px;
}

/* Amount Highlight */
p:contains("Amount:") {
    background: rgba(39, 174, 96, 0.1);
    font-size: 18px;
    font-weight: 700;
    color: #27ae60;
}

p:contains("Amount:") strong {
    color: #27ae60;
    font-size: 18px;
}

/* Receipt Number Highlight */
p:contains("Receipt No:") {
    background: rgba(52, 152, 219, 0.1);
    font-weight: 600;
}

p:contains("Receipt No:") strong {
    color: #2980b9;
}

hr {
    border: none;
    height: 3px;
    background: linear-gradient(90deg, #27ae60, #3498db, #9b59b6);
    margin: 0;
}

/* Thank you message */
p:contains("Thank you") {
    background: rgba(241, 196, 15, 0.1);
    font-style: italic;
    text-align: center;
    font-size: 17px;
    color: #2c3e50;
    border-bottom: none;
}

button {
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 16px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    margin: 20px auto;
    display: block;
    border: 2px solid white;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
    background: linear-gradient(135deg, #2980b9, #1f618d);
}

p a {
    display: block;
    background: linear-gradient(135deg, #95a5a6, #7f8c8d);
    color: white;
    text-decoration: none;
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
    text-align: center;
    margin: 20px 30px;
    border: 2px solid white;
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(149, 165, 166, 0.4);
    background: linear-gradient(135deg, #7f8c8d, #6c7a89);
}

/* Print Styles */
@media print {
    body {
        background: white !important;
        padding: 0 !important;
    }
    
    body > * {
        box-shadow: none !important;
        border: 2px solid #333 !important;
    }
    
    button, p a {
        display: none !important;
    }
    
    h2 {
        background: #27ae60 !important;
        -webkit-print-color-adjust: exact;
        color-adjust: exact;
    }
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
        padding: 15px 20px;
        font-size: 15px;
    }
    
    p strong {
        min-width: 100px;
        display: block;
        margin-bottom: 5px;
    }
    
    button {
        padding: 12px 30px;
        font-size: 15px;
        margin: 15px 20px;
    }
    
    p a {
        margin: 15px 20px;
        padding: 10px 20px;
    }
}

/* Animation for receipt */
body > * {
    animation: receiptAppear 0.6s ease-out;
}

@keyframes receiptAppear {
    from {
        opacity: 0;
        transform: scale(0.9) translateY(20px);
    }
    to {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

/* Currency symbol styling */
p:contains("₹") {
    font-family: 'Courier New', monospace;
    font-weight: 700;
}

/* Date styling */
p:contains("Date:") {
    font-family: 'Courier New', monospace;
    color: #7f8c8d;
}

/* Security features for receipt */
p:contains("Receipt No:")::after {
    content: " ✓";
    color: #27ae60;
    font-weight: bold;
}

/* Watermark effect */
body::before {
    content: "OFFICIAL RECEIPT";
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) rotate(-45deg);
    font-size: 80px;
    color: rgba(39, 174, 96, 0.03);
    font-weight: bold;
    z-index: -1;
    pointer-events: none;
}
</style>

</head>
<body>
<h2>Donation Receipt</h2>
<p><strong>Receipt No:</strong> <%= d.getReceiptNumber() %></p>
<p><strong>Donor ID:</strong> <%= d.getDonorId() %></p>
<p><strong>Amount:</strong> ₹ <%= d.getAmount() %></p>
<p><strong>Date:</strong> <%= d.getCreatedAt() %></p>

<hr/>
<p>Thank you for your generous donation. This receipt is for your records.</p>
<button onclick="window.print()">Print / Save</button>
<p><a href="dashboard">Back to Dashboard</a></p>
</body>
</html>
