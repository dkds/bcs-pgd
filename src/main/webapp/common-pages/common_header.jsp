<%--
    Document   : common_header
    Created on : Nov 26, 2014, 12:49:18 AM
    Author     : Neo
--%>

<%@page import="com.neo.util.AppPropertyContainer"%>
<%@page import="com.neo.beans.user.User.SearchResult"%>
<%@page import="com.neo.beans.item.Container"%>
<%@page import="com.neo.beans.item.Category"%>
<%@page import="com.neo.util.ResponseMessage"%>
<%@page import="com.neo.beans.user.User"%>
<%@page import="com.neo.util.AppUtil"%>
<%@page import="com.neo.util.AppConst"%>
<%@page import="com.neo.util.AppUtil.ResponseStatus"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="50kb"%>
<script>

    $(document).ready(function () {
        $(".collapsed-header-toggle,.collapsed-header,.category-menu-container,.advanced-search-container").hide();
    });

</script>
<style>
    .advanced-search-separator {
        height: 15px;
    }
    .advanced-search-label {
        margin-bottom: 0px;
        margin-top: 2px;
        font-weight: normal;
    }
    #colllapsed_search,#collapsed_advanced_search_toggle{
        padding-left: 10px;
        padding-right: 10px;
    }
    @media(max-width:480px){
        #collapsed_search,#collapsed_advanced_search_toggle{
            margin-right: 0px;
            padding-left: 7px;
            padding-right: 7px;
        }
        .advanced-search-separator {
            height: 0px;
        }
    }
</style>
<%
    User user = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
    if (user == null) {
        user = AppUtil.createUser(request, response);
    }
    ResponseMessage message = (ResponseMessage) session.getAttribute(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE);
    if (message == null) {
        message = new ResponseMessage();
    }
    SearchResult searchResult = (SearchResult) session.getAttribute(AppConst.Item.SESSION_ATTR_SEARCH_RESULT);
    if (searchResult == null) {
        AppUtil.loadItems(request);
        searchResult = (SearchResult) session.getAttribute(AppConst.Item.SESSION_ATTR_SEARCH_RESULT);
    }
    session.removeAttribute(AppConst.Item.SESSION_ATTR_ITEM_DRAFT);
    AppPropertyContainer appPropertyContainer = AppUtil.getAppProperties(request);
