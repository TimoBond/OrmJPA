<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Arrays" %>

<jsp:include page="header.jsp"/>
<jsp:include page="left.jsp"/>
<div class="content">
    <jsp:useBean id="document" class="com.home.ormjpa.entities.Document" scope="session"></jsp:useBean>
    <c:if test='<%=request.getParameter("name") != null%>'>
        <c:set target="${employee}" property="name" value='<%=request.getParameter("name")%>'></c:set>
    </c:if>
    <c:if test='<%=request.getParameter("surname") != null%>'>
        <c:set target="${employee}" property="surname" value='<%=request.getParameter("surname")%>'></c:set>
    </c:if>
    <c:if test='<%=request.getParameter("country") != null%>'>
        <c:set target="${employee.address}" property="country" value='<%=request.getParameter("country")%>'></c:set>
    </c:if>
    <c:if test='<%=request.getParameter("city") != null%>'>
        <c:set target="${employee.address}" property="city" value='<%=request.getParameter("city")%>'></c:set>
    </c:if>
    <c:if test='<%=request.getParameter("street") != null%>'>
        <c:set target="${employee.address}" property="street" value='<%=request.getParameter("street")%>'></c:set>
    </c:if>
    <c:if test='<%=request.getParameter("zipCode") != null%>'>
        <c:set target="${employee.address}" property="zipCode" value='<%=request.getParameter("zipCode")%>'></c:set>
    </c:if>

    <form method="post" action="UploadController" enctype="multipart/form-data" id="uploadPhoto"/>
    <form method="post" id="documentForm" action="${pageContext.request.contextPath}/createEmployee.jsp"></form>
    <form method="post" action="FrontController" id>
        <table class="table">
            <tr>
                <td>id</td>
                <td><input type="text" disabled value="${employee.staffID.number}"></td>
            </tr>
            <tr>
                <td>dept</td>
                <td><input type="text" disabled value="${employee.staffID.dept}"></td>
            </tr>
            <tr>
                <td>name</td>
                <td><input type="text" required name="name" value="${employee.name}"></td>
            </tr>
            <tr>
                <td>surname</td>
                <td><input type="text" required name="surname" value="${employee.surname}"></td>
            </tr>
            <tr>
                <td>country</td>
                <td><input type="text" required name="country" value="${employee.address.country}"></td>
            </tr>
            <tr>
                <td>city</td>
                <td><input type="text" required name="city" value="${employee.address.city}"></td>
            </tr>
            <tr>
                <td>street</td>
                <td><input type="text" required name="street" value="${employee.address.street}"></td>
            </tr>
            <tr>
                <td>zipCode</td>
                <td><input type="text" required name="zipCode" value="${employee.address.zipCode}"></td>
            </tr>
            <tr>
                <%--                <td>   <td><img width="90" alt="no photo" src="data:image/jpg;base64,<c:out value='${employee.image64}'/>"/></td>--%>
                <td>
                    <input type="image" name="photo"
                           width="70"
                           alt="no photo"
                           src="<c:url value="/images/${employee.photoFile}"/>">
                </td>

                <td>
                    <input type="file" form="uploadPhoto" name="multimedia" value="upload" accept="image/jpeg">
                    <input type="hidden" form="uploadPhoto" name="photoFile" value="${employee.photoFile}">
                    <input type="submit" form="uploadPhoto" name="upload_photo" value="upload photo"/>
                </td>
                <td>
                    <input type="file" form="uploadPhoto" name="video" value="upload"
                           accept="video/mp4,video/x-m4v">
                    <input type="submit" form="uploadPhoto" name="upload_photo" value="upload video"/>
                </td>
            </tr>
        </table>
        <c:if test='<%="addDoc".equals(request.getParameter("command"))%>'>
            <c:set target="${document}" property="title" value='<%=request.getParameter("docTitle")%>'/>
            <c:if test='<%=request.getParameter("docNumber") != null%>'>
                <c:set target="${document}" property="number"
                       value='<%=Integer.parseInt(request.getParameter("docNumber"))%>'/>
                <c:set target="${employee}" property="document" value="${document}"></c:set>
            </c:if>

        </c:if>
        <table class="documentContent">
            <thead>Document content</thead>

            <tr>
                <td><h1> Documents </h1></td>
                <td>title</td>
                <td>code</td>
                <td>picture</td>
            </tr>
            <c:forEach var="document1" items="${employee.documents}" varStatus="status">
                <tr>
                    <td><input form="documentForm" required type="text" name="docesTitle"
                               value="${document1.title}">
                    </td>
                    <td><input form="documentForm" required type="text" name="docesNumber"
                               value="${document1.number}">
                    </td>
                    <td><input type="submit" form="documentForm" name="UpDocument" value="update document"></td>
                    <td><input type="image" name="photo"
                               src="<c:url  value="images/${document1.number}.jpg" />" width="70"
                               alt="no photo">
                    </td>
                    <td><input type="checkbox" value="${document1.number}" name="selected"></td>
                    <td>

                        <input type="file" form="uploadPhoto" name="multimedia" value="upload" accept="image/jpeg">
                        <input type="submit" form="uploadPhoto"
                               formaction="UploadController?docNumberPh=${document1.number}" name="upload_photo"
                               value="upload document photo"/>
                    </td>
                </tr>
            </c:forEach>
            tr>
            <td><input type="text" name="docTitle" value=""></td>
            <td><input type="text" name="docNumber" value=""></td>
            <%--            <td><a href="<c:url value="addDocument.jsp"></c:url>">add</a></td>--%>
            <td><input type="submit"
                       formaction="${pageContext.request.contextPath}/employeeDetails.jsp?command=addDoc"
                       value="addDocument"></td>
        </table>

        <table>
            <div class="phoneContent">
                <%--      DOCUMENTS--%>
                <tr>
                    <td>phone</td>
                </tr>

                <jsp:setProperty name="employee" property="phone"
                                 value='<%= request.getParameter("phone")%>'></jsp:setProperty>
                <ul>
                    <c:forTokens items="${employee.phones}" delims=",[]null{} " var="phone">
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


                <%--                <c:if test='<%="deleteHobby".equals(request.getParameter("command"))%>'>--%>
                <%--                    <c:set target="${employee}" property="deleteHobbies"--%>
                <%--                           value='<%=Arrays.toString(request.getParameterValues("selectedKeyH"))%>'></c:set>--%>
                <%--                </c:if>--%>

                <%--                Hobbyname ${hobby.title}--%>
                <%--                hobbyEXP ${hobby.experience}--%>
                <tr>
                    <td><h1>Hobby</h1></td>
                    <td>title</td>
                    <td>exp</td>
                </tr>

                <c:forEach var="hobby1" items="${employee.hobbies}" varStatus="statusH">
                    <tr>
                        <td><input type="text" name="hobbyKey" value="${hobby1.key}"></td>
                        <td><input type="text" name="hobbyVTitle" value="${hobby1.value.title}"></td>
                        <td><input type="text" name="hobbyVExp" value="${hobby1.value.experience}"></td>
                        <td><input type="checkbox" value="${hobby1.key}" name="selectedKeyH"></td>
                        <td><input type="submit"
                                   formaction="${pageContext.request.contextPath}/employeeDetails.jsp?command=upHobby">
                        </td>
                    </tr>
                </c:forEach>

                <tr>
                    <td><input type="text" name="hobbyTitle" value=""></td>
                    <td><input type="text" name="hobbyExp" value=""></td>
                    <td></td>
                    <td><input type="submit"
                               formaction="${pageContext.request.contextPath}/employeeDetails.jsp?command=addHobby"
                               value="addHobby"></td>
                    <td><input type="submit"
                               formaction="${pageContext.request.contextPath}/employeeDetails.jsp?command=deleteHobby"
                               value="deleteHobby"></td>

                </tr>
            </div>
        </table>
        <table align="center">

            <tr>
                <td>
                    <input type="submit" name="save" value="save employee"
                           formaction="${pageContext.request.contextPath}/FrontController?command=updateEmployee">
                </td>
                <td><input type="submit" value="all staff"
                           formaction="${pageContext.request.contextPath}/FrontController?command=getAllStaff">
                </td>
            </tr>
        </table>
        <table>

        </table>
    </form>
</div>
<jsp:include page="right.jsp"/>
<jsp:include page="footer.jsp"/>