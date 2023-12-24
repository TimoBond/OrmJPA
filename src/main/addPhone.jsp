<%--
  Created by IntelliJ IDEA.
  User: TTT
  Date: 20.07.2023
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Add Phone</h1>
<form method="post" action="${pageContext.request.contextPath}/createEmployee.jsp">
    <input type="tel" required name="phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}">
    <input type="submit" value="addPhone">

</form>
</body>
</html>
