<%-- 
    Document   : myrequest
    Created on : Apr 3, 2016, 11:59:52 PM
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
        <h1>คำร้องขอ</h1>

        <form action='CreateRequestServlet' method="POST" >
            หัวข้อ<br><input type="text" name="req_title"><br><br>
            เนื้อหา<br><textarea name="req_detail" cols=100 rows=5 ></textarea><br><br>
            ประเภท <select name="req_type">
                <option>ข้อเสนอแนะ</option>
                <option>ปัญหา</option>
                <option>ย้ายออก</option>
            </select>
            <br><br><input type="submit" value="ส่ง"/>
        </form>
        <br>
        <h2>ประวัติ</h2>
        <sql:query var="req" dataSource="dormdata">
            SELECT req_title, req_detail, req_date, req_status FROM REQUESTS
            join RENTERS
            using(renter_id)
            where username='${user.username}'
            order by req_date DESC
        </sql:query>
            
        <table border="1">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${req.columnNames}">
                    <th><c:out value="${columnName}"/></th>
                    </c:forEach>
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${req.rowsByIndex}">
                <tr>
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
