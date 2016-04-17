<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<script>
            $(document).ready(function(){
                $(".button-collapse").sideNav();
                $('.collapsible').collapsible();
             });
        </script>
<header>
<style>
    .kanit {
        font-family: 'kanit';
    }
</style>
    <div class="navbar-fixed">
        <nav class="grey darken-3">
            <div class="top-nav">
                <a href="#" style="font-family: 'Kanit'" data-activates="slide-out" class="button-collapse"><i class="mdi-navigation-menu material-icons">menu</i></a>
                <a href="main.jsp" data-activates="slide-out" class="brand-logo center hide-on-large-only kanit" style="padding-left:10px;">ระบบจัดการหอพัก</a>
                <a href="main.jsp" class="brand-logo left hide-on-med-and-down kanit" style="padding-left:10px;">ระบบจัดการหอพัก</a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <c:if test="${user.role=='admin'}"><li><a href="dorm.jsp" class='kanit'>จัดการหอพัก</a></li></c:if>
                    <c:if test="${user.role=='ผู้ดูแลหอพัก'}">
                        <li><a href="managenews.jsp" class='kanit'>จัดการข่าวสาร</a></li>
                        <li><a href="requestbox.jsp" class='kanit'>กล่องคำร้องขอ</a></li>
                        <li><a href="managerenter.jsp" class='kanit'>จัดการผู้เช่า</a></li>
                    </c:if>
                    <c:if test="${user.role=='ผู้เช่า'}">
                        <li><a href="myrental.jsp" class='kanit'>ค่าเช่าประจำเดือน</a></li>
                        <li><a href="myrequest.jsp" class='kanit'>คำร้องขอ</a></li>
                    </c:if>
                    <li><a href="Logout" class='kanit'>Logout</a></li>
                </ul>   
            </div>
            <ul id="slide-out" class="side-nav">
                    <c:if test="${user.role=='admin'}"><li><a href="dorm.jsp" class='kanit'>จัดการหอพัก</a></li></c:if>
                    <c:if test="${user.role=='ผู้ดูแลหอพัก'}">
                        <li><a href="managenews.jsp" class='kanit'>จัดการข่าวสาร</a></li>
                        <li><a href="requestbox.jsp" class='kanit'>กล่องคำร้องขอ</a></li>
                    </c:if>
                    <c:if test="${user.role=='ผู้เช่า'}">
                        <li><a href="myrental.jsp" class='kanit'>ค่าเช่าประจำเดือน</a></li>
                        <li><a href="myrequest.jsp" class='kanit'>คำร้องขอ</a></li>
                    </c:if>
                    <c:if test="${user!=null}"><li><a href="Logout" class='kanit'>Logout</a></li></c:if>
            </ul>
        </nav>
    </div>
</header>