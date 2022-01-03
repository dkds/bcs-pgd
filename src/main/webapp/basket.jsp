<%--
    Document   : bascket
    Created on : Nov 29, 2014, 11:15:22 PM
    Author     : neo
--%>

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
        <title>Your basket | IDEALStore.com</title>
        <script>

            $(document).ready(function () {

                $(function () {
                    $("[data-toggle='popover']").popover();
                });

                $('#item_remove_confirm').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var item_description = button.data('item-description');
                    var item_uid = button.data('item-uid');
                    var item_qty = button.data('item-qty');
                    var modal = $(this);
                    modal.find('#item_remove_confirm_item_uid').val(item_uid);
                    modal.find('#item_remove_confirm_item_qty').val(item_qty);
                    modal.find('#item_remove_confirm_item_description').html(item_description);
                    $("#item_remove_confirm_btn_ok").html("Yes, remove it");
                    $("#item_remove_confirm_btn_cancel, #item_remove_confirm_btn_ok").removeClass("disabled");
                    $("#item_remove_confirm_confirm_header").html("Confirm");
                });
            });

            var itemUpdateTimeout;

            function updateItem(uid, qty, input, description) {
                $("#item_remove_confirm_header").html("Removing ...");
                $("#item_remove_confirm_btn_cancel, #item_remove_confirm_btn_ok").addClass("disabled");
                if (itemUpdateTimeout !== undefined) {
                    clearTimeout(itemUpdateTimeout);
                }
                itemUpdateTimeout = setTimeout(function () {
                    $(input).addClass("disabled");
                    $("#item_remove_confirm_header").html("Removing ...");
                    $("#item_remove_confirm_btn_cancel, #item_remove_confirm_btn_ok").addClass("disabled");
                    $.post("SerItmMng",
                            {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Item.REQUEST_TYPE_REMOVE_FROM_CART%>",
            <%=AppConst.Item.PARA_UID%>: uid,
            <%=AppConst.Item.PARA_QUANTITY%>: qty
                            },
                            function (data, status) {
                                if (status === "success" && data !== "<%=AppConst.Item.STATUS_CART_ITEM_REMOVE_ERROR%>") {
                                    reloadCartData($.parseJSON(data), description);
                                } else {
                                    $("#item_remove_confirm_btn_cancel, #item_remove_confirm_btn_ok").removeClass("disabled");
                                    $("#item_remove_confirm_btn_ok").html("Try again");
                                    $("#item_remove_confirm_header").html("Error");
                                }
                                $(input).removeClass("disabled");
                            });
                }, 1500);
            }

            function reloadCartData(cartData, desc) {
                if (desc === undefined) {
                    location.reload();
                    return;
                }
                var itemCountText = cartData.itemCountText;
                var cartTotalItemCount = cartData.itemCount;
                var cartTotalQtyText = cartData.totalQtyText;
                var cartTotalQty = cartData.totalQty;
                var cartTotalValue = cartData.totalValue;
                var availableQty = cartData.availableQty;
                var unitprice = cartData.unitprice;
                var qty = cartData.qty;
                var itemTotal = cartData.itemTotal;
                var content = "<span class='card-header'>"
                        + "<span class='highlight-header'>"
                        + itemCountText + " (" + cartTotalItemCount + ") </span>products with <br>total of <span class='highlight-header'>"
                        + cartTotalQtyText + " (" + cartTotalQty + ") </span>items (quantity) and <br> <span class='highlight-header'>"
                        + "Rs. " + cartTotalValue + " </span> of value. </span>";
                $("[data-toggle='popover']").attr("data-content", content);
                var span = $("<span> / " + availableQty + " items for a total of <span class='highlight'>Rs. " + itemTotal + " </span> ("
                        + unitprice + " x " + qty + ")</span>");
                $(desc).replaceWith(span);
            }

        </script>
        <style>

            .item-list-container {
                max-height: none;
                overflow-y:visible;
            }
            .highlight-header {
                color: #000;
            }
            @media (min-width: 767px) {
                .item-img-container {
                    width: 165px;
                }
                .item-list-details-container {
                    padding-right: 15px;
                }
            }
            .item-img-container {
                height:  auto;
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

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">

            <div class="card">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-8 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span class="h3" title="Your basket has"
                                      data-container="body" data-toggle="popover" data-placement="bottom"
                                      data-html='true' data-trigger='hover'
                                      data-content="<%=(user.getItemCount(Container.CART) == 0
                                      ? ("no items")
                                      : ("<span class='card-header'>"
                                         + "<span class='highlight-header'>" + user.getItemCountText(Container.CART) + " (" + user.getItemCount(
                                         Container.CART) + ") </span>"
                                         + "products with <br>total of "
                                         + "<span class='highlight-header'>" + user.getTotalQtyText(Container.CART) + " (" + user.getTotalQty(
                                         Container.CART) + ") </span>"
                                         + "items (quantity) and <br> "
                                         + "<span class='highlight-header'>Rs. " + user.getTotalValueFormatted(
                                         Container.CART) + " </span> "
                                         + "of value. "
                                         + "</span>"))%>">
                                    Your basket
                                </span>
                            </span>

                            <div class="col-xs-4" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <div class="input-group-btn">
                                            <a href="checkout.jsp" class="btn btn-default btn-sm pull-right <%=(user.getItemCount(Container.CART) == 0
                                      ? ("disabled") : "")%>" title="checkout">
                                                <span class="glyphicon glyphicon-credit-card"></span>
                                                <span class="hidden-xs"> checkout</span>
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


                            <div class="modal" id="item_remove_confirm" tabindex="-1" role="dialog" aria-labelledby="item_remove_confirm_header" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title" id="item_remove_confirm_header">Confirm</h4>
                                        </div>
                                        <div class="modal-body">
                                            <span>Are you sure you want to remove this product from your basket?</span>
                                            <br>
                                            <br>
                                            <p id="item_remove_confirm_description" style="font-size: smaller; white-space: pre;"></p>
                                        </div>
                                        <div class="modal-footer">
                                            <input hidden id="item_remove_confirm_item_uid">
                                            <input hidden id="item_remove_confirm_item_qty">
                                            <button type="button" class="btn btn-default" id="item_remove_confirm_btn_cancel"
                                                    data-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" id="item_remove_confirm_btn_ok"
                                                    onclick="updateItem($('#item_remove_confirm_item_uid').val(), 0);">Yes, remove it</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%
                                for (Item item : user.getItems(Container.CART)) {
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
                                                            <a role="menuitem" tabindex="-1" href="#"  data-toggle="modal" data-target="#item_remove_confirm"
                                                               data-item-description="<%=item.getName()%>"
                                                               data-item-qty="<%=item.getQuantity()%>"
                                                               data-item-uid="<%=item.getUid()%>" >remove item</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>">
                                                <img class="img-border" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Image of <%=item.getName()%>"
                                                     style="max-height: 140px; max-width: 185px;">
                                            </a>
                                        </div>
                                        <div>
                                            <div class="pull-right hidden-xs text-right" style="font-size: 12px; color:  #888; display: inline-block; vertical-align: bottom;">
                                                <br><br>
                                                <br><br>
                                                <br><br>
                                                <a href="#"  data-toggle="modal" data-target="#item_remove_confirm"
                                                   data-item-description="<%=item.getName()%>"
                                                   data-item-qty="<%=item.getQuantity()%>"
                                                   data-item-uid="<%=item.getUid()%>" >remove item</a>
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
                                            <span class="item-subdata">Added to basket on <%=item.getCreateTimeFormatted()%></span>

                                            <label style="font-weight: normal; margin: 5px 0;">
                                                <span>you added</span>
                                                <input class="form-control input-sm" style="width: 55px; display: inline;" type="number"
                                                       <%="value=\"" + item.getQuantity() + "\""%> min="1" <%="max=\"" + item.getAvailableQty() + "\""%> onclick="updateItem('<%=item.getUid()%>', $(this).val(), $(this), $(this).next());">
                                                <span> / <%=item.getAvailableQty()%> items for a total of <span class="highlight">Rs. <%=item.getTotalFormatted()%> </span> (<%=item.getUnitpriceFormatted()%> x <%=item.getQuantityFormatted()%>)</span>
                                            </label>
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
