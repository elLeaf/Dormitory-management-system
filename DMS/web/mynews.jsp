<%-- 
    Document   : mynews
    Created on : Apr 16, 2016, 10:53:17 AM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>สร้างข่าวสาร</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
    </head>
    <body>
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">จัดการข่าวสาร</a>
                        <c:if test="${myedit!='1'}"><a class="breadcrumb">สร้างข่าวสาร</a></c:if>
                        <c:if test="${myedit=='1'}"><a class="breadcrumb">แก้ไขข่าวสาร</a></c:if>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row">
            <div class="container">
                <div class="col s12 m12 l12">
                    <div class="card">
                        <form action='news.do' method="POST" >
                            <input type="hidden" name='news_id' value="${news.id}"/>
                            <div class="card-title center-align">
                                <br><c:if test="${myedit!='1'}"><h4 class="kanit">สร้างข่าวสาร</h4></c:if>
                                <c:if test="${myedit == '1'}"><h4 class="kanit">แก้ไขข่าวสาร</h4></c:if>
                            </div>
                            <div class="card-content">
                                <div class="input-field center-align">
                                    <input type="text" name="news_title" value='${news.title}'>
                                    <label>หัวข้อ</label>
                                </div>
                                <div class="input-field center-align">
                                    <textarea id="text1" name="news_detail" cols=100 rows=7 class="materialize-textarea">${news.detail}</textarea>
                                    <label for="text1">เนื้อหา</label>
                                </div>
                                <br>
                                <c:if test="${myedit!='1'}">
                                    <button class="btn waves-effect waves-light light-green darken-1" type="submit" name="submit" value="create">เสร็จสิ้น
                                        <i class="material-icons right">send</i>
                                    </button>
                                </c:if>
                                <c:if test="${myedit=='1'}">
                                    <button class="btn waves-effect waves-light light-green darken-1" type="submit" name="submit" value="update">เสร็จสิ้น
                                        <i class="material-icons right">send</i>
                                    </button>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
