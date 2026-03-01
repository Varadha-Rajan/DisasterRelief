<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Upload Resource</title>
<style>
<style>
/* Upload Resource Page Styles */
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
    margin: 0 5px;
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
form input[type="text"],
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
form input[type="text"]:focus,
form input[type="number"]:focus,
form textarea:focus {
    outline: none;
    border-color: #27ae60;
    background: white;
    box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
}

form select {
    cursor: pointer;
}

form textarea {
    min-height: 100px;
    resize: vertical;
}

form br {
    display: none;
}

/* Form Labels */
form {
    position: relative;
}

form select:first-of-type,
form input[type="text"]:first-of-type,
form input[type="number"]:first-of-type,
form textarea:first-of-type {
    margin-top: 0;
}

/* Style form labels by targeting text nodes before inputs */
form {
    color: #2c3e50;
    font-weight: 600;
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
    margin-top: 10px;
}

form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
    background: linear-gradient(135deg, #219a52, #1e8449);
}

/* Error Message Styles */
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

/* Form field grouping and labels */
form {
    display: flex;
    flex-direction: column;
}

/* Custom styling for form elements */
form select {
    background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23333' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 15px center;
    background-size: 12px;
    appearance: none;
}

form input[type="number"] {
    font-weight: 600;
}

form input[name="unit"] {
    font-style: italic;
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
    
    form {
        padding: 30px 20px;
    }
    
    form select,
    form input[type="text"],
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
        display: block;
        margin: 5px 0;
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
    transform: translateY(-1px);
}

/* Placeholder styling */
form input::placeholder,
form textarea::placeholder {
    color: #bdc3c7;
    font-style: italic;
}

/* Unit input specific styling */
form input[name="unit"] {
    background: rgba(39, 174, 96, 0.05);
    border-color: #bdc3c7;
}

/* Description textarea specific styling */
form textarea {
    line-height: 1.5;
}
</style>
</style>
</head>
<body>
<h2>Upload Resource (NGO Only)</h2>
<p><a href="resources">View Resources</a> | <a href="dashboard.jsp">Dashboard</a></p>

<form method="post" action="upload-resource">
  Type:
  <select name="type">
    <option>Food</option>
    <option>Medicine</option>
    <option>Supplies</option>
    <option>Other</option>
  </select><br/>
  Name: <input type="text" name="name" required/><br/>
  Quantity: <input type="number" name="quantity" min="1" required/><br/>
  Unit: <input type="text" name="unit" value="pcs"/><br/>
  Description: <textarea name="description"></textarea><br/>
  <button type="submit">Upload</button>
</form>

<% if(request.getParameter("error")!=null){ %>
  <p style="color:red;"><%= request.getParameter("error") %></p>
<% } %>
</body>
</html>
