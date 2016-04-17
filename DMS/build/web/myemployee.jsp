<%-- 
    Document   : createemployee
    Created on : Apr 14, 2016, 12:40:26 AM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>สร้างพนักงาน</title>
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
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">หอพัก</a>
                        <a class="breadcrumb">ห้องพัก</a>
                        <a class="breadcrumb"><c:if test="${myedit!='1'}">สร้างพนักงาน</c:if><c:if test="${myedit=='1'}">แก้ไขพนักงาน</c:if></a>
                    </div>
                </div>
            </nav>
        </div>
        <div class='row'>
            <div class="container">
                <div class="col s12 white z-depth-1">
                    <div class="section center-align">
                        <c:if test="${myedit!='1'}"><h3 class="kanit">สร้างข้อมูลพนักงาน</h3></c:if>
                        <c:if test="${myedit=='1'}"><h3 class="kanit">แก้ข้อมูลพนักงาน</h3></c:if>
                    </div>
                    <div class="divider"></div>
                    <form action='emp.do' method='POST'>
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
                                    <div class="col s12 m6 l6">
                                        <i class="material-icons prefix">next_week</i>
                                        <select name="role">
                                            <option value="" disabled selected>ประเภทผู้ใช้งาน</option>
                                            <option value="ผู้ดูแลด้านการเงิน">ผู้ดูแลด้านการเงิน</option>
                                            <option value="ผู้ดูแลหอพัก">ผู้ดูแลหอพัก</option>
                                        </select>
                                    </div>    
                                </div> 
                            </div>
                        </c:if>
                        <div class="divider"></div>
                        <div class="section">
                            <div class="row">
                                <div class="col s12"><h5>ข้อมูลพนักงาน</h5></div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="fname" value="${emp.fname}">
                                        <label for="elect_rate">ชื่อ</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="lname" value="${emp.lname}">
                                        <label for="elect_rate">นามสกุล</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">person</i>
                                        <input id="elect_rate" type="text" class="validate" name="age" value="${emp.age}">
                                        <label for="elect_rate">อายุ</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <p>
                                        <i class="material-icons prefix">person</i>
                                        <label>เพศ</label>
                                        <input class="with-gap" name="gender" type="radio" id="male" value="ชาย" <c:if test="${myedit=='1' and emp.gender=='ชาย'}">checked</c:if>/>
                                       <label for="male">ชาย</label>
                                       <input class="with-gap" name="gender" type="radio" id="female" value="หญิง"  <c:if test="${myedit=='1' and emp.gender=='หญิง'}">checked</c:if>/>
                                       <label for="female">หญิง</label>
                                    </p>
                                    
                                </div>
                                <div class="col s12 m12 l12">
                                    <div class="input-field">
                                        <i class="material-icons prefix">call</i>
                                        <input id="phone" type="text" class="validate" name="phone" value="${emp.phone}">
                                        <label for="phone">เบอร์โทรศัพท์</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">attach_money</i>
                                        <input id="salary" type="text" class="validate" name="salary" value="${emp.salary}">
                                        <label for="salary">เงินเดือน</label>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <div class="input-field">
                                        <i class="material-icons prefix">next_week</i>
                                        <input id="elect_rate" type="text" class="validate" name="position" value="${emp.position}">
                                        <label for="elect_rate">ตำแหน่ง</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                                        <input type="hidden" name="emp_id" value="${emp.id}"/>
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
