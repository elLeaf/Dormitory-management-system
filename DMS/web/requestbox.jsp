<%-- 
    Document   : requestbox
    Created on : Apr 13, 2016, 3:39:35 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>กล่องคำร้องขอ</title>
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
    <c:if test="${user==null}"><jsp:forward page="login.jsp"></jsp:forward></c:if>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"></jsp:include>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12" style="font-family: 'Kanit'">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">กล่องคำร้องขอ</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row">
            <div class="col s12 m12 l12">
                <div class="container">
                    <div class="row">
                        <div class="col s12 white z-depth-1">
                        <br>
                        <div class="section"><h3 class="center-align kanit">กล่องคำร้องขอ</h3></div>
                        <div class="divider"></div>
                        <div class="section">
                            <form action="requestbox.jsp" method="GET">
                                <div class="row">
                                    <div class="col s3 m3 l3">
                                        <p>
                                           <input type="checkbox" id="check" name="isFinished" value="รอ"/>
                                           <label for="check">เฉพาะสถานะรออย่างเดียว</label>
                                        </p>
                                    </div>
                                        <div class="input-field col s4">
                                            <select name="type">
                                                <option value="ทั้งหมด">ทั้งหมด</option>
                                                <option value="ข้อเสนอแนะ">ข้อเสนอแนะ</option>
                                                <option value="ปัญหา">ปัญหา</option>
                                                <option value="ย้ายออก">ย้ายออก</option>
                                            </select>
                                            <label>เลือกประเภท</label>
                                        </div>
                                    <div class="col s6 m4 l4">
                                        <button class="waves-effect waves-light btn green darken-2 kanit">เลือก</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <sql:query var="req" dataSource="dormdata">
                            SELECT req_id, req_title, req_detail, req_date, req_status, req_type, renter_id, room_no, fname, lname FROM requests
                            JOIN contract
                            USING (renter_id)
                            JOIN rooms
                            USING (room_no)
                            JOIN renters
                            USING (renter_id)
                            WHERE dorm_id=${user.dorm_id}
                            <c:if test="${param.type!=null and param.type!='ทั้งหมด'}">and req_type='${param.type}'</c:if>
                            <c:if test="${param.isFinished!=null}">and req_status='${param.isFinished}'</c:if>
                            order by req_id DESC
                        </sql:query>
                        <div class="section">
                            <ul class="collapsible" data-collapsible="accordion">
                                <c:forEach var="r" items="${req.rows}">
                                    <li>
                                        <div class="collapsible-header">
                                            <c:if test="${r.req_status=='รับทราบ'}">
                                                <i class="material-icons">check</i>
                                            </c:if>
                                            <span>${r.req_title}</span><span class="grey-text lighten-1"> - ${r.req_date}</span>
                                        </div>
                                        <div class="collapsible-body grey lighten-4">
                                            <div class="row">
                                                <div class="col s12">
                                                    <p>
                                                        <b>เนื้อหา:</b><br> ${r.req_detail}<br>
                                                        <b>จาก:</b><br>คุณ ${r.fname} ${r.lname}<br>
                                                        <b>ห้อง:</b><br> ${r.room_no}
                                                    </p>
                                                </div>
                                                <div class="col s12 right-align">
                                                    <form action="request.do" method="POST">
                                                        <input type="hidden" name="req_id" value="${r.req_id}"/>
                                                        <c:if test="${r.req_status=='รอ'}">
                                                            <button class="btn-floating btn waves-effect waves-light green accent-4 tooltipped" style="margin: 10px;" 
                                                           data-position="top" data-delay="50" data-tooltip="รับทราบ" type="submit" name="submit" value="update"><i class="material-icons">check</i></button>
                                                        </c:if>
                                                        <button class="btn-floating btn waves-effect waves-light red tooltipped" style="margin: 10px;" 
                                                       data-position="top" data-delay="50" data-tooltip="ลบ" type="submit" name="submit" value="delete" onclick="return confirm('คุณต้องการที่จะลบห้องพักใช่หรือไม่?')"><i class="material-icons">delete</i></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
