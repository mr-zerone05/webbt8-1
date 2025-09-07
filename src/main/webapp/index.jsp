<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Email List</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<h1>Join our email list</h1>
<form action="emailList" method="post">
    <p>First name: <input type="text" name="firstName" value="${user.firstName}"></p>
    <p>Last name: <input type="text" name="lastName" value="${user.lastName}"></p>
    <p>Email: <input type="text" name="email" value="${user.email}"></p>
    <input type="submit" value="Join">
</form>
</body>
</html>
