<%-- 
    Document   : createroom
    Created on : Apr 14, 2016, 12:40:14 AM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:if test="${myedit=='1'}"><title>แก้ไขห้องพัก</title></c:if>
                    <c:if test="${myedit!='1'}"><title>สร้างห้องพัก</title></c:if>
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
                        <a class="breadcrumb">สร้างห้องพัก</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class='row'>
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="section center-align">
                    <c:if test="${myedit=='1'}"><h3 class="kanit">แก้ไขห้องพัก</h3></c:if>
                    <c:if test="${myedit!='1'}"><h3 class="kanit">สร้างห้องพัก</h3></c:if>
                    </div>
                    <div class="divider"></div>
                    <form action='room.do' method='POST'>
                        <c:if test="${myedit=='1'}"><input type="hidden" name="dorm_id" value="${room.dorm_id}" /></c:if>
                        <c:if test="${myedit!='1'}"><input type="hidden" name="dorm_id" value="${param.dorm_id}" /></c:if>
                        <div class="section">
                            <div class="row">
                                <div class="input-field col s12 m12 l12 ">
                                    <i class="material-icons prefix">vpn_key</i>
                                    <input id="doorm_title" type="text" class="validate" name="room_no" value="${room.number}" <c:if test="${myedit=='1'}">disabled</c:if>>
                                    <c:if test="${myedit=='1'}"><input type="hidden" name="room_no" value="${room.number}" /></c:if>
                                    <label for="last_name">หมายเลขห้อง</label>
                                </div>
                                <div class="input-field col s12 m6 l6">
                                    <i class="material-icons prefix">attach_money</i>
                                    <input id="doorm_title" type="text" class="validate" name="room_charge" value="${room.charge}">
                                    <label for="last_name">ค่าเช่าห้อง</label>
                                </div>
                                <div class="input-field col s12 m6 l6">
                                    <i class="material-icons prefix">dehaze</i>
                                    <input id="doorm_title" type="text" class="validate" name="room_floor" value="${room.floor}">
                                    <label for="last_name">ชั้น</label>
                                </div>
                                <div class="col s12 m12 l 12">
                                    <div class="row">
                                        <div class="col s12 m12 l12">
                                            <label>ประเภทห้อง</label>
                                        </div>
                                        <div class="col s12 m12 l12" style="padding-left: 40px;">
                                                <input type="checkbox" id="air" name="type" value="air"<c:if test="${room.air==1}">checked="checked"</c:if>/>
                                                <label for="air">แอร์</label>
                                            </div>
                                            <div class="col s12 m12 l12" style="padding-left: 40px;">
                                                <input type="checkbox" id="fan" name="type" value="fan" <c:if test="${room.fan==1}">checked="checked"</c:if>/>
                                                <label for="fan">พัดลม</label>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="section right-align">
                            <c:if test="${myedit=='1'}">
                                <button class="btn waves-effect waves-light green darken-3" type="submit" type="submit" name="submit" value="update">เสร็จสิ้น
                                    <i class="material-icons right">send</i>
                                </button>
                            </c:if>
                            <c:if test="${myedit!='1'}">
                                <button class="btn waves-effect waves-light green darken-3" type="submit" type="submit" name="submit" value="create">เสร็จสิ้น
                                    <i class="material-icons right">send</i>
                                </button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp"></jsp:include>
    </body>
</html>
