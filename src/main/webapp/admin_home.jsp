<%--
    Document   : admin_home
    Created on : May 8, 2015, 10:15:30 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.admin.Image"%>
<%@page import="com.neo.util.AppPropertyContainer"%>
<%@page import="com.neo.util.AdminStatistics"%>
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
        <link rel="stylesheet" type="text/css" href="tools/font-awesome/css/font-awesome.min.css">
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
            if (!admin) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
        %>
        <title>Admin home | IDEALStore.com</title>
        <style>
            .list-container {
                max-height: 500px;
                overflow-y: auto;
            }
            #img_logo_preview {
                cursor: pointer;
                max-width: 190px;
                max-height: 120px;
            }
            #sortable {
                list-style-type: none;
                margin: 0;
                padding: 0;
                max-width: 262px;
            }
            #sortable li {
                margin: 0 5px 5px 5px;
                padding: 5px;
                max-height: 200px;
            }
            html>body #sortable li {
                max-height: 200px;
            }
            .ui-state-highlight {
                height: 180px;
            }
            .corousel-image-preview {
                max-width: 240px;
                max-height: 168px;
                cursor: move;
            }
            .btn-remove {
                padding-top: 2px;
                float: right;
                opacity: 0.6;
                cursor: pointer;
            }
            .btn-remove:hover {
                opacity: 1;
            }
            .img-count {
            }

        </style>
        <script>

            $(document).ready(function () {

                $(".progress").hide();
                toggleUserOverlay();
                loadUsers(function () {
                    toggleItemOverlay();
                    loadItems();
                    console.log("in loadUser");
                });


                $(function () {
                    $("#sortable").sortable({
                        placeholder: "ui-state-highlight",
                        update: function () {
                            recountImages();
                        }
                    });
                    $("#sortable").disableSelection();
                });

                function Image(id, image_data) {
                    this.imageId = id;
                    this.imageData = image_data;
                }

                $("#images").change(function () {
                    var files = $("#images").prop("files");
                    var img_count = $("#img_preview").children("div").length;
                    console.log(img_count + " : " + files.length);
                    if (img_count >= 8) {
                        $("#images").prop("disabled", true);
                        $("#btn_choose_img").addClass("disabled");
                        return false;
                    } else {
                        $("#images").prop("disabled", false);
                        $("#btn_choose_img").removeClass("disabled");
                    }
                    var images = [];
                    for (var i = 0; i < 8 - img_count; i++) {
                        if (files[i] === undefined) {
                            break;
                        }
                        var img_id = (i + img_count) + "";
                        var listItem = $("<li class='ui-state-default'>"
                                + "<div>"
                                + "<div>"
                                + "<input hidden id='image_name_" + img_id + "' name=\"<%=AppConst.Admin.PARA_IMAGE_NAME%>\" value=\"\">"
                                + "<input hidden id='image_count_" + img_id + "' name=\"<%=AppConst.Admin.PARA_IMAGE_ORDINAL%>\" value=\"\">"
                                + "<span class='img-count'></span>"
                                + "<span class='glyphicon glyphicon-remove btn-remove'></span>"
                                + "</div>"
                                + "</div>"
                                + "</li>");
                        var img = $("<img class='img-border corousel-image-preview' src=''  alt='image'>");
                        openImage(files[i], img.get(0), function (result, images, img_id) {
                            images[images.length] = new Image(img_id, result);
                        }, images, img_id);
                        listItem.children("div").prepend(img);
                        $("#sortable").append(listItem);
                    }
                    setTimeout(function () {
                        console.log(images);
                        uploadImages(images);
                    }, 2000);
                    $("#images").val("");
                    recountImages();
                });

                $("#search_user").click(function () {
                    loadUsers();
                });

                $("#search_item").click(function () {
                    loadItems();
                });


                $("span.btn-remove").click(function () {
                    $(this).parent().parent().parent().remove();
                    recountImages();
                    return false;
                });

                $('#user_actions').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var user_uid = button.data('user-uid');
                    var showData = button.data('show-data');
                    var modal = $(this);
                    if (showData) {
                        modal.find("#user_action_link_view,#user_action_link_edit,#user_action_link_suspend").removeClass("hidden");
                    } else {
                        modal.find("#user_action_link_view,#user_action_link_edit,#user_action_link_suspend").addClass("hidden");
                    }
                    modal.find("#user_action_link_suspend,#user_action_link_delete").data("user-uid", user_uid);
                    modal.find("#user_action_link_view").attr("href", "user_profile.jsp?<%=AppConst.User.PARA_UID%>=" + user_uid);
                    modal.find("#user_action_link_edit").attr("href", "user_add.jsp?edit=true&<%=AppConst.User.PARA_UID%>=" + user_uid);
                });

                $('#item_actions').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var item_uid = button.data('item-uid');
                    var modal = $(this);
                    modal.find("#item_actions_link_delete").data("item-uid", item_uid);
                    modal.find("#item_actions_link_view").attr("href", "product_view.jsp?<%=AppConst.User.PARA_UID%>=" + item_uid);
                    modal.find("#item_actions_link_edit").attr("href", "product_add.jsp?edit=true&<%=AppConst.User.PARA_UID%>=" + item_uid);
                });

                $('#user_action_confirm').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var user_uid = button.data('user-uid');
                    var action_type = button.data("action-type");
                    var modal = $(this);
                    if (action_type === "suspend") {
                        modal.find("#user_action_confirm_text").text("Are you sure you want to suspend this user?");
                        $("#user_action_confirm_btn_ok").text("Yes, suspend user")
                                .data("user-uid", user_uid)
                                .data("action-type", action_type);
                    } else if (action_type === "delete") {
                        modal.find("#user_action_confirm_text").text("Are you sure you want to delete this user?");
                        $("#user_action_confirm_btn_ok").text("Yes, delete user")
                                .data("user-uid", user_uid)
                                .data("action-type", action_type);
                    }
                });

                $('#item_actions_confirm').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var item_uid = button.data('item-uid');
                    var action_type = button.data("action-type");
                    var modal = $(this);
                    if (action_type === "delete") {
                        modal.find("#item_actions_confirm_text").text("Are you sure you want to delete this user?");
                        $("#item_actions_confirm_btn_ok").text("Yes, delete user")
                                .data("item-uid", item_uid)
                                .data("action-type", action_type);
                    }
                });

                $("#user_action_confirm_btn_ok").click(function () {
                    var button = $(this);
                    var user_uid = button.data('user-uid');
                    var action_type = button.data("action-type");
                    if (action_type === "suspend") {
                        suspendUser(user_uid);
                    } else if (action_type === "delete") {
                        removeUser(user_uid);
                    }
                });

                $("#item_actions_confirm_btn_ok").click(function () {
                    var button = $(this);
                    var user_uid = button.data('item-uid');
                    var action_type = button.data("action-type");
                    if (action_type === "delete") {
                        removeItem(user_uid);
                    }
                });

                $('#user_search_text').keypress(function (e) {
                    if (e.keyCode === 13) {
                        loadUsers();
                    }
                });

                $('#item_search_text').keypress(function (e) {
                    if (e.keyCode === 13) {
                        loadItems();
                    }
                });

            });

            function suspendUser(uid) {
                alert("suspending : " + uid);
            }

            function removeUser(uid) {
                alert("Deleting : " + uid);
            }

            function loadUsers(callBack) {
                toggleUserOverlay();
                var searchText = $("#user_search_text").val();
                $.post("SerAdminMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Admin.REQUEST_TYPE_SEARCH_USERS%>",
            <%=AppConst.Admin.PARA_SEARCH_TEXT%>:searchText
                }, function (data, success) {
                    if (success === "success") {
                        fillUserTable($.parseJSON(data));
                    }
                    toggleUserOverlay();
                    if (callBack !== undefined) {
                        callBack();
                    }
                });
            }

            function loadItems() {
                toggleItemOverlay();
                var searchText = $("#item_search_text").val();
                $.post("SerAdminMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Admin.REQUEST_TYPE_SEARCH_ITEMS%>",
            <%=AppConst.Admin.PARA_SEARCH_TEXT%>:searchText
                }, function (data, success) {
                    if (success === "success") {
                        fillItemTable($.parseJSON(data));
                    }
                    toggleItemOverlay();
                });
            }

            function fillUserTable(users) {
                var table = $("#user_tbody");
                $(table).children().remove();
                for (var i = 0; i < users.length; i++) {
                    var user = users[i];
                    var tRow = $("<tr></tr>");
                    tRow.append($("<td></td>").html("" + (i + 1)));
                    tRow.append($("<td></td>").html(user.email));
                    tRow.append($("<td></td>").html(user.regDate));
                    tRow.append($("<td></td>").html(user.type));
                    tRow.append();
                    var td = $("<td></td>");
                    if (user.uid !== "<%=(usr.getUid())%>") {
                        td.append($("<button data-toggle='modal' data-target='#user_actions' "
                                + "data-user-uid='" + user.uid + "' data-show-data='" + user.showData + "'></button>")
                                .addClass("btn")
                                .addClass("btn-default")
                                .addClass("btn-sm")
                                .html("actions ..."));
                    }
                    tRow.append(td);
                    table.append(tRow);
                }
            }

            function fillItemTable(items) {
                var table = $("#item_tbody");
                $(table).children().remove();
                for (var i = 0; i < items.length; i++) {
                    var item = items[i];
                    var tRow = $("<tr></tr>");
                    tRow.append($("<td></td>").html("" + (i + 1)));
                    tRow.append($("<td></td>").html(item.name));
                    tRow.append($("<td></td>").html(item.regDate));
                    tRow.append($("<td></td>").html(item.price));
                    tRow.append();
                    var td = $("<td></td>");
                    if (item.uid !== "<%=(usr.getUid())%>") {
                        td.append($("<button data-toggle='modal' data-target='#item_actions' "
                                + "data-item-uid='" + item.uid + "' data-show-data='" + item.showData + "'></button>")
                                .addClass("btn")
                                .addClass("btn-default")
                                .addClass("btn-sm")
                                .html("actions ..."));
                    }
                    tRow.append(td);
                    table.append(tRow);
                }
            }

            function toggleUserOverlay() {
                var overlay = $("div#user_table_overlay");
                if ($(overlay).is(":visible")) {
                    $(overlay).hide();
                } else {
                    $(overlay).width($(overlay).parent().width())
                            .height($(overlay).parent().height()).show();
                }
            }

            function toggleItemOverlay() {
                var overlay = $("div#item_table_overlay");
                if ($(overlay).is(":visible")) {
                    $(overlay).hide();
                } else {
                    $(overlay).width($(overlay).parent().width())
                            .height($(overlay).parent().height()).show();
                }
            }

            function recountImages() {
                var count = 0;
                $("#sortable").children("li").each(function () {
                    count++;
                    $(this).find("span.img-count").html("" + count);
                    $(this).find("input[id^='image_count_']").val("" + count);
                });
                $("#img_count").text(count + " / 8 images");
                if (count === 0) {
                    $("#btn_img_save").addClass("disabled");
                } else {
                    $("#btn_img_save").removeClass("disabled");
                }
                if (count >= 8) {
                    $("#images").prop("disabled", true);
                    $("#btn_choose_img").addClass("disabled");
                } else {
                    $("#images").prop("disabled", false);
                    $("#btn_choose_img").removeClass("disabled");
                }
            }


            function uploadImages(images) {
                $.post("SerImgMng",
                        {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ADMIN%>",
            <%=AppConst.Item.PARA_IMAGES%>: JSON.stringify(images)
                        }, function (data) {
                    console.log(data);
                    var imgs = $.parseJSON(data);
                    nameImages(imgs);
                });
            }

            function nameImages(images) {
                for (var i = 0; i < images.length; i++) {
                    var id = images[i].imageId;
                    var name = images[i].imageName;
                    $("#image_name_" + id).attr("value", name);
                }
            }

        </script>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">

            <div class="card">
                <h3>Statistics</h3>
                <br>
                <%                    AdminStatistics statistics = AppUtil.getStatictics(request);
                %>
                <div class="row">
                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div  class="panel-title">
                                    Users
                                </div>
                            </div>
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>Registered</td>
                                        <td><%=statistics.getUser().getUserCountRegistered()%></td>
                                    </tr>
                                    <tr>
                                        <td>Sellers</td>
                                        <td><%=statistics.getUser().getUserCountSellers()%></td>
                                    </tr>
                                    <tr>
                                        <td>Buyers</td>
                                        <td><%=statistics.getUser().getUserCountBuyers()%></td>
                                    </tr>
                                    <tr>
                                        <td>Guests</td>
                                        <td><%=statistics.getUser().getUserCountGuests()%></td>
                                    </tr>
                                    <tr>
                                        <td>Currently visiting (~30 mins)</td>
                                        <td><%=statistics.getUser().getUserCountCurrent()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div  class="panel-title">
                                    Items
                                </div>
                            </div>
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>Registered</td>
                                        <td><%=statistics.getItem().getItemCountRegistered()%></td>
                                    </tr>
                                    <tr>
                                        <td>In stock (quantity)</td>
                                        <td><%=statistics.getItem().getItemCountStock()%></td>
                                    </tr>
                                    <tr>
                                        <td>In baskets (quantity)</td>
                                        <td><%=statistics.getItem().getItemCountCart()%></td>
                                    </tr>
                                    <tr>
                                        <td>Sales (quantity)</td>
                                        <td><%=statistics.getItem().getItemCountSold()%></td>
                                    </tr>
                                    <tr>
                                        <td>Currently viewed</td>
                                        <td><%=statistics.getItem().getItemCountCurrent()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-5 panel-title">
                                            Accounts
                                        </div>
                                        <span class="col-xs-7"><a class=" pull-right" href="acc_profile.jsp">View sales</a></span>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <td>Total value of stock items</td>
                                        <td>Rs. <%=statistics.getAccounts().getTotalStockValue()%></td>
                                    </tr>
                                    <tr>
                                        <td>Total amount of sales</td>
                                        <td>Rs. <%=statistics.getAccounts().getTotalSalesValue()%></td>
                                    </tr>
                                    <tr>
                                        <td>Income by commissions</td>
                                        <td>Rs. <%=statistics.getAccounts().getIncomeCommissions()%></td>
                                    </tr>
                                    <tr>
                                        <td>Income by promotions</td>
                                        <td>Rs. <%=statistics.getAccounts().getIncomePromotions()%></td>
                                    </tr>
                                    <tr>
                                        <td>Total income</td>
                                        <td>Rs. <%=statistics.getAccounts().getTotalIncome()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">


                <div class="modal" id="user_add" tabindex="-1" role="dialog" aria-labelledby="user_add_header" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title" id="user_add_header">Create new user</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label class="col-xs-12 col-sm-3 control-label" for="user_type">
                                                User type
                                            </label>
                                            <div class="col-xs-9 col-sm-6 col-md-5 col-lg-4 ">
                                                <select class="form-control input-sm" name="user_type" id="user_type">
                                                    <option>Seller / Buyer</option>
                                                    <option>Accountant</option>
                                                    <option>Administrator</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <button type="button" class="btn btn-primary">Continue</button>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="row card-header-container">
                    <span class="col-xs-3 card-header">
                        <span class="h4">
                            Users
                        </span>
                    </span>
                    <div class="col-xs-push-2 col-xs-7">
                        <div class="input-group">
                            <input class="form-control input-sm" type="text" placeholder="search users" id="user_search_text">
                            <span class="input-group-btn">
                                <button class="btn btn-default btn-sm" title="Search" id="search_user">
                                    <span class="glyphicon glyphicon-search"></span>
                                    <span class="hidden-xs" style="padding-left: 5px;">Search</span>
                                </button>
                                <button class="btn btn-default btn-sm" title="New User" data-toggle="modal" data-target="#user_add" >
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <span class="hidden-xs"  style="padding-left: 5px;">New user ...</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="list-container">

                    <div class="modal" id="user_actions" tabindex="-1" role="dialog" aria-labelledby="user_actions_header" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="user_actions_header">User actions</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <input hidden id="user_action_user_uid">
                                            <div class="col-xs-12" style="padding-bottom: 5px;"><a id="user_action_link_view" href="#" target="_blank">View user profile</a></div>
                                            <div class="col-xs-12" style="padding-bottom: 5px;"><a id="user_action_link_edit" href="#" target="_blank">Edit user data</a></div>
                                            <div class="col-xs-12" style="padding-bottom: 5px;">
                                                <a id="user_action_link_suspend" href="#"  data-toggle="modal" data-dismiss="modal"
                                                   data-target="#user_action_confirm" data-user-uid="" data-action-type="suspend">Suspend user account</a>
                                            </div>
                                            <div class="col-xs-12" style="padding-bottom: 5px;">
                                                <a id="user_action_link_delete" href="#"  data-toggle="modal" data-dismiss="modal"
                                                   data-target="#user_action_confirm" data-user-uid="" data-action-type="delete">Delete user account</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal" id="user_action_confirm" tabindex="-1" role="dialog" aria-labelledby="user_action_confirm_header" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="user_action_confirm_header">Confirm</h4>
                                </div>
                                <div class="modal-body">
                                    <span id="user_action_confirm_text">Are you sure you want to remove this user?</span>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" id="user_action_confirm_btn_cancel"
                                            data-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary" id="user_action_confirm_btn_ok"
                                            data-user-uid="" data-action-type="">Yes, remove it</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class=" table-responsive">
                        <div class="modal-overlay text-center" id="user_table_overlay">
                            <span class="fa fa-circle-o-notch fa-spin modal-overlay-loader"></span>
                        </div>
                        <table class="table table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Email</th>
                                    <th>Reg. Date</th>
                                    <th>Type</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="user_tbody">
                                <tr>
                                    <td>1</td>
                                    <td>email@tesd.com</td>
                                    <td>2015-06-20 10:20 PM</td>
                                    <td>Seller / Buyer</td>
                                    <td style="text-align: right;">
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="modal"
                                                data-target="#user_actions" data-user-uid="23234234">actions ...</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>






            <div class="card">

                <div class="row card-header-container">
                    <span class="col-xs-3 card-header">
                        <span class="h4">
                            Items
                        </span>
                    </span>
                    <div class="col-xs-push-2 col-xs-7">
                        <div class="input-group">
                            <input class="form-control input-sm" type="text" placeholder="search users" id="item_search_text">
                            <span class="input-group-btn">
                                <button class="btn btn-default btn-sm" title="Search" id="search_item">
                                    <span class="glyphicon glyphicon-search"></span>
                                    <span class="hidden-xs" style="padding-left: 5px;">Search</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="list-container">

                    <div class="modal" id="item_actions" tabindex="-1" role="dialog" aria-labelledby="item_actions_header" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="item_actions_header">Item actions</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <input hidden id="item_actions_user_uid">
                                            <div class="col-xs-12" style="padding-bottom: 5px;"><a id="item_actions_link_view" href="#" target="_blank">View item</a></div>
                                            <div class="col-xs-12" style="padding-bottom: 5px;"><a id="item_actions_link_edit" href="#" target="_blank">Edit item data</a></div>
                                            <div class="col-xs-12" style="padding-bottom: 5px;">
                                                <a id="item_actions_link_delete" href="#"  data-toggle="modal" data-dismiss="modal"
                                                   data-target="#item_actions_confirm" data-user-uid="" data-action-type="delete">Delete item</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal" id="item_actions_confirm" tabindex="-1" role="dialog" aria-labelledby="item_actions_confirm_header" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="item_actions_confirm_header">Confirm</h4>
                                </div>
                                <div class="modal-body">
                                    <span id="item_actions_confirm_text">Are you sure you want to remove this item?</span>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" id="item_actions_confirm_btn_cancel"
                                            data-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary" id="item_actions_confirm_btn_ok"
                                            data-item-uid="" data-action-type="">Yes, remove it</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class=" table-responsive">
                        <div class="modal-overlay text-center" id="item_table_overlay">
                            <span class="fa fa-circle-o-notch fa-spin modal-overlay-loader"></span>
                        </div>
                        <table class="table table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Reg. Date</th>
                                    <th>Price (Rs.)</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="item_tbody">
                                <tr>
                                    <td>1</td>
                                    <td>Test item 1</td>
                                    <td>2015-06-20 10:20 PM</td>
                                    <td>45,100.00</td>
                                    <td style="text-align: right;">
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="modal"
                                                data-target="#item_actions" data-user-uid="23234234">actions ...</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
















            <div class="card">
                <div class="row card-header-container">
                    <span class="col-xs-12 card-header">
                        <span class="h4">
                            Site properties
                        </span>
                    </span>
                </div>
                <div class="row">
                    <div class="col-xs-12" style="padding: 30px;">
                        <form class="form-horizontal" role="form" action="SerAdminMng" method="POST">
                            <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Admin.REQUEST_TYPE_APP_PROPERTIES%>">
                            <input hidden name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" value="">
                            <div class="form-group">
                                <label class="col-xs-12 visible-xs control-label" for="about_us_description">
                                    About us
                                </label>
                                <div class="visible-xs" style="padding: 5px;"></div>
                                <label class="col-xs-12 visible-xs control-label" for="about_us_description">
                                    Description <br>
                                    <span class="subtext">
                                        (HTML formatting not supported)
                                    </span>
                                </label>
                                <label class="col-xs-12 col-sm-3 control-label" for="about_us_description">
                                    <span class="hidden-xs">About us description  <br>
                                        <span class="subtext">
                                            (HTML formatting not supported)
                                        </span>
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9 ">
                                    <textarea name="<%=AppConst.Admin.PARA_ABOUT_US_DESCRIPTION%>" id="about_us_description" rows="5" style=" width: 100%; resize: vertical;"><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_DESCRIPTION)%></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="address">
                                    Address
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Admin.PARA_ABOUT_US_ADDRESS%>"
                                           id="address" value="<%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_ADDRESS)%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="year">
                                    Start year
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Admin.PARA_ABOUT_US_START_YEAR%>"
                                           id="year" value="<%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_START_YEAR)%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="employees">
                                    No. of Employees
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Admin.PARA_ABOUT_US_EMPLOYEE_COUNT%>"
                                           id="employees" value="<%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_EMPLOYEE_COUNT)%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="vision">
                                    Company vision <br>
                                    <span class="subtext">
                                        (HTML formatting not supported)
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <textarea name="<%=AppConst.Admin.PARA_ABOUT_US_COMPANY_VISION%>" id="vision" rows="5" style=" width: 100%; resize: vertical;"><%=appPropertyContainer.getValue(AppConst.Admin.PARA_ABOUT_US_COMPANY_VISION)%></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="copyright">
                                    Copyright text <br>
                                    <span class="subtext">
                                        (visible in site footer)
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Admin.PARA_COPYRIGHT_TEXT%>" id="copyright"
                                           value="<%=appPropertyContainer.getValue(AppConst.Admin.PARA_COPYRIGHT_TEXT)%>">
                                </div>
                            </div>
                            <div class="separator"></div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="privacy_policy">
                                    Privacy policy <br>
                                    <span class="subtext">
                                        (copy and paste the content here.)
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <textarea name="<%=AppConst.Admin.PARA_PRIVACY_POLICY%>" id="privacy_policy" rows="5" style=" width: 100%; resize: vertical;"><%=appPropertyContainer.getValue(AppConst.Admin.PARA_PRIVACY_POLICY)%></textarea>
                                </div>
                            </div>
                            <div class="separator"></div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label" for="conditions">
                                    Terms and conditions <br>
                                    <span class="subtext">
                                        (copy and paste the content here.)
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <textarea name="<%=AppConst.Admin.PARA_TERMS_AND_CONDITIONS%>" id="conditions" rows="5" style=" width: 100%; resize: vertical;"><%=appPropertyContainer.getValue(AppConst.Admin.PARA_TERMS_AND_CONDITIONS)%></textarea>
                                </div>
                            </div>
                            <div class="separator"></div>
                            <div class="separator"></div>
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label">
                                    Carousel images <br>
                                    <span class="subtext">
                                        (drag to change order)
                                    </span>
                                </label>
                                <div class="col-xs-12 col-sm-9">
                                    <input hidden type="file" accept="image/jpeg" multiple name="<%=AppConst.Item.PARA_IMAGES%>" id="images" style="display: none;" />
                                    <a class="btn btn-default btn-sm" id="btn_choose_img" onclick="jQuery('#images').click();">
                                        Choose images</a>
                                    <span id="img_count" style="padding-left: 10px;" ></span>
                                    <br>
                                    <br>
                                    <ul id="sortable">
                                        <%
                                            int img_id = 0;
                                            for (Image image : appPropertyContainer.getImages()) {
                                        %>
                                        <li class="ui-state-default">
                                            <div>
                                                <img class="img-border corousel-image-preview" src="<%=image.getImageBase64()%>" alt="image">
                                                <div>
                                                    <input hidden="" <%=("id='image_name_'" + img_id)%> name="image_name" value="<%=image.getName()%>">
                                                    <input hidden=""  <%=("id='image_count_'" + img_id)%> name="image_ordinal" value="<%=image.getOrdinal()%>">
                                                    <span class="img-count"><%=image.getOrdinal()%></span>
                                                    <span class="glyphicon glyphicon-remove btn-remove"></span>
                                                </div>
                                            </div>
                                        </li>
                                        <%
                                                img_id++;
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                            <div class="separator"></div>
                            <div class="separator"></div>
                            <div class="col-xs-12 text-center">
                                <input class="btn btn-default btn-sm" type="submit" value="Save properties" >
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
