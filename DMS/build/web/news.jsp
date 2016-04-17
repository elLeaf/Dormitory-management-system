<%-- 
    Document   : news
    Created on : Apr 13, 2016, 8:31:12 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
    </head>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <c:if test="${param.news_id!=null}">
        <sql:query var="news" dataSource="dormdata">
            select * from news
            where news_id='${param.news_id}';
        </sql:query>
        </c:if>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">ข่าวสาร</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row">
            <div class="container">
                <c:forEach var="n" items="${news.rows}">
                    <div class="col s12 z-depth-1 white">
                        <div class="section">
                            <h3>${n.news_title}</h3>
                        </div>
                        <div class="divider"></div>
                        <div class="section">
                            <p style="text-indent: 50px" class='flow-text'>
                                ${n.news_detail}
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp"></jsp:include>
    </body>
</html>
