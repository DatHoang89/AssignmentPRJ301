<%-- 
    Document   : timetable
    Created on : Mar 14, 2023, 12:40:39 PM
    Author     : LEGION
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            h1,h2,h4,footer{
                padding-left:115px;
            }
            footer{
                padding-top: 30px;
                }

            table {
                border-collapse: collapse;
                width: 80%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            td, th {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #dddddd;
            }
            .time{
                background-color:#00FFFF;
                }
        </style>
    </head>
    <body>
        <h1>
            <p>FPT University Academic Portal</p>
        </h1>
        <h2>
            <p>Activities for ${requestScope.s.stdname} </p>
        </h2>
        <h4>
            <div>
                <p>Các phòng bắt đầu bằng AL thuộc tòa nhà Alpha. VD: AL...</p>
                <p>Các phòng bắt đầu bằng BE thuộc tòa nhà Beta. VD: BE,..</p>
                <p>Các phòng bắt đầu bằng G thuộc tòa nhà Gamma. VD: G201,...</p>
                <p>Các phòng tập bằng đầu bằng R thuộc khu vực sân tập Vovinam.</p>
                <p>Các phòng bắt đầu bằng DE thuộc tòa nhà Delta. VD: DE,..</p>
                <p>Little UK (LUK) thuộc tầng 5 tòa nhà Delta</p>
            </div>
        </h4>

        <table> 
            <tr>
                <td class="time"></td>
                <c:forEach items="${requestScope.dates}" var="d">
                    <td class="time">${d}<br/><fmt:formatDate value="${d}" pattern="EEEE"/>
                    </td>
                </c:forEach>

            </tr>
            <c:forEach items="${requestScope.slots}" var="slot"> 
                <tr>
                    <td>${slot.description}</td>
                    <c:forEach items="${requestScope.dates}" var="d">
                        <td>
                            <c:forEach items="${requestScope.s.groups}" var="g">
                                <c:forEach items="${g.sessions}" var="ses">
                                    <c:if test="${ses.date eq d and ses.slot.id eq slot.id}">
                                        ${g.name}(${g.course.name}) <br/>
                                        ${ses.lecturer.name}-${ses.room.name} <br/>
                                        <c:if test="${ses.status}">
                                            <u style="color: green">(attended)</u>
                                            <!--<img src="../img/Ok-icon.png" alt=""/>-->
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>

        </table>
        <footer>
            <p>Mọi góp ý, thắc mắc xin liên hệ: Phòng dịch vụ sinh viên: Email: dichvusinhvien@fe.edu.vn. Điện thoại: (024)7308.13.13</p>
        </footer>
    </body>
</html>