<%--
    Document   : user_change_security
    Created on : Nov 30, 2014, 3:44:36 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.user.SecurityQuestion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <%
            User usr = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
            if (usr == null || usr.isGuest()) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
            boolean admin = usr.isAdmin();
            String uid = request.getParameter(AppConst.User.PARA_UID);
            if (admin && uid != null) {
                usr = AppUtil.viewUser(request, uid);
            }
        %>
        <title>Security | IDEALStore.com</title>
        <script>

            $(document).ready(function () {

                $("#form_chng_pswd").submit(function () {
                    $("#chng_pswd_password_current").val($("#password_current").val());
                });

                $("#form_chng_sec_q").submit(function () {
                    $("#chng_sec_q_password_current").val($("#password_current").val());
                });
            });

        </script>
        <style>
            .btn-change {
                margin-top: 0px;
            }
            .spacer {
                height: 15px;
            }
            /*            @media (max-width: 470px){
                            .alert-text-btn {
                                padding: 0 15px 0 15px;
                            }
                        }*/

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            if (usr != null) {
                user = usr;
            }
            boolean error = false;
            boolean success = false;
            if (message.getStatus() == ResponseStatus.ERROR) {
                error = true;
            } else if (message.getStatus() == ResponseStatus.SUCCESS) {
                success = true;
            }
        %>
        <div class="container">

            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="user_profile.jsp"><%=user.getUsername()%>'s store</a></li>
                    <li><span>Change security details</span></li>
                </ul>
            </div>


            <div class="card">
                <h3>Security options</h3>
                <br>
                Please enter your current password below in order to verify your identity.
                <br>
                <form class="form-horizontal" id="form_cur_pass" role="form" >
                    <div class="spacer"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="password_current">
                            Current password
                        </label>
                        <div class="col-xs-7 col-sm-5 col-md-4">
                            <input class="form-control input-sm" type="password" name="password" id="password_current" value="" >
                        </div>
                        <div class="col-xs-3"></div>
                        <%    if (error && !message.isEmpty(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text"  title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER).getDescription()%>"><%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </form>
            </div>

            <div class="card">
                <div class="row card-header-container">
                    <div class="col-xs-12">
                        <span class="card-header">Change your password</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <form class="form-horizontal" id="form_chng_pswd" role="form" action="<%=((usr != null) ? "SerUsrMng" : "SerAdminMng")%>" method="POST">
                            <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD%>">
                            <input hidden name="<%=AppConst.User.PARA_PASSWORD%>" id="chng_pswd_password_current" value="" >
                            <%
                                if (usr != null) {
                            %>
                            <input hidden  name="<%=AppConst.Admin.PARA_USER_UID%>" value="<%=user.getUid()%>">
                            <%
                                }
                            %>

                            <div class="spacer"></div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3  control-label" for="password_new">
                                    New password
                                </label>
                                <div class="col-xs-7 col-sm-5 col-md-4">
                                    <input class="form-control input-sm" type="password" name="<%=AppConst.User.PARA_PASSWORD_NEW%>" id="password_new" value="" >
                                </div>
                                <div class="col-xs-3"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="password_confirm">
                                    Confirm password
                                </label>
                                <div class="col-xs-7 col-sm-5 col-md-4">
                                    <input class="form-control input-sm" type="password" name="<%=AppConst.User.PARA_PASSWORD_CONFIRM%>" id="password_confirm" value="" >
                                </div>
                                <div class="col-xs-3"></div>
                            </div>
                            <div class="row" >
                                <div class="col-xs-12 col-sm-5 col-sm-push-3">
                                    <input class="btn btn-default btn-sm btn-change" type="submit" value="Change">
                                </div>

                                <%
                                    if ((error || success) && !message.isEmpty(
                                            AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD)) {
                                %>
                                <div class="alert <%=(error ? "alert-danger" : "alert-success")%> alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD).getDescription()%>">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <p class="alert-text" title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD).getDescription()%>"><%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD).getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="spacer"></div>
                        </form>
                    </div>
                </div>
            </div>


            <div class="card">
                <div class="row card-header-container">
                    <div class="col-xs-12">
                        <span class="card-header">Change your security question</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <form class="form-horizontal" id="form_chng_sec_q" role="form" action="<%=((usr != null) ? "SerUsrMng" : "SerAdminMng")%>" method="POST">
                            <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION%>">
                            <input hidden name="<%=AppConst.User.PARA_PASSWORD%>" id="chng_sec_q_password_current" value="" >
                            <%
                                if (usr != null) {
                            %>
                            <input hidden  name="<%=AppConst.Admin.PARA_USER_UID%>" value="<%=user.getUid()%>">
                            <%
                                }
                            %>
                            <div class="spacer"></div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="question">
                                    Security question
                                </label>
                                <div class=" col-xs-8 col-sm-6">
                                    <select class="form-control input-sm" name="question" id="question">
                                        <option><%=AppConst.User.PARA_VAL_UPDATE_SECURITY_QUESTION_DEFAULT%></option>
                                        <%                for (SecurityQuestion sq : AppUtil.<SecurityQuestion>getConsts(request,
                                                                                                           AppUtil.ConstType.USER_SECURITY_QUESTION)) {
                                        %>
                                        <option><%=sq.getQuestion()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-xs-3"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="answer">
                                    Answer <br>
                                    <span class="subtext">
                                        (you will be asked to answer
                                        above question with this
                                        in case of forgotten password)
                                    </span>
                                </label>
                                <div class="col-xs-8 col-sm-6 ">
                                    <input class="form-control input-sm" placeholder="- Unchanged -" type="text" name="answer" id="answer" value="">

                                </div>
                                <div class="col-xs-3"></div>
                            </div>
                            <div class="row" >
                                <div class="col-xs-12 col-sm-5 col-sm-push-3">
                                    <input class="btn btn-default btn-sm btn-change" type="submit" value="Change">
                                </div>
                                <%
                                    if ((error || success) && !message.isEmpty(
                                            AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION)) {
                                %>
                                <div class="alert <%=(error ? "alert-danger" : "alert-success")%> alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION).getDescription()%>">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <p class="alert-text" title="<%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION).getDescription()%>"><%=message.getMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION).getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="spacer"></div>
                        </form>
                    </div>
                </div>
            </div>




        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
