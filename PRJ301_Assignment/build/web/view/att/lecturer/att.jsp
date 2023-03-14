<%-- 
    Document   : attendance
    Created on : Mar 14, 2023, 12:40:30 PM
    Author     : LEGION
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="att" method="POST"> 
            <table border="1px">
                <tr>
                    <td>Seq</td>
                    <td>Student Id</td>
                    <td>Name</td>
                    <td>Present/Absent</td>
                    <td>Description</td>
                </tr>
                <c:forEach items="${requestScope.atts}" var="a" varStatus="loop">
                    <tr>

                        <td>${loop.index +1}</td>
                        <td>${a.student.stdid}</td>
                        <td>${a.student.stdname}</td>
                        <td>
                            <input type="radio" 
                                   <c:if test="${!a.status}">
                                   checked="checked" 
                                   </c:if>
                                   name="status${a.student.stdid}" value="absent"/> Absent
                            <input type="radio" 
                                   <c:if test="${a.status}">
                                   checked="checked" 
                                   </c:if>
                                   name="status${a.student.stdid}" value="present" /> Present
                        </td>
                        <td>
                            <input type="hidden" name="sid" value="${a.student.stdid}"/>
                            <input type="hidden" name="aid${a.student.stdid}" value="${a.id}"/>
                            <input type="text" name="description${a.student.stdid}" value="${a.description}"/></td>
                    </tr>    

                </c:forEach>
            </table>
            <input type="hidden" name="sessionid" value="${param.id}"/>
            <input type="submit" value="Save"/>
        </form>
        
    </body>
</html>
