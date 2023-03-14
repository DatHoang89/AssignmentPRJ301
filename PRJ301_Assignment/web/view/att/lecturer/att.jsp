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
        <link rel="stylesheet" type="text/css" href="css/att.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                
            }

            table td, table th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            table th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #4CAF50;
                color: white;
            }

            input[type="radio"] {
                margin: 0 10px 0 0;
            }

            input[type="text"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-top: 6px;
                margin-bottom: 16px;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .row{
                background-color: #00FFFF;
            }
        </style>
    </head>
    <body>
        <h2>
            <p>Single activity Attendance</p>
        </h2>
        <h4>
            <p>Attendance for ... with lecturer ... at slot 1</p>
        </h4>
        <form action="att" method="POST"> 
            <table border="1px">
                <tr class="row">
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
