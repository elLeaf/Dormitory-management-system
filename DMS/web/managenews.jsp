<%-- 
    Document   : managenews
    Created on : Apr 14, 2016, 1:36:42 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการข่าวสาร</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
    </head>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">จัดการข่าวสาร</a>
                    </div>
                </div>
            </nav>
        </div>
        <sql:query var="news" dataSource="dormdata">
            SELECT * FROM news
            join employees
            using(emp_id)
            where dorm_id=${user.dorm_id}
            order by news_id DESC
        </sql:query>
        <div class="row">
            <div class="container">
                <div class="col s12 m12 l12 white z-depth-1">
                    <div class="center-align">
                        <h3 class="kanit">จัดการข่าวสาร</h3>
                    </div>
                    <div class="divider"></div>
                    <div class="section">
                        <a href="mynews.jsp" class="waves-effect waves-light btn green darken-2 kanit"><i class="material-icons left">add</i>เพิ่มข่าวใหม่</a><br>
                    </div>
                    <div class='row'>
                        <div class="col s12 m12 l12">
                            <ul class="collapsible" data-collapsible="accordion">
                                <c:forEach var="n" items="${news.rows}">                                        
                                    <li> 
                                        <div class="collapsible-header">
                                            <span>${n.news_title}</span><span class="grey-text lighten-1"> - ${n.news_date}</span>
                                        </div>
                                        <div class="collapsible-body grey lighten-4">
                                            <form action="news.do" method="POST">
                                                <input type="hidden" name='news_id' value="${n.news_id}"/>
                                                <input type="hidden" name='news_title' value="${n.news_title}"/>
                                                <input type="hidden" name='news_detail' value="${n.news_detail}"/>
                                                <div class="row">
                                                    <div class="col s12">
                                                        <p class="flow-text"><b>เนื้อหา:</b><br> ${n.news_detail}</p>
                                                    </div>
                                                    <div class="col s12 right-align">
                                                        <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin: 10px;" 
                                                        data-position="top" data-delay="50" data-tooltip="แก้ไข" name='submit' type='submit' value='edit'><i class="material-icons">mode_edit</i></button>
                                                        <button class="btn-floating btn waves-effect waves-light red tooltipped" style="margin: 10px;" 
                                                        data-position="top" data-delay="50" data-tooltip="ลบ" name='submit' type='submit' value='delete' onclick="return confirm('คุณต้องการที่จะลบข่าวสารใช่หรือไม่?')"><i class="material-icons">delete</i></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>   
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
