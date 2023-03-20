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
        <style>
            body {
                background-color: #f2f2f2;
                font-family: Arial, sans-serif;
            }

            table {
                border-collapse: collapse;
                width: 100%;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #4CAF50;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <h2>View Attendance</h2>
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
                                <td></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </body>
</html>

