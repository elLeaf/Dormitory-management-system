<%-- 
    Document   : mymonthly
    Created on : Apr 4, 2016, 12:00:17 AM
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
        <h1>ค่าเช่าประจำเดือน</h1>
        <sql:query var="monthly" dataSource="dormdata">
            SELECT monthly_date, elect_value, water_value, room_charge, fine_value, water_value+elect_value+room_charge+fine_value,monthly_final_date, monthly_status FROM MONTHLY_RENT
            join CONTRACT
            using (contract_id)
            join ROOMS
            using (room_no)
            join RENTERS
            using (renter_id)
            where username='${user.username}'
            order by monthly_date DESC
        </sql:query>
            
        <table border="1">
            <!-- column headers -->
            <tr>
                <th>รอบ</th>
                <th>ค่าไฟ</th>
                <th>ค่าน้ำ</th>
                <th>ค่าห้อง</th>
                <th>ค่าปรับ</th>
                <th>รวม</th>
                <th>วันจ่ายสุดท้าย</th>
                <th>สถานะ</th>
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${monthly.rowsByIndex}">
                <tr>
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
