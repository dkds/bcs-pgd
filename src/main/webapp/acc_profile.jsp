<%--
    Document   : acc_profile
    Created on : May 5, 2015, 11:58:07 PM
    Author     : neo
--%>

<%@page import="com.neo.util.TransactionContainer"%>
<%@page import="com.neo.beans.acc.Transaction"%>
<%@page import="com.neo.database.entities.Sale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/ui/favicon.ico">
        <link rel="stylesheet" type="text/css" href="tools/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="styles/common.css"/>
        <script src="scripts/util.js"></script>
        <%
            User usr = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
            if (usr == null || !(usr.isAdmin() || usr.isAccountant())) {
                response.sendRedirect(response.encodeRedirectURL("user_signin.jsp"));
                return;
            }
        %>
        <title>Accountant home</title>
        <style>

            .total-container {
                font-weight: bold;
            }
            .total-container td {
                padding-top: 10px !important;
                border-top:  #000 solid thin !important;
            }
            .total-container:hover {
                background-color: transparent !important;
            }
            .total-container-spacer {
                height: 15px;
            }

        </style>
    </head>
    <body>
        <%@include file="common-pages/common_header.jsp" %>
        <div class="container">
            <div class="card">
                <h3>Transactions</h3>
                <br>

                <%    TransactionContainer container = AppUtil.getTransactions(request, 0, 0);
                %>
                <div class="table-responsive">
                    <table class="table table-hover table-condensed">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Time</th>
                                <th class="text-right">Amount (Rs.)</th>
                                <th class="text-right">Commission (Rs.)</th>
                            <tr>
                        </thead>
                        <tbody id="draft_table">
                            <%                                for (Transaction transaction : container.getTransactions()) {
                            %>
                            <tr>
                                <td><%=transaction.getCount()%></td>
                                <td><%=transaction.getTimeFormatted()%></td>
                                <td class="text-right"><%=(transaction.getAmountFormatted() + " (" + transaction.getItem().getUnitpriceFormatted() + " x " + transaction.getItem().getQuantity() + ")")%></td>
                                <td class="text-right"><%=(transaction.getCommissionAmountFormatted() + " (" + transaction.getCommissionPersentageFormatted() + "%)")%></td>
                            </tr>
                            <%
                                }
                            %>
                            <tr class="total-container-spacer"></tr>
                            <tr class="total-container">
                                <td><%=container.getTotalCount()%></td>
                                <td></td>
                                <td class="text-right"><%=container.getTotalAmountFormatted()%></td>
                                <td class="text-right"><%=container.getTotalCommissionFormatted()%></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <%@include file="common-pages/common_footer.jsp" %>
    </body>
</html>
