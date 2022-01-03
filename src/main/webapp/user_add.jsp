<%--
    Document   : user_signup
    Created on : Nov 25, 2014, 10:01:23 PM
    Author     : Neo
--%>

<%@page import="com.neo.beans.user.SecurityQuestion"%>
<%@page import="com.neo.util.ResponseMessage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <link rel="stylesheet" href="tools/font-awesome/css/font-awesome.min.css">
        <script src="scripts/util.js"></script>
        <script src="scripts/jquery/jquery.form.js"></script>
        <%
            boolean editing = request.getParameter("edit") != null && request.getParameter("edit").equals("true");
            User usr = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
            if (editing && (usr == null || usr.isGuest())) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
            boolean admin = usr != null && usr.isAdmin();
            String uid = request.getParameter(AppConst.User.PARA_UID);
            if (admin && uid != null) {
                usr = AppUtil.viewUser(request, uid);
            }
        %>
        <title><%=(editing ? "Edit details" : "Sign up")%> | IDEALStore.com</title>
        <script>

            $(document).ready(function () {

                $(".progress").hide();

                $("#avatar").change(function () {
                    var files = $(this).prop("files");
                    if (files !== undefined) {
                        openImage(files[0], $("#img-avatar-user").get(0));
                        var form = $("#form_img_upload");
                        form.append($("#avatar"));
                        var options = {
                            beforeSend: function () {
                                $(".progress").toggle();
                                setProgress("start");
                            },
                            uploadProgress: function (event, position, total, percentComplete) {
                                setProgress(percentComplete);
                            },
                            success: function (data) {
                                setProgress(100);
                                $(".progress").toggle();
                                $("#img-avatar-user").attr("src", "<%=(AppConst.Image.REQUEST_IMAGE_USER)%>" + data);
                                $("#avatar_name").val(data);
                            },
                            complete: function (response) {
                                setProgress("success");
                            },
                            error: function () {
                                setProgress("error");
                            }
                        };
                        form.ajaxForm(options);
                        form.submit();
                    }
                });

                $("#img-avatar-generic-female").click(function () {
                    $("#avatar-generic-female").click();
                });

                $("#img-avatar-generic-male").click(function () {
                    $("#avatar-generic-male").click();
                });

                $("#img-avatar-user").click(function () {
                    $("#avatar").click();
                    $("#avatar-user").click();
                });

                $("#buyer").click(function (evt) {
                    if (!$("#seller").is(":checked")) {
                        evt.stopPropagation();
                        return false;
                    }
                });

                $("#seller").click(function (evt) {
                    if (!$("#buyer").is(":checked")) {
                        evt.stopPropagation();
                        return false;
                    }
                });

                $("#email").keyup(function (evt) {
                    var value = $(this).val();
                    if (value.trim() !== "") {
                        checkParameter(evt, {<%=AppConst.User.AJAX_CHECK_EMAIL%>: value}
                        , "<%=AppConst.User.STATUS_SIGN_UP_CHECK_EMAIL_VALID%>", "feedback_email");
                    } else {
                        toggleInputFeedback("feedback_email", false);
                    }
                });

                $("#username").keyup(function (evt) {
                    var value = $(this).val();
                    if (value.trim().length >= 5) {
                        checkParameter(evt, {<%=AppConst.User.AJAX_CHECK_USERNAME%>: value}
                        , "<%=AppConst.User.STATUS_SIGN_UP_CHECK_USERNAME_VALID%>", "feedback_username");
                    } else {
                        toggleInputFeedback("feedback_username", false);
                    }
                });

                $("#password_new,#password_confirm").on("copy", function () {
                    return false;
                }).on("paste", function () {
                    return false;
                }).on("contextmenu", function () {
                    return false;
                }).keydown(function (evt) {
                    if (evt.ctrlKey) {
                        return;
                    }
                    var value = $(this).val();
                    if (!isTextSelected($(this))
                            && !isEssentialKey(evt.keyCode)
                            && (value.trim().length >= 15)) {
                        evt.stopPropagation();
                        return false;
                    }
                }).keyup(function (evt) {
                    if ($(this).is($("#password_new"))) {
                        var value = $(this).val();
                        if (value.trim().length >= 5) {
                            checkParameter(evt, {<%=AppConst.User.AJAX_CHECK_PASSWORD_NEW%>: value}
                            , "<%=AppConst.User.STATUS_SIGN_UP_CHECK_PASSWORD_NEW_VALID%>", "feedback_password_new");
                        } else {
                            toggleInputFeedback("feedback_password_new", false);
                        }
                    } else if ($(this).is($("#password_confirm"))) {
                        if ($("#password_new").val() !== $("#password_confirm").val()) {
                            toggleInputFeedback("feedback_password_confirm", true, false);
                        } else {
                            toggleInputFeedback("feedback_password_confirm", true, true);
                            setTimeout(function () {
                                toggleInputFeedback("feedback_password_confirm", false);
                            }, 2000);
                        }
                    }
                });
            });


            var paramCheckerTimeout;
            function checkParameter(evt, data, valid, feedback_id) {
                if (evt.keyCode === 8 || !isEssentialKey(evt.keyCode)) {
                    if (paramCheckerTimeout !== undefined) {
                        clearTimeout(paramCheckerTimeout);
                    }
                    paramCheckerTimeout = setTimeout(function () {
                        toggleInputFeedback(feedback_id, true);
                        $.post("SerUsrMng", data, function (data, status) {
                            if (status === "success") {
                                if (data === valid) {
                                    toggleInputFeedback(feedback_id, true, true);
                                } else {
                                    toggleInputFeedback(feedback_id, true, false, data);
                                }
                            } else {
                                toggleInputFeedback(feedback_id, false);
                            }
                        });
                    }, 1000);
                }
            }

            function toggleInputFeedback(feedback_id, visible, success, message) {
                $("#" + feedback_id)
                        .removeClass("fa")
                        .removeClass("fa-circle-o-notch")
                        .removeClass("fa-spin")
                        .removeClass("fa-ban")
                        .removeClass("glyphicon")
                        .removeClass("glyphicon-ok")
                        .removeClass("glyphicon-remove")
                        .parent().removeClass("has-error").attr("title", "");
                if (visible) {
                    if (success === undefined) {
                        $("#" + feedback_id)
                                .addClass("fa")
                                .addClass("fa-circle-o-notch")
                                .addClass("fa-spin");
                    } else if (success) {
                        $("#" + feedback_id)
                                .addClass("glyphicon")
                                .addClass("glyphicon-ok");
                        setTimeout(function () {
                            toggleInputFeedback(feedback_id, false);
                        }, 2000);
                    } else {
                        $("#" + feedback_id)
                                .addClass("fa")
                                .addClass("fa-ban")
                                .parent().addClass("has-error").attr("title", message);
                    }
                }
            }


            function setProgress(value) {
                var printProgress = true;
                if (value === "start") {
                    setMessage("File upload in progress !");
                    $(".progress-bar").addClass("progress-bar-info");
                    $(".progress-bar").addClass("active");
                    $(".progress-bar").removeClass("progress-bar-success");
                    $(".progress-bar").removeClass("progress-bar-danger");
                    value = 1;
                } else if (value === "success") {
                    setMessage("File uploaded successfully !");
                    $(".progress-bar").addClass("progress-bar-success");
                    $(".progress-bar").removeClass("progress-bar-info");
                    $(".progress-bar").removeClass("active");
                    value = 100;
                } else if (value === "error") {
                    setMessage("Error !");
                    $(".progress-bar").addClass(".progress-bar-danger");
                    $(".progress-bar").removeClass("progress-bar-info");
                    $(".progress-bar").removeClass("active");
                    printProgress = false;
                }
                if (printProgress) {
                    $(".progress-bar").html(value + "%");
                    $(".progress-bar").css("width", value + "%");
                }
            }

            function setMessage(text) {
                console.log(text);
            }

        </script>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            if (usr != null) {
                user = usr;
            }
            boolean error = false;
            if (message.getStatus() == ResponseStatus.ERROR) {
                error = true;
                user = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER_TEMP);
