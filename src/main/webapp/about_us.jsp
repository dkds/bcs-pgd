<%--
    Document   : about_us
    Created on : Nov 26, 2014, 11:17:31 PM
    Author     : neo
--%>

<%@page import="com.neo.util.AppPropertyContainer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="tools/jquery-ui/jquery-ui.structure.min.css"/>
        <link rel="stylesheet" type="text/css" href="tools/jquery-ui/jquery-ui.theme.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <script src="tools/jquery-ui/jquery-ui.min.js"></script>
        <title>About us</title>
    </head>

    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">
            <div class="card">
                <h3>IDEALStore.com about us</h3>
                <br>
                <p><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_DESCRIPTION)%></p>
                <br>
                <br>
                <p>Corporate Information</p>
                <p><br>
                    <strong>Headquarters: </strong><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_ADDRESS)%><br>
                    <strong>Year Started: </strong><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_START_YEAR)%><br>
                    <strong>Number of Employees: </strong><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_EMPLOYEE_COUNT)%></p>
                <p><br>
                    <strong>Our Vision</strong></p>
                <p><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_COMPANY_VISION)%></p>
            </div>
        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
