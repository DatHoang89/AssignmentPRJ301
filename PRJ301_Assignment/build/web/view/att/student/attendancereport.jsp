<%-- 
    Document   : attendancereport
    Created on : Mar 20, 2023, 11:45:13 AM
    Author     : LEGION
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendance Report</title>
    </head>
    <body>

        <c:if test="${requestScope.attendance ne null}">

            <div class="timetable">
                <c:set var="p" value="0"/>
                <c:forEach items="${requestScope.attendance}" var="a" varStatus="loop">
                </c:forEach>
                <table border="1px">
                    <thead>
                    <td>NO</td>
                    <td>DATE</td>   
                    <td>SLOT</td>
                    <td>ROOM</td>
                    <td>LECTURER</td>
                    <td>GROUP NAME</td>
                    <td>ATTEDANCE STATUS</td>
                    <td>LECTURER'S COMMENT</td>
                    </thead>
                    <tbody>
                        <c:set var="t" value="0"/>
                        <c:forEach items="${requestScope.attendance}" var="a" varStatus="loop">
                            <tr>
                                <td>${loop.index+1}</td>
                                <td><fmt:formatDate value="${a.session.date}" pattern="EEEE dd/MMMM/yyyy" /></td>
                                <td>${a.session.slot.id}_(${a.session.slot.description})</td>
                                <td>${a.session.room.name}</td>
                                <td>${a.session.lecturer.name}</td>
                                <td>${a.session.group.name}</td>

                                <td>
                                    <c:set var="t" value="${a.status}"/>
                                    <span ${t eq  "present" ? 'style="color: red"': t eq  "attended" ? 'style="color: green"': 'style="color: black"'}> ${a.status eq null ? 'Future': a.status eq "attended" ? 'present' : a.status}</span>
                                </td>
                                <td>${a.description}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </body>
</html>

