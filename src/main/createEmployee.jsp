<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: TTT
  Date: 18.07.2023
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="style/stl.css">
    <title>Title</title>
</head>
<body>

<jsp:useBean id="employee" class="com.home.ormjpa.entities.Employee" scope="session"/>
<jsp:useBean id="document" class="com.home.ormjpa.entities.Document" scope="request"></jsp:useBean>
<jsp:useBean id="address" class="com.home.ormjpa.entities.Address" scope="request"></jsp:useBean>
<jsp:useBean id="staffID" class="com.home.ormjpa.entities.StaffID" scope="request"></jsp:useBean>
<jsp:useBean id="hobby" class="com.home.ormjpa.entities.Hobby" scope="request"></jsp:useBean>
<%--<jsp:setProperty name="employee" property="address" value="address"></jsp:setProperty>--%>
<c:set target="${employee}" property="address" value="${address}"></c:set>
<%--<jsp:setProperty name="employee" property="staffID" value="staffID"></jsp:setProperty>--%>
<c:set target="${employee}" property="staffID" value="${staffID}"></c:set>
<c:set target="${staffID}" property="number" value="11"></c:set>
<c:set target="${staffID}" property="dept" value="te"></c:set>
<c:if test='<%=request.getParameter("name") != null%>'>
    <c:set target="${employee}" property="name" value='<%=request.getParameter("name")%>'/>
</c:if>
<c:if test='<%=request.getParameter("surname") != null%>'>
    <c:set target="${employee}" property="surname" value='<%=request.getParameter("surname")%>'/>
</c:if>
<c:if test='<%="upPhoto".equals(request.getParameter("typePhoto"))%>'>
    <c:set target="${employee}" property="photoFile" value='<%=request.getParameter("fileName")%>'></c:set>
</c:if>
<c:if test='<%=request.getParameter("birthDate") != null%>'>
    <c:set target="${employee}" property="date"
           value='<%=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("birthDate"))%>'/>

</c:if>
<c:if test='<%=request.getParameter("city") != null%>'>
    <c:set target="${employee.address}" property="city" value='<%=request.getParameter("city")%>'/>
</c:if>
<c:if test='<%=request.getParameter("country") != null%>'>
    <c:set target="${employee.address}" property="country" value='<%=request.getParameter("country")%>'/>
</c:if>
<c:if test='<%=request.getParameter("street") != null%>'>
    <c:set target="${employee.address}" property="street" value='<%=request.getParameter("street")%>'/>
</c:if>
<c:if test='<%=request.getParameter("zipCode") != null%>'>
    <c:set target="${employee.address}" property="zipCode" value='<%=request.getParameter("zipCode")%>'/>
</c:if>
<c:if test='<%="clear".equals(request.getParameter("command"))%>'>
    <c:remove var="employee"/>
