<%--
    Document   : notifications_add
    Created on : Nov 30, 2014, 1:45:15 PM
    Author     : neo
--%>

<%@page import="com.neo.util.AppUtil.ConstType"%>
<%@page import="com.neo.beans.user.Subject"%>
<%@page import="com.neo.beans.item.Item"%>
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
        %>
        <title>Contact others | IDEALStore.com</title>
        <style>


            .highlight-header {
                color: #000;
            }
            /*
                        .item-img-container {
                            height:  110px;
                        }*/
            .item:hover {
                background-color: #f5f5f5;
            }
            .item-name {
                display: block;
                font-size: 17px;
                margin-bottom: 5px;
            }
            .item-subdata {
                font-size: smaller;
            }
            .highlight {
                color: #000;
            }
            .item-list-container {
                max-height: 800px;
                overflow-y: auto;
            }
            .message-types {
                margin-bottom: 10px;
            }
            @media (min-width: 767px) {
                /*                .item-img-container {
                                    width: 115px;
                                }*/
                .message-types {
                    margin-bottom: 0px;
                }
                .btn-send-message {
                    float: right;
                }
                .item-list-container {
                    max-height: 500px;
                    overflow-y: auto;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">


            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="user_profile.jsp"><%=user.getUsername()%>'s store</a></li>
                    <li><span>Send message</span></li>
                </ul>
            </div>




            <%                int msgCount = 0;
                Item[] boughtItems = user.getItems(Container.BOUGHT);
                Item[] soldItems = user.getItems(Container.SOLD);
            %>


            <div class="card">


                <div class="row card-header-container">
                    <div class="col-xs-8">
                        <span class="card-header">Contact your sellers</span>
                    </div>
                    <div class="col-xs-4" style="margin-bottom: 5px;">
                        <div class="btn-toolbar pull-right">
                            <div class="input-group">
                                <select class="form-control input-sm pull-right" style="width: auto;display: inline-block;">
                                    <option>most recent first</option>
                                    <option>oldest first</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>


                <%
                    if (boughtItems.length > 0) {
                %>

                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">

                            <%
                                for (Item item : boughtItems) {
                                    msgCount++;
                            %>

                            <div class="list-group-item item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-sm-4">
                                        <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                            <img class="img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                 style="max-height: 140px; max-width: 185px;">
                                        </a>
                                    </div>
                                    <div class="col-sm-8">
                                        <span style="display: block;">
                                            <span class="item-subdata">referenced product (bought on <%=item.getCreateTimeFormatted()%>)</span>
                                        </span>
                                        <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                            <span class="item-name"><%=item.getName()%></span>
                                        </a>
                                        <span style="display: block; margin-bottom: 5px;"><%=item.getSeller().getUsername()%></span>
                                    </div>

                                    <div class="col-xs-12" style="margin-top: 15px;">
                                        <form class="form-horizontal" role="form" action="SerUsrMng" method="POST">
                                            <input type="hidden" name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_MESSAGE_NEW%>" />
                                            <input type="hidden" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" />
                                            <input type="hidden" name="<%=AppConst.User.PARA_MESSAGE_ITEM_UID%>" value="<%=item.getUid()%>" />
                                            <input type="hidden" name="<%=AppConst.User.PARA_MESSAGE_TO_USER_UID%>" value="<%=item.getSeller().getUid()%>" />
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 message-types">
                                                    <%
                                                        for (Subject subject : AppUtil.<Subject>getConsts(request,
                                                                                                          ConstType.MESSAGE_SUBJECT_BUYERS)) {
                                                    %>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="<%=AppConst.User.PARA_MESSAGE_SUBJECT%>" value="<%=subject.hashCode()%>" checked/>
                                                            <%=subject.getName()%>
                                                        </label>
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                                <div class="col-xs-12 col-sm-8" style="margin-top: 10px;">
                                                    <script>

                                                        $(document).ready(function () {
                                                            $("#message_<%=msgCount%>").change(function () {
                                                                $("#message_char_count_<%=msgCount%>").text("(" + $(this).val().length + " / " + max_message_char_count + ")");
                                                                return check($(this).val().length);
                                                            });

                                                            $("#message_<%=msgCount%>").keyup(function () {
                                                                $("#message_<%=msgCount%>").change();
                                                            });
                                                        });

                                                        var max_message_char_count = 180;
                                                        function check(length) {
                                                            if (length >= max_message_char_count) {
                                                                return false;
                                                            }
                                                            return true;
                                                        }


                                                    </script>
                                                    <textarea class="form-control input-sm" maxlength="180" name="<%=AppConst.User.PARA_MESSAGE_TEXT%>" <%=("id='message_" + msgCount + "'")%>
                                                              rows="4" style=" width: 100%; resize: vertical;" placeholder="message"></textarea>
                                                    <span  <%=("id='message_char_count_" + msgCount + "'")%> class="subtext pull-right" style="display: block;">(0 / 180)</span>
                                                    <br>
                                                    <span  style="display: block; margin-top: 10px;" class=" btn-send-message">
                                                        <button class="btn btn-default btn-sm">
                                                            <span class="glyphicon glyphicon-send"></span> send message
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>



                                        </form>


                                    </div>
                                </div>
                            </div>

                            <%
                                }
                            %>




                        </div>
                    </div>
                </div>

                <%
                    }
                %>

            </div>




            <div class="card">


                <div class="row card-header-container">
                    <div class="col-xs-8">
                        <span class="card-header">Contact your buyers</span>
                    </div>
                    <div class="col-xs-4" style="margin-bottom: 5px;">
                        <div class="btn-toolbar pull-right">
                            <div class="input-group">
                                <select class="form-control input-sm pull-right" style="width: auto;display: inline-block;">
                                    <option>most recent first</option>
                                    <option>oldest first</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>


                <%
                    if (soldItems.length > 0) {
                %>

                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">

                            <%
                                for (Item item : soldItems) {
                                    msgCount++;
                            %>

                            <div class="list-group-item item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-sm-4">
                                        <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                            <img class="img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                 style="max-height: 140px; max-width: 185px;">
                                        </a>
                                    </div>
                                    <div class="col-sm-8">
                                        <span style="display: block;">
                                            <span class="item-subdata">referenced product (sold on <%=item.getCreateTimeFormatted()%>)</span>
                                        </span>
                                        <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                            <span class="item-name"><%=item.getName()%></span>
                                        </a>
                                        <span style="display: block; margin-bottom: 5px;"><%=item.getBuyer().getUsername()%></span>
                                    </div>

                                    <div class="col-xs-12" style="margin-top: 15px;">
                                        <form class="form-horizontal" role="form" action="SerUsrMng" method="POST">
                                            <input type="hidden" name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_MESSAGE_NEW%>" />
                                            <input type="hidden" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" />
                                            <input type="hidden" name="<%=AppConst.User.PARA_MESSAGE_ITEM_UID%>" value="<%=item.getUid()%>" />
                                            <input type="hidden" name="<%=AppConst.User.PARA_MESSAGE_TO_USER_UID%>" value="<%=item.getBuyer().getUid()%>" />
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 message-types">
                                                    <%
                                                        for (Subject subject : AppUtil.<Subject>getConsts(request,
                                                                                                          ConstType.MESSAGE_SUBJECT_SELLERS)) {
                                                    %>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="<%=AppConst.User.PARA_MESSAGE_SUBJECT%>" value="<%=subject.hashCode()%>" checked/>
                                                            <%=subject.getName()%>
                                                        </label>
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                                <div class="col-xs-12 col-sm-8" style="margin-top: 10px;">
                                                    <script>

                                                        $(document).ready(function () {
                                                            $("#message_<%=msgCount%>").change(function () {
                                                                $("#message_char_count_<%=msgCount%>").text("(" + $(this).val().length + " / " + max_message_char_count + ")");
                                                                return check($(this).val().length);
                                                            });

                                                            $("#message_<%=msgCount%>").keyup(function () {
                                                                $("#message_<%=msgCount%>").change();
                                                            });
                                                        });


                                                        var max_message_char_count = 180;
                                                        function check(length) {
                                                            if (length >= max_message_char_count) {
                                                                return false;
                                                            }
                                                            return true;
                                                        }


                                                    </script>
                                                    <textarea class="form-control input-sm" maxlength="180" name="<%=AppConst.User.PARA_MESSAGE_TEXT%>" <%=("id='message_" + msgCount + "'")%>
                                                              rows="4" style=" width: 100%; resize: vertical;" placeholder="message"></textarea>
                                                    <span  <%=("id='message_char_count_" + msgCount + "'")%> class="subtext pull-right" style="display: block;">(0 / 180)</span>
                                                    <br>
                                                    <span  style="display: block; margin-top: 10px;" class=" btn-send-message">
                                                        <button class="btn btn-default btn-sm">
                                                            <span class="glyphicon glyphicon-send"></span> send message
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>



                                        </form>


                                    </div>
                                </div>
                            </div>

                            <%
                                }
                            %>




                        </div>
                    </div>
                </div>

                <%
                    }
                %>

            </div>






            <div class="card">


                <div class="row card-header-container">
                    <div class="col-xs-12">
                        <span class="card-header">Contact IDEALStore.com administrators</span>
                    </div>
                </div>



                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">



                            <div class="list-group-item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-xs-12 col-sm-10">
                                        <form class="form-horizontal" role="form" action="SerUsrMng" method="POST">
                                            <input type="hidden" name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_MESSAGE_NEW%>" />
                                            <input type="hidden" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" />
                                            <div class="col-xs-12 col-sm-7">
                                                <script>

                                                    $(document).ready(function () {
                                                        $("#message_admin").change(function () {
                                                            $("#message_char_count_admin").text("(" + $(this).val().length + " / " + max_message_char_count + ")");
                                                            return check($(this).val().length);
                                                        });

                                                        $("#message_admin").keyup(function () {
                                                            $("#message_admin").change();
                                                        });
                                                    });


                                                    var max_message_char_count = 180;
                                                    function check(length) {
                                                        if (length >= max_message_char_count) {
                                                            return false;
                                                        }
                                                        return true;
                                                    }


                                                </script>
                                                <textarea class="form-control input-sm" maxlength="180" name="<%=AppConst.User.PARA_MESSAGE_TEXT%>" id="message_admin"
                                                          rows="4" style=" width: 100%; resize: vertical;" placeholder="message"></textarea>
                                                <span id="message_char_count_admin" class="subtext pull-right" style="display: block;">(0 / 180)</span>
                                                <br>
                                                <span  style="display: block; margin-top: 10px;" class=" btn-send-message">
                                                    <button class="btn btn-default btn-sm">
                                                        <span class="glyphicon glyphicon-send"></span> send message
                                                    </button>
                                                </span>
                                            </div>


                                        </form>

                                    </div>
                                </div>
                            </div>




                        </div>
                    </div>
                </div>
            </div>





        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
