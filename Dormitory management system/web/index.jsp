<%-- 
    Document   : index
    Created on : Apr 3, 2016, 5:37:49 PM
    Author     : adisorn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ยินดีต้อนรับสู่หอพัก</title>
    </head>
    <body>
        <sql:query var="news" dataSource="dormdata">
            select * from NEWS
        </sql:query>
        <table>
            <tr>
                <td><a href="user.jsp">${user.username}</a> 
                <td><a href="Logout">Logout</a></td>
                <td><a href="index.jsp" >Home</a></td>
                <c:if var="check" test="${user.role=='renter'}">
                    <td><a href="mymonthly.jsp">ค่าเช่าประจำเดือน</a></td>
                    <td><a href="myrequest.jsp">คำร้องขอ</a></td>
                </c:if>
            </tr>
        </table>
        <h1>ยินดีต้อนรับ</h1>
        <h2>ข่าวสาร</h2>
        <sql:query var="result" dataSource="dormdata">
            SELECT * FROM NEWS
        </sql:query>
            
        <c:forEach var="row" items="${result.rows}">
            <a href="news.view?news_id=${row.news_id}">${row.news_title}</a><br>
        </c:forEach>
    </body>
</html>
