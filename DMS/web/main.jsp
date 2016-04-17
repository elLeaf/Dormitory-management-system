<%-- 
    Document   : main
    Created on : Apr 12, 2016, 8:16:28 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>หน้าแรก</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
        <style>
            body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
          }

          main {
            flex: 1 0 auto;
          }
        </style>
    </head>
    <c:if test="${user.role != 'admin'}">
        <sql:query var="dorm" dataSource="dormdata">
            select dorm_name from dorms where dorm_id=${user.dorm_id}
        </sql:query>
    </c:if>
    <body class="grey lighten-3">
        <c:if test="${user==null}"><jsp:forward page="login.jsp"></jsp:forward></c:if>
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row white center-align z-depth-1" style="width: 100%;">
            <c:if test="${user.role == 'admin'}"><h3 class="kanit">ยินดีต้อนรับสู่ระบบจัดการหอพัก</h3></c:if>
            <c:if test="${user.role != 'admin'}"><h3 class="kanit">ยินดีต้อนรับสู่หอพัก <c:forEach var="d" items="${dorm.rows}">${d.dorm_name}</c:forEach></h3></c:if>
        </div>
        <sql:query var="result" dataSource="dormdata">
            SELECT news_id, news_title, news_detail, news_date FROM news join employees using(emp_id) where dorm_id=${user.dorm_id} order by news_id DESC
        </sql:query>
        <div class="container">
            <div class="cellection">
                <ul class="collection with-header">
                    <li class="collection-header light-blue"><h3 class="white-text">ข่าวสาร</h3></li>
                    <c:forEach var="row" items="${result.rows}">
                        <li class="collection-item">
                            <a href="news.jsp?news_id=${row.news_id}">${row.news_title}</a><span class="grey-text"> - ${row.news_date}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp"></jsp:include>
    </body>
</html>