//                out.print("Error");
            }
            if (!error && !user.isGuest() && !editing) {
                response.sendRedirect(response.encodeRedirectURL("user_profile.jsp"));
                return;
            }
        %>
        <div class="container">
            <%
                if (editing) {
            %>
            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="user_profile.jsp"><%=user.getUsername()%>'s store</a></li>
                    <li><span>Change user details</span></li>
                </ul>
            </div>
            <%
                }
            %>
            <div class="card">
                <h3><%=(editing || error ? "Edit details" : "Sign up")%></h3>
                <br>
                <form id="form_img_upload" action="SerImgMng" method="POST" enctype="multipart/form-data">
                    <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_USER%>">
                </form>
                <form class="form-horizontal" role="form" action="<%=(editing ? (usr != null ? "SerUsrMng" : "SerAdminMng") : "SerUsrMng")%>" method="POST">
                    <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=(editing && !error ? AppConst.User.REQUEST_TYPE_UPDATE_USER : AppConst.User.REQUEST_TYPE_SIGN_UP)%>">
                    <input hidden id="current_location" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" value="">
                    <%
                        if (editing && usr != null) {
                    %>
                    <input hidden  name="<%=AppConst.Admin.PARA_USER_UID%>" value="<%=user.getUid()%>">
                    <%
                        }
                    %>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="email">
                            Email Address <span class="text-danger">*</span><br>
                            <span class="subtext">
                                (essential details for you
                                will be sent here.
                                For our use only, no spam)
                            </span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4  has-feedback">
                            <input class="form-control input-sm " <%=(editing ? "readonly" : "")%> type="email" name="<%=AppConst.User.PARA_EMAIL%>" id="email" value="<%=(editing || error ? user.getEmail() : "")%>" required tabindex="1">
                            <span id="feedback_email" class="form-control-feedback"></span>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_EMAIL)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_EMAIL).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_EMAIL).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="username">
                            Username <span class="text-danger">*</span><br>
                            <span class="subtext">
                                (used to identify yourself to
                                other users. min length : 5 chars)
                            </span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 has-feedback">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_USERNAME%>" id="username" value="<%=(editing || error ? user.getUsername() : "")%>"  required tabindex="2">
                            <span id="feedback_username" class="form-control-feedback"></span>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_USERNAME)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_USERNAME).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_USERNAME).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_USERNAME).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <%
                        if (!editing) {
                    %>
                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="password_new">
                            New password <span class="text-danger">*</span><br>
                            <span class="subtext">
                                (min : 5 chars, max : 15 chars)
                            </span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 has-feedback">
                            <input class="form-control input-sm" type="password" name="<%=AppConst.User.PARA_PASSWORD_NEW%>" id="password_new" value=""  required tabindex="3">
                            <span id="feedback_password_new" class="form-control-feedback"></span>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_PASSWORD_NEW)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_PASSWORD_NEW).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_PASSWORD_NEW).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_PASSWORD_NEW).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="password_confirm">
                            Confirm password  <span class="text-danger">*</span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 has-feedback">
                            <input class="form-control input-sm" type="password" name="<%=AppConst.User.PARA_PASSWORD_CONFIRM%>" id="password_confirm" value=""  required tabindex="4">
                            <span id="feedback_password_confirm" class="form-control-feedback"></span>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_PASSWORD_CONFIRM)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_PASSWORD_CONFIRM).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_PASSWORD_CONFIRM).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_PASSWORD_CONFIRM).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="row separator"></div>
                    <%
                        }
                    %>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label">
                            Avatar  <br>
                            <span class="subtext">
                                (used to identify yourself to
                                other users)
                            </span>
                        </label>
                        <div class="col-xs-12 col-sm-9">
                            <div class="avatar-imgs text-center" id="avatar_preview">
                                <img class="img-border" title="click to select" id="img-avatar-user"
                                     src="<%=(editing || error ? user.getUserAvatarBase64() : AppUtil.getBase64Image(
                                       AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                       AppConst.User.AVATAR_NAME_SELECT_IMAGE))%>" width="100" height="100" alt="Select image"/>
                                <br>
                                <input class="hidden" type="file" accept="image/jpeg" id="avatar" name="<%=AppConst.User.PARA_AVATAR_USER_PATH%>" />
                                <input class="hidden" id="avatar_name" name="<%=AppConst.User.PARA_AVATAR_USER_NAME%>" />
                                <div class="progress" style="margin-top: 5px; margin-bottom: 0px; margin-right: 4px;">
                                    <div class="progress-bar progress-bar-striped"></div>
                                </div>
                                <input <%=(editing || error ? (user.isAvatarUser() ? "checked" : "") : "")%> id="avatar-user" value="<%=AppConst.User.PARA_AVATAR_USER%>" type='radio' name='<%=AppConst.User.PARA_AVATAR%>'  tabindex="5">
                            </div>
                            <div class="avatar-imgs text-center" >
                                <img class="img-border" id="img-avatar-generic-female" src="<%=AppUtil.getBase64Image(
                                      AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                      AppConst.User.AVATAR_NAME_GENERIC_FEMALE)%>" width="100" height="100" alt="Test Image"/>
                                <br>
                                <input <%=(editing || error ? (user.isAvatarGenericFemale() ? "checked" : "") : "")%> id="avatar-generic-female" value="<%=AppConst.User.PARA_AVATAR_FEMALE%>" type='radio' name='<%=AppConst.User.PARA_AVATAR%>'  tabindex="5">
                            </div>
                            <div class="avatar-imgs text-center">
                                <img class="img-border" id="img-avatar-generic-male" src="<%=AppUtil.getBase64Image(
                                      AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                      AppConst.User.AVATAR_NAME_GENERIC_MALE)%>" width="100" height="100" alt="Test Image"/>
                                <br>
                                <input <%=(editing || error ? (user.isAvatarGenericMale() ? "checked" : "") : "")%> id="avatar-generic-male" value="<%=AppConst.User.PARA_AVATAR_MALE%>" type='radio' name='<%=AppConst.User.PARA_AVATAR%>'  tabindex="5">
                            </div>
                        </div>
                        <div class="col-xs-3"></div>
                    </div>

                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" style="padding-top: 7px;">
                            What would you do  <span class="text-danger">*</span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="<%=AppConst.User.PARA_USER_TYPE_BUYER%>" id="buyer"  <%=(editing || error ? (user.isBuyer() ? "checked" : "") : "checked")%>  tabindex="6">
                                    Buy items from store
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="<%=AppConst.User.PARA_USER_TYPE_SELLER%>" id="seller"  <%=(editing || error ? (user.isSeller() ? "checked" : "") : "checked")%> tabindex="7">
                                    Sell items on store
                                </label>
                            </div>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_USER_TYPE)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_USER_TYPE).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_USER_TYPE).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_USER_TYPE).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="first_name" >
                            First name
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_NAME_FIRST%>" id="first_name" value="<%=(editing || error ? user.getNameFirst() : "")%>" tabindex="8">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="second_name">
                            Second name
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_NAME_SECOND%>" id="second_name" value="<%=(editing || error ? user.getNameSecond() : "")%>" tabindex="9">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="last_name">
                            Last name
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_NAME_LAST%>" id="last_name" value="<%=(editing || error ? user.getNameLast() : "")%>" tabindex="10">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>

                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="contactno" >
                            Contact no
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="tel" name="<%=AppConst.User.PARA_CONTACT_NO%>" id="contactno" value="<%=(editing || error ? user.getContactNo() : "")%>"  tabindex="11">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>

                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 visible-xs control-label" for="address_line_1">
                            Address
                        </label>
                        <label class="col-xs-12 visible-xs control-label" for="address_line_1">
                            Line 1
                        </label>
                        <label class="col-xs-12 col-sm-3 control-label" for="address_line_1">
                            <span class="hidden-xs">Address Line 1</span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_ADDRESS_LINE_1%>" id="address_line_1" value="<%=(editing || error ? user.getAddressLine1() : "")%>" tabindex="12">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="address_line_2">
                            Line 2
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_ADDRESS_LINE_2%>" id="address_line_2" value="<%=(editing || error ? user.getAddressLine2() : "")%>" tabindex="13">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="address_line_3">
                            Line 3
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_ADDRESS_LINE_3%>" id="address_line_3" value="<%=(editing || error ? user.getAddressLine3() : "")%>" tabindex="14">
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="city">
                            City
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <select class="form-control input-sm" name="<%=AppConst.User.PARA_ADDRESS_CITY%>" id="city" tabindex="15">
                                <option class="disabled"><%=AppConst.User.PARA_VAL_CITY_DEFAULT%></option>
                                <%
                                    for (String city : AppUtil.<String>getConsts(request, AppUtil.ConstType.CITY)) {
                                %>
                                <option <%=(editing || error ? (city.equals(user.getAddressCity()) ? "selected" : "") : "")%>><%=city%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-xs-3"></div>
                    </div>

                    <%
                        if (!editing) {
                    %>
                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="question">
                            Security question  <span class="text-danger">*</span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <select class="form-control input-sm" name="<%=AppConst.User.PARA_QUESTION%>" id="question" required  tabindex="16">
                                <option><%=AppConst.User.PARA_VAL_SECURITY_QUESTION_DEFAULT%></option>
                                <%
                                    for (SecurityQuestion sq : AppUtil.<SecurityQuestion>getConsts(request,
                                                                                                   AppUtil.ConstType.USER_SECURITY_QUESTION)) {
                                %>
                                <option><%=sq.getQuestion()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_QUESTION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_QUESTION).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_QUESTION).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_QUESTION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="answer">
                            Answer   <span class="text-danger">*</span><br>
                            <span class="subtext">
                                (you will be asked to answer
                                above question with this
                                in case of forgotten password)
                            </span>
                        </label>
                        <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.User.PARA_ANSWER%>" id="answer" value="" required  tabindex="17">
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.User.PARA_ANSWER)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert" title="<%=message.getMessage(AppConst.User.PARA_ANSWER).getDescription()%>">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.User.PARA_ANSWER).getDescription()%>"><%=message.getMessage(AppConst.User.PARA_ANSWER).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <%
                        }
                    %>

                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="row">
                        <div class="col-xs-12 text-center">
                            <strong>Note :</strong>  by signing up with us, we consider that you have read and accepted our <a href="privacy_policy.jsp">privacy policy</a> and <a href="terms_and_conditions.jsp">terms</a>.
                        </div>
                    </div>

                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="row">
                        <div class="col-xs-12 text-center">
                            <input class="btn btn-default btn-sm" type="submit" value="<%=(editing || error ? "Update details" : "Sign up")%>"  tabindex="18">
                        </div>
                    </div>

                    <div class="row separator"></div>
                    <div class="row separator"></div>
                </form>
            </div>

        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
