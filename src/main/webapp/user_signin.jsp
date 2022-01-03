<%--
    Document   : user_signin
    Created on : Nov 26, 2014, 8:41:39 PM
    Author     : neo
--%>

<%@page import="com.neo.util.ResponseMessage"%>
<%@page import="com.neo.beans.user.User"%>
<%@page import="com.neo.util.AppConst"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <title>Sign in | IDEALStore.com</title>
        <style>

            .recover {
                float: right;
                display: block;
                margin-top: 5px;
                margin-bottom:  5px;
                font-size: x-small;
            }
            .separator-1,.separator-2 {
                display: none;
            }
            @media (min-height: 550px){
                .separator-1 {
                    display: block;
                }
            }
            @media (min-height: 680px){
                .separator-1,.separator-2 {
                    display: block;
                }
            }


        </style>
        <script>
            $(document).ready(function () {
                $("#username").focus();
            });
        </script>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            if (!user.isGuest()) {
                response.sendRedirect(response.encodeRedirectURL("user_profile.jsp"));
                return;
            }
            boolean invalid = false;
            if (message.getStatus() == ResponseStatus.ERROR) {
                invalid = true;
            }
        %>
        <div class="container">
            <div class="card">
                <h3>Sign in</h3>
                <form class="form-horizontal" role="form" action="SerUsrMng" method="POST">
                    <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_SIGN_IN%>">
                    <input hidden id="current_location" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" value="<%=request.getParameter(AppConst.Application.PARA_CURRENT_LOCATION)%>">
                    <div class="separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3  control-label" for="username">
                            Email / Username
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-4">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_USERNAME%>" id="username" value="" >
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="password">
                            Password
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-4">
                            <input class="form-control input-sm" type="password" name="<%=AppConst.User.PARA_PASSWORD%>" id="password" value="" >
                            <a href="#" class="recover">forgot password ?</a>
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-9 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-3 text-right">
                            <div class="checkbox">
                                <label style="color: #777;"><input type="checkbox" name="<%=AppConst.User.PARA_REMEMBER%>" id="signedin"  checked/>stay signed in</label>
                            </div>
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div style="height: 20px;"></div>
                    <div class="row" >
                        <div class="col-xs-9 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-3 text-right">
                            <input class="btn btn-default btn-sm" style="padding-right: 35px; padding-left: 35px;" type="submit" value="Sign in">
                        </div>
                        <%
                            if (invalid && !message.isEmpty(AppConst.User.STATUS_SIGN_IN_ERROR)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.STATUS_SIGN_IN_ERROR).getDescription()%>"><%=message.getMessage(AppConst.User.STATUS_SIGN_IN_ERROR).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </form>
                <div class="separator"></div>
            </div>
        </div>
        <div class="separator separator-1"></div>
        <div class="separator separator-2"></div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
