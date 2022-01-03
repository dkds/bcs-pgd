<%--
    Document   : wishlist
    Created on : Nov 29, 2014, 11:15:22 PM
    Author     : neo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.min.css"/>
        <script src="scripts/util.min.jss"></script>
        <title>Your wishlist | IDEALStore.com</title>
        <style>

            span.item_name {
                font-size: small;
            }

            span.item_subdata {
                font-size: smaller;
            }

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <h3>Your wishlist</h3>
        <div class="content">
            <div style="padding-top: 15px; width: 100%;">
                <span id="item_stock">
                    Your wishlist has,
                    <span class="highlight">three (3) </span>
                    products
                </span>
                <span class="float_right"><a href="basket.jsp">add all to basket</a></span>
            </div>
            <hr>
            <br>
            <table class="borderless" style="width: 100%;">
                <tbody>
                    <tr>
                        <td rowspan="4" style="width: 110px;">
                            <a href="#"><img class="img-border" src="images/items/modern-patio.jpg" width="100" height="100" alt="Test Image"/></a>
                        </td>
                        <td><a href="#"><span class="item_name">This is a test item with a medium name</span></a></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 0px; padding-top: 0px;"><span class="item_subdata">Added on 2014-10-14 4:34 PM</span></td>
                        <td style="padding-bottom: 0px; padding-top: 0px;"></td>
                    </tr>
                    <tr>
                        <td><span class="highlight" >four (4)</span> items available on stock</td>
                        <td nowrap style="text-align: end;"><a href="#">remove product</a></td>
                    </tr>
                    <tr>
                        <td><input type="number" value="2" min="1" max="10"/>  products for a total of <span class="highlight">Rs. 12,000.00 </span> (6,000.00 x 2)</td>
                        <td nowrap style="text-align: end;"><a href="#">add to basket</a></td>
                    </tr>
                    <tr class="separator"></tr>
                    <tr class="separator"></tr>
                    <tr>
                        <td rowspan="4">
                            <a href="#"><img class="img-border" src="images/items/modern-beds.jpg" width="100" height="100" alt="Test Image"/></a>
                        </td>
                        <td><a href="#"><span class="item_name">Short name</span></a></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 0px; padding-top: 0px;"><span class="item_subdata">Added on 2014-10-14 4:34 PM</span></td>
                        <td style="padding-bottom: 0px; padding-top: 0px;"></td>
                    </tr>
                    <tr>
                        <td><span class="highlight" >six (6)</span> items available on stock</td>
                        <td nowrap style="text-align: end;"><a href="#">remove product</a></td>
                    </tr>
                    <tr>
                        <td><input type="number" value="1" min="1" max="10"/> product for a total of <span class="highlight">Rs. 1,000.00 </span></td>
                        <td nowrap style="text-align: end;"><a href="#">add to basket</a></td>
                    </tr>
                    <tr class="separator"></tr>
                    <tr class="separator"></tr>
                    <tr>
                        <td rowspan="4">
                            <a href="#"><img class="img-border" src="images/items/modern-outdoor-sofas.jpg" width="100" height="100" alt="Test Image"/></a>
                        </td>
                        <td><a href="#"><span class="item_name">This is a very very very very very very very very very very very very long long long long long long long long long long test item name</span></a></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 0px; padding-top: 0px;"><span class="item_subdata">Added on 2014-10-14 4:34 PM</span></td>
                        <td style="padding-bottom: 0px; padding-top: 0px;"></td>
                    </tr>
                    <tr>
                        <td><span class="highlight" >ten (10)</span> items available on stock</td>
                        <td nowrap style="text-align: end;"><a href="#">remove product</a></td>
                    </tr>
                    <tr>
                        <td><input type="number" value="3" min="1" max="10"/> products for a total of <span class="highlight">Rs. 3,000.00 </span> (1,000.00 x 3)</td>
                        <td nowrap style="text-align: end;"><a href="#">add to basket</a></td>
                    </tr>
                    <tr class="separator"></tr>
                    <tr class="separator"></tr>
                    <tr class="separator"></tr>
                    <tr class="separator"></tr>
                </tbody>
            </table>
            <div style="margin-top: 45px;">
                More products like this
                <br>
                <br>
                <div class="related-box">
                    <div class="related-box-content" style="border: none;"></div>
                    <div class="related-box-content">
                        <a href="product_view.jsp"><img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"/></a>
                        <a href="product_view.jsp"><div style="padding: 6px 6px 6px 6px; height: 50px; width: 140px;">Prince Dark Slate Leather Platform Bed, Cal King</div></a>
                        <div style="font-weight: bold; padding: 6px 6px 6px 6px;">Rs. 12,450.00</div>
                    </div>
                    <div class="related-box-content" style="border: none;"></div>
                    <div class="related-box-content">
                        <a href="product_view.jsp"><img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"/></a>
                        <a href="product_view.jsp"><div style="padding: 6px 6px 6px 6px; height: 50px; width: 140px;">Prince Dark Slate Leather Platform Bed, Cal King</div></a>
                        <div style="font-weight: bold; padding: 6px 6px 6px 6px;">Rs. 12,450.00</div>
                    </div>
                    <div class="related-box-content" style="border: none;"></div>
                    <div class="related-box-content">
                        <a href="product_view.jsp"><img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"/></a>
                        <a href="product_view.jsp"><div style="padding: 6px 6px 6px 6px; height: 50px; width: 140px;">Prince Dark Slate Leather Platform Bed, Cal King</div></a>
                        <div style="font-weight: bold; padding: 6px 6px 6px 6px;">Rs. 12,450.00</div>
                    </div>
                    <div class="related-box-content" style="border: none;"></div>
                    <div class="related-box-content">
                        <a href="product_view.jsp"><img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"/></a>
                        <a href="product_view.jsp"><div style="padding: 6px 6px 6px 6px; height: 50px; width: 140px;">Prince Dark Slate Leather Platform Bed, Cal King</div></a>
                        <div style="font-weight: bold; padding: 6px 6px 6px 6px;">Rs. 12,450.00</div>
                    </div>
                    <div class="related-box-content" style="border: none;"></div>
                    <div class="related-box-content">
                        <a href="product_view.jsp"><img class="img-border" src="images/items/modern-beds.jpg" width="160" height="150" alt="modern-beds"/></a>
                        <a href="product_view.jsp"><div style="padding: 6px 6px 6px 6px; height: 50px; width: 140px;">Prince Dark Slate Leather Platform Bed, Cal King</div></a>
                        <div style="font-weight: bold; padding: 6px 6px 6px 6px;">Rs. 12,450.00</div>
                    </div>
                    <div class="related-box-content" style="border: none;"></div>
                </div>
            </div>
        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
