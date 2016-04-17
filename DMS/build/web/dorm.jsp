<%-- 
    Document   : dorm
    Created on : Apr 13, 2016, 3:23:36 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการหอพัก</title>
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
                    </div>
                </div>
            </nav>
        </div>
        <sql:query var="dorm" dataSource="dormdata">
            SELECT dorm_id, dorm_name, elect_rate, water_rate, dorm_phone from dorms
        </sql:query>
        <div class="row">
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="center-align">
                        <h3 class="kanit">จัดการหอพัก</h3>
                    </div>
                    <div class="divider"></div>
                    <div class="section">
                        <a href="mydorm.jsp" class="waves-effect waves-light btn green darken-2 kanit"><i class="material-icons left">add</i>เพิ่มหอพักใหม่</a>
                        <a href="employee.jsp" class="waves-effect waves-light btn grey darken-2 kanit"><i class="material-icons left">account_circle</i>จัดการพนักงาน</a><br>
                    </div>
                    <div class="row">
                        <c:forEach var="d" items="${dorm.rows}">
                            <div class="col s12 m6 l6">
                                <div class="card">
                                    <form id="dorm_detail" action="dorm.do" method="GET">
                                        <div class="card-title blue darken-1 white-text z-depth-1">
                                            <h4 class="header" style="padding:20px;">หอพัก ${d.dorm_name}</h4>
                                        </div>
                                        <div class="card-content flow-text"><input type="hidden" name="dorm_id" value="${d.dorm_id}"/>
                                            <b>อัตราค่าไฟ:</b> ${d.elect_rate}<br>
                                            <b>อัตราค่าน้ำ:</b> ${d.water_rate}<br>
                                            <b>เบอร์โทรศัพท์:</b> ${d.dorm_phone}
                                        </div>
                                        <div class="card-action center-align grey lighten-5">
                                            <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin: 10px;" 
                                               data-position="top" data-delay="50" data-tooltip="ดูข้อมูลห้องพัก" name="submit" value="view" type="submit"><i class="material-icons">visibility</i></button>
                                            <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin: 10px;" 
                                               data-position="top" data-delay="50" data-tooltip="แก้ไข" name="submit" value="edit" type="submit"><i class="material-icons">mode_edit</i></button>
                                            <button type="submit" class="btn-floating btn waves-effect waves-light red tooltipped" style="margin: 10px;" 
                                               data-position="top" data-delay="50" data-tooltip="ลบ" name="submit" value="delete" onclick="return confirm('คุณต้องการที่จะลบหอพักใช่หรือไม่?')"><i class="material-icons">delete</i></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
