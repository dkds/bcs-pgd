<%--
    Document   : common_footer
    Created on : Nov 26, 2014, 1:04:20 AM
    Author     : Neo
--%>

<%@page import="com.neo.util.AppUtil"%>
<%@page import="com.neo.util.AppPropertyContainer"%>
<%@page import="com.neo.util.AppConst"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>

    $(document).ready(function () {

        var working = false;
        $(window).scroll(function () {
            if ($(this).scrollTop() < 100) {
                if (working) {
                    $(".top-button-container").stop();
                }
                working = true;
                $(".top-button-container").animate({right: "-44px"}, function () {
                    working = false;
                });
            } else if ($(".top-button-container").css("right") === "-44px") {
                if (working) {
                    $(".top-button-container").stop();
                }
                working = true;
                $(".top-button-container").animate({right: "2px"}, function () {
                    working = false;
                });
            }
            if ($(".top-button-container").offset().top + $(".top-button-container").height() >= $(".footer-container").offset().top) {
                $(".top-button-container").css("border-bottom", "none").css("opacity", "1");
            } else {
                $(".top-button-container").css("border-bottom", "#E7E7E7 thin solid").css("opacity", "0.7");
            }
        });

        $(".top-button-container").mouseenter(function () {
            $(".top-button-container").css("opacity", "1");
        });

        $(".top-button-container").mouseleave(function () {
            $(".top-button-container").css("opacity", "0.7");
        });

        $("#btn_top").click(function () {
            $('html,body').animate({scrollTop: 0});
        });

        $(".top-button-container").css("bottom", ($(".footer-container").outerHeight() - 4) + "px");

        $(window).resize(function () {
            $(".top-button-container").css("bottom", ($(".footer-container").outerHeight() - 4) + "px");
        });
    });

</script>

<%
    session.removeAttribute(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE);
%>

<div class="top-button-container">
    <button class="btn btn-default btn-sm" id="btn_top" title="Go to top">
        <span class="glyphicon glyphicon-arrow-up"></span>
    </button>
</div>
<div class="container-fluid footer-container">
    <!--©2014 <a href="about_us.jsp">IDEALStore.com</a>   <span style="display: block; float: right;"> <span class="divider">|</span> </span>-->
    <div class="row">
        <div class="col-xs-12">
            <a href="about_us.jsp">About us</a>
            <span class="hidden-xs pull-right" style="display: inline-block;">
                <a href="privacy_policy.jsp">Privacy policy</a>
                <span style="display: inline-block; margin: 0 12px;"> | </span>
                <a href="terms_and_conditions.jsp">Terms and conditions</a>
            </span>
        </div>
        <div class="col-xs-12 privacy-policy-link-container visible-xs">
            <a href="privacy_policy.jsp">Privacy policy</a>
        </div>
        <div class="col-xs-12 terms-and-conditions-link-container visible-xs">
            <a href="terms_and_conditions.jsp">Terms and conditions</a>
        </div>
    </div>
    <div class="row separator"></div>
    <div class="row">
        <div class="col-xs-12 text-center" style="color: #535D64; font-size: 12px;">
            <%=AppUtil.getAppProperties(request).getValue(AppConst.Admin.PARA_COPYRIGHT_TEXT)%>
        </div>
    </div>
</div>
