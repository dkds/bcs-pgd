/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls.dispatcher;

import com.neo.beans.user.User;
import com.neo.controls.ItemManager;
import com.neo.controls.MessageManager;
import com.neo.controls.UserManager;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import com.neo.util.ResponseMessage;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author neo
 */
abstract class Dispatcher {

    private HttpServletRequest request;
    private HttpServletResponse response;
    private String currentLocation;

    public abstract void dispatchGet();

    public abstract void dispatchPost();

    HttpServletRequest getRequest() {
        return request;
    }

    void setRequest(HttpServletRequest request) {
        this.request = request;
        setCurrentLocation();
        System.out.println("Request from : " + getRequest().getLocalAddr() + " (" + getRequest().getLocalName() + ")");
    }

    HttpServletResponse getResponse() {
        return response;
    }

    void setResponse(HttpServletResponse response) {
        this.response = response;
    }

    String getCurrentLocation() {
        return currentLocation;
    }

    final void redirect(String location) {
        try {
            getResponse().sendRedirect(getResponse().encodeRedirectURL(location));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    final void redirectToCurrentLocation() {
        redirect(getCurrentLocation());
    }

    final void write(String value) {
        try {
            getResponse().getWriter().write(value);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    final String getRealPath(String location) {
        return getRequest().getServletContext().getRealPath(location);
    }

    final void addResponseMessage(String name, String message, String description) {
        ResponseMessage rm = (ResponseMessage) getSessionAttr(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE);
        if (rm == null) {
            rm = new ResponseMessage();
        }
        rm.add(name, message, description);
        setSessionAttr(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE, rm);
    }

    final void clearResponseMessage() {
        getRequest().getSession().removeAttribute(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE);
    }

    final ResponseMessage getResponseMessage() {
        ResponseMessage rm = (ResponseMessage) getSessionAttr(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE);
        if (rm == null) {
            rm = new ResponseMessage();
            setSessionAttr(AppConst.Application.SESSION_ATTR_RESPONSE_MESSAGE, rm);
        }
        return rm;
    }

    final String getRequestType() {
        return getParameter(AppConst.Application.PARA_REQUEST_TYPE);
    }

    final void setResponseStatus(AppUtil.ResponseStatus status) {
        getResponseMessage().setStatus(status);
    }

    final void setSessionAttr(String name, Object value) {
        getRequest().getSession().setAttribute(name, value);
    }

    final Object getSessionAttr(String name) {
        return getRequest().getSession().getAttribute(name);
    }

    final void removeSessionAttr(String name) {
        getRequest().getSession().removeAttribute(name);
    }

    final String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    final String[] getParameters(String name) {
        return getRequest().getParameterValues(name);
    }

    final void setCurrentUser(User user) {
        setSessionAttr(AppConst.User.SESSION_ATTR_USER, user);
    }

    final User getCurrentUser() {
        return (User) getSessionAttr(AppConst.User.SESSION_ATTR_USER);
    }

    final void reloadCurrentUser() {
        User user = getCurrentUser();
        getUserManager().reloadUser(user);
    }

    final UserManager getUserManager() {
        return UserManager.getInstance(getRequest());
    }

    final ItemManager getItemManager() {
        return ItemManager.getInstance(getRequest());
    }

    final MessageManager getMessageManager() {
        return MessageManager.getInstance(getRequest());
    }

    private void setCurrentLocation() {
        String location = getParameter(AppConst.Application.PARA_CURRENT_LOCATION);
        if (location == null || location.equalsIgnoreCase("null")) {
            location = "home.jsp";
        }
        if (location.contains(AppConst.Application.PARA_CURRENT_LOCATION)) {
            int curLocIndex = location.indexOf(AppConst.Application.PARA_CURRENT_LOCATION) + AppConst.Application.PARA_CURRENT_LOCATION.length() + 1;
            location = location.substring(curLocIndex, location.length());
        }
        currentLocation = location;
    }

}
