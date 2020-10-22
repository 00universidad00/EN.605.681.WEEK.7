<%--Include css files from assets--%>
<link rel="stylesheet" href="assets/css/bulma.min.css">
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/normalize.css">
<link rel="stylesheet" href="assets/vendors/fontawesome-5.15.0/css/all.css">
<link rel="stylesheet" href="assets/vendors/bulma-calendar-6.0.0/css/bulma-calendar.min.css">
<%--Include js files from assets--%>
<script src="assets/vendors/bulma-calendar-6.0.0/js/bulma-calendar.js"></script>
<%--Include page components--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--choose to display the home page or calculator based on user choice--%>
<c:choose>
    <c:when test="${display_calculator==true}">
        <jsp:include page="view/calculator/calculator.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="view/home/header.jsp"/>
        <jsp:include page="view/home/hero.jsp"/>
        <jsp:include page="view/home/tours.jsp"/>
        <jsp:include page="view/home/prices.jsp"/>
        <jsp:include page="view/home/info.jsp"/>
        <jsp:include page="view/home/footer.jsp"/>
    </c:otherwise>
</c:choose>