%>
<div class="container-fluid header-container">
    <div class="row">
        <div class="col-xs-7 col-sm-4 logo-container">
            <a href="home.jsp">
                <img class="img-responsive brand-logo" src="<%=AppConst.Application.BRANDING_LOGO%>" alt="Logo">
            </a>
        </div>
        <div class="col-xs-5 col-sm-2 col-sm-push-6 text-right" style="margin-bottom: 10px;">
            <div class="row" style="margin-bottom: 5px;">
                <div class="col-xs-12">
                    <%
                        if (user.isGuest()) {
                    %>
                    <a href="user_add.jsp"> Sign up</a>
                    <%
                    } else {
                    %>
                    <form id="form_sign_out" method="POST" action="SerUsrMng">
                        <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.User.REQUEST_TYPE_SIGN_OUT%>">
                        <input hidden id="location" name="<%=AppConst.Application.PARA_CURRENT_LOCATION%>" value="">
                    </form>
                    <a id="user_signout_link" href="javascript:signOut();"> Sign out</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="row" style="margin-bottom: 10px;">
                <div class="col-xs-12">
                    <%
                        if (user.isGuest()) {
                    %>
                    <a id="user_signin_link" href="user_signin.jsp"> Sign in</a>
                    <%
                    } else {
                    %>
                    <a href="user_profile.jsp"> My store</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <a class="btn btn-default btn-sm" href="basket.jsp">
                <span class="glyphicon glyphicon-shopping-cart"></span>
                <span class="hidden-xs">Basket</span>
                <span class="badge-custom"><%=(user == null ? 0 : user.getItemCount(Container.CART))%></span>
            </a>
        </div>

        <div id="search-bar" class="col-xs-12 col-sm-6 col-sm-pull-2 text-right" style="margin-bottom: 10px; ">
            <div>
                <form id="form_search_bar"  class="form-horizontal" role="form" action="SerItmMng" method="GET">
                    <div class="input-group">
                        <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Item.REQUEST_TYPE_ITEM_LIST%>">
                        <input id="txt_search" class="form-control input-sm" placeholder="Search store ..."
                               style="min-width: 150px;" type="text" name="<%=AppConst.Item.PARA_SEARCH_TEXT%>"
                               value="<%=(searchResult == null ? "" : searchResult.getCriteria().getSearchText())%>" />
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-default btn-sm" style="padding-left: 10px; padding-right: 10px;" title="Search">
                                <span class="glyphicon glyphicon-search"></span>
                                <span class="hidden-xs hidden-sm" style="margin-left: 10px;margin-right:  10px;">Search</span>
                            </button>
                            <button id="category_toggle" type="button" class="btn btn-default btn-sm" style="padding-left: 10px; padding-right: 10px;" title="Categories">
                                <span id="category-toggle-icon" class="glyphicon glyphicon-chevron-down"></span>
                                <span class="hidden-xs hidden-sm" style="margin-left: 10px;">Category</span>
                            </button>
                            <button id="advanced_search_toggle" type="button" class="btn btn-default btn-sm" style="padding-left: 10px; padding-right: 10px;" title="Advanced">
                                <span class="glyphicon glyphicon-cog"></span>
                                <span class="visible-lg-inline" style="margin-left: 10px;">Advanced</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<div class="collapsed-header-toggle">
    <button id="btn-show-header" type="button" class="btn btn-default btn-sm pull-right" title="Toggle header">
        <span class="glyphicon glyphicon-list"></span>
    </button>
</div>
<div class="collapsed-header">
    <div class="row">
        <div class="col-xs-1">
            <a class="btn btn-default btn-sm" title="Home" href="home.jsp">
                <span class="glyphicon glyphicon-home"></span>
            </a>
        </div>
        <div class="col-xs-6">
            <div>
                <form id="form_search_collapsed" class="form-horizontal" role="form" action="SerItmMng" method="GET">
                    <div class="input-group ">
                        <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Item.REQUEST_TYPE_ITEM_LIST%>">
                        <input id="txt_collapsed_search" class="form-control input-sm" placeholder="Search store ..."
                               style="min-width: 120px; margin-top: 5px;" type="text"
                               name="<%=AppConst.Item.PARA_SEARCH_TEXT%>"
                               value="<%=(searchResult == null ? "" : searchResult.getCriteria().getSearchText())%>" />
                        <div class="input-group-btn">
                            <button id="collapsed_search" type="submit" class="btn btn-default btn-sm" title="Search">
                                <span class="glyphicon glyphicon-search"></span>
                                <span class="hidden-xs" style="margin-left: 10px;margin-right:  10px;">Search</span>
                            </button>
                            <button id="collapsed_advanced_search_toggle" type="button" class="btn btn-default btn-sm" title="Advanced">
                                <span class="glyphicon glyphicon-cog"></span>
                                <span class="hidden-xs">Advanced</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-xs-4 pull-right" style="margin-right: 7px;">
            <div class="input-group">
                <div class="input-group-btn">
                    <a id="collapsed-cart"  class="btn btn-default btn-sm" title="Basket" href="basket.jsp">
                        <span class="glyphicon glyphicon-shopping-cart"></span>
                        <span class="hidden-xs"> Basket
                            <span class="badge-custom"><%=(user == null ? 0 : user.getItemCount(Container.CART))%></span></span>
                    </a>
                    <%
                        if (user.isGuest()) {
                    %>
                    <a class="btn btn-default btn-sm" title="Sign up" href="user_add.jsp">
                        <span class="glyphicon glyphicon-user"></span>
                    </a>
                    <a class="btn btn-default btn-sm" title="Sign in" href="user_signin.jsp">
                        <span class="glyphicon glyphicon-log-in"></span>
                    </a>
                    <%
                    } else {
                    %>
                    <a class="btn btn-default btn-sm" title="My store" href="user_profile.jsp">
                        <span class="glyphicon glyphicon-user"></span>
                    </a>
                    <a class="btn btn-default btn-sm" title="Sign out" href="javascript:signOut();">
                        <span class="glyphicon glyphicon-log-out"></span>
                    </a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="category-menu-container" hidden>
    <div class="row">
        <%
            int categoryCount = 0;
            for (Category category : AppUtil.getCategoriesForMenu(request)) {
                categoryCount++;
        %>
        <div class="col-xs-6 col-sm-3">
            <div class="category-set">
                <ul class="list-unstyled">
                    <li class="main-category"><%=category.getName()%></li>
                        <%
                            for (Category subCategory : category.getSubCategories()) {
                        %>
                    <li><a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_SUB + subCategory.getId()%>"><%=subCategory.getName()%></a></li>
                        <%
                            }
                        %>
                    <li><a href="<%=AppConst.Item.REQUEST_ITEM_LIST_BY_CATEGORY_MAIN + category.getCategoryId()%>"><%="All " + category.getName().toLowerCase() + " products"%></a></li>
                </ul>
            </div>
        </div>
        <%
            if (categoryCount % 2 == 0) {
        %>
        <div class="clearfix visible-xs"></div>
        <%
                }
            }
        %>
    </div>
</div>


<div class="advanced-search-container">
    <div class="row">
        <form id="form_search_bar"  class="form-horizontal" role="form" action="SerItmMng" method="GET">
            <input hidden name="<%=AppConst.Application.PARA_REQUEST_TYPE%>" value="<%=AppConst.Item.REQUEST_TYPE_ITEM_LIST%>">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-xs-12 col-sm-3 advanced-search-label" for="search_text">
                        Keywords
                    </label>
                    <div class="col-xs-12 col-sm-9 ">
                        <input id="search_text" class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_SEARCH_TEXT%>"
                               value="<%=searchResult.getCriteria().getSearchText()%>" >
                    </div>
                </div>
                <div class="col-xs-12 advanced-search-separator"></div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-3 advanced-search-label" for="price_range">
                        Price
                    </label>
                    <div class="col-xs-12 col-sm-9 ">
                        <input id="price_range" class="form-control input-sm" type="text" name="<%=AppConst.Item.PARA_SEARCH_PRICE_RANGE%>"
                               value="" >
                    </div>
                </div>
                <div class="col-xs-12 advanced-search-separator"></div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-3 advanced-search-label" for="materials">
                        Materials
                    </label>
                    <div class="col-xs-12 col-sm-9 ">
                        <select class="form-control input-sm" name="<%=AppConst.Item.PARA_SEARCH_MATERIALS%>" id="materials" >
                            <option class="disabled"><%=AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT%></option>
                            <%
                                for (String property : AppUtil.<String>getConsts(request, AppUtil.ConstType.MATERIALS)) {
                            %>
                            <option <%=(property.equalsIgnoreCase(searchResult.getCriteria().getMaterial()) ? "selected" : "")%>><%=property%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="col-xs-12 advanced-search-separator"></div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-3 advanced-search-label" for="styles">
                        Styles
                    </label>
                    <div class="col-xs-12 col-sm-9 ">
                        <select class="form-control input-sm" name="<%=AppConst.Item.PARA_SEARCH_STYLES%>" id="styles" >
                            <option class="disabled"><%=AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT%></option>
                            <%
                                for (String property : AppUtil.<String>getConsts(request, AppUtil.ConstType.STYLES)) {
                            %>
                            <option <%=(property.equalsIgnoreCase(searchResult.getCriteria().getStyle()) ? "selected" : "")%>><%=property%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="col-xs-12 advanced-search-separator"></div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-3 advanced-search-label" for="colors">
                        Colors
                    </label>
                    <div class="col-xs-12 col-sm-9 ">
                        <select class="form-control input-sm" name="<%=AppConst.Item.PARA_SEARCH_COLORS%>" id="colors" >
                            <option class="disabled"><%=AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT%></option>
                            <%
                                for (String property : AppUtil.<String>getConsts(request, AppUtil.ConstType.COLORS)) {
                            %>
                            <option <%=(property.equalsIgnoreCase(searchResult.getCriteria().getColor()) ? "selected" : "")%>><%=property%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="col-xs-12 advanced-search-separator"></div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class="btn btn-default btn-sm pull-right" type="submit"  value="Search" >
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script>

    var working = false;
    var scrollTimer;
    $(document).ready(function () {

        $(document).scroll(function () {
            if (scrollTimer !== undefined) {
                clearTimeout(scrollTimer);
            }
            scrollTimer = setTimeout(function () {
                if (isScrolledOutFromView($(".header-container"))) {
                    toggleCollapsedHeader();
                } else {
                    if (isHeaderVisible()) {
                        hideHeader();
                    }
                    if (isHeaderButtonVisible()) {
                        hideHeaderButton();
                    }
                }
            }, 100);
        });

        $(".collapsed-header,.collapsed-header-toggle").mouseenter(function () {
            $(".collapsed-header,.collapsed-header-toggle").css("opacity", "1");
        }).mouseleave(function () {
            $(".collapsed-header,.collapsed-header-toggle").css("opacity", "0.7");
        });

        $("#btn-show-header").click(function () {
            showHeader();
            hideHeaderButton();
        });

        $("#txt_search").keyup(function () {
            $("#txt_collapsed_search,#search_text").val($("#txt_search").val());
        });

        $("#txt_collapsed_search").keyup(function () {
            $("#txt_search").val($("#txt_collapsed_search").val());
        });

        $("#category_toggle").click(function (evt) {
            toggleCategories();
            toggleAdvancedSearch(false);
            evt.stopPropagation();
            return false;
        });

        $("#advanced_search_toggle").click(function (evt) {
            toggleAdvancedSearch();
            toggleCategories(false);
            evt.stopPropagation();
            return false;
        });

        $("#collapsed_advanced_search_toggle").click(function (evt) {
            toggleAdvancedSearch(undefined, true);
            toggleCategories(false);
            evt.stopPropagation();
            return false;
        });

        $(document).click(function (evt) {
            toggleCategories(false);
            if (!$(".advanced-search-container").has($(evt.target)).length) {
                toggleAdvancedSearch(false);
            }
        });

        $("#user_signin_link").click(function () {
            $(this).attr("href", "user_signin.jsp?<%=AppConst.Application.PARA_CURRENT_LOCATION%>=" + getFilePath(window.location.href));
//            console.log($(this).attr("href"));
        });

        $("#price_range").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 0,
            max: 500000,
            from: <%=searchResult.getCriteria().getMinPrice()%>,
            to: <%=searchResult.getCriteria().getMaxPrice()%>,
            type: 'double',
            step: 1000,
            prefix: "Rs.",
            grid: true
        });

        var cache = {};
        $("#txt_search").autocomplete({
            minLength: 2,
            source: function (request, response) {
                var term = request.term;
                if (term in cache) {
                    response(cache[term]);
                    return;
                }
                $.getJSON("<%=AppConst.Item.REQUEST_SUGGESIONS%>", request, function (data, status, xhr) {
                    cache[ term ] = data;
                    response(data);
                });
            }
        });

    <%
        if (!user.isGuest()) {
    %>
        startCheckingMessages();
    <%
        }
    %>
    });

    function getFilePath(href) {
        var array = href.split("/");
        return array[array.length - 1];
    }

    function isScrolledOutFromView(element) {
        return ((($(element).offset().top + $(element).height() + 20) < $(window).scrollTop()))
                || ($(element).offset().top > ($(window).scrollTop() + $(window).height()));
    }

    function toggleCollapsedHeader() {
//        if (working) {
//            $(".collapsed-header,.collapsed-header-toggle").stop();
//            working = false;
//        }
        if (!working) {
            console.log("in");
            if (isHeaderVisible()) {
                if (isHeaderHidable()) {
                    hideHeader();
                    showHeaderButton();
                } else {
                    hideHeaderButton();
                    showHeader();
                }
            } else {
                if (!isHeaderButtonVisible()) {
                    if (isHeaderHidable()) {
                        hideHeader();
                        showHeaderButton();
                    } else {
                        hideHeaderButton();
                        showHeader();
                    }
                }
            }
        }
    }

    function isHeaderButtonVisible() {
        return $(".collapsed-header-toggle").is(":visible");
    }

    function isHeaderVisible() {
        return $(".collapsed-header").is(":visible");
    }

    function isHeaderHidable() {
        return $("#txt_collapsed_search").val().trim() === "";
    }

    function hideHeader() {
        working = true;
        $(".collapsed-header-toggle").css("border-left", "#E7E7E7 thin solid")
                .css("border-right", "#E7E7E7 thin solid");
        $(".collapsed-header").animate({top: "-40px"}, function () {
            working = false;
            $(".collapsed-header").hide();
        });
    }

    function showHeader() {
        working = true;
        $(".collapsed-header").show().animate({top: "-4px"}, function () {
            working = false;
            $(".collapsed-header-toggle").css("border-left", "none")
                    .css("border-right", "#FFF thin solid");
            $("#txt_collapsed_search").focus();
        });
    }

    function showHeaderButton() {
        working = true;
        $(".collapsed-header-toggle").show().animate({top: "-4px"}, function () {
            working = false;
        });
    }

    function hideHeaderButton() {
        working = true;
        $(".collapsed-header-toggle").animate({top: "-40px"}, function () {
            working = false;
            $(this).hide();
        });
    }

    function toggleCategories(visible) {
        var hide = $(".category-menu-container").is(":visible");
        if (visible !== undefined) {
            hide = !visible;
        }
        if (hide) {
            $(".category-menu-container").hide();
            $("#category-toggle-icon")
                    .addClass("glyphicon-chevron-down")
                    .removeClass("glyphicon-chevron-up");
            $("#category_toggle").removeClass("active");
        } else {
            $(".category-menu-container").show();
            $("#category-toggle-icon")
                    .removeClass("glyphicon-chevron-down")
                    .addClass("glyphicon-chevron-up");
            $("#category_toggle").addClass("active");
        }
    }

    function toggleAdvancedSearch(visible, collapsed) {
        var hide = $(".advanced-search-container").is(":visible");
        if (visible !== undefined) {
            hide = !visible;
        }
        if (collapsed === undefined) {
            collapsed = false;
        }
        if (hide) {
            $(".advanced-search-container").css("position", "absolute").css("top", "inherit").hide();
            $("#advanced_search_toggle,#collapsed_advanced_search_toggle").removeClass("active");
        } else {
            if (collapsed) {
                $(".advanced-search-container").css("position", "fixed").css("top", "40px");
            }
            $(".advanced-search-container").show();
            $("#advanced_search_toggle,#collapsed_advanced_search_toggle").addClass("active");
        }
        collapsedHeaderHidable = hide;
    }

    function browseCategory(span) {
        var html = $(span).parent().html();
        window.location.href = "product_search.jsp?q=" + html.substr(0, html.indexOf("<span"));
    }

    function signOut() {
        $("#location").val(getFilePath(window.location.href));
        $("#form_sign_out").submit();
    }

    function startCheckingMessages() {
        setTimeout(checkNewMessages, 15000);
    }


    function checkNewMessages() {
        console.log("Cheking messages");
        $.post("SerUsrMng", {
    <%=AppConst.Application.PARA_REQUEST_TYPE%>: "<%=AppConst.Message.REQUEST_TYPE_CHECK_NEW_MESSAGES%>"
        }, function (data, status) {
            if (status === "success" && data !== "<%=AppConst.Message.STATUS_NO_NEW_MESSAGES%>") {
                showNotifications($.parseJSON(data));
            }
            setTimeout(checkNewMessages, 15000);
        });
    }

    function showNotifications(messages) {
        for (var i = 0; i < messages.length; i++) {
            var message = messages[i];
            notify(message.text, message.subject, true).get().click(function (e) {
                if ($('.ui-pnotify-closer, .ui-pnotify-sticker, .ui-pnotify-closer *, .ui-pnotify-sticker *').is(e.target)) {
                    return;
                }
                location.href = "user_profile.jsp";
            });
        }
    }
</script>