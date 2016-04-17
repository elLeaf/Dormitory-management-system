<%-- 
    Document   : createdorm
    Created on : Apr 13, 2016, 10:51:33 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>สร้างข้อมูลหอพัก</title>
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
                        <a href="main.jsp" class="breadcrumb"">หน้าแรก</a>
                        <a href="dorm.jsp" class="breadcrumb">หอพัก</a>
                        <a href="createdorm.jsp" class="breadcrumb">สร้างหอพัก</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class='row'>
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="section center-align">
                        <c:if test="${myedit!='1'}">
                            <h3 class="kanit">สร้างหอพัก</h3>
                        </c:if>
                        <c:if test="${myedit == '1'}">
                            <h3 class="kanit">แก้ไขหอพัก</h3>
                        </c:if>
                    </div>
                    <div class="divider"></div>
                    <form action='dorm.do' method='POST'>
                        <input type="hidden" name="dorm_id" value="${dorm.id}"/>
                        <div class="section">
                            <div class="row">
                                <div class='col s12 m12 l12'>
                                    <div class="input-field col s12 m12 l12 ">
                                        <i class="material-icons prefix">home</i>
                                        <input id="doorm_title" type="text" class="validate" name="dorm_name" value="${dorm.name}">
                                        <label for="last_name">ชื่อหอพัก</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class='col s12 m12 l12'>
                                    <div class="input-field col s12 m6 l6">
                                        <i class="material-icons prefix">attach_money</i>
                                        <input id="elect_rate" type="text" class="validate" name="elect_rate" value="${dorm.elect_rate}">
                                        <label for="elect_rate">อัตราค่าไฟ</label>
                                    </div>
                                    <div class="input-field col s12 m6 l6">
                                        <i class="material-icons prefix">attach_money</i>
                                        <input id="water_rate" type="text" class="validate" name="water_rate" value="${dorm.water_rate}">
                                        <label for="water_rate">อัตราค่าน้ำ</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class='col s12 m12 l12'>
                                    <div class="input-field col s12 m12 l12">
                                        <i class="material-icons prefix">call</i>
                                        <input id="phone" type="text" class="validate" name="dorm_phone" value="${dorm.phone}">
                                        <label for="phone">เบอร์โทรศัพท์</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="section right-align">
                            <c:if test="${myedit!='1'}">
                                <button class="btn waves-effect waves-light green darken-3" type="submit" name="submit" value="create">เสร็จสิ้น
                                    <i class="material-icons right">send</i>
                                </button>
                            </c:if>
                            <c:if test="${myedit == '1'}">
                                <button class="btn waves-effect waves-light green darken-3" type="submit" name="submit" value="update">เสร็จสิ้น
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
