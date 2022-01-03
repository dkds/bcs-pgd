/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.listeners;

import com.neo.controls.ItemManager;
import com.neo.controls.UserManager;
import com.neo.database.controls.DataUtil;
import com.neo.util.AppUtil;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author neo
 */
@WebListener
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent sessionEvent) {
        HttpSession session = sessionEvent.getSession();
        UserManager.createNewInstance(session);
        ItemManager.createNewInstance(session);
        DataUtil.createNewInstance(session);
        System.out.println("User initiated");
        AppUtil.setVisitorCount(AppUtil.getVisitorCount() + 1);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent sessionEvent) {
        System.out.println("User destroyed");
        AppUtil.setVisitorCount(AppUtil.getVisitorCount() - 1);
    }
}
