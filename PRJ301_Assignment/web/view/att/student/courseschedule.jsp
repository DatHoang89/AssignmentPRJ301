<%-- 
    Document   : courseschedule
    Created on : Mar 20, 2023, 6:31:29 PM
    Author     : LEGION
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 class="a">View Attendance Report</h1>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Subject Name</th>
                    <th scope="col">Choose subject to view</th>
                </tr>
            </thead>
            <tbody>
                    <tr>
                        <th scope="row">PRJ301</th>
                        <th ><a href="/PRJ301_Assignment/viewattendancestudent?sid=1&cid=1">View attendance</a></th>
                    </tr>
                    <tr>
                        <th scope="row">MAS291</th>
                        <th ><a href="/PRJ301_Assignment/viewattendancestudent?sid=1&cid=1">View attendance</a></th>
                    </tr>
            </tbody>
        </table>
        </br>
        <a href="logout">Logout</a>
    </body>
</html>
