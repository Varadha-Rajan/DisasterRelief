<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Donate - DisasterRelief</title>
<style>
/* Donation Page Styles */
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
    border-left: 5px solid #27ae60;
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
}

p a:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
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
form input[type="number"],
form textarea {
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
form input[type="number"]:focus,
form textarea:focus {
    outline: none;
    border-color: #27ae60;
    background: white;
    box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
}

form select {
    cursor: pointer;
    background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23333' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 15px center;
    background-size: 12px;
    appearance: none;
}

form textarea {
    min-height: 120px;
    resize: vertical;
    line-height: 1.5;
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

/* Donation Type Specific Blocks */
#moneyBlock,
#materialBlock {
    transition: all 0.4s ease;
    overflow: hidden;
}

#moneyBlock {
    border-left: 4px solid #27ae60;
    padding-left: 15px;
    margin-left: -15px;
}

#materialBlock {
    border-left: 4px solid #e67e22;
    padding-left: 15px;
    margin-left: -15px;
}

/* Money Amount Styling */
#moneyBlock input[type="number"] {
    font-family: 'Courier New', monospace;
    font-weight: 700;
    font-size: 18px;
    text-align: center;
    background: rgba(39, 174, 96, 0.05);
}

#moneyBlock input[type="number"]:focus {
    background: white;
}

/* Material Description Styling */
#materialBlock textarea {
    background: rgba(230, 126, 34, 0.05);
    font-style: italic;
}

#materialBlock textarea:focus {
    background: white;
}

/* Button Styles */
form button {
    background: linear-gradient(135deg, #27ae60, #219a52);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    font-size: 18px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
    width: 100%;
    margin-top: 20px;
}

form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
    background: linear-gradient(135deg, #219a52, #1e8449);
}

/* Message Styles */
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

/* Payment Gateway Note */
#moneyBlock::after {
    content: "💳 In production, a real payment gateway would be integrated here";
    display: block;
    margin-top: 10px;
    font-size: 14px;
    color: #7f8c8d;
    font-style: italic;
    text-align: center;
    padding: 10px;
    background: rgba(52, 152, 219, 0.1);
    border-radius: 6px;
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
    form input[type="number"],
    form textarea {
        padding: 10px 12px;
        font-size: 16px;
    }
    
    form button {
        padding: 12px 30px;
        font-size: 16px;
    }
    
    p a {
        padding: 10px 15px;
        font-size: 14px;
    }
    
    #moneyBlock input[type="number"] {
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
form input:focus,
form textarea:focus {
    outline: 2px solid #27ae60;
    outline-offset: 2px;
}

/* Placeholder styling */
form input::placeholder,
form textarea::placeholder {
    color: #bdc3c7;
    font-style: italic;
}

/* Donation type selector emphasis */
#donationType {
    font-weight: 600;
    border-color: #3498db;
    background: rgba(52, 152, 219, 0.05);
}

/* Block transition animations */
#moneyBlock,
#materialBlock {
    animation: blockFade 0.5s ease-out;
}

@keyframes blockFade {
    from {
        opacity: 0;
        transform: translateX(-10px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}
</style>
</head>
<body>
<h2>Make a Donation</h2>
<p><a href="dashboard">Back to Dashboard</a></p>

<form method="post" action="donate" id="donationForm">
  Donation Type:
  <select name="donationType" id="donationType" onchange="toggleType()">
    <option value="MONEY">Money</option>
    <option value="MATERIAL">Material</option>
  </select><br/>

  <div id="moneyBlock">
    Amount (INR): <input type="number" step="0.01" name="amount" min="1" /><br/>
    <!-- In production integrate a real payment gateway here -->
  </div>

  <div id="materialBlock" style="display:none;">
    Material description:<br/>
    <textarea name="materialDescription" rows="4" cols="50"></textarea><br/>
  </div>

  <button type="submit">Donate</button>
</form>

<script>
  function toggleType() {
    var t = document.getElementById('donationType').value;
    document.getElementById('moneyBlock').style.display = (t === 'MONEY') ? 'block' : 'none';
    document.getElementById('materialBlock').style.display = (t === 'MATERIAL') ? 'block' : 'none';
  }
</script>

<% if(request.getParameter("error")!=null){ %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } else if(request.getParameter("msg")!=null){ %>
  <p style="color:green;"><%= request.getParameter("msg") %></p>
<% } %>
</body>
</html>
