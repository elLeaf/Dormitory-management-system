<%-- 
    Document   : managerenter
    Created on : Apr 16, 2016, 10:44:36 PM
    Author     : anst_
--%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการผู้เช่า</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
        <script>
            $(document).ready(function() {
                $('select').material_select();
            });
        </script> 
    </head>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12" style="font-family: 'Kanit'">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">จัดการผู้เช่า</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row">
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="section center-align kanit">
                        <h4 >จัดการผู้เช่า</h4>
                    </div>
                    <div class="divider"></div>
                    <div class="section">
                        <a href="myrenter.jsp" class="waves-effect waves-light btn green darken-2 kanit"><i class="material-icons left">add</i>เพิ่มผู้เช่าใหม่</a>
                    </div>
                    <div class="section">
                        <form action='managerenter.jsp' method="GET">
                            <div class="col s6 m4 l4">
                                <select name="status">
                                    <option value="" disabled selected>เลือกประเภท</option>
                                    <option value="เช่า">ผู้เช่าปัจจุบัน</option>
                                    <option value="สิ้นสุด">ผู้เช่าเก่า</option>
                                </select>
                            </div>
                            <button class="waves-effect waves-light btn green darken-2 kanit">เลือก</button>
                        </form>
                    </div>
                    <sql:query var="renter" dataSource="dormdata">
                        select * from renters
                        join contract using (renter_id)
                        join rooms using (room_no)
                        where dorm_id=${user.dorm_id}
                        <c:if test="${param.status=='เช่า' or param.status==null}">and contract_status='เช่า'</c:if>
                        <c:if test="${param.status=='สิ้นสุด'}">and contract_status='สิ้นสุด'</c:if>
                    </sql:query>
                    <div class="section">
                        <div class="row">
                            <c:forEach var="r" items="${renter.rows}">
                                <form action="renter.do" method="POST">
                                    <div class="col s12 m6 l6">
                                        <div class="card">
                                                <div class="card-title blue darken-1 white-text z-depth-1">
                                                    <h5 class="header" style="padding:20px;">ผู้เช่ารหัส ${r.renter_id}</h5>
                                                </div>
                                                <div class="card-content ">
                                                    <b>ชื่อ:</b> ${r.fname}<br>
                                                    <b>นามสกุล:</b> ${r.lname}<br>
                                                    <b>เพศ:</b> ${r.gender}<br>
                                                    <b>อายุ:</b> ${r.age}<br>
                                                    <b>เบอร์โทรศัพท์:</b> ${r.phone}<br>
                                                    <b>อาชีพ:</b> ${r.career}<br>
                                                    <b>ห้อง:</b> ${r.room_no}<br>
                                                    <b>สถานะ:</b> ${r.contract_status}<br>
                                                    <b>สัญญาสิ้นสุด:</b> ${r.contract_end_date}
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
        </div>
    </body>
</html>