</c:if>
<form method="post" id="uploadPhoto" action="UploadController" enctype="multipart/form-data"></form>
<form method="post" id="documentForm" action="${pageContext.request.contextPath}/createEmployee.jsp"></form>
DATE: ${employee.date} !!!
<form method="post" id="mainForm" action="FrontController">
    <div class="content">
        <table>
            <tr>
                <td>
                    <input type="submit" name="save" value="save employee">
                    <input type="hidden" name="command" value="create_employee">
                </td>
                <td><input type="submit" value="all staff"
                           formaction="${pageContext.request.contextPath}/FrontController?command=getAllStaff">
                </td>
                <td>
                    <input type="submit" value="clear"
                           formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=clear">
                </td>
            </tr>
        </table>
        <div class="employeeContent">
            <table>

                <tr>
                    <th>name</th>
                    <th>surname</th>
                    <th>birth date</th>
                    <th>counrty</th>
                    <th>city</th>
                    <th>street</th>
                    <th>zip code</th>
                    <th></th>
                </tr>

                <tr>
                    <td><input type="text" form="mainForm" required name="name" value="${employee.name}"></td>
                    <td><input type="text" form="mainForm" required name="surname" value="${employee.surname}"></td>
                    <td><input type="date" form="mainForm" name="birthDate" value="${employee.date}"></td>
                    <td><input type="text" form="mainForm" required name="country" value="${address.country}"></td>
                    <td><input type="text" form="mainForm" required name="city" value="${address.city}"></td>
                    <td><input type="text" form="mainForm" required name="street" value="${address.street}"></td>
                    <td><input type="text" form="mainForm" required name="zipCode" value="${address.zipCode}"></td>
                    <%--            <td><img src="data:image/jpg;base64,<c:out value='${employee.image64}'/>"/></td>--%>
                    <td><input type="image" form="mainForm" name="photo"
                               src="<c:url  value="images/${employee.photoFile}" />"
                               width="70"
                               alt="no photo"/>
                    </td>
                    <td>
                        <%--                <form method="post" action="UploadController" enctype="multipart/form-data">--%>
                        <input type="file" form="uploadPhoto" name="multimedia" value="upload" accept="image/jpeg">
                        <input type="submit" form="uploadPhoto" name="upload_photo" value="upload photo"/>
                        <%--                </form>--%>
                    </td>
                    <td>
                        <%--                <form method="post" action="UploadController" enctype="multipart/form-data">--%>
                        <input type="file" form="uploadPhoto" name="video" value="upload"
                               accept="video/mp4,video/x-m4v">
                        <input type="submit" form="uploadPhoto" name="upload_photo" value="upload video"/>
                        <%--                </form>--%>
                    </td>

                </tr>
            </table>
        </div>

        <table class="documentContent">
            <%--      DOCUMENTS--%>
            <tr>
                <td><h1> Documents </h1></td>
                <td>title</td>
                <td>code</td>
                <td>picture</td>

                <c:if test='<%="UpDocument".equals(request.getParameter("command"))%>'>
                    <c:set target="${document}" property="title" value='<%=request.getParameter("docesTitle")%>'/>
                    <c:set target="${document}" property="number" value='<%=request.getParameter("docesNumber")%>'/>
                    <%--                        <c:set target="${document}" property="pictureName"--%>
                    <%--                               value='<%=request.getParameter("oldDoc")%>'></c:set>--%>
                    <c:set target="${employee}" property="deleteDoc"
                           value='<%=Arrays.toString(request.getParameterValues("oldDoc"))%>'></c:set>
                </c:if>
                pictureName - ${document.pictureName}


                <c:if test='<%="deleteDoc".equals(request.getParameter("command"))%>'>
                    <c:set target="${employee}" property="deleteDoc"
                           value='<%=Arrays.toString(request.getParameterValues("selected"))%>'/>
                </c:if>
            </tr>
            <c:if test='<%="addDoc".equals(request.getParameter("command"))%>'>
                <c:set target="${document}" property="title" value='<%=request.getParameter("docTitle")%>'/>
                <c:if test='<%=request.getParameter("docNumber") != null%>'>
                    <c:set target="${document}" property="number"
                           value='<%=Integer.parseInt(request.getParameter("docNumber"))%>'/>
                </c:if>
            </c:if>
            <c:set target="${employee}" property="document" value="${document}"/>

            <c:forEach var="document1" items="${employee.documents}" varStatus="status">
                <tr>
                        <%--                <form method="post" action="${pageContext.request.contextPath}/createEmployee.jsp">--%>
                    <td><input type="hidden" form="documentForm" name="command" value="UpDocument"></td>
                    <td><input type="hidden" form="documentForm" name="oldDoc" value="${document1.number}"></td>
                    <td><input form="documentForm" required type="text" name="docesTitle"
                               value="${document1.title}">
                    </td>
                    <td><input form="documentForm" required type="text" name="docesNumber"
                               value="${document1.number}">
                    </td>
                    <td><input type="submit" form="documentForm" name="UpDocument" value="update document"></td>
                        <%--                </form>--%>
                    <td><input type="image" form="mainForm" name="photo"
                               src="<c:url  value="images/${document1.number}.jpg" />" width="70"
                               alt="no photo">
                    </td>

                    <td><input type="checkbox" form="mainForm" value="${document1.number}" name="selected"></td>
                    <td>
                            <%--                    <form method="post" action="UploadController" enctype="multipart/form-data">--%>
                        <input type="file" form="uploadPhoto" name="multimedia" value="upload" accept="image/jpeg">
                        <input type="submit" form="uploadPhoto"
                               formaction="UploadController?docNumberPh=${document1.number}" name="upload_photo"
                               value="upload document photo"/>
                            <%--                    </form>--%>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td><input type="text" form="mainForm" name="docTitle" value=""></td>
                <td><input type="text" form="mainForm" name="docNumber" value=""></td>
                <%--            <td><a href="<c:url value="addDocument.jsp"></c:url>">add</a></td>--%>
                <td><input type="submit" form="mainForm"
                           formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=addDoc"
                           value="addDocument"></td>
                <td><input type="submit" form="mainForm"
                           formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=deleteDoc"
                           value="deelteDoc"></td>
            </tr>
        </table>

        <table>
            <div class="phoneContent">
                <%--      DOCUMENTS--%>
                <tr>
                    <td>phone</td>
                </tr>

                <%--        <c:if test="'<%= request.getParameter("phone")%>' != null">--%>
                <jsp:setProperty name="employee" property="phone"
                                 value='<%= request.getParameter("phone")%>'></jsp:setProperty>
                <%--        </c:if>--%>
                <ul>
                    <c:forTokens items="${employee.phones}" delims=",[] " var="phone">
                        <tr>
                            <td>
                                <li>${phone}</li>

                            </td>
                            <td><a form="documentForm" href="<c:url value="deletePhone.jsp?phone=${phone}" ></c:url> ">
                                deletePhone</a></td>
                            <td><a form="documentForm" href="<c:url value="updatePhone.jsp?phone=${phone}"></c:url> ">
                                updatePhone</a></td>
                        </tr>
                    </c:forTokens>
                </ul>

                <td><a href="<c:url value="addPhone.jsp"></c:url>">addPhone</a></td>
            </div>
            <div class="hobbyContent">

                <c:if test='<%="addHobby".equals(request.getParameter("command"))%>'>
                    <c:set target="${hobby}" property="title" value='<%=request.getParameter("hobbyTitle")%>'/>
                    <c:set target="${hobby}" property="experience"
                           value='<%=Integer.parseInt(request.getParameter("hobbyExp"))%>'/>
                    <c:set target="${employee}" property="hobby"
                           value="${hobby}"/>
                </c:if>


                <c:if test='<%="deleteHobby".equals(request.getParameter("command"))%>'>
                    <c:set target="${employee}" property="deleteHobbies"
                           value='<%=Arrays.toString(request.getParameterValues("selectedKeyH"))%>'></c:set>
                </c:if>

                Hobbyname ${hobby.title}
                hobbyEXP ${hobby.experience}
                <tr>
                    <td><h1>Адреса</h1></td>
                    <td>title</td>
                    <td>exp</td>
                </tr>

                <c:forEach var="hobby1" items="${employee.hobbies}" varStatus="statusH">
                    <tr>
                        <td><input type="text" form="mainForm" name="hobbyKey" value="${hobby1.key}"></td>
                        <td><input type="text" form="mainForm" name="hobbyVTitle" value="${hobby1.value.title}"></td>
                        <td><input type="text" form="mainForm" name="hobbyVExp" value="${hobby1.value.experience}"></td>
                        <td><input type="checkbox" form="mainForm" value="${hobby1.key}" name="selectedKeyH"></td>
                        <td><input type="submit" form="mainForm"
                                   formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=upHobby">
                        </td>
                    </tr>
                </c:forEach>

                <tr>
                    <td><input type="text" form="mainForm" name="hobbyTitle" value=""></td>
                    <td><input type="text" form="mainForm" name="hobbyExp" value=""></td>
                    <td></td>
                    <td><input type="submit" form="mainForm"
                               formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=addHobby"
                               value="addHobby"></td>
                    <td><input type="submit" form="mainForm"
                               formaction="${pageContext.request.contextPath}/createEmployee.jsp?command=deleteHobby"
                               value="deleteHobby"></td>
                    <%--            <td><a href="<c:url value="addHobby.jsp"></c:url>">addHobbies</a></td>--%>
                </tr>
            </div>
        </table>

    </div>

</form>

</body>
</html>
