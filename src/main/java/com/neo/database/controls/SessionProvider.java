/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.database.controls;

import com.neo.util.AppConst;
import org.hibernate.Session;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author neo
 */
public class SessionProvider {

    public static synchronized void closeSession(ServletRequest request) {
        Session session = (Session) request.getAttribute(AppConst.Application.REQUEST_ATTR_HIB_SESSION);
        if (session != null && session.isOpen()) {
            session.close();
            request.removeAttribute(AppConst.Application.REQUEST_ATTR_HIB_SESSION);
            System.out.println("Closing session");
        }
    }

    synchronized Session openSession(HttpServletRequest request) {
        if (request == null) {
            throw new NullPointerException("Null hibernateSessionKey");
        }
        return getSession(request);
    }

    private synchronized Session openSession() {
        System.out.println("Opening session");
        return HibernateUtil.getSessionFactory().openSession();
    }

    private Session getSession(HttpServletRequest request) {
        Session session = (Session) request.getAttribute(
                AppConst.Application.REQUEST_ATTR_HIB_SESSION);
        if (session == null || !session.isOpen()) {
            session = openSession();
        }
        request.setAttribute(AppConst.Application.REQUEST_ATTR_HIB_SESSION, session);
        return session;
    }
}