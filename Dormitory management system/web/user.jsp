<%-- 
    Document   : user
    Created on : Apr 5, 2016, 9:56:19 AM
    Author     : adisorn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ข้อมูลผู้ใช้งาน</h1>
        <c:if var="check" test="${user.role=='owner'}">
            <h2>Admin</h2>
        </c:if>
        <c:if var="check" test="${user.role=='renter'}">
            <b>ชื่อ: </b> ${renter.renter_fname}<br>
            <b>นามสกุล: </b> ${renter.renter_lname}<br>
            <b>เพศ: </b> ${renter.renter_gender}<br>
            <b>เบอร์โทรศัพท์: </b> ${renter.renter_phone}<br>
            <b>อาชีพ: </b> ${renter.renter_career}<br>
        </c:if>
    </body>
</html>
