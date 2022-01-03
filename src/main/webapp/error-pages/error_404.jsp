<%--
    Document   : error_404
    Created on : Jan 7, 2015, 9:54:45 PM
    Author     : neo
--%>

<%@page import="com.neo.util.AppConst"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="./images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="./tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="./styles/common.css"/>
        <script src="./scripts/util.js"></script>
        <title>Page not found</title>
    </head>
    <body>
        <div class="container">
            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <a href="./home.jsp">
                            <img class="brand-logo" src="<%=AppConst.Application.BRANDING_LOGO%>" alt="Logo" width="190" height="60">
                        </a>
                    </div>
                    <div class="col-xs-12">
                        <h3>Page not found</h3>
                        <p>Sorry, page you requested is not available in store's servers.</p>
                        <p>Try going <a href="javascript:window.history.back();">back</a> or visit the <a href="./home.jsp">store home</a> and search from there.</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
