<%--
    Document   : home
    Created on : Nov 26, 2014, 8:41:39 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.item.Item"%>
<%@page import="com.neo.beans.admin.Image"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <title>IDEALStore.com</title>
        <style>

            .item-container {
                float: left;
                margin-left: 15px;
            }
            .item-img {
                width: 100%;
                max-height: 200px;
            }
            @media (max-width: 990px) {
                .item-container {
                    margin-left: 0px;
                }
            }
            /*

            @media (min-width: 767px) {
                            .item-img-container {
                                width: 205px;
                            }
                            .item-img {
                                width: 200px;
                            }
                        }
            */

            .item-name {
                display: block;
                font-size: 12px;
                margin-top:  5px;
                margin-bottom: 5px;
            }
            .item-subdata {
                display: block;
                margin-top: 5px;
                color: #555;
                font-size: 11px;
            }
            .item-superdata {
                color: #555;
                font-size: 13px;
            }
            .item {
                border: #C0C0C0 thin solid;
                border-radius: 2px;
                padding: 10px;
            }
            .item:hover {
                background-color: #f4f4f4;
                background: radial-gradient(ellipse at center, rgba(0,0,0,0) 0%,rgba(248,248,248,1) 100%); /* W3C */
            }
            .highlight {
                color: #222;
            }
            .item-details-container {
                padding: 5px;
                margin: 5px 0;
            }

        </style>
    </head>

    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">

            <div class="card">
                <%                Image[] images = appPropertyContainer.getImages();
                %>
                <div id="carousel-generic" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->

                    <ol class="carousel-indicators">
                        <%
                            int count = 0;
                            for (Image image : images) {
                        %>
                        <li data-target="#carousel-generic" data-slide-to="<%=count%>" <%=(count == 0 ? "class='active'" : "")%>></li>
                            <%
                                    count++;
                                }
                            %>
                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <%
                            count = 0;
                            for (Image image : images) {
                        %>
                        <div class="item <%=(count == 0 ? "active" : "")%>">
                            <img src="<%=image.getImageBase64()%>" alt="...">
                        </div>
                        <%
                                count++;
                            }
                        %>
                    </div>

                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-generic" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#carousel-generic" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>


            <div class="card">
                <h4>Top selling products</h4>
                <br>
                <%AppUtil.loadItems(request);
                    searchResult = (SearchResult) session.getAttribute(AppConst.Item.SESSION_ATTR_SEARCH_RESULT);
                    Item[] items = searchResult.getItems();
                    int itmCount = 0;

                %>
                <div class="row">
                    <%                            for (Item item : items) {
                            if (itmCount > 5) {
                                break;
                            }
                            if (item != null) {
                                itmCount++;
                    %>
                    <div class="col-xs-4">
                        <div class="col-xs-12 item item-details-container">
                            <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>" title="<%=item.getName()%>">
                                <img class="item-img" src="<%=item.getDefaultImage().getBase64Image()%>" alt="image of <%=item.getName()%>"/>
                                <span class="item-name"><%=item.getName()%></span>
                            </a>
                            <span class="item-superdata">
                                Rs. <%=item.getUnitpriceFormatted()%>
                            </span>
                        </div>
                    </div>
                    <%

                            }
                        }
                    %>
                </div>
            </div>


        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
