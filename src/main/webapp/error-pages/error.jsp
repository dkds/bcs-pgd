<%--
    Document   : error
    Created on : Jan 7, 2015, 9:06:42 PM
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
        <title>Error</title>
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
                        <h3>Something is wrong</h3>
                        <p>Sorry, something seems to be wrong with store's servers.</p>
                        <script>
                            $(document).ready(function () {
                                var counter = 20;
                                var interval = setInterval(function () {
                                    counter--;
                                    $("#sec_count").html("after " + counter + " seconds");
                                    if (counter === 1) {
                                        $("#sec_count").html("now");
                                        clearInterval(interval);
                                        location.reload();
                                    }
                                }, 1000);
                            });
                        </script>
                        <p>This page will retry the server <span id="sec_count">after 20 seconds</span> </p>
                        <p>You may try <a href="javascript:location.reload();">reloading now</a>.</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
