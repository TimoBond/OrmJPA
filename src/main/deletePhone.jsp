<%@ page import="com.home.ormjpa.entities.Employee" %><%--
  Created by IntelliJ IDEA.
  User: TTT
  Date: 23.07.2023
  Time: 08:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
 <form method="post" action="${pageContext.request.contextPath}/employeeDetails.jsp">
     <%= ((Employee) request.getSession().getAttribute("employee")).getPhones().remove(request.getParameter("phone"))%>
     <a>Ты точно хочешь удалить телоефов</a>
     <input type="submit" value="delete" name="yes">
 </form>
</body>
</html>
