<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanks</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h1>Thanks for joining our list</h1>

<p>Here is the information that you entered:</p>
<ul>
    <li>First name: ${sessionScope.user.firstName}</li>
    <li>Last name: ${sessionScope.user.lastName}</li>
    <li>Email: ${sessionScope.user.email}</li>
</ul>

<hr>
<p>Current date: ${requestScope.currentDate}</p>

<p>First user: ${sessionScope.users[0].firstName} ${sessionScope.users[0].lastName}</p>
<p>Second user: ${sessionScope.users[1].firstName} ${sessionScope.users[1].lastName}</p>

<p>Customer service: ${initParam.custServEmail}</p>

<form action="index.jsp" method="post">
    <input type="submit" value="Return">
</form>
</body>
</html>

