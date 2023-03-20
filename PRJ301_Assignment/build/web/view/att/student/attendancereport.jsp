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
        <div class="title"><h1>FPT University Academic Portal</h1></div>        
<!--        <div class="formm">
            <form action="viewattendstudent" method="GET">
                <input type="hidden" name="studenId" value="${sessionScope.account.studentId}">
                <h3>Choose the course:</h3> 
                <select style="height: 30px" name="course">
                    <c:forEach items="${requestScope.course}" var="c">
                        <c:set var="course" value="${requestScope.course}"/>
                        <option value="${c.course.courseid}"  ${course == c.course.courseid ? 'selected':''}   >${c.gname}(${c.course.name})</option>
                    </c:forEach>
                </select> 
                <input class="button-66" type="submit" value="View" />
            </form>
        </div>-->

        <c:if test="${requestScope.attendance ne null}">

            <div class="timetable">
                <c:set var="p" value="0"/>
                <c:forEach items="${requestScope.attendance}" var="a" varStatus="loop">
                    <c:if test="${a.status eq 'absent'}">
                        <c:set var="p" value="${p+1}"/>
                    </c:if>
                </c:forEach>
                <c:set var="size" value="${requestScope.attendance.size()}"/>
                <fmt:formatNumber var="aa" value="${p/size*100}" pattern="##"/>
                <p class="percentage">ABSENT: ${aa}% ABSENT SO FAR ( ${p} ABSENT ON ${size} TOTAL).</p>
                <table>
                    <thead>
                    <th>NO</th>
                    <th>DATE</th>   
                    <th>SLOT</th>
                    <th>ROOM</th>
                    <th>LECTURER</th>
                    <th>GROUP NAME</th>
                    <th>ATTEDANCE STATUS</th>
                    <th>LECTURER'S COMMENT</th>
                    </thead>
                    <tbody>
                        <c:set var="t" value="0"/>
                        <c:forEach items="${requestScope.attendance}" var="a" varStatus="loop">
                            <tr>
                                <td>${loop.index+1}</td>
<!--                                <td><fmt:formatDate value="${a.session.date}" pattern="EEEE dd/MMMM/yyyy" /></td>
                                <td>${a.session.slot.tid}_(${a.session.slot.description})</td>
                                <td>${a.session.room.rname}</td>
                                <td>${a.session.lecturer.lname}</td>
                                <td>${a.session.group.gname}</td>-->

                                <td>
                                    <c:set var="t" value="${a.status}"/>
                                    <span ${t eq  "absent" ? 'style="color: red"': t eq  "attended" ? 'style="color: green"': 'style="color: black"'}> ${a.status eq null ? 'Future': a.status eq "attended" ? 'present' : a.status}</span>
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

