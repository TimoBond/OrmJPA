<%@ page import="com.home.ormjpa.entities.Employee" %><%--
  Created by IntelliJ IDEA.
  User: TTT
  Date: 23.07.2023
  Time: 09:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath}/createEmployee.jsp">
    <input type="tel" required name="phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" value="<%=request.getParameter("phone")%>" >
    <%=((Employee)request.getSession().getAttribute("employee")).getPhones().remove(request.getParameter("phone"))%>
    <input type="submit" value="up" name="update">
</form>
</body>
</html>
