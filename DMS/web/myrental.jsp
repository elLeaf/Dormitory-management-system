<%-- 
    Document   : myrental
    Created on : Apr 13, 2016, 12:42:08 PM
    Author     : anst_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ค่าเช่าประจำเดือน</title>
        <link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css">
        <link rel="stylesheet" href="materialize/css/materialize.css" type="text/css"/>
        <script type="text/javascript" src="materialize/js/jquery.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Kanit:400,500&subset=thai,latin' rel='stylesheet' type='text/css'>
    </head>
    <body class="grey lighten-3">
        <jsp:include page="/include/header.jsp"/>
        <div class="row">
            <nav class="white" style="padding-left: 50px;">
                <div class="nav-wrapper">
                    <div class="col s12 kanit">
                        <a href="main.jsp" class="breadcrumb kanit">หน้าแรก</a>
                        <a href="myrental.jsp" class="breadcrumb kanit">ค่าเช่ารายเดือน</a>
                    </div>
                </div>
            </nav>
        </div>
        <div class="row" >
            <div class="container" style="width: 80%;">
                <div class="card">
                    <sql:query var="monthly" dataSource="dormdata">
                        SELECT monthly_date, elect_value, water_value, room_charge, fine_value, water_value+elect_value+room_charge+fine_value,monthly_final_date, monthly_status FROM MONTHLY_RENT
                        join CONTRACT
                        using (contract_id)
                        join ROOMS
                        using (room_no)
                        join RENTERS
                        using (renter_id)
                        where username='renter1'
                        order by monthly_date DESC
                    </sql:query>
                    <table class="highlight centered responsive-table bordered">
                        <!-- column headers -->
                        <thead>
                            <tr class="light-blue white-text">    
                                <th>รอบ</th>
                                <th>ค่าไฟ</th>
                                <th>ค่าน้ำ</th>
                                <th>ค่าห้อง</th>
                                <th>ค่าปรับ</th>
                                <th>รวม</th>
                                <th>วันจ่ายสุดท้าย</th>
                                <th>สถานะ</th>
                            </tr>
                        </thead>
                        <!-- column data -->
                        <tbody>
                            <c:forEach var="row" items="${monthly.rowsByIndex}">
                                <tr>
                                    <c:forEach var="column" items="${row}">
                                        <td><c:out value="${column}"/></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="/include/footer.jsp"/>
    </body>
</html>
