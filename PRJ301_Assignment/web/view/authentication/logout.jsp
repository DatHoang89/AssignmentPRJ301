<%-- 
    Document   : logout
    Created on : Mar 16, 2023, 6:59:04 PM
    Author     : LEGION
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Logout successful!</h1>
        <br/>
        You will be directed to /login after <span id="time"></span> seconds
        <script> 
        var count =3;
        var time = document.getElementById('time');
        time.innerHTML = count;
        function counting()
        {
            count --;
            time.innerHTML = count;
            if(count <= 0 )
            {
                window.location.href = 'login';
            }
        }
        setInterval(counting,1000);
        
        </script>
    </body>
</html>
