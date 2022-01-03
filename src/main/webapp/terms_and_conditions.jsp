<%--
    Document   : terms_and_conditions
    Created on : Nov 26, 2014, 11:17:31 PM
    Author     : neo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <title>Terms and conditions</title>
    </head>

    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">
            <div class="card">
                <h3>IDEALStore.com terms and conditions</h3>
                <%=appPropertyContainer.getValue(AppConst.Admin.PARA_TERMS_AND_CONDITIONS)%>
            </div>
        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
