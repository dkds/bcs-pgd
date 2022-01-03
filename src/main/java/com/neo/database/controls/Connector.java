/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.database.controls;

import com.neo.util.AppUtil;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author neo
 */
public class Connector {

    private Class<? extends Serializable> databaseBeanClass;
    private ArrayList<Serializable> deleteList;
    private HttpServletRequest hibernateSessionKey;
    private final HttpSession httpSession;
    private final ServletContext context;

    protected Connector(HttpSession session) {
        this.httpSession = session;
        this.context = null;
    }

    protected Connector(ServletContext context) {
        this.context = context;
        this.httpSession = null;
    }

    public SaveResult save(Serializable entity) {
        return new SaveResult(entity, DataUtil.getInstance(getContainer()).save(hibernateSessionKey, entity));
    }

    public Serializable get(int id) {
        return DataUtil.getInstance(getContainer()).get(hibernateSessionKey, getDatabaseBeanClass(), id);
    }

    public Serializable get(Class<? extends Serializable> databaseBeanClass, int id) {
        return DataUtil.getInstance(getContainer()).get(hibernateSessionKey, databaseBeanClass, id);
    }

    public Serializable[] get(Criteria criteria) {
        return get(getDatabaseBeanClass(), criteria);
    }

    public Serializable[] get(Criterion... criterions) {
        return get(getDatabaseBeanClass(), criterions);
    }

    public Serializable[] get(Class<? extends Serializable> databaseBeanClass, Criteria criteria) {
        return DataUtil.getInstance(getContainer()).get(hibernateSessionKey, databaseBeanClass, criteria);
    }

    public Serializable[] get(Class<? extends Serializable> databaseBeanClass, Criterion... criterions) {
        return DataUtil.getInstance(getContainer()).get(hibernateSessionKey, databaseBeanClass, criterions);
    }

    public int count() {
        Serializable[] ses = get();
        if (ses[0] == null) {
            return 0;
        }
        return ses.length;
    }

    public long count(Criteria criteria) {
        Serializable[] ses = get(criteria);
        if (ses[0] == null) {
            return 0;
        }
        return ses.length;
    }

    public HttpServletRequest getRequest() {
        return hibernateSessionKey;
    }

    public void setRequest(HttpServletRequest hibernateSessionKey) {
        this.hibernateSessionKey = hibernateSessionKey;
    }

    public HttpSession getHttpSession() {
        return httpSession;
    }

    protected void addToDelete(Serializable... entities) {
        if (entities != null && entities.length > 0) {
            if (deleteList == null) {
                deleteList = new ArrayList<>(5);
            }
            deleteList.addAll(Arrays.asList(entities));
        }
    }

    protected void delete(Serializable... entities) {
        addToDelete(entities);
        if (deleteList != null && !deleteList.isEmpty()) {
            AppUtil.clearNulls(deleteList);
            DataUtil.getInstance(getContainer()).delete(hibernateSessionKey,
                                                        false,
                                                        deleteList.toArray(new Serializable[deleteList.size()]));
            deleteList.clear();
            deleteList = null;
        }
    }

    protected Class<? extends Serializable> getDatabaseBeanClass() {
        return databaseBeanClass;
    }

    protected void setDatabaseBeanClass(Class<? extends Serializable> databaseBeanClass) {
        this.databaseBeanClass = databaseBeanClass;
    }

    protected Criteria createCriteria(Class<? extends Serializable> cls) {
        return DataUtil.getInstance(getContainer()).getSession(hibernateSessionKey).createCriteria(cls);
    }

    private Object getContainer() {
        if (httpSession != null) {
            return httpSession;
        } else {
            return context;
        }
    }

    protected class SaveResult {

        private final Serializable[] entities;
        private final int id;

        protected SaveResult(Serializable entity, int id) {
            this.entities = new Serializable[]{entity};
            this.id = id;
        }

        protected SaveResult(Serializable[] entities, int id) {
            this.entities = entities;
            this.id = id;
        }

        public Serializable getEntity() {
            return entities[0];
        }

        public Serializable[] getEntities() {
            return Arrays.copyOf(entities, entities.length);
        }

        public int getId() {
            return id;
        }

        public boolean isSuccess() {
            return id != 0;
        }
    }
}