<%-- 
    Document   : ViewFeatureTeacher
    Created on : Mar 16, 2023, 2:02:43 PM
    Author     : LEGION
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        table, th, td {
            border:1px solid black;
        }
        .a {
            padding-left: 40px;
        }
        h2 {
            font-size: 24px;
            color: blue;
        }

        th {
            background-color: gray;
            color: white;
        }

        td.a {
            text-align: center;
        }
    </style>
    <body>

        <h2>Welcome To FAP FPT UNIVERSITY </h2>
        <h4>Activity by: ${requestScope.lecture.getName()}</h4>
        <table style="width:100%">
            <tr>
                <th class="A">Academic Information</th>               
            </tr>
            <tr>
             <td class="a"><a href="/PRJ301_Assignment/lecturer/timetable?lid=${requestScope.lecture.getId()}&from=2023-03-13&to=2023-03-19">Lecturer TimeTable</a></td>
            </tr>
        </table>

        <p>Mọi góp ý, thắc mắc xin liên hệ: Phòng dịch vụ sinh viên: Email: dichvusinhvien@fe.edu.vn. Điện thoại: (024)7308.13.13</p>
        </br>
        <a href="logout">Logout</a>
    </body>
</html>