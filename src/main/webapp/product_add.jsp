<%--
    Document   : user_signup
    Created on : Nov 25, 2014, 10:01:23 PM
    Author     : Neo
--%>

<%@page import="com.neo.util.AppUtil.ConstType"%>
<%@page import="com.neo.beans.acc.Commission"%>
<%@page import="com.neo.beans.item.Property"%>
<%@page import="com.neo.beans.item.OptionGroup"%>
<%@page import="com.neo.beans.item.ItemOption"%>
<%@page import="com.neo.beans.item.Category"%>
<%@page import="com.neo.beans.item.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="tools/pnotify/pnotify.custom.min.css">
        <link rel="stylesheet" type="text/css" href="styles/common.css">
        <script src="scripts/util.js"></script>
        <script src="tools/nic-editor/nicEdit.js"></script>
        <%
            User usr = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
            if (usr == null || (!usr.isSeller())) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
            boolean editing = request.getParameter("edit") != null && request.getParameter("edit").equals("true");
            boolean draft = request.getParameter("draft") != null && request.getParameter("draft").equals("true");
            boolean fromView = request.getParameter("from_view") != null && request.getParameter("from_view").equals("true");
            String uid = request.getParameter(AppConst.Item.PARA_UID);
        %>
        <title><%=(editing ? "Edit product" : "New product")%> | IDEALStore.com</title>
        <style>

            div.img-view {
                float: left;
                width: 80px;
                padding: 10px 10px 10px 10px;
            }

        </style>
        <script>

            var editor;
            var max_quantity = 100;
            var min_quantity = 0;
            var max_price_length = 6;

            function Image(id, image_data) {
                this.imageId = id;
                this.imageData = image_data;
            }

            bkLib.onDomLoaded(function () {
                editor = new nicEditor({
                    fullPanel: true,
                    maxHeight: 250,
                    iconsPath: 'tools/nic-editor/nicEditorIcons.gif'
                }).panelInstance('description', {hasPanel: true});
            });

            $(document).ready(function () {

                $(function () {
                    $("[data-toggle='popover']").popover();
                });

                var max_summary_char_count = 180;
                $("#summary").change(function () {
                    $("#summary_char_count").text("(" + $(this).val().length + " / " + max_summary_char_count + ")");
                    if ($(this).val().length >= max_summary_char_count) {
                        return false;
                    }
                }).keyup(function () {
                    $(this).change();
                });

                $(window).resize(function () {
                    if (editor !== undefined) {
                        editor.removeInstance('description');
                        editor = undefined;
                    }
                    editor = new nicEditor({
                        fullPanel: true,
                        maxHeight: 250,
                        iconsPath: 'tools/nic-editor/nicEditorIcons.gif'
                    }).panelInstance('description', {hasPanel: true});
                });

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
                        var div = $("<div class='col-xs-4 col-sm-3 img-container'>"
                                + "<div id='img_" + (i + img_count) + "' class='img-view'>"
                                + "<div style='width: 80px;'>"
                                + "<input hidden id='image_name_" + img_id + "' name=\"<%=AppConst.Item.PARA_IMAGE_NAME%>\" value=\"\" />"
                                + "<label style='display: inline-block;'>"
                                + "<input style='vertical-align: text-bottom; margin: 0px 2px 0px 0px;' type='radio' name='<%=AppConst.Item.PARA_IMAGE_DEFAULT%>' id='deafult_" + img_id + "' checked>"
                                + "default"
                                + "</label>"
                                + "<a name='img_remove' class='pull-right' style='vertical-align: text-bottom; margin: 0px 2px 0px 0px;' title='remove' href='#'>"
                                + "<span class='glyphicon glyphicon-remove' style='font-size: x-small; opacity: 0.6;' onmouseover='jQuery(this).css(\"opacity\", \"1\");' onmouseout='jQuery(this).css(\"opacity\", \"0.6\");'></span>"
                                + "</a>"
                                + "</div>"
                                + "</div>"
                                + "</div>");
                        var img = $("<img class='img-border' src='' width='80' height='70'  onclick='$(\"#deafult_" + img_id + "\").click();'><br><br>");
                        openImage(files[i], img.get(0), function (result, images, img_id) {
                            images[images.length] = new Image(img_id, result);
                        }, images, img_id);
                        if ($("#img_preview").children("div.img-view").length === 0) {
                            div.find("input[type=radio]").attr("checked", "true");
                        }
                        div.children("div").prepend(img);
                        $("#img_preview").append(div);
                    }
                    setTimeout(function () {
                        uploadImages(images);
                    }, 2000);
                    $("a[name=img_remove]").click(function () {
                        $(this).parent().parent().parent().remove();
                        $("#img_count").text($("#img_preview").children("div").length + " / 8 images");
                        if ($("#img_preview").children("div").length >= 8) {
                            $("#images").prop("disabled", true);
                            $("#btn_choose_img").addClass("disabled");
                        } else {
                            $("#images").prop("disabled", false);
                            $("#btn_choose_img").removeClass("disabled");
                        }
                        return false;
                    });
                    $("#images").val("");
                    $("#img_count").text($("#img_preview").children("div").length + " / 8 images");
                    if ($("#img_preview").children("div").length >= 8) {
                        $("#images").prop("disabled", true);
                        $("#btn_choose_img").addClass("disabled");
                    } else {
                        $("#images").prop("disabled", false);
                        $("#btn_choose_img").removeClass("disabled");
                    }
                });


                $("#unitprice").on("click", function () {
                    $(this).select();
                }).keydown(function (evt) {
                    console.log(evt.keyCode);
                    if (evt.ctrlKey) {
                        return;
                    }
                    if (!isTextSelected($(this))
                            && !isEssentialKey(evt.keyCode)
                            && ($(this).val().length >= max_price_length || !isNumber(evt.keyCode))) {
                        evt.stopPropagation();
                        return false;
                    }
                });

                $("#quantity").keydown(function (evt) {
                    if (evt.ctrlKey) {
                        return;
                    }
                    var value = $(this).val() + String.fromCharCode(evt.keyCode);
                    if (!isTextSelected($(this))
                            && !isEssentialKey(evt.keyCode)
                            && (value > max_quantity || !isNumber(evt.keyCode))) {
                        evt.stopPropagation();
                        return false;
                    }
                });

            <%
                if (!editing) {
            %>
                $("#item_data").submit(function () {
                    var form = $("#item_data");
                    form.find($("input[name=<%=AppConst.Application.PARA_REQUEST_TYPE%>]")).val("<%=(AppConst.Item.REQUEST_TYPE_ITEM_NEW)%>");
                });
                startSavingDrafts();
            <%
                }
            %>
            });


            var custom_specifications_count = 1;

            function addRow() {
                var test = "<div class='row'>"
                        + "<div class='col-xs-3 specification-property' >"
                        + "<input class='form-control input-sm' type='text' name='<%=AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX%>" + custom_specifications_count + "' id='<%=AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX%>" + custom_specifications_count + "' value='' >"
                        + "</div>"
                        + "<div class='col-xs-9 specification-value'>"
                        + "<div class='input-group'>"
                        + "<input class='form-control input-sm' type='text' name='<%=AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX%>" + custom_specifications_count + "' id='<%=AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX%>" + custom_specifications_count + "' value='' >"
                        + "<span class='input-group-addon checkbox-addon'>"
                        + "<input tabindex='-1' type='checkbox' name='<%=AppConst.Item.PARA_CUSTOM_PROPERTY_VISIBLE_PREFIX%>" + custom_specifications_count + "' checked>"
                        + "</span>"
                        + "</div>"
                        + "</div>"
                        + "</div>";
                var old_custom_properties = $("input[id^=<%=AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX%>]");
                var old_custom_values = $("input[id^=<%=AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX%>]");
                if ($(old_custom_properties).length === 0
                        || ($($(old_custom_properties)[$(old_custom_properties).length - 1]).val().trim() !== ""
                                && $($(old_custom_values)[$(old_custom_values).length - 1]).val().trim() !== "")) {
                    var addNewButton = $(".specifications-new-container").detach();
                    $(".specification-container").append($(test)).append($(addNewButton));
                    custom_specifications_count++;
                }
            }


            function increaseQty() {
                if ($("#quantity").val().trim() === "") {
                    $("#quantity").val("0");
                } else
                if ($("#quantity").val() < max_quantity) {
                    var i = new Number($("#quantity").val());
                    $("#quantity").val(i + 1);
                }
            }

            function decreaseQty() {
                if ($("#quantity").val().trim() === "") {
                    $("#quantity").val("0");
                } else
                if ($("#quantity").val() > min_quantity) {
                    $("#quantity").val($("#quantity").val() - 1);
                }
            }

            function startSavingDrafts() {
                setTimeout(saveDraft, 10000);
            }

            var unloadHandlerAdded = false;
            var savingDraft = false;

            function saveDraft() {
                if (!unloadHandlerAdded) {
                    window.onbeforeunload = saveDraft;
                    unloadHandlerAdded = true;
                }
                var form = $("#item_data");
                form.find($("input[name=<%=AppConst.Application.PARA_REQUEST_TYPE%>]")).val("<%=AppConst.Item.REQUEST_TYPE_ITEM_DRAFT%>");
                savingDraft = true;
                $.post("SerItmMng", form.serialize(), function (data, status) {
                    if (status === "success") {
                        if (data === "<%=AppConst.Item.STATUS_DRAFT_SAVE_SUCCESS%>") {
                            notifyTimed("Draft saved", 1500);
                            console.log("Item saved");
                        } else {
                            console.log("Item saving failed");
                        }
                    } else {
                        console.log("Item saving not success");
                    }
                    setTimeout(saveDraft, 15000);
                });
                form.find($("input[name=<%=AppConst.Application.PARA_REQUEST_TYPE%>]")).val("<%=AppConst.Item.REQUEST_TYPE_ITEM_NEW%>");
                savingDraft = false;
            }

            function uploadImages(images) {
                $.post("SerImgMng",
                        {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ITEM%>",
            <%=AppConst.Item.PARA_IMAGES%>: JSON.stringify(images)
                        }, function (data) {
                    console.log(data);
                    var imgs = $.parseJSON(data);
                    nameImages(imgs);
                });
//                form.ajaxForm(options);
//                form.submit();
            }

            function nameImages(images) {
                for (var i = 0; i < images.length; i++) {
                    var id = images[i].imageId;
                    var name = images[i].imageName;
                    $("#image_name_" + id).attr("value", name);
                }
            }
        </script>

        <style>

            div.specification-container > div.row {
                padding-top: 2px;
                padding-bottom: 2px;
            }
            div.specification-property {
                padding-right:  5px;
            }
            div.specification-property > span {
                display: inline-block;
                padding-left: 10px;
                font-size: 12px;
            }
            div.specification-value {
                padding-left: 5px;
            }
            span.checkbox-addon {
                padding: 0 8px;
            }
            span.checkbox-addon > input[type=checkbox] {
                height: 15px;
                width:  15px;
                margin-top: 2px;
                margin-left: 2px;
            }
            .img-container {
                padding: 0 5px;
            }
        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            boolean error = false;
            Item item = null;
            if (editing) {
                item = AppUtil.viewItem(request, uid);
                if (item == null) {
                    item = new Item();
                }
                if (uid == null) {
                    item = (Item) session.getAttribute(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
                } else {
                    session.setAttribute(AppConst.Item.SESSION_ATTR_ITEM_UPDATE, item);
                }
                System.out.println("@@@ Seller ::::: " + item.getSeller());
                if (item == null || item.getSeller().getId() != user.getId()) {
                    response.sendRedirect("user_profile.jsp");
                    return;
                }
            }
            if (message.getStatus() == ResponseStatus.ERROR) {
                error = true;
                item = (Item) session.getAttribute(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
            }
        %>
        <div class="container">

            <%
                if (fromView) {
            %>
            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="product_search.jsp">Search products</a></li>
                    <li><a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">View product</a></li>
                    <li><span><%=(editing ? "Edit product" : "Add new product")%></span></li>
                </ul>
            </div>
            <%
            } else {
            %>
            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="user_profile.jsp"><%=user.getUsername()%>'s store</a></li>
                    <li><span><%=(editing ? "Edit product" : "Add new product")%></span></li>
                </ul>
            </div>
            <%
                }
            %>
            <div class="card">
                <h3><%=(editing ? "Edit product" : "New product")%></h3>
                <br>

                <form id="form_img_upload" action="SerImgMng" method="POST" >
                    <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ITEM%>">
                </form>
                <form id="item_data" class="form-horizontal" role="form" action="SerItmMng" method="POST">
                    <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=(editing && !error ? AppConst.Item.REQUEST_TYPE_ITEM_UPDATE : AppConst.Item.REQUEST_TYPE_ITEM_NEW)%>">
                    <input hidden id="current_location" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" value="">
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="name">
                            Name
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <input class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_NAME%>"
                                   id="name" value="<%=(editing || error ? item.getName() : "")%>" required="true" >
                        </div>
                        <div class="col-xs-2"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_NAME)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_NAME).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_NAME).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="category">
                            Category
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <select class="form-control input-sm" name="<%=AppConst.Item.PARA_CATEGORY%>" id="category" required="true" >
                                <%
                                    for (Category category : AppUtil.<Category>getConsts(request,
                                                                                         AppUtil.ConstType.ITEM_CATEGORY)) {
                                        if (category != null) {
                                %>
                                <optgroup label="<%=category.getName()%>">
                                    <%

                                        for (Category subCategory : category.getSubCategories()) {
                                            if (subCategory != null) {
                                    %>
                                    <option <%=(((editing || error) && item.getCategorySub() != null && subCategory.getId() == item.getCategorySub().getId()) ? "selected" : "")%> value="<%=subCategory.getId()%>"><%=(category.getName() + " - " + subCategory.getName())%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </optgroup>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-xs-2"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_CATEGORY)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_CATEGORY).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_CATEGORY).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="condition">
                            Condition
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <select class="form-control input-sm" name="<%=AppConst.Item.PARA_CONDITION%>" id="condition" required="true" >
                                <%
                                    for (OptionGroup group : AppUtil.<OptionGroup>getConsts(request,
                                                                                            AppUtil.ConstType.ITEM_CONDITION)) {
                                        if (group != null) {
                                %>
                                <optgroup label="<%=group.getName()%>">
                                    <%
                                        for (ItemOption option : group.getOptions()) {
                                            if (option != null) {
                                    %>
                                    <option <%=(((editing || error) && item.getCondition() != null && option.getOptionIdInt() == item.getCondition().getOptionIdInt()) ? "selected" : "")%> value="<%=option.getOptionId()%>"><%=option.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </optgroup>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-xs-2"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_CONDITION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_CONDITION).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_CONDITION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="row separator"></div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" >
                            Specifications <br>
                            <span class="subtext">
                                (will be used in search filters.
                                Use suggested properties
                                as much as possible.)
                            </span>
                        </label>
                        <div class="col-xs-10 col-sm-6 specification-container">
                            <%
                                if ((editing || error)) {
                                    int count = 0;
                                    for (Property property : item.getProperties()) {
                                        if (property != null) {
                                            if (property.isDefaultProp()) {
                            %>
                            <div class="row ">
                                <div class="col-xs-3 specification-property" >
                                    <span><%=property.getProperty()%></span>
                                </div>
                                <div class="col-xs-9 specification-value">
                                    <div class="input-group">
                                        <input class="form-control input-sm " name="<%=property.getPid()%>" type="text" value="<%=property.getValue()%>" >
                                        <span class="input-group-addon checkbox-addon" title="visible to viewer">
                                            <input tabindex="-1" type="checkbox" name="<%=("visible_" + property.getPid())%>" <%=(property.isVisible() ? "checked" : "")%>>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <%
                            } else {
                                count++;
                            %>
                            <div class="row">
                                <div class="col-xs-3 specification-property">
                                    <input class="form-control input-sm" type="text" name="<%=(AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX + count)%>" id="<%=(AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX + count)%>" value="<%=(property.getProperty())%>">
                                </div>
                                <div class="col-xs-9 specification-value">
                                    <div class="input-group">
                                        <input class="form-control input-sm" type="text" name="<%=(AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX + count)%>" id="<%=(AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX + count)%>" value="<%=(property.getValue())%>">
                                        <span class="input-group-addon checkbox-addon">
                                            <input tabindex="-1" type="checkbox" name="<%=(AppConst.Item.PARA_CUSTOM_PROPERTY_VISIBLE_PREFIX + count)%>" <%=(property.isVisible() ? "checked" : "")%>>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <%
                                        }
                                    }
                                }
                            } else {
                                for (Property property : AppUtil.<Property>getConsts(request,
                                                                                     AppUtil.ConstType.ITEM_DEFAULT_PROPERTY)) {
                                    if (property != null) {
                            %>
                            <div class="row ">
                                <div class="col-xs-3 specification-property" >
                                    <span><%=property.getProperty()%></span>
                                </div>
                                <div class="col-xs-9 specification-value">
                                    <div class="input-group">
                                        <input class="form-control input-sm " name="<%=property.getPid()%>" type="text" value="" >
                                        <span class="input-group-addon checkbox-addon" title="visible to viewer">
                                            <input tabindex="-1" type="checkbox" name="<%=("visible_" + property.getPid())%>" checked>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <%
                                        }
                                    }
                                }
                            %>

                            <div class="row specifications-new-container">
                                <div class="col-xs-12" >
                                    <a class="btn btn-default btn-sm pull-right specifications-add" onclick="addRow();"
                                       style="display: inline-block; padding: 5px 11px;"><span class="glyphicon glyphicon-plus">
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-2"></div>
                    </div>



                    <div class="row separator"></div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="summary">
                            Summary <br>
                            <span class="subtext">
                                (a short description.
                                HTML not supported)
                            </span>
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <textarea maxlength="180" name="<%=AppConst.Item.PARA_SUMMARY%>" id="summary" rows="5" style=" width: 100%; resize: vertical;"><%=(editing ? item.getSummary() : "")%></textarea><br>
                            <span id="summary_char_count" class="float_right subtext">
                            </span>
                        </div>
                        <div class="col-xs-2"></div>
                    </div>



                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="description">
                            Description
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <textarea name="<%=AppConst.Item.PARA_DESCRIPTION%>" id="description" rows="5" style=" width: 100%; resize: vertical;">
                                <%=((editing || error) ? item.getDescription() : "")%>
                            </textarea>
                        </div>
                        <div class="col-xs-2"></div>
                    </div>


                    <div class="row separator"></div>


                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="images">
                            Add images   <br>
                            <span class="subtext">
                                (max size 640x480)
                            </span>
                        </label>
                        <div class="col-xs-10 col-sm-6 ">
                            <input hidden type="file" accept="image/jpeg" multiple name="<%=AppConst.Item.PARA_IMAGES%>" id="images" style="visibility: hidden;" />
                            <a class="btn btn-default btn-sm" id="btn_choose_img" onclick="jQuery('#images').click();">Choose images</a>
                            <span id="img_count" class="float_right" ></span>
                            <br>
                            <br>
                            <div id="img_preview" class="row" style="font-size: xx-small;">
                            </div>
                        </div>
                        <div class="col-xs-2"></div>
                    </div>


                    <div class="row separator"></div>


                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="unitprice">
                            Unit price
                        </label>
                        <div class="col-xs-8 col-sm-6 col-md-4 col-lg-3">
                            <div class="input-group">
                                <span class="input-group-addon">Rs.</span>
                                <input class="form-control input-sm text-right" type="text" name="<%=AppConst.Item.PARA_UNITPRICE%>"
                                       data-toggle="popover" data-placement="top" data-content="Following persentages of unitprice will be
                                       charged for each sold item by the store<br>
                                       <table>
                                       <%
                                           for (Commission commission : AppUtil.<Commission>getConsts(request, ConstType.COMMISIONS)) {
                                       %>
                                       <tr>
                                       <td><%=(commission.getLowerLimit() == 0 ? ("&lt; " + commission.getUpperLimitFormatted())
                                       : (commission.getLowerLimitFormatted() + " - " + commission.getUpperLimitFormatted()))%></td>
                                       <td style='text-align:right;'><%=(commission.getPersentageFormatted())%></td>
                                       </tr>
                                       <%
                                           }
                                       %>
                                       </table>"
                                       date-viewport="{ selector: 'body', padding: 0 }" data-html="true" data-trigger="focus"
                                       id="unitprice" value="<%=((editing || error) ? (item.getUnitprice() > 0 ? item.getUnitprice() : "") : "")%>" required="true"  >
                                <span class="input-group-addon">.00</span>
                            </div>

                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_UNITPRICE)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_UNITPRICE).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_UNITPRICE).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 control-label" for="quantity">
                            Quantity
                        </label>
                        <div class="col-xs-8 col-sm-6 col-md-4 col-lg-3">
                            <div class="input-group">
                                <div class="input-group-btn" >
                                    <a class="btn btn-default btn-sm" onclick="decreaseQty(
                                                    )
                                                    ;"><span class="glyphicon glyphicon-minus" style="padding: 0 10px 0 9px;"></span></a>
                                </div>
                                <input class="form-control input-sm text-right" type="text" name="<%=AppConst.Item.PARA_QUANTITY%>"
                                       id="quantity" value="<%=((editing || error) ? item.getQuantityFormatted() : "1")%>" required="true" >
                                <div class="input-group-btn">
                                    <a class="btn btn-default btn-sm" onclick="increaseQty(
                                                    )
                                                    ;"><span class="glyphicon glyphicon-plus" style="padding: 0 10px 0 9px;"></span></a>
                                </div>
                            </div>

                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_QUANTITY)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_QUANTITY).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_QUANTITY).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>



                    <div class="row separator"></div>


                    <div class="form-group">
                        <label class="col-sm-3 col-xs-12 control-label" for="city">
                            Current location
                        </label>
                        <div class="col-sm-6 col-xs-8">
                            <select class="form-control input-sm" name="<%=AppConst.Item.PARA_LOCATION%>" id="city" required="true" >
                                <option class="disabled"><%=AppConst.Item.PARA_VAL_CITY_DEFAULT%></option>
                                <%
                                    for (String city : AppUtil.<String>getConsts(request,
                                                                                 AppUtil.ConstType.CITY)) {
                                        if (city != null) {
                                %>
                                <option <%=((editing || error) && city.equals(item.getLocation()) ? "selected"
                                       : (city.equals(user.getAddressCity()) ? "selected" : ""))%> ><%=city%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_LOCATION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_LOCATION).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_LOCATION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>



                    <div class="row separator"></div>



                    <div class="form-group">
                        <label class="col-sm-3 col-xs-12 control-label" for="delivery">
                            Delivery
                        </label>
                        <div class="col-sm-6 col-xs-8">
                            <select class="form-control input-sm" name="<%=AppConst.Item.PARA_DELIVERY_OPTION%>" id="delivery" required="true" >
                                <option class="disabled"><%=AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT%></option>
                                <%
                                    for (OptionGroup group : AppUtil.<OptionGroup>getConsts(request,
                                                                                            AppUtil.ConstType.ITEM_DELIVERY_OPTION)) {
                                        if (group != null) {
                                %>
                                <optgroup label="<%=group.getName()%>">
                                    <%
                                        for (ItemOption option : group.getOptions()) {
                                            if (option != null) {
                                    %>
                                    <option <%=(((editing || error) && item.getDeliveryOption() != null && option.getOptionIdInt() == item.getDeliveryOption().getOptionIdInt()) ? "selected" : "")%> value="<%=option.getOptionId()%>"><%=option.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </optgroup>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <br>
                            <input class="form-control input-sm" placeholder="delivery description" type="text" name="<%=AppConst.Item.PARA_DELIVERY_DESCRIPTION%>" value="" />
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_DELIVERY_OPTION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_DELIVERY_OPTION).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_DELIVERY_OPTION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="row separator"></div>

                    <div class="form-group">
                        <label class="col-sm-3 col-xs-12 control-label" for="returns">
                            Returns
                        </label>
                        <div class="col-sm-6 col-xs-8">
                            <select class="form-control input-sm"  name="<%=AppConst.Item.PARA_RETURN_OPTION%>" id="returns" required="true" >
                                <option class="disabled"><%=AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT%></option>
                                <%
                                    for (OptionGroup group : AppUtil.<OptionGroup>getConsts(request,
                                                                                            AppUtil.ConstType.ITEM_RETURN_OPTION)) {
                                        if (group != null) {
                                %>
                                <optgroup label="<%=group.getName()%>">
                                    <%
                                        for (ItemOption option : group.getOptions()) {
                                            if (option != null) {
                                    %>
                                    <option <%=(((editing || error) && item.getReturnOption() != null && option.getOptionIdInt() == item.getReturnOption().getOptionIdInt()) ? "selected" : "")%> value="<%=option.getOptionId()%>"><%=option.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </optgroup>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <br>
                            <div class="row">
                                <div class="col-xs-2">
                                    <label style="font-size: 13px; font-weight: normal;" for="return_time_limit">within</label>
                                </div>
                                <div class="col-xs-10">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_RETURN_TIME_LIMIT%>" id="return_time_limit" value="3 months" />
                                </div>
                            </div>
                            <br>
                            <input class="form-control input-sm"  placeholder="returns description" type="text" name="<%=AppConst.Item.PARA_RETURN_DESCRIPTION%>" value="" />
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_RETURN_OPTION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_RETURN_OPTION).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_RETURN_OPTION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="row separator"></div>

                    <div class="form-group">
                        <label class="col-sm-3 col-xs-12 control-label" for="guarantee">
                            Guarantee
                        </label>
                        <div class="col-sm-6 col-xs-8">
                            <select class="form-control input-sm" name="<%=AppConst.Item.PARA_GUARANTEE_OPTION%>" id="guarantee" required="true"  >
                                <option class="disabled"><%=AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT%></option>
                                <%
                                    for (OptionGroup group : AppUtil.<OptionGroup>getConsts(request,
                                                                                            AppUtil.ConstType.ITEM_GUARANTEE_OPTION)) {
                                        if (group != null) {
                                %>
                                <optgroup label="<%=group.getName()%>">
                                    <%
                                        for (ItemOption option : group.getOptions()) {
                                            if (option != null) {
                                    %>
                                    <option <%=(((editing || error) && item.getGuranteeOption() != null && option.getOptionIdInt() == item.getGuranteeOption().getOptionIdInt()) ? "selected" : "")%> value="<%=option.getOptionId()%>"><%=option.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </optgroup>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <br>
                            <div class="row">
                                <div class="col-xs-2">
                                    <label style="font-size: 13px; font-weight: normal;" for="guarantee_time_limit">within</label>
                                </div>
                                <div class="col-xs-10">
                                    <input class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_GUARANTEE_TIME_LIMIT%>" id="guarantee_time_limit" value="3 months" />
                                </div>
                            </div>
                            <br>
                            <input placeholder="guarantee description" class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_GUARANTEE_DESCRIPTION%>" value="" />
                        </div>
                        <div class="col-xs-3"></div>
                        <%
                            if (error && !message.isEmpty(AppConst.Item.PARA_GUARANTEE_OPTION)) {
                        %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <p class="alert-text" title="<%=message.getMessage(AppConst.Item.PARA_GUARANTEE_OPTION).getDescription()%>"><%=message.getMessage(AppConst.Item.PARA_GUARANTEE_OPTION).getText()%></p>
                        </div>
                        <%
                            }
                        %>
                    </div>




                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <strong>Note :</strong>  any details required at ordering / delivering can be changed at there as necessary.
                        </div>
                    </div>

                    <div class="row separator"></div>
                    <div class="row separator"></div>
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <input class="btn btn-default btn-sm" type="submit" value="<%=(editing ? (draft ? "Add to stock" : "Update product") : "Add to store")%>">
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
