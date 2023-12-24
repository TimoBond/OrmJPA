<%--
  Created by IntelliJ IDEA.
  User: TTT
  Date: 17.07.2023
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<td>
    <form method="post" action="FrontController">
        <table>
            <tr>
                <th>dept</th>
                <th>name</th>
                <th>surname</th>
                <th>date</th>

            </tr>
            <c:forEach var="Staff" items="${staff}">
                <tr>
                    <td>${Staff.staffID.dept}</td>
                    <td>${Staff.name}</td>
                    <td>${Staff.surname}</td>
                    <td>${Staff.date}</td>
                    <td><input type="submit" formaction="FrontController?dept=${Staff.staffID.dept}&number=${Staff.staffID.number}&command=delete" name="deleteEmployee" value="delete">
                    </td>
                    <td><input type="submit" formaction="FrontController?dept=${Staff.staffID.dept}&number=${Staff.staffID.number}&command=details" name="detailsEmployee" value="details"></td>
                </tr>
            </c:forEach>
        </table>
        <table>
            <tr>
                <td>
                    <input type="submit" formaction="${pageContext.request.contextPath}/createEmployee.jsp" value="create new employee">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
