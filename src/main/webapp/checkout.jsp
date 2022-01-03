<%--
    Document   : checkout
    Created on : May 5, 2015, 4:17:58 PM
    Author     : neo
--%>

<%@page import="java.util.Date"%>
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
        <title>Checkout</title>
        <style>
            @media print {
                body {
                    font-family: sans, sans-serif, serif;
                }
                .nav-card,
                .header-container,
                .footer-container,
                .collapsed-header-toggle,
                .collapsed-header,
                .category-menu-container,
                .advanced-search-container,
                .top-button-container,
                .btn {
                    display: none !important;
                }
                .print-header-container,.table {
                    page-break-before: always;
                }
                .print-header-container {
                    display: block !important;
                }
                .brand-logo-container {
                    max-width: 240px;
                    margin-bottom: 35px;
                }
                .total {
                    padding-bottom: 5px;
                }
            }
            .print-header-container {
                display: none;
            }
            .user-data-container {
                padding: 5px;
            }
            .total-container {
                margin-top: 10px;
                padding: 5px;
            }
            .total-top-border {
                border-top: #c3c3c3 dotted thin;
            }
            .total-bottom-border {
                border-bottom:  #c3c3c3 dotted thin;
            }
            .total {
                padding-top: 10px;
            }
            .separator-1,
            .separator-2,
            .separator-3,
            .separator-4,
            .separator-5,
            .separator-6 {
                display: none;
            }
            @media (min-height: 450px){
                .separator-1 {
                    display: block;
                }
            }
            @media (min-height: 475px){
                .separator-1,
                .separator-2 {
                    display: block;
                }
            }
            @media (min-height: 525px){
                .separator-1,
                .separator-2,
                .separator-3 {
                    display: block;
                }
            }
            @media (min-height: 575px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4 {
                    display: block;
                }
            }
            @media (min-height: 625px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5 {
                    display: block;
                }
            }
            @media (min-height: 675px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6 {
                    display: block;
                }
            }

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            if (user.isGuest()) {
                response.sendRedirect(response.encodeRedirectURL("user_add.jsp?current_location=checkout.jsp"));
                return;
            }
        %>
        <div class="container">


            <div class="card nav-card">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="basket.jsp"><%=user.getUsername()%>'s basket</a></li>
                    <li><span>Checkout</span></li>
                </ul>
            </div>

            <div class="print-header-container">
                <div class="row ">
                    <div class="col-xs-6">
                        <div class="brand-logo-container">
                            <img class="img-responsive brand-logo" src="<%=AppConst.Application.BRANDING_LOGO%>" alt="Logo">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="user-data-container text-right">
                            <%=user.getUsername()%><br>
                            <%=AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date())%>
                        </div>
                    </div>
                </div>
            </div>




            <div class="card">


                <div class="row">
                    <div class="col-xs-12">
                        <div class="row card-header-container">
                            <span class="col-xs-8 card-header"  style="margin-top: 5px; padding-right: 0px;">
                                <span class="h3" >
                                    Checkout
                                </span>
                            </span>

                            <div class="col-xs-4" style="margin-bottom: 5px;">
                                <div class="btn-toolbar pull-right">
                                    <div class="input-group">
                                        <form action="SerItmMng" method="POST">
                                            <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Item.REQUEST_TYPE_BUY_CART%>" >
                                            <div class="input-group-btn">
                                                <button type="submit" class="btn btn-default btn-sm pull-right <%=(user.getItemCount(Container.CART) == 0
                                      ? ("disabled") : "")%>" title="buy now">
                                                    <span class="glyphicon glyphicon-credit-card"></span>
                                                    <span class="hidden-xs">Buy now</span>
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
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
                                            int itemCount = 0;
                                            for (Item item : user.getItems(Container.CART)) {
                                                itemCount++;
                                        %>
                                        <tr>
                                            <td>#<%=itemCount%></td>
                                            <td>
                                                <%
                                                    out.print(item.getName());
                                                %>
                                            </td>
                                            <td>
                                                <%
                                                    out.print("(" + item.getUnitpriceFormatted() + " x " + item.getQuantity() + ")");
                                                %>
                                            </td>
                                            <td style="text-align: right;">
                                                <%
                                                    out.print(item.getTotalFormatted());
                                                %>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>


                                    </tbody>
                                </table>
                            </div>

                            <div class="total-container col-xs-6 col-xs-push-6 col-sm-4 col-sm-push-8 ">
                                <div class="total total-top-border total-bottom-border text-right"><span style="padding-right: 15px;">Total:</span>Rs. <%=user.getTotalValueFormatted(Container.CART)%></div>
                            </div>

                        </div>
                    </div>
                </div>


            </div>
        </div>
        <div class="separator separator-1"></div>
        <div class="separator separator-2"></div>
        <div class="separator separator-3"></div>
        <div class="separator separator-4"></div>
        <div class="separator separator-5"></div>
        <div class="separator separator-6"></div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
