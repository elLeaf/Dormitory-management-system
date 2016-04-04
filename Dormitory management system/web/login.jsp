<%-- 
    Document   : login
    Created on : Apr 3, 2016, 2:59:23 PM
    Author     : adisorn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>
    <body>
        <form action="Login" method="POST">
            <h1>Login</h1>
            Username <input type="text" name="username"><br>
            Password <input type="password" name="psw"><br>
            <input type="submit" value="Login">
        </form>
        <br>${warningPsw}
    </body>
</html>
