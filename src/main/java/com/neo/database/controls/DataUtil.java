/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.database.controls;

import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;

/**
 *
 * @author neo
 */
public final class DataUtil {

    public static DataUtil getInstance(Object container) {
        if (container instanceof HttpSession) {
            return getInstance((HttpSession) container);
        } else {
            return getInstance((ServletContext) container);
        }
    }

    public static void createNewInstance(HttpSession session) {
        DataUtil dataUtil = (DataUtil) session.getAttribute(AppConst.Application.SESSION_ATTR_DATA_UTIL);
        if (dataUtil == null) {
            dataUtil = new DataUtil();
            session.setAttribute(AppConst.Application.SESSION_ATTR_DATA_UTIL, dataUtil);
        }
    }

    private static DataUtil getInstance(HttpSession session) {
        DataUtil dataUtil = (DataUtil) session.getAttribute(AppConst.Application.SESSION_ATTR_DATA_UTIL);
        if (dataUtil == null) {
            dataUtil = new DataUtil();
            session.setAttribute(AppConst.Application.SESSION_ATTR_DATA_UTIL, dataUtil);
        }
        return dataUtil;
    }

    private static DataUtil getInstance(ServletContext context) {
        DataUtil dataUtil = (DataUtil) context.getAttribute(AppConst.Application.CONTEXT_ATTR_DATA_UTIL);
        if (dataUtil == null) {
            dataUtil = new DataUtil();
            context.setAttribute(AppConst.Application.CONTEXT_ATTR_DATA_UTIL, dataUtil);
        }
        return dataUtil;
    }

    private final SessionProvider sessionProvider;

    private DataUtil() {
        this.sessionProvider = new SessionProvider();
    }

    public Serializable[] get(HttpServletRequest hibernateSessionKey, Class<? extends Serializable> databaseClass,
                              Criteria criteria) {
        return get(sessionProvider.openSession(hibernateSessionKey), databaseClass, false, criteria);
    }

    public Serializable[] get(HttpServletRequest hibernateSessionKey, Class<? extends Serializable> databaseClass,
                              Criterion... criterions) {
        return get(sessionProvider.openSession(hibernateSessionKey), databaseClass, false, criterions);
    }

    public Serializable get(HttpServletRequest hibernateSessionKey, Class<? extends Serializable> databaseClass, int id) {
        return get(sessionProvider.openSession(hibernateSessionKey), databaseClass, false, id);
    }

    public int save(HttpServletRequest hibernateSessionKey, Serializable object) {
        return save(sessionProvider.openSession(hibernateSessionKey), false, object);
    }

    public void delete(HttpServletRequest hibernateSessionKey, boolean closeSession, Serializable... objects) {
        delete(sessionProvider.openSession(hibernateSessionKey), closeSession, objects);
    }

    Session getSession(HttpServletRequest hibernateSessionKey) {
        return sessionProvider.openSession(hibernateSessionKey);
    }

    private Serializable[] get(Session session, Class<? extends Serializable> databaseClass, boolean closeSession,
                               Criterion... criterions) {
        return get(session, databaseClass, closeSession, null, criterions);
    }

    @SuppressWarnings("unchecked")
    private synchronized Serializable[] get(Session session, Class<? extends Serializable> databaseClass, boolean closeSession,
                                            Criteria criteria, Criterion... criterions) {
        try {
            Criteria cri = criteria;
            if (cri == null) {
                cri = session.createCriteria(databaseClass);
            }
            if (criterions != null) {
                for (Criterion criterion : criterions) {
                    if (criterion != null) {
                        cri.add(criterion);
                    }
                }
            }
            Serializable[] items = AppUtil.toArray(databaseClass, cri.list());
            if (items == null || items.length == 0) {
                items = new Serializable[]{null};
            }
            return items;
        } finally {
            if (session != null && session.isOpen() && closeSession) {
                session.close();
            }
        }
    }

    private synchronized Serializable get(Session session, Class<? extends Serializable> databaseClass, boolean closeSession, int id) {
        try {
            return (Serializable) session.get(databaseClass, id);
        } finally {
            if (session != null && session.isOpen() && closeSession) {
                session.close();
            }
        }
    }

    private synchronized int save(Session session, boolean closeSession, Serializable object) {
        Transaction transaction = null;
        try {
            int id = 0;
            if (object != null) {
                transaction = session.getTransaction();
                if (!transaction.isActive()) {
                    transaction.begin();
                }
//                for (Serializable object : objects) {
//                    if (object != null) {
                session.saveOrUpdate(object);
                id = (int) session.getIdentifier(object);
                System.out.println("Saving " + object + "#" + id);
//                    }
//                }
                if (id != 0) {
                    transaction.commit();
                }
            }
            return id;
        } catch (RuntimeException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        } finally {
            if (session != null && session.isOpen() && closeSession) {
                session.close();
                System.out.println("Closing session (save())");
            }
        }
    }

    private synchronized void delete(Session session, boolean closeSession, Serializable... objects) {
        Transaction transaction = null;
        try {
            if (objects != null) {
                transaction = session.getTransaction();
                if (!transaction.isActive()) {
                    transaction.begin();
                }
                for (Serializable object : objects) {
                    if (object != null) {
                        session.delete(object);
                    }
                }
                transaction.commit();
            }
        } catch (RuntimeException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        } finally {
            if (session != null && session.isOpen() && closeSession) {
                session.close();
            }
        }
    }

}