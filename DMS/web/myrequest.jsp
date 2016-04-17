<%-- 
    Document   : myrequest
    Created on : Apr 12, 2016, 11:43:57 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>คำร้องขอ</title>
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
        <c:if test="${user==null}"><jsp:forward page="login.jsp"></jsp:forward></c:if>
        <jsp:include page="/include/header.jsp" />
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a class="breadcrumb">หน้าแรก</a>
                        <a class="breadcrumb">คำร้องขอ</a>
                    </div>
                </div>
            </nav>
        </div>
        <br>
        <div class="row">
            <div class="col s12 m12 l4">
                <div class="card hoverable">
                    <form action='request.do' method="POST" >
                        <input type="hidden" name="renter_id" value="${user.user_id}"/>
                        <div class="card-title center-align">
                            <br><h4 class="kanit">ส่งคำร้องขอ</h4>
                        </div>
                        <div class="card-content">
                            <div class="input-field center-align">
                                <input type="text" name="req_title">
                                <label>หัวข้อ</label>
                            </div>
                            <div class="input-field center-align">
                                <textarea id="text1" name="req_detail" cols=100 rows=5 class="materialize-textarea"></textarea>
                                <label for="text1">เนื้อหา</label>
                            </div>
                            <div class="input-field col s6">
                                <select name="req_type">
                                    <option value="" disabled selected>เลือกประเภท</option>
                                    <option value="ข้อเสนอแนะ">ข้อเสนอแนะ</option>
                                    <option value="ปัญหา">ปัญหา</option>
                                    <option value="ย้ายออก">ย้ายออก</option>
                                </select>
                            </div>     
                            <br>
                            <button class="btn waves-effect waves-light light-green darken-1" type="submit" name="submit" value="create">ส่ง
                                <i class="material-icons right">send</i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col s12 m12 l8">
                <div class="card hoverable">
                <br>
                    <h3 class="center-align kanit">ประวัติ</h3>
                    <sql:query var="req" dataSource="dormdata">
                        SELECT req_title, req_detail, req_date, req_status FROM requests
                        join renters
                        using(renter_id)
                        where username='${user.username}'
                        order by req_date DESC
                    </sql:query>
                    <ul class="collapsible" data-collapsible="accordion">
                        <c:forEach var="req" items="${req.rows}" varStatus="counter">
                            <li>
                                <div class="collapsible-header">
                                    <c:if test="${req.req_status=='รับทราบ'}">
                                        <i class="material-icons">check</i>
                                    </c:if>
                                        <span>${req.req_title}</span><span class="grey-text lighten-1"> - ${req.req_date}</span>
                                </div>
                                    <div class="collapsible-body grey lighten-4"><p class="flow-text"><b>เนื้อหา:</b><br> ${req.req_detail}</p></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp" />
    </body>
</html>
