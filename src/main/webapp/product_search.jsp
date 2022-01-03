<%--
    Document   : product_search
    Created on : Nov 29, 2014, 7:29:46 PM
    Author     : neo
--%>

<%@page import="com.neo.beans.item.Item"%>
<%@page import="com.neo.beans.item.Category"%>
<%@page import="com.neo.beans.user.User.SearchResult.PageSelector"%>
<%@page import="com.neo.beans.user.User.SearchResult.ResultPage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <title>Search products | IDEALStore.com</title>
        <script>

            $(document).ready(function () {
                $(".narrowed-category-container").hide();

                $("#narrowed-category-toggle").click(function (evt) {
                    toggleNarrowedCategories();
                    evt.stopPropagation();
                    return false;
                });

                $(".item-img").hover(function () {
                    $(".item-name>a").hover();
                });

                $(window).resize(function () {
                    resizeItemContainer();
                });
                resizeItemContainer();

                $(document).click(function () {
                    toggleNarrowedCategories(false);
                });
            });

            function resizeItemContainer() {
                if ($(document).width() + 15 >= 992) {
                    toggleNarrowedCategories(false);
                    $(".item-container").width(($(".container").width() - $(".narrowed-category-container-md").outerWidth(true)) - 46);
                } else {
                    $(".item-container").css("width", "100%");
                }
            }

            function toggleNarrowedCategories(visible) {
                var hide = $(".narrowed-category-container").is(":visible");
                if (visible !== undefined) {
                    hide = !visible;
                }
                if (hide) {
                    $(".narrowed-category-container").hide();
                    $("#narrowed-category-toggle-icon")
                            .addClass("glyphicon-chevron-down")
                            .removeClass("glyphicon-chevron-up");
                    $("#narrowed-category-toggle").removeClass("active");
                } else {
                    $(".narrowed-category-container").show();
                    $("#narrowed-category-toggle-icon")
                            .removeClass("glyphicon-chevron-down")
                            .addClass("glyphicon-chevron-up");
                    $("#narrowed-category-toggle").addClass("active");
                }
            }
        </script>
        <style>

            ul.narrowed-ul {
                padding-top: 3px;
                padding-bottom: 3px;
                padding-left: 15px;
            }
            li.narrowed-li-main {
                list-style: none;
                padding-bottom: 5px;
                padding-top: 3px;
            }
            li.narrowed-li {
                list-style: none;
                padding-bottom: 5px;
                padding-top: 3px;
            }
            span.item_name {
                font-size: medium;
            }
            span.item_subdata {
                font-size: smaller;
            }
            table.item-list td {
                padding: 0px 0px 0px 10px;
            }
            .narrowed-category-container {
                position: absolute;
                border: #C0C0C0 thin solid;
                border-radius: 2px;
                z-index: 998;
                background-color: #FFF;
                box-shadow: 0px 2px 6px 1px #BBB;
                padding-right: 25px;
            }
            .narrowed-category-container-md {
                /*padding-left: 0px;*/
                width: 260px;
                float: left;
                font-size: 13px;
                line-height: 1.6;
            }
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
            .item-list-column {
                padding: 0px 5px;
            }
            .item-list-container {
            }
            .category-visible {
                font-weight: bold;
            }
            .style-summery-container {
                display: table-cell;
                vertical-align: middle;
                font-size: 12px;
                padding-right: 10px;
            }
            .pagination-container {
                display: table-cell;
            }
            @media (max-width: 420px){
                .style-summery-container {
                    width: 100%;
                    padding-right: 0;
                }
                .pagination-container {
                    display: block;
                }
            }
            .separator-1,
            .separator-2,
            .separator-3,
            .separator-4,
            .separator-5,
            .separator-6,
            .separator-7,
            .separator-8,
            .separator-9,
            .separator-10,
            .separator-11,
            .separator-12 {
                display: none;
            }
            @media (min-height: 300px){
                .separator-1 {
                    display: block;
                }
            }
            @media (min-height: 345px){
                .separator-1,
                .separator-2 {
                    display: block;
                }
            }
            @media (min-height: 375px){
                .separator-1,
                .separator-2,
                .separator-3 {
                    display: block;
                }
            }
            @media (min-height: 425px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4 {
                    display: block;
                }
            }
            @media (min-height: 445px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5 {
                    display: block;
                }
            }
            @media (min-height: 500px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6 {
                    display: block;
                }
            }
            @media (min-height: 550px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6,
                .separator-7 {
                    display: block;
                }
            }
            @media (min-height: 575px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6,
                .separator-7,
                .separator-8 {
                    display: block;
                }
            }
            @media (min-height: 605px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6,
                .separator-7,
                .separator-8,
                .separator-9 {
                    display: block;
                }
            }
            @media (min-height: 650px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6,
                .separator-7,
                .separator-8,
                .separator-9,
                .separator-10 {
                    display: block;
                }
            }
            @media (min-height: 700px){
                .separator-1,
                .separator-2,
                .separator-3,
                .separator-4,
                .separator-5,
                .separator-6,
                .separator-7,
                .separator-8,
                .separator-9,
                .separator-10,
                .separator-11 {
                    display: block;
                }
            }

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <%            String type = request.getParameter(AppConst.Application.PARA_REQUEST_TYPE);
            ResultPage resultPage = searchResult.getResults(1);
            if (type != null) {
                if (type.equals(AppConst.Item.REQUEST_TYPE_ITEM_LIST_MOVE)) {
                    String pageNo = request.getParameter(AppConst.Item.PARA_SEARCH_RESULT_PAGE_NO);
                    try {
                        int resPageNo = Integer.valueOf(pageNo);
                        resultPage = searchResult.getResults(resPageNo);
                    } catch (NumberFormatException e) {
                    }
                } else if (type.equals(AppConst.Item.REQUEST_TYPE_ITEM_LIST)) {
                    String searchCategoryMainId = request.getParameter(AppConst.Item.PARA_SEARCH_MAIN_CATEGORY_ID);
                    String searchItemCategoryId = request.getParameter(AppConst.Item.PARA_SEARCH_ITEM_CATEGORY_ID);
                    if (searchCategoryMainId != null) {
                        resultPage = searchResult.getResultsByMainCategoryId(Integer.valueOf(searchCategoryMainId));
                    } else if (searchItemCategoryId != null) {
                        resultPage = searchResult.getResultsByItemCategoryId(Integer.valueOf(searchItemCategoryId));
                    } else {
                        resultPage = searchResult.resetResults(1);
                    }
                }
            }
        %>
        <div class="container">
            <%
                if (searchResult.isEmpty()) {
            %>
            <div class="card">
                Your search query did not match any items in the store
            </div>
            <%
            } else {
            %>
            <div class="card hidden-xs hidden-sm narrowed-category-container-md">
                <div class="row card-header-container">
                    <span class="col-xs-12 card-header">
                        <span>
                            Narrowed categories
                        </span>
                    </span>
                </div>
                <div style="padding: 10px 15px;"><a href="<%=AppConst.Item.REQUEST_RESULTS%>">View all results</a></div>
                <ul class="narrowed-ul">
                    <%
                        if (searchResult != null) {
                            for (Category category : searchResult.getDistinctCategories()) {
                    %>
                    <li class="narrowed-li-main">
                        <a href="<%=AppConst.Item.REQUEST_RESULTS_BY_CATEGORY_MAIN + category.getCategoryId()%>">
                            <span class="<%=(category.isVisible() ? "category-visible" : "")%>" ><%=category.getName()%> furniture</span>
                        </a>
                        (<%=category.getCount()%>)
                        <ul class="narrowed-ul">
                            <%
                                for (Category subCategory : category.getSubCategories()) {
                                    if (subCategory != null) {
                            %>
                            <li class="narrowed-li">
                                <a class="<%=(subCategory.isVisible() ? "category-visible" : "")%>"
                                   href="<%=AppConst.Item.REQUEST_RESULTS_BY_CATEGORY_SUB + subCategory.getId()%>">
                                    <span class="<%=(subCategory.isVisible() ? "category-visible" : "")%>" ><%=subCategory.getName()%></span>
                                </a>
                                (<%=subCategory.getCount()%>)
                            </li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>

            <div class="card item-container">

                <div class="row card-header-container">
                    <div class="col-xs-2 col-sm-3 visible-xs visible-sm">
                        <button id="narrowed-category-toggle" type="button" class="btn btn-default btn-sm" style="padding-left: 10px; padding-right: 10px;" title="Narrowed categories">
                            <span id="narrowed-category-toggle-icon" class="glyphicon glyphicon-chevron-down"></span>
                            <span class="hidden-xs" style="margin-left: 10px;">Narrowed categories</span>
                        </button>
                    </div>
                    <div class="col-xs-10 col-sm-9 col-md-12">
                        <div style="float:  right; text-align: right;">
                            <div class="style-summery-container">
                                <%=searchResult.getResultSummary()%>
                            </div>
                            <div class="pagination-container">
                                <ul class="pagination pagination-sm">
                                    <%
                                        for (PageSelector selector : searchResult.getSelectors()) {
                                    %>
                                    <li class="<%=(selector.isActive() ? "active" : "")%>"><a href="<%=selector.getLink()%>"><%=selector.getPageNo()%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12" >
                        <div class="narrowed-category-container"  style="font-size: 12px; ">
                            <div style="padding: 10px 15px;"><a href="<%=AppConst.Item.REQUEST_RESULTS%>">View all results</a></div>
                            <ul class="narrowed-ul">
                                <%
                                    if (searchResult != null) {
                                        for (Category category : searchResult.getDistinctCategories()) {
                                %>
                                <li class="narrowed-li-main">
                                    <a href="<%=AppConst.Item.REQUEST_RESULTS_BY_CATEGORY_MAIN + category.getCategoryId()%>">
                                        <span class="<%=(category.isVisible() ? "category-visible" : "")%>" ><%=category.getName()%> furniture</span>
                                    </a>
                                    (<%=category.getCount()%>)
                                    <ul class="narrowed-ul">
                                        <%
                                            for (Category subCategory : category.getSubCategories()) {
                                                if (subCategory != null) {
                                        %>
                                        <li class="narrowed-li">
                                            <a class="<%=(subCategory.isVisible() ? "category-visible" : "")%>"
                                               href="<%=AppConst.Item.REQUEST_RESULTS_BY_CATEGORY_SUB + subCategory.getId()%>">
                                                <span class="<%=(subCategory.isVisible() ? "category-visible" : "")%>" ><%=subCategory.getName()%></span>
                                            </a>
                                            (<%=subCategory.getCount()%>)
                                        </li>
                                        <%
                                                }
                                            }
                                        %>
                                    </ul>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>



                <div class="row">
                    <div class="col-xs-12 item-list-container">
                        <%
                            Item[] col1Items = resultPage.getCulumn1Items();
                            Item[] col2Items = resultPage.getCulumn2Items();
                        %>
                        <div class="col-xs-6 item-list-column">
                            <%
                                for (Item item : col1Items) {
                                    if (item != null) {
                            %>
                            <div class="col-xs-12 item item-details-container">
                                <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>" title="<%=item.getName()%>">
                                    <img class="item-img" src="<%=item.getDefaultImage().getBase64Image()%>" alt="image of <%=item.getName()%>"/>
                                    <span class="item-name"><%=item.getName()%></span>
                                </a>
                                <span class="item-superdata">
                                    Rs. <%=item.getUnitpriceFormatted()%>
                                </span>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="col-xs-6 item-list-column">
                            <%
                                for (Item item : col2Items) {
                                    if (item != null) {
                            %>
                            <div class="col-xs-12 item item-details-container">
                                <a href="product_view.jsp?<%=AppConst.Item.PARA_UID%>=<%=item.getUid()%>" title="<%=item.getName()%>">
                                    <img class="item-img" src="<%=item.getDefaultImage().getBase64Image()%>" alt="Test Image"/>
                                    <span class="item-name"><%=item.getName()%></span>
                                </a>
                                <span class="item-superdata">
                                    Rs. <%=item.getUnitpriceFormatted()%>
                                </span>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>


            </div>
            <%
                }
            %>
        </div>
        <div class="separator separator-1"></div>
        <div class="separator separator-2"></div>
        <div class="separator separator-3"></div>
        <div class="separator separator-4"></div>
        <div class="separator separator-5"></div>
        <div class="separator separator-6"></div>
        <div class="separator separator-7"></div>
        <div class="separator separator-8"></div>
        <div class="separator separator-9"></div>
        <div class="separator separator-10"></div>
        <div class="separator separator-11"></div>
        <div class="separator separator-12"></div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
