<%-- 
    Document   : login
    Created on : Apr 12, 2016, 7:49:12 PM
    Author     : adisorn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>เข้าสู่ระบบ</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body>
        <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <br>
        <div class="container">
            <div class="row">
                <div class="card hoverable ">
                    <div class="card-title center-align">
                        <br>
                        <i class="material-icons large">account_circle</i>
                    </div>
                    <div class="card-content">
                        <form action="Login" method="POST">
                            <div class="container">
                                <div class="input-field">
                                    <input id="user" type="text" class="validate" name="username">
                                    <label for="user">Username</label>
                                </div>
                                <div class="input-field">
                                    <input id="psw" type="password" class="validate" name="password">
                                    <label for="psw">Password</label>
                                </div>
                            </div>
                            <br>
                            <div class="card-action center-align">
                                <button class="btn waves-effect waves-light  light-green darken-1" type="submit" name="action">Login
                                    <i class="material-icons right">send</i>
                            </button>
                            </div>
                        </form>
                    </div>
                </div>
          </div>
        </div>
        <jsp:include page="/include/footer.jsp"></jsp:include>
    </body>
</html>
