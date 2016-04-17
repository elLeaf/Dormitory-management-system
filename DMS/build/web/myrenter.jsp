<%-- 
    Document   : myrenter
    Created on : Apr 17, 2016, 12:03:04 AM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ข้อมูลผู้เช่า</title>
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
            $('.datepicker').pickadate({
                selectMonths: true, // Creates a dropdown to control month
                selectYears: 15 // Creates a dropdown of 15 years to control year
              });
        </script> 
    </head>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">จัดการผู้เช่า</a>
                        <a class="breadcrumb"><c:if test="${myedit!='1'}">สร้างผู้เช่า</c:if><c:if test="${myedit=='1'}">แก้ไขผู้เช่า</c:if></a>
                    </div>
                </div>
            </nav>
        </div>
        <div class='row'>
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="section center-align">
                        <c:if test="${myedit!='1'}"><h3 class="kanit">สร้างข้อมูลผู้เช่า</h3></c:if>
                        <c:if test="${myedit=='1'}"><h3 class="kanit">แก้ข้อมูลผู้เช่า</h3></c:if>
                    </div>
                    <div class="divider"></div>
                    <form action='renter.do' method='POST'>
                        <c:if test="${myedit!='1'}">
                            <script>
                                $(document).ready(function() {
                                    $('select').material_select();
                                });
                            </script> 
                            <input type="hidden" name="dorm_id" value="${param.dorm_id}"/>
                            <div class="section">
                                <div class="row">
                                    <div class="col s12"><h5>Account</h5></div>
                                    <div class="col s12 m12 l12">
                                        <div class="input-field">
                                            <i class="material-icons prefix">person</i>
                                            <input id="username" type="text" class="validate" name="username">
                                            <label for="username">Username</label>
                                        </div>
                                    </div>
                                    <div class="col s12 m12 l12">
                                        <div class="input-field">
                                            <i class="material-icons prefix">lock</i>
                                            <input id="password1" type="password" class="validate" name="password1">
                                            <label for="password1">Password</label>
                                        </div>
                                    </div>
                                    <div class="col s12 m12 l12">
                                        <div class="input-field">
                                            <i class="material-icons prefix">lock</i>
                                            <input id="password2" type="password" class="validate" name="password2">
                                            <label for="password2">Re-password</label>
                                        </div>
                                    </div>
                                    <input type="hidden" name='role' value="ผู้เช่า"/>  
                                </div> 
                            </div>
                        </c:if>
                        <div class="divider"></div>
                        <div class="section">
                            <div class="row">
                                <div class="col s12"><h5>ข้อมูลผู้เช่า</h5></div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="fname" value="${renter.fname}">
                                        <label for="elect_rate">ชื่อ</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="lname" value="${renter.lname}">
                                        <label for="elect_rate">นามสกุล</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="age" value="${renter.age}">
                                        <label for="elect_rate">อายุ</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <p>
                                        <i class="material-icons prefix">person</i>
                                        <label>เพศ</label>
                                        <input class="with-gap" name="gender" type="radio" id="male" value="ชาย" <c:if test="${myedit=='1' and renter.gender=='ชาย'}">checked</c:if>/>
                                       <label for="male">ชาย</label>
                                       <input class="with-gap" name="gender" type="radio" id="female" value="หญิง"  <c:if test="${myedit=='1' and renter.gender=='หญิง'}">checked</c:if>/>
                                       <label for="female">หญิง</label>
                                    </p>
                                    
                                </div>
                                <div class="col s12 m12 l12">
                                    <div class="input-field">
                                        <i class="material-icons prefix">call</i>
                                        <input id="phone" type="text" class="validate" name="phone" value="${renter.phone}">
                                        <label for="phone">เบอร์โทรศัพท์</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">next_week</i>
                                        <input id="salary" type="text" class="validate" name="salary" value="${renter.career}">
                                        <label for="salary">อาชีพ</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="section">
                            <div class="row">
                                <div class="col s12"><h5>ข้อมูลสัญญา</h5></div>
                                <sql:query var="a" dataSource="dormdata">
                                    select distinct room_no from rooms where dorm_id=${user.dorm_id} and room_status='ว่าง'
                                </sql:query>
                                <div class="col s12 m6 l6">
                                    <label for='date'>เลือกห้องว่างที่ต้องการเช่า</label>
                                    <select name="room_no">
                                        <c:forEach var="b" items="${a.rows}">
                                            <option value="${b.room_no}">${b.room_no}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col s12 m6 l6">
                                    <script>
                                        $("#datepicker").datepicker({ dateFormat: "yyyy-mm-dd" });
                                        $("#date").datepicker("setDate", '2016-04-17'); 
                                    </script>
                                    <label for='date'>เลือกวันสิ้นสุดสัญญา</label>
                                    <input id='date' type="date" class="datepicker" name='date'>
                                </div>
                                <div class="col s12 m12 l12">
                                    <div class="input-field">
                                        <i class="material-icons prefix">attach_money</i>
                                        <input id="salary" type="text" class="validate" name="deposit" value="${contract.deposit}">
                                        <label for="salary">เงินประกัน</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="renter_id" value="${renter.id}"/>
                        <div class="divider"></div>
                        <div class="section right-align">
                            <c:if test="${myedit!='1'}">
                                <button class="btn waves-effect waves-light green darken-3" type="submit" name="submit" value="create">เสร็จสิ้น
                                    <i class="material-icons right">send</i>
                                </button>
                            </c:if>
                            <c:if test="${myedit=='1'}">
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
