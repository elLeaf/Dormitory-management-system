<%-- 
    Document   : news
    Created on : Apr 4, 2016, 8:41:43 PM
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
        <h1>${news.news_title}</h1>
        <p>${news.news_detail}</p>
        <br>
        <p>${news.news_date}</p>
    </body>
</html>
