<%-- 
    Document   : employee
    Created on : Apr 13, 2016, 3:28:48 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>พนักงาน</title>
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
                    <div class="col s12" style="font-family: 'Kanit'">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">หอพัก</a>
                        <a class="breadcrumb">พนักงาน</a>
                    </div>
                </div>
            </nav>
        </div>
        <sql:query var="dorm" dataSource="dormdata">
            SELECT dorm_id, dorm_name from dorms;
        </sql:query>
        <div class="row">
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="center-align">
                        <h3 class="kanit">จัดการข้อมูลพนักงาน</h3>
                    </div>
                </div>
            </div>
        </div>
        <c:forEach var="d" items="${dorm.rows}"> 
                <div class="row">
                    <div class="container">
                        <div class="col s12 white z-depth-1">
                            <div class="section center-align">
                                <h3 class="kanit">หอพัก ${d.dorm_name}</h3>
                            </div>
                            <div class="divider"></div>
                            <div class="section">
                                <a href="myemployee.jsp?dorm_id=${d.dorm_id}" class="waves-effect waves-light btn green darken-2 kanit"><i class="material-icons left">add</i>เพิ่มพนักงานใหม่</a>
                            </div>
                            <sql:query var="emp" dataSource="dormdata">
                                select * from employees
                                where dorm_id=${d.dorm_id}
                            </sql:query>
                            <div class="row">
                                <c:forEach var="e" items="${emp.rows}">
                                    <form action="emp.do" method="GET">
                                        <input type="hidden" name="dorm_id" value="${d.dorm_id}"/>
                                        <input type="hidden" name="emp_id" value="${e.emp_id}"/>
                                        <div class="col s12 m6 l6">
                                            <div class="card">
                                                <div class="card-title blue darken-1 white-text z-depth-1">
                                                    <h4 class="header" style="padding:20px;">พนักงานรหัส ${e.emp_id}</h4>
                                                </div>
                                                <div class="card-content flow-text">
                                                    <b>ชื่อ:</b> ${e.fname}<br>
                                                    <b>นามสกุล:</b> ${e.lname}<br>
                                                    <b>เพศ:</b> ${e.gender}<br>
                                                    <b>อายุ:</b> ${e.age}<br>
                                                    <b>เบอร์โทรศัพท์:</b> ${e.phone}<br>
                                                    <b>ตำแหน่ง:</b> ${e.position}<br>
                                                    <b>เงินเดือน:</b> ${e.salary}
                                                </div>
                                                <div class="card-action center-align grey lighten-5">
                                                    <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin-right: 10px;" 
                                                            data-position="top" data-delay="50" data-tooltip="แก้ไข" type="submit" name="submit" value="edit"><i class="material-icons">mode_edit</i></button>
                                                    <button class="btn-floating btn waves-effect waves-light red tooltipped" style="margin-left: 10px;" 
                                                       data-position="top" data-delay="50" data-tooltip="ลบ" type="submit" name="submit" value="delete" onclick="return confirm('คุณต้องการที่จะลบพนักงานใช่หรือไม่?')"><i class="material-icons">delete</i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
        </c:forEach>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
