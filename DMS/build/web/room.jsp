<%-- 
    Document   : room
    Created on : Apr 13, 2016, 3:28:17 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการห้องพัก</title>
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
                        <a class="breadcrumb">หอพัก</a>
                        <a class="breadcrumb">ห้องพัก</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row">
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="center-align">
                        <h3 class="kanit">หอพัก ${dorm.name}</h3>
                    </div>
                    <div class="divider"></div>
                    <div class="section">
                        <a href="myroom.jsp?dorm_id=${dorm.id}" class="waves-effect waves-light btn green darken-2 kanit"><i class="material-icons left">add</i>เพิ่มห้องใหม่</a><br>
                    </div>
                    <div class="row">
                            <input type="hidden" name="dorm_id" value="${dorm.id}"/>
                            <c:forEach var="r" items="${rooms}">
                                <form action="room.do" method="POST">
                                <div class="col s12 m6 l6">
                                    <div class="card">
                                        <div class="card-title blue darken-1 white-text z-depth-1">
                                            <a class="white-text"><h4 class="header" style="padding:20px;">ห้อง ${r.number}</h4></a>
                                        </div>
                                        <input type="hidden" name="dorm_id" value="${dorm.id}"/>
                                        <input type="hidden" name="room_no" value="${r.number}"/>
                                        <div class="card-content flow-text">
                                            <b>ชั้น:</b> ${r.floor}<br>
                                            <b>ค่าห้อง:</b> ${r.charge}<br>
                                            <b>สถานะ:</b> ${r.status}<br>
                                            <b>ประเภท:</b> <c:if test="${r.air==1}">แอร์</c:if> <c:if test="${r.fan==1}"> พัดลม</c:if><br>
                                        </div>
                                        <div class="card-action center-align grey lighten-5">
                                            <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin-right: 10px;" 
                                               data-position="top" data-delay="50" data-tooltip="แก้ไข" name="submit" value="edit"><i class="material-icons">mode_edit</i></button>
                                            <button class="btn-floating btn waves-effect waves-light red tooltipped" style="margin-left: 10px;" 
                                               data-position="top" data-delay="50" data-tooltip="ลบ" name="submit" value="delete"><i class="material-icons" onclick="return confirm('คุณต้องการที่จะลบห้องพักใช่หรือไม่?')">delete</i></button>
                                        </div>
                                    </div>
                                </div>
                                </form>
                            </c:forEach>
                        
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
