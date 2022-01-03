<%--
    Document   : product_view
    Created on : Nov 28, 2014, 7:19:44 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.item.Property"%>
<%@page import="com.neo.beans.item.Image"%>
<%@page import="com.neo.beans.item.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <link rel="stylesheet" type="text/css" href="tools/highslide/highslide.min.css" />
        <script src="scripts/util.js"></script>
        <script src="tools/highslide/highslide-full.packed.js"></script>
        <%
            String uid = request.getParameter(AppConst.Item.PARA_UID);
            Item item = AppUtil.viewItem(request, uid);
            if (item == null) {
                response.sendRedirect("product_search.jsp");
                return;
            }
        %>
        <title><%=item.getName()%> | IDEALStore.com</title>
        <script>
            hs.graphicsDir = 'tools/highslide/graphics/';
            hs.align = 'center';
            hs.transitions = ['expand', 'crossfade'];
            hs.fadeInOut = true;
            hs.outlineType = 'glossy-dark';
            hs.wrapperClassName = 'dark';
            hs.captionEval = 'this.a.title';
            hs.numberPosition = 'caption';
            hs.useBox = false;
            hs.width = 640;
            hs.height = 480;
            hs.dimmingOpacity = 0.8;
            hs.allowMultipleInstances = false;

// Add the slideshow providing the controlbar and the thumbstrip
            hs.addSlideshow({
                //slideshowGroup: 'group1',
                interval: 2500,
                repeat: false,
                useControls: true,
                fixedControls: 'fit',
                overlayOptions: {
                    position: 'bottom center',
                    opacity: 0.75,
                    hideOnMouseOut: true
                },
                thumbstrip: {
                    position: 'above',
                    mode: 'horizontal',
                    relativeTo: 'expander'
                }
            });
            var miniGalleryOptions1 = {
                thumbnailId: 'thumb1'
            };

            $(document).ready(function () {

                notifyItemViewEnter();

                $(window).resize(function () {
                    resizeSellerCard();
                });
                resizeSellerCard();
            });

            function notifyItemViewEnter() {
                window.onbeforeunload = notifyItemViewLeave;
                $.post("SerAdminMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Admin.REQUEST_TYPE_ITEM_VIEW_COUNTER%>",
            <%=AppConst.Admin.PARA_ITEM_VIEW%>: "<%=AppConst.Admin.PARA_VAL_ITEM_VIEW_ENTER%>"
                });
            }

            function notifyItemViewLeave() {
                $.post("SerAdminMng", {
            <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Admin.REQUEST_TYPE_ITEM_VIEW_COUNTER%>",
            <%=AppConst.Admin.PARA_ITEM_VIEW%>: "<%=AppConst.Admin.PARA_VAL_ITEM_VIEW_LEAVE%>"
                });
            }

            function resizeSellerCard() {
                console.log("Window : " + $(window).width());
                if ($(window).width() < 752) {
                    $(".seller-card").css("height", "100%");
                } else {
                    console.log("setting height : " + $(".specification-card").outerHeight());
                    if ($(".specification-card").outerHeight() > 258) {
                        $(".seller-card").css("height", $(".specification-card").outerHeight() + "px");
                    }
                }
            }

        </script>
        <style>

            .item-details-container {
                color: #555;
                font-size: 13px;
            }
            .item-name {
                color: #333;
                display: block;
                font-size: 17px;
                margin-bottom: 10px;
                margin-top: 10px;
            }
            .item-subdata {
                font-size: smaller;
            }
            .item-summery {
                font-size: 13px;
            }
            .item-property-container {
                display: table-row;
            }
            .item-property-container span.property {
                display: table-cell;
                width: 85px;
                padding-bottom: 5px;
            }
            .item-property-container span.value {
                display: table-cell;
                padding-bottom: 5px;
            }
            .item-specification-container {
                display: table-row;
            }
            .item-specification-container span.property {
                display: table-cell;
                width: 90px;
                padding-bottom: 5px;
            }
            .item-specification-container span.value {
                display: table-cell;
                padding-bottom: 5px;
            }
            .review-date {
                color: #666666;
                font-size: 12px;
            }
            .review-container .row:not(.card-header-container) {
                font-size: 13px;
                margin-bottom: 20px;
            }
            .review-date {
                padding-left: 15px;
                padding-right: 15px;
                margin-bottom: 5px;
                margin-top: 5px;
            }
            @media (max-width: 767px) {
                .item-img-container {
                    margin-bottom: 25px;
                }
                .specification-card {
                    margin: 0 1px;
                }
                .seller-card {
                    margin: 15px 1px 0 1px;
                }
            }
            @media (min-width: 768px) {
                #buttons {
                    float: right;
                }
                .specification-card {
                    margin: 0 0 0 1px;
                }
                .specification-card-container {
                    padding-right: 0;
                }
                .seller-card {
                    margin: 0 1px 0 0;
                }
                .review-date {
                    padding-left: 0;
                    padding-right: 0;
                }
                .review-container .row:not(.card-header-container) {
                    font-size: 13px;
                    margin-bottom: 10px;
                }
            }

        </style>
    </head>
    <body>

        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">
            <div class="card">


                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-5 item-img-container">
                        <%                            Image defaultImage = item.getDefaultImage();
                        %>
                        <div class="col-xs-12 ">
                            <a id="thumb1" href="<%=defaultImage.getBase64Image()%>" class="highslide" onclick="return hs.expand(this)">
                                <img class="img-responsive" src="<%=defaultImage.getBase64Image()%>" style="margin: auto;" alt="Image of <%=item.getName()%>" width="460" height="320"
                                     title="Click to enlarge" />
                            </a>
                        </div>
                        <div class="col-xs-12" style="margin: 5px 0;">
                            <div style=" overflow-x: auto;" class="highslide-gallery highslide-thumbstrip-horizontal">
                                <div style="text-align: center;min-width: 400px;">
                                    <%
                                        Image[] otherImages = item.getNormalImages();
                                        for (int i = 0; i < otherImages.length; i++) {
                                            Image image = otherImages[i];
                                    %>
                                    <a <%=("id='thumb'" + (i + 2))%> href="<%=image.getBase64Image()%>" class="highslide" onclick="return hs.expand(this)">
                                        <img src="<%=image.getBase64Image()%>" alt="Image of <%=item.getName()%>" width="100" height="90"
                                             title="Click to enlarge" />
                                    </a>
                                    <div class="highslide-caption">
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-7" >
                        <ol class="breadcrumb">
                            <li><a href="product_search.jsp" >All Products</a></li>
                            <li><a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_MAIN + item.getCategoryMain().getCategoryId()%>"><%=item.getCategoryMain().getName()%></a></li>
                            <li><a class="active" href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_SUB + item.getCategorySub().getCategoryId()%>"><%=item.getCategorySub().getName()%></a></li>
                        </ol>
                        <div class="item-details-container">
                            <span class="item-name"><%=item.getName()%></span>
                            <p class="item-summery"><%=item.getSummary()%></p>
                            <div class="item-property-container">
                                <span class="property">Price</span>
                                <span class="value">Rs. <%=item.getUnitpriceFormatted()%></span>
                            </div>
                            <div class="item-property-container">
                                <span class="property">Location</span>
                                <span class="value"><%=item.getLocation()%></span>
                            </div>
                            <div class="item-property-container">
                                <span class="property">Delivery</span>
                                <span class="value"><%=item.getDeliveryOption().getName()%></span>
                            </div>
                            <div class="item-property-container">
                                <span class="property">Guarantee</span>
                                <span class="value"><%=item.getGuranteeOption().getName()%></span>
                            </div>
                            <div class="item-property-container">
                                <span class="property">Returns</span>
                                <span class="value"><%=item.getReturnOption().getName()%></span>
                            </div>
                            <form id="form_add_to_cart" style="float: left;" action="SerItmMng" method="POST">
                                <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Item.REQUEST_TYPE_ADD_TO_CART%>">
                                <input hidden name="<%=AppConst.Item.PARA_UID%>" value="<%=item.getUid()%>">
                                <div class="item-property-container">
                                    <span class="property">Quantity</span>
                                    <span class="value">
                                        <input class="form-control input-sm" style="width: 55px; display: inline;" name="<%=AppConst.Item.PARA_QUANTITY%>"
                                               type="number" value="1" min="1" <%=(" max=\"" + item.getAvailableQty() + "\"")%>/>
                                        / <%=item.getAvailableQty()%> available
                                    </span>
                                </div>
                                <div style="margin-top: 20px;">
                                    <div class="btn-group" id="buttons">
                                        <noscript>
                                        <button class="btn btn-default btn-sm" type="submit">Add to your basket</button>
                                        </noscript>
                                        <button class="<%=(user.getQtyOf(Container.CART, item) >= item.getAvailableQty()
                                       || item.getSeller().getId() == user.getId() ? "disabled" : "")%> btn btn-default btn-sm"
                                                onclick="$('#form_add_to_cart').submit();"><%=(user.hasItem(Container.CART, item)
                                       ? "Add more to basket" : "Add to your basket")%></button>
                                            <%
                                                if (item.getSeller().getId() == user.getId()) {
                                            %>
                                        <a href="product_add.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>&edit=true&from_view=true"
                                           class="btn btn-default btn-sm ">edit</a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>


            <!--<div class="row">-->
            <!--<div class="col-xs-12 specification-card-container">-->


            <div class="card specification-card">
                <div class="row card-header-container">
                    <span class="col-xs-12 card-header"  style="margin-top: 5px;">
                        <span>
                            Specifications
                        </span>
                    </span>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="item-specification-container">
                            <span class="property">Condition</span>
                            <span class="value"><%=item.getCondition().getName()%></span>
                        </div>
                        <%
                            Property[] properties = item.getProperties();
                            for (Property property : properties) {
                                if (property.isVisible()) {
                        %>
                        <div class="item-specification-container">
                            <span class="property"><%=property.getProperty()%></span>
                            <span class="value"><%=property.getValue()%></span>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>

                <!--</div>-->

                <!--</div>-->

                <!--
                                <div class="col-xs-12 col-sm-4 col-md-3 seller-card-container">
                                    <div class="card seller-card">
                                        <div class="row card-header-container">
                                            <span class="col-xs-12 card-header"  style="margin-top: 5px;">
                                                <span>
                                                    Sellers' info
                                                </span>
                                            </span>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-7 col-sm-12">
                                                <span style="display: inline-block;margin-bottom: 10px;"><%=item.getSeller().getUsername()%></span><br>
                                                <img style="margin-bottom: 5px;" src="images/ui/rating.png" width="100" height="16" alt="rating"/>
                                                <span class="subtext" style="display: block">rated by 23 buyers</span>
                                                <div class="hidden-xs">
                                                    <br>
                                                    <br>
                                                    <br>
                                                    <span style="display: block; float: right;"><a href="#">View reviews</a></span>
                                                </div>
                                            </div>

                                            <div class="col-xs-5">
                                                <div class="visible-xs">
                                                    <span style="display: block; float: right;"><a href="#">View reviews</a></span>
                                                    <br>
                                                    <br>
                                                    <span class="pull-right" style="display: block"><a href="#">View products</a></span>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>-->


            </div>

            <%
                if (item.isDescriptionSet()) {
            %>
            <div class="card">
                <%=item.getDescription()%>
            </div>
            <%
                }
            %>





            <div class="card review-container">
                <div class="row card-header-container">
                    <span class="col-xs-12 card-header"  style="margin-top: 5px;">
                        <span>
                            Buyer reviews <span class="subtext">(showing reviews from last five (5) buyers)</span>
                        </span>
                    </span>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        tes******r_1
                    </div>
                    <div class="col-xs-12 col-sm-2 review-date">
                        2014-07-13 4:05 PM
                    </div>
                    <div class="col-xs-12 col-sm-8">
                        Excellent design and craftsmanship, totally worth the price
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        use****ter
                    </div>
                    <div class="col-xs-12 col-sm-2 review-date">
                        2014-07-13 4:05 PM
                    </div>
                    <div class="col-xs-12 col-sm-8">
                        I will def go back for more furnishings as money permits!
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        tur******014
                    </div>
                    <div class="col-xs-12 col-sm-2 review-date">
                        2014-07-13 4:05 PM
                    </div>
                    <div class="col-xs-12 col-sm-8">
                        Hard goods like bureaus and tables are OK, but stay away from anything with a mattress or cushions, Unless you don't mind buying another mattress in 2 yrs.
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        web*******ler
                    </div>
                    <div class="col-xs-12 col-sm-2 review-date">
                        2014-07-13 4:05 PM
                    </div>
                    <div class="col-xs-12 col-sm-8">
                        Definitely worth checking out before making a purchase at the more expensive competitors.
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-2">
                        tes******ter
                    </div>
                    <div class="col-xs-12 col-sm-2 review-date">
                        2014-07-13 4:05 PM
                    </div>
                    <div class="col-xs-12 col-sm-8">
                        Excellent design and craftsmanship, totally worth the price
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
