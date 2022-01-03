/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.listeners;

import com.neo.database.controls.SessionProvider;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;

/**
 *
 * @author neo
 */
@WebListener
public class RequestListener implements ServletRequestListener {

    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {
        SessionProvider.closeSession(servletRequestEvent.getServletRequest());
    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
    }
}
