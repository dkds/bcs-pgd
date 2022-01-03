<%--
    Document   : user_profile
    Created on : Nov 26, 2014, 11:17:31 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.user.MessageBox"%>
<%@page import="com.neo.beans.user.Message"%>
<%@page import="com.neo.beans.item.Container"%>
<%@page import="com.neo.beans.item.Item"%>
<%@page import="com.neo.beans.user.User"%>
<%@page import="com.neo.util.AppConst"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="tools/pnotify/pnotify.custom.min.css">
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/jquery/jquery-2.1.1.min.js"></script>
        <script src="scripts/util.js"></script>
        <script src="tools/pnotify/pnotify.custom.min.js"></script>
        <%
            User usr = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
            if (usr == null) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
            boolean admin = usr.isAdmin();
            String uid = request.getParameter(AppConst.User.PARA_UID);
            if (admin && uid != null) {
                usr = AppUtil.viewUser(request, uid);
            }
        %>
        <title><%=(admin ? usr.getUsername() + "'s" : "My")%> store | IDEALStore.com</title>
        <script>

            $(document).ready(function () {

                $("[id^='qty_edit_']").hide();
                $("[id^='review_edit_']").hide();
                $("[id^='collapsed_notif_'],[id^='notif_'],#outbox_container").hide();
                checkNotifSelection();

                $(window).resize(function () {
                    if ($(this).width() > 767 && $("[id^='collapsed_notif_'],[id^='notif_']").is(":visible")) {
                        $("[id^='collapsed_notif_'],[id^='notif_']").hide();
                    }
                });

                $(function () {
                    $("[data-toggle='popover']").popover();
                });

                $('#draft_remove_confirm').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var item_description = button.data('item-description');
                    var item_uid = button.data('item-uid');
                    var modal = $(this);
                    modal.find('#draft_remove_item_uid').val(item_uid);
                    modal.find('#draft_remove_item_description').html(item_description);
                    $("#draft_remove_btn_ok").html("Yes, remove it");
                    $("#draft_remove_btn_cancel, #draft_remove_btn_ok").removeClass("disabled");
                    $("#draft_remove_confirm_header").html("Confirm");
                });

                $(".notification.unread").click(function () {
                    var msgId = "" + $(this).children("[name='msg_id']").val();
                    $.post("SerUsrMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: '<%=AppConst.User.REQUEST_TYPE_MESSAGE_SET_READ%>',
            <%=AppConst.User.PARA_MESSAGE_ID%>:msgId
                    }, function (data, status) {
                        if (status === "success" && data === "<%=AppConst.User.STATUS_MESSAGE_SAVE_SUCCESS%>") {
                            $(this).removeClass("unread");
                        }
                    });
                });
            });

            function showEditQty(i) {
                $("#qty_edit_" + i).toggle();
            }

            function showEditReview(i) {
                $("#review_edit_" + i).toggle();
            }

            function scrollToStock() {
                $('html,body').animate({scrollTop: $("#item_stock").offset().top - 20});
            }

            function scrollToBoughtItems() {
                $('html,body').animate({scrollTop: $("#buying_history").offset().top - 20});
            }

            function scrollToSoldItems() {
                $('html,body').animate({scrollTop: $("#selling_history").offset().top - 20});
            }

            function toggleSelection(notif) {
                if ($(notif).hasClass("selected")) {
                    $(notif).removeClass("selected");
                } else {
                    $(notif).addClass("selected");
                }
                checkNotifSelection();
                console.log("toggoled");
            }

            function checkNotifSelection() {
                var inbox = $("#inbox_container").is(":visible");
                console.log($("#inbox_container").find("input:checkbox:checked").length);
                if (inbox) {
                    if ($("#inbox_container").find("input:checkbox:checked").length === 0) {
                        $("#btn_delete_messages").addClass("disabled");
                    } else {
                        $("#btn_delete_messages").removeClass("disabled");
                    }
                } else {
                    if ($("#outbox_container").find("input:checkbox:checked").length === 0) {
                        $("#btn_delete_messages").addClass("disabled");
                    } else {
                        $("#btn_delete_messages").removeClass("disabled");
                    }
                }
            }

            function toggleNotifications(type) {
                var inbox = $("#inbox_container").is(":visible");
                var notif;
                if (inbox) {
                    notif = $("#notif_store_inbox");
                    if (type === "store") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_store_inbox");
                        } else {
                            notif = $("#notif_store_inbox");
                        }
                    } else if (type === "sellers") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_sellers_inbox");
                        } else {
                            notif = $("#notif_sellers_inbox");
                        }
                    } else if (type === "buyers") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_buyers_inbox");
                        } else {
                            notif = $("#notif_buyers_inbox");
                        }
                    }
                } else {
                    notif = $("#notif_store_outbox");
                    if (type === "store") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_store_outbox");
                        } else {
                            notif = $("#notif_store_outbox");
                        }
                    } else if (type === "sellers") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_sellers_outbox");
                        } else {
                            notif = $("#notif_sellers_outbox");
                        }
                    } else if (type === "buyers") {
                        if ($(window).width() < 768) {
                            notif = $("#collapsed_notif_buyers_outbox");
                        } else {
                            notif = $("#notif_buyers_outbox");
                        }
                    }
                }
                $("[id^='collapsed_notif_'],[id^='notif_']").not($(notif)).hide();
                $(notif).toggle();
                checkNotifSelection();
                console.log("toggoled");
            }

            function changeMessageBox(box) {
                if (box === 'inbox') {
                    $("#outbox_container").hide();
                    $("#inbox_container").show();
                } else if (box === 'outbox') {
                    $("#inbox_container").hide();
                    $("#outbox_container").show();
                }
                checkNotifSelection();
            }

            function loadDraft(item_uid) {
                location.href = "product_add.jsp?uid=" + item_uid + "&edit=true&draft=true";
            }

            function removeDraft(item_uid) {
                $("#draft_remove_confirm_header").html("Removing ...");
                $("#draft_remove_btn_cancel, #draft_remove_btn_ok").addClass("disabled");
                $.post("SerItmMng",
                        {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Item.REQUEST_TYPE_REMOVE_DRAFT%>",
            <%=AppConst.Item.PARA_UID%>: item_uid
                        },
                        function (data, status) {
                            if (status === "success" && data !== "<%=AppConst.Item.STATUS_DRAFT_REMOVE_ERROR%>") {
                                $("#draft_remove_confirm").modal('hide');
                                reloadDrafts($.parseJSON(data));
                            } else {
                                $("#draft_remove_btn_cancel, #draft_remove_btn_ok").removeClass("disabled");
                                $("#draft_remove_btn_ok").html("Try again");
                                $("#draft_remove_confirm_header").html("Error");
                            }
                        });
            }

            function refresh() {
                location.reload();
            }

            function reloadDrafts(items) {
                if (items === undefined || items === null || items.length === 0) {
                    $("#draft_container").hide();
                    return;
                }
                var draftTable = $("#draft_table");
                $(draftTable).empty();
                for (var i = 0; i < items.length; i++) {
                    var draftName = items[i].draftName;
                    var createTime = items[i].createTime;
                    var uid = items[i].uid;
                    var tableRow = $("<tr></tr>");
                    var colDraftName = $("<td></td>");
                    colDraftName.click(function () {
                        loadDraft(uid);
                    }).css("cursor", "pointer").html(draftName);
                    var colCreateTime = $("<td></td>");
                    colCreateTime.click(function () {
                        loadDraft(uid);
                    }).css("cursor", "pointer").html(createTime);
                    var colDeleteBtn = $("<td style='text-align: right;'>"
                            + "<button class='btn btn-default btn-sm' data-toggle='modal' data-target='#draft_remove_confirm'"
                            + "data-item-description='" + draftName + "          " + createTime + "'"
                            + "data-item-uid='" + uid + "'"
                            + "title='delete'>"
                            + "<span class='glyphicon glyphicon-trash'></span>"
                            + "<span class='hidden-xs'> delete</span>"
                            + "</button></td>");
                    tableRow.append(colDraftName).append(colCreateTime).append(colDeleteBtn);
                    draftTable.append(tableRow);
                }
            }

            function deleteMessages() {
                var msgIds = [];
                $(".notification").each(function () {
                    console.log($(this).find("input[type='checkbox']").is(":checked"));
                    var selected = $(this).find("input[type='checkbox']").is(":checked");
                    if (selected) {
                        var msgId = $(this).find("input[name='msg_id']").val();
                        msgIds[msgIds.length] = msgId;
                        console.log(msgIds);
                    }
                });
                if (msgIds.length > 0) {
                    $.post("SerUsrMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Message.REQUEST_TYPE_DELETE_MESSAGES%>",
            <%=AppConst.Message.PARA_MESSAGE_IDS%>: JSON.stringify(msgIds)
                    }, function (data, status) {
                        if (status === "success") {
                            refresh();
                        }
                    });
                }
            }

        </script>
        <style>

            .user-property{
                padding-right: 5px;
                max-width: 180px;
            }
            .user-value {
                padding-left: 5px;
            }
            div.floater {
                opacity: 0.5;
                padding: 10px 10px 10px 10px;
                display: inline-block;
                position: fixed;
                bottom: 20px;
                right: 20px;
                text-align: end;
                background: #ececec;
            }
            div.floater:hover {
                opacity: 0.9;
            }
            @media (max-width: 767px){
                .notif-container {
                    display: none;
                }
            }
            @media (min-width: 767px){
                .collapsed-notif-container {
                    display: none;
                }
            }
            notif-container {
                max-height: 400px;
                overflow-y: auto;
            }
            .collapsed-notif-container {
                max-height: 400px;
                overflow-y: auto;
            }
            .notif-container-header {
                display: block;
                margin-bottom: 10px;
            }
            .notif-text {
                white-space: pre-line;
            }
            .notif-item-name {
                float: left;
                padding-left: 10px;
            }
            .notif-item-img {
                max-width: 100px;
                max-height: 80px;
                float: left;
            }
            .notif-date {
                font-family: monospace;
                font-size: 10px;
            }
            .notification.selected,
            .notification.unread.selected{
                background-color: #E8E8E8;
            }
            .notification:hover,
            .notification.unread:hover,
            .notification.unread.selected:hover {
                background-color: #EFEFEF;
            }
            .notification.unread {
                background-color: #FFF;
            }
            .notification {
                background-color: #f5f5f5;
            }
            .unread-header {
                color: #000;
            }
            .highlight-header {
                color: #000;
            }
            @media (min-width: 767px) {
                .item-img-container {
                    width: 115px;
                }
            }
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
                max-height: 500px;
                overflow-y: auto;
            }
            .item-img {
            }

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            if (usr != null) {
                user = usr;
            }
            if (user.isGuest()) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
            session.removeAttribute(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
        %>
        <!--            <div class="img-border floater" >
                                <span style="display: block;padding: 5px 5px 5px 5px;"><a href="javascript:scrollToStock();">Your stock</a></span>
                                <span style="display: block;padding: 5px 5px 5px 5px;"><a href="javascript:scrollToBoughtItems();">Bought items</a></span>
                                <span style="display: block;padding: 5px 5px 5px 5px;"><a href="javascript:scrollToSoldItems();">Sold items</a></span>
                            </div>-->


        <div class="container">


            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><span><%=user.getUsername()%>'s store</span></li>
                </ul>
            </div>


            <div class="card">
                <div class="row">
                    <div class="col-xs-8">
                        <h3><%=user.getUsername()%>'s store</h3>
                        <br>
                    </div>
                    <div class="col-xs-4">
                        <div class="pull-right visible-xs-inline-block" style="margin-top: 20px;">
                            <div class="dropdown">
                                <a class="btn-overflow dropdown-toggle" id="user_settings_menu"
                                   data-toggle="dropdown" href="#">
                                    <span class="icon-dot"></span>
                                    <span class="icon-dot"></span>
                                    <span class="icon-dot"></span>
                                </a>
                                <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="user_settings_menu">
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="user_change_security.jsp<%=(usr != null ? ("?" + AppConst.User.PARA_UID + "=" + usr.getUid()) : "")%>">security options</a>
                                    </li>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="user_add.jsp?edit=true<%=(usr != null ? ("&" + AppConst.User.PARA_UID + "=" + usr.getUid()) : "")%>">change details</a>
                                    </li>
                                    <%
                                        if (user.isAdmin()) {
                                    %>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="admin_home.jsp">admin panel</a>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                        <div class="hidden-xs pull-right text-right"  style="margin-top: 20px;">
                            <a style="margin-bottom: 5px;" href="user_change_security.jsp<%=(usr != null ? ("?" + AppConst.User.PARA_UID + "=" + usr.getUid()) : "")%>" >security options</a><br>
                            <a href="user_add.jsp?edit=true<%=(usr != null ? ("&" + AppConst.User.PARA_UID + "=" + usr.getUid()) : "")%>" >change details</a>
                            <%
                                if (user.isAdmin()) {
                            %>
                            <br><a href="admin_home.jsp" >admin panel</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-3" style="width: 115px;">
                        <img class="img-border" style="margin-bottom: 10px; margin-right: 10px;" src="<%=user.getAvatarBase64()%>" width="100" height="100" alt="Test Image"/>

                    </div>
                    <div class="col-xs-12 col-sm-9">
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-xs-3 user-property">
                                Name
                            </div>
                            <div class="col-xs-9 user-value">
                                <%=user.getName()%>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-xs-3 user-property">
                                Contact no
                            </div>
                            <div class="col-xs-9 user-value">
                                <%=user.getContactNo()%>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-xs-3 user-property">
                                Primary address
                            </div>
                            <div class="col-xs-9 user-value">
                                <%=user.getAddress()%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">

                            <div class="modal" id="message_delete_confirm" tabindex="-1" role="dialog" aria-labelledby="message_delete_confirm_header" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title" id="message_delete_confirm_header">Confirm</h4>
                                        </div>
                                        <div class="modal-body">
                                            <span>Are you sure you want to delete selected message(s)?</span>
                                            <br>
                                            <br>
                                            <p id="message_delete_item_description" style="font-size: smaller; white-space: pre;"></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" id="message_delete_btn_cancel"
                                                    data-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" id="message_delete_btn_ok"
                                                    onclick="deleteMessages();">Yes, delete</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <span class="col-xs-4 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <%
                                    int unreadCount;
                                    if ((unreadCount = user.getUnreadMessageCount()) != 0) {
                                %>
                                <span class="unread-header hidden-xs">(<%=unreadCount%> unread)</span>
                                <span class="visible-xs-inline-block" >Unread</span>
                                <span class="visible-xs-inline-block badge-custom" style="margin-left: 2px;"><%=unreadCount%></span>
                                <%
                                } else {
                                %>
                                Messages
                                <%
                                    }
                                %>
                            </span>
                            <%
                                Message[] msgsStoreInbox = user.getMessages(AppConst.User.USER_TYPE_ADMINISTRATOR, MessageBox.INBOX);
                                Message[] msgsSellersInbox = user.getMessages(AppConst.User.USER_TYPE_SELLER, MessageBox.INBOX);
                                Message[] msgsBuyersInbox = user.getMessages(AppConst.User.USER_TYPE_BUYER, MessageBox.INBOX);
                                Message[] msgsStoreOutbox = user.getMessages(AppConst.User.USER_TYPE_ADMINISTRATOR, MessageBox.OUTBOX);
                                Message[] msgsSellersOutbox = user.getMessages(AppConst.User.USER_TYPE_SELLER, MessageBox.OUTBOX);
                                Message[] msgsBuyersOutbox = user.getMessages(AppConst.User.USER_TYPE_BUYER, MessageBox.OUTBOX);
                            %>
                            <div class="col-xs-8" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <select class="form-control input-sm pull-right" style="width: 80px;" onchange="changeMessageBox($(this).val());">
                                            <option>inbox</option>
                                            <option>outbox</option>
                                        </select>
                                        <div class="input-group-btn">
                                            <button class="btn btn-default btn-sm" title="refresh" onclick="refresh();">
                                                <span class="glyphicon glyphicon-refresh"></span>
                                                <span class="hidden-xs"> refresh</span>
                                            </button>
                                            <button class="btn btn-default btn-sm" title="delete" id="btn_delete_messages" data-toggle="modal"
                                                    data-target="#message_delete_confirm">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                <span class="hidden-xs"> delete</span>
                                            </button>
                                            <a class="btn btn-default btn-sm" title="send message" href="notifications_add.jsp">
                                                <span class="glyphicon glyphicon-send"></span>
                                                <span class="hidden-xs"> send</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" id="inbox_container">
                    <div class="col-xs-12 col-sm-3 ">
                        <div class="list-group">
                            <a href="javascript:toggleNotifications('store');" class="list-group-item">From the store</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_store_inbox">
                                <%
                                    if (msgsStoreInbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsStoreInbox) {
                                    %>
                                    <div class="list-group-item notification <%=(msg.isUnread() ? "unread" : "")%>">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                            <a href="javascript:toggleNotifications('sellers');"  class="list-group-item">From sellers</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_sellers_inbox">
                                <%
                                    if (msgsSellersInbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsSellersInbox) {
                                    %>
                                    <div class="list-group-item notification <%=(msg.isUnread() ? "unread" : "")%>">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <div class="row" style="margin-bottom: 10px;">
                                            <div class="col-xs-12">
                                                <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                                <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                            </div>
                                        </div>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                            <a href="javascript:toggleNotifications('buyers');"  class="list-group-item">From buyers</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_buyers_inbox">
                                <%
                                    if (msgsBuyersInbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsBuyersInbox) {
                                    %>
                                    <div class="list-group-item notification <%=(msg.isUnread() ? "unread" : "")%>">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <div class="row" style="margin-bottom: 10px;">
                                            <div class="col-xs-12">
                                                <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                                <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                            </div>
                                        </div>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="hidden-xs col-sm-9 ">
                        <div class="notif-container" id="notif_store_inbox">
                            <%
                                if (msgsStoreInbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsStoreInbox) {
                                %>
                                <div class="list-group-item notification  <%=(msg.isUnread() ? "unread" : "")%>">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                        <div class="notif-container" id="notif_sellers_inbox">
                            <%
                                if (msgsSellersInbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsSellersInbox) {
                                %>
                                <div class="list-group-item notification  <%=(msg.isUnread() ? "unread" : "")%>">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <div class="col-xs-12">
                                            <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                            <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                        </div>
                                    </div>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                        <div class="notif-container" id="notif_buyers_inbox">
                            <%
                                if (msgsBuyersInbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsBuyersInbox) {
                                %>
                                <div class="list-group-item notification  <%=(msg.isUnread() ? "unread" : "")%>">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <div class="col-xs-12">
                                            <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                            <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                        </div>
                                    </div>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                    </div>
                </div>
                <div class="row" id="outbox_container">
                    <div class="col-xs-12 col-sm-3 ">
                        <div class="list-group">
                            <a href="javascript:toggleNotifications('store');" class="list-group-item">To the store</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_store_outbox">
                                <%
                                    if (msgsStoreOutbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsStoreOutbox) {
                                    %>
                                    <div class="list-group-item notification">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                            <a href="javascript:toggleNotifications('sellers');"  class="list-group-item">To sellers</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_sellers_outbox">
                                <%
                                    if (msgsSellersOutbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsSellersOutbox) {
                                    %>
                                    <div class="list-group-item notification">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <div class="row" style="margin-bottom: 10px;">
                                            <div class="col-xs-12">
                                                <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                                <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                            </div>
                                        </div>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                            <a href="javascript:toggleNotifications('buyers');"  class="list-group-item">To buyers</a>
                            <div class="collapsed-notif-container list-group-item" id="collapsed_notif_buyers_outbox">
                                <%
                                    if (msgsBuyersOutbox.length > 0) {
                                %>
                                <div class="list-group">
                                    <%
                                        for (Message msg : msgsBuyersOutbox) {
                                    %>
                                    <div class="list-group-item notification">
                                        <input hidden name="msg_id" value="<%=msg.getId()%>">
                                        <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                        <div class="row" style="margin-bottom: 10px;">
                                            <div class="col-xs-12">
                                                <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                                <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                            </div>
                                        </div>
                                        <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                        <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                        <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    } else {
                                        out.print("No messages to show");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="hidden-xs col-sm-9 ">
                        <div class="notif-container" id="notif_store_outbox">
                            <%
                                if (msgsStoreOutbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsStoreOutbox) {
                                %>
                                <div class="list-group-item notification">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                        <div class="notif-container" id="notif_sellers_outbox">
                            <%
                                if (msgsSellersOutbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsSellersOutbox) {
                                %>
                                <div class="list-group-item notification">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <div class="col-xs-12">
                                            <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                            <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                        </div>
                                    </div>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                        <div class="notif-container" id="notif_buyers_outbox">
                            <%
                                if (msgsBuyersOutbox.length > 0) {
                            %>
                            <div class="list-group">
                                <%
                                    for (Message msg : msgsBuyersOutbox) {
                                %>
                                <div class="list-group-item notification">
                                    <input hidden name="msg_id" value="<%=msg.getId()%>">
                                    <label style="padding: 5px 5px;"><input type="checkbox" onchange="toggleSelection(jQuery(this).parent().parent());"></label>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <div class="col-xs-12">
                                            <img class="img-border notif-item-img" src="<%=msg.getReferencedItem().getDefaultImage().getBase64Image()%>" alt="Image of <%=msg.getReferencedItem().getName()%>">
                                            <span class="list-group-item-text notif-item-name"><%=msg.getReferencedItem().getName()%><br><br><%=msg.getReferencedItem().getBuyer().getUsername()%></span>
                                        </div>
                                    </div>
                                    <h5 class="list-group-item-heading"><%=msg.getSubject().getName()%></h5>
                                    <h6 class="notif-date"><%=msg.getTimeSentFormatted()%></h6>
                                    <p class="list-group-item-text notif-text"><%=msg.getText()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                } else {
                                    out.print("No messages to show");
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>


            <%
                if (user.isSeller()) {
            %>


            <%
                if (user.getItemCount(Container.DRAFT) > 0) {
            %>
            <div class="card" id="draft_container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-12 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span>
                                    Your draft products
                                </span>
                            </span>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">

                            <div class="modal" id="draft_remove_confirm" tabindex="-1" role="dialog" aria-labelledby="draft_remove_confirm_header" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title" id="draft_remove_confirm_header">Confirm</h4>
                                        </div>
                                        <div class="modal-body">
                                            <span>Are you sure you want to remove this draft item from your profile?</span>
                                            <br>
                                            <br>
                                            <p id="draft_remove_item_description" style="font-size: smaller; white-space: pre;"></p>
                                        </div>
                                        <div class="modal-footer">
                                            <input hidden id="draft_remove_item_uid">
                                            <button type="button" class="btn btn-default" id="draft_remove_btn_cancel"
                                                    data-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" id="draft_remove_btn_ok"
                                                    onclick="removeDraft($('#draft_remove_item_uid').val());">Yes, remove it</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover table-condensed">
                                    <tbody id="draft_table">
                                        <%
                                            int draftCount = 0;
                                            for (Item item : user.getItems(Container.DRAFT)) {
                                                draftCount++;
                                        %>

                                        <tr>
                                            <td onclick="loadDraft('<%=item.getUid()%>');" style="cursor: pointer;">
                                                <%
                                                    String draftName;
                                                    if (item.isNameSet()) {
                                                        draftName = item.getName();
                                                    } else {
                                                        draftName = "[Draft " + draftCount + "]";
                                                    }
                                                    out.print(draftName);
                                                %>
                                            </td>
                                            <td onclick="loadDraft('<%=item.getUid()%>');" style="cursor: pointer;">
                                                <%
                                                    out.print(item.getCreateTimeFormatted());
                                                %>
                                            </td>
                                            <td style="text-align: right;">
                                                <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#draft_remove_confirm"
                                                        data-item-description="<%=draftName + "          " + item.getCreateTimeFormatted()%>"
                                                        data-item-uid="<%=item.getUid()%>"
                                                        title="delete">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                                    <span class="hidden-xs"> delete</span>
                                                </button>
                                            </td>
                                        </tr>

                                        <%
                                            }
                                        %>


                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <%
                }
            %>



            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-7 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span id="item_stock" title="Your stock has"
                                      data-container="body" data-toggle="popover" data-placement="bottom"
                                      data-html='true' data-trigger='hover'
                                      data-content="<%=(user.getItemCount(Container.STOCK) == 0
                                        ? ("no items")
                                        : ("<span class='card-header'>"
                                           + "<span class='highlight-header'>" + user.getItemCountText(Container.STOCK) + " (" + user.getItemCount(
                                           Container.STOCK) + ") </span>"
                                           + "products with <br>total of "
                                           + "<span class='highlight-header'>" + user.getTotalQtyText(Container.STOCK) + " (" + user.getTotalQty(
                                           Container.STOCK) + ") </span>"
                                           + "items (quantity) and <br> "
                                           + "<span class='highlight-header'>Rs. " + user.getTotalValueFormatted(
                                           Container.STOCK) + " </span> "
                                           + "of value. "
                                           + "</span>"))%>">
                                    Your stock at store
                                </span>
                            </span>

                            <div class="col-xs-5" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <select class="form-control input-sm pull-right" style="width: auto;display: inline-block;">
                                            <option>best selling first</option>
                                            <option>least selling first</option>
                                            <option>most recent first</option>
                                            <option>oldest first</option>
                                            <option>most quantity first</option>
                                            <option>least quantity first</option>
                                            <option>price lowest first</option>
                                            <option>price highest first</option>
                                        </select>
                                        <div class="input-group-btn">
                                            <a class="btn btn-default btn-sm" title="add new products" href="product_add.jsp">
                                                <span class="glyphicon glyphicon-plus"></span>
                                                <span class="hidden-xs"> add new products</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">

                            <%
                                for (Item item : user.getItems(Container.STOCK)) {
                            %>

                            <div class="list-group-item item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-xs-12">
                                        <div class="item-img-container">
                                            <div class="pull-right visible-xs-inline-block">
                                                <div class="dropdown">
                                                    <a class="btn-overflow dropdown-toggle" style="padding-right: 2px;" id="items_menu" data-toggle="dropdown" href="#">
                                                        <span class="icon-dot"></span>
                                                        <span class="icon-dot"></span>
                                                        <span class="icon-dot"></span>
                                                    </a>
                                                    <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="items_menu">
                                                        <li role="presentation">
                                                            <a role="menuitem" tabindex="-1" href="product_add.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>&edit=true">change details</a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a role="menuitem" tabindex="-1" href="product_add.jsp?edit=true">add / remove items</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <img class="item-img img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                     style="max-height: 140px; max-width: 185px;">
                                            </a>
                                        </div>
                                        <div>
                                            <div class="pull-right hidden-xs text-right" style="font-size: 12px; color:  #888; display: inline-block; vertical-align: bottom;">
                                                <br><br>
                                                <a href="product_add.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>&edit=true">change details</a>
                                                <br><br>
                                                <a href="product_add.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>&edit=true">add / remove items</a>
                                            </div>
                                            <span style="display: block; padding:5px 0;">
                                                <span class="item-subdata">
                                                    <a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_MAIN + item.getCategoryMain().getCategoryId()%>"><%=item.getCategoryMain().getName()%></a>
                                                    / <a class="active" href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_SUB + item.getCategorySub().getCategoryId()%>"><%=item.getCategorySub().getName()%></a>
                                                </span>
                                            </span>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <span class="item-name"><%=item.getName()%></span>
                                            </a>
                                            <span class="item-subdata">Product introduced to store on <%=item.getIntroducedTimeFormatted()%></span>
                                            <br>
                                            <%
                                                if (item.getLastSoldTime() != 0) {
                                            %>
                                            <span class="item-subdata">Last sold on <%=item.getLastSoldTimeFormatted()%></span>
                                            <%
                                                }
                                            %>
                                            <span style="display: block; margin: 5px 0;">
                                                <span class="highlight"><%=(item.getQuantityText())%> (<%=item.getQuantityFormatted()%>)</span> items available on stock
                                            </span>
                                            <span  style="display: block; margin: 5px 0;">Current unit price
                                                <span>Rs. <%=item.getUnitpriceFormatted()%></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>

                        </div>
                    </div>
                </div>
            </div>

            <% }  %>



            <%

                if (user.isBuyer() || user.isAdmin()) {
            %>
            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-7 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span id="buying_history" title="You have bought"
                                      data-container="body" data-toggle="popover" data-placement="bottom"
                                      data-html='true' data-trigger='hover'
                                      data-content="<%=(user.getItemCount(Container.BOUGHT) == 0
                                        ? ("no items")
                                        : ("<span class='card-header'> "
                                           + "<span class='highlight-header'>" + user.getItemCountText(Container.BOUGHT) + " (" + user.getItemCount(
                                           Container.BOUGHT) + ") </span> "
                                           + "products with <br>total of "
                                           + "<span class='highlight-header'>" + user.getTotalQtyText(Container.BOUGHT) + " (" + user.getTotalQty(
                                           Container.BOUGHT) + ") </span> "
                                           + "items (quantity) and <br> "
                                           + "<span class='highlight-header'>Rs. " + user.getTotalValueFormatted(
                                           Container.BOUGHT) + "</span> "
                                           + "of value."
                                           + "</span>"))%>">
                                    Items you bought from store
                                </span>
                            </span>
                            <div class="col-xs-5" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <select class="form-control input-sm pull-right">
                                            <option>most recent first</option>
                                            <option>oldest first</option>
                                            <option>price lowest first</option>
                                            <option>price highest first</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">


                            <%
                                for (Item item : user.getItems(Container.BOUGHT)) {
                            %>

                            <div class="list-group-item item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-xs-12">
                                        <div class="item-img-container">
                                            <div class="pull-right visible-xs-inline-block">
                                                <div class="dropdown">
                                                    <a class="btn-overflow dropdown-toggle" style="padding-right: 2px;" id="items_menu" data-toggle="dropdown" href="#">
                                                        <span class="icon-dot"></span>
                                                        <span class="icon-dot"></span>
                                                        <span class="icon-dot"></span>
                                                    </a>
                                                    <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="items_menu">
                                                        <li role="presentation">
                                                            <a role="menuitem" tabindex="-1" href="#">add review</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <img class="item-img img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                     style="max-height: 140px; max-width: 185px;">
                                            </a>
                                        </div>
                                        <div>
                                            <div class="pull-right hidden-xs text-right" style="font-size: 12px; color:  #888; display: inline-block; ">
                                                <br><br>
                                                <br><br>
                                                <a style="bottom: 0px;" href="#">add review</a>
                                            </div>
                                            <span style="display: block; padding:5px 0;">
                                                <span class="item-subdata">
                                                    <a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_MAIN + item.getCategoryMain().getCategoryId()%>"><%=item.getCategoryMain().getName()%></a>
                                                    / <a class="active" href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_SUB + item.getCategorySub().getCategoryId()%>"><%=item.getCategorySub().getName()%></a>
                                                </span>
                                            </span>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <span class="item-name"><%=item.getName()%></span>
                                            </a>
                                            <span class="item-subdata">Bought on <%=item.getCreateTimeFormatted()%> from <%=item.getSeller().getUsername()%></span>
                                            <br>
                                            <span style="display: block; margin: 5px 0;">
                                                you bought
                                                <span class="highlight"><%=item.getQuantityText()%> (<%=item.getQuantity()%>) </span>
                                                item<%=(item.getQuantity() > 1 ? "s" : "")%> for a total of
                                                <span class="highlight">Rs. <%=item.getTotalFormatted()%> </span>
                                                (<%=item.getUnitpriceFormatted()%> x <%=item.getQuantity()%>)
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>


            <% }  %>



            <%

                if (user.isSeller() || user.isAdmin()) {
            %>


            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-7 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span id="selling_history" title="You have sold"
                                      data-container="body" data-toggle="popover" data-placement="bottom"
                                      data-html='true' data-trigger='hover'
                                      data-content="<%=(user.getItemCount(Container.SOLD) == 0
                                        ? ("no items")
                                        : ("<span class='card-header'> "
                                           + "<span class='highlight-header'>" + user.getItemCountText(Container.SOLD) + " (" + user.getItemCount(
                                           Container.SOLD) + ") </span> "
                                           + "products with <br>total of "
                                           + "<span class='highlight-header'>" + user.getTotalQtyText(Container.SOLD) + " (" + user.getTotalQty(
                                           Container.SOLD) + ") </span> "
                                           + "items (quantity) and <br> "
                                           + "<span class='highlight-header'>Rs. " + user.getTotalValueFormatted(
                                           Container.SOLD) + "</span> "
                                           + "of value."
                                           + "</span>"))%>">
                                    Items you sold on store
                                </span>
                            </span>
                            <div class="col-xs-5" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <select class="form-control input-sm pull-right">
                                            <option>most recent first</option>
                                            <option>oldest first</option>
                                            <option>price lowest first</option>
                                            <option>price highest first</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <div class="list-group">


                            <%
                                for (Item item : user.getItems(Container.SOLD)) {
                            %>

                            <div class="list-group-item item">
                                <div class="row" style="margin-bottom: 10px;">
                                    <div class="col-xs-12">
                                        <div class="item-img-container">
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <img class="item-img img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                     style="max-height: 140px; max-width: 185px;">
                                            </a>
                                        </div>
                                        <div>
                                            <div class="pull-right hidden-xs text-right" style="font-size: 12px; color:  #888; display: inline-block; ">
                                                <br><br>
                                                <br><br>
                                            </div>
                                            <span style="display: block; padding:5px 0;">
                                                <span class="item-subdata">
                                                    <a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_MAIN + item.getCategoryMain().getCategoryId()%>"><%=item.getCategoryMain().getName()%></a>
                                                    / <a class="active" href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_SUB + item.getCategorySub().getCategoryId()%>"><%=item.getCategorySub().getName()%></a>
                                                </span>
                                            </span>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <span class="item-name"><%=item.getName()%></span>
                                            </a>
                                            <span class="item-subdata">Sold on <%=item.getCreateTimeFormatted()%> to <%=item.getBuyer().getUsername()%></span>
                                            <br>
                                            <span style="display: block; margin: 5px 0;">
                                                you sold
                                                <span class="highlight"><%=item.getQuantityText()%> (<%=item.getQuantity()%>) </span>
                                                item<%=(item.getQuantity() > 1 ? "s" : "")%> for a total of
                                                <span class="highlight">Rs. <%=item.getTotalFormatted()%> </span>
                                                (<%=item.getUnitpriceFormatted()%> x <%=item.getQuantity()%>)
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>

            <%
                }
            %>



            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-12 card-header">
                                <span>
                                    More product suggestions for you
                                </span>
                            </span>

                        </div>
                    </div>
                </div>
                <div class="row" style="padding: 10px;">
                    <div class="col-xs-12 related-list-container">

                        <div class="" style="text-align: center;min-width: 900px;">


                            <div class="related-item-container">
                                <div class="related-item-img-container">
                                    <a href="product_view.jsp">
                                        <img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"
                                             title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King"/>
                                    </a>
                                </div>
                                <div class="related-item-details-container">
                                    <a href="product_view.jsp" class="related-item-name"
                                       title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King">
                                        Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King
                                    </a>
                                    <span class="related-item-price">
                                        Rs. 12,450.00
                                    </span>
                                </div>
                            </div>



                            <div class="related-item-container">
                                <div class="related-item-img-container">
                                    <a href="product_view.jsp">
                                        <img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"
                                             title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King"/>
                                    </a>
                                </div>
                                <div class="related-item-details-container">
                                    <a href="product_view.jsp" class="related-item-name"
                                       title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King">
                                        Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King
                                    </a>
                                    <span class="related-item-price">
                                        Rs. 12,450.00
                                    </span>
                                </div>
                            </div>



                            <div class="related-item-container">
                                <div class="related-item-img-container">
                                    <a href="product_view.jsp">
                                        <img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"
                                             title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King"/>
                                    </a>
                                </div>
                                <div class="related-item-details-container">
                                    <a href="product_view.jsp" class="related-item-name"
                                       title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King">
                                        Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King
                                    </a>
                                    <span class="related-item-price">
                                        Rs. 12,450.00
                                    </span>
                                </div>
                            </div>



                            <div class="related-item-container">
                                <div class="related-item-img-container">
                                    <a href="product_view.jsp">
                                        <img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"
                                             title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King"/>
                                    </a>
                                </div>
                                <div class="related-item-details-container">
                                    <a href="product_view.jsp" class="related-item-name"
                                       title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King">
                                        Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King
                                    </a>
                                    <span class="related-item-price">
                                        Rs. 12,450.00
                                    </span>
                                </div>
                            </div>



                            <div class="related-item-container">
                                <div class="related-item-img-container">
                                    <a href="product_view.jsp">
                                        <img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"
                                             title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King"/>
                                    </a>
                                </div>
                                <div class="related-item-details-container">
                                    <a href="product_view.jsp" class="related-item-name"
                                       title="Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King">
                                        Prince Dark Slate Leather Platform Bed, Cal King Leather Platform Bed, Cal King
                                    </a>
                                    <span class="related-item-price">
                                        Rs. 12,450.00
                                    </span>
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
