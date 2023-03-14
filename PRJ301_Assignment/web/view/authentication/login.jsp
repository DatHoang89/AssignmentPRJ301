<%-- 
    Document   : login
    Created on : Feb 27, 2023, 10:38:07 AM
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
        <form action="login" method="POST">
            <label for="email">Username:</label>
            <input type="text" id="username" name="username" required><br/>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Submit</button>
        </form>
    </body>
</html>
