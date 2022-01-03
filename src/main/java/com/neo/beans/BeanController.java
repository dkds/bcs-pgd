/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans;

import com.neo.database.controls.Connector;
import java.io.Serializable;
import java.lang.reflect.Array;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;

/**
 *
 * @author neo
 * @param <BEAN>databaseBean
 */
public abstract class BeanController<BEAN extends Bean<BEAN>> extends Connector {

    private Class<BEAN> userBeanClass;

    public BeanController(HttpSession session) {
        super(session);
    }

    public BeanController(ServletContext context) {
        super(context);
    }

    public BeanController(Class<? extends Serializable> databaseBeanClass, Class<BEAN> userBeanClass,
                          HttpSession session) {
        this(session);
        this.userBeanClass = userBeanClass;
        setDatabaseBeanClass(databaseBeanClass);
    }

    public BeanController(Class<? extends Serializable> databaseBeanClass, Class<BEAN> userBeanClass,
                          ServletContext context) {
        this(context);
        this.userBeanClass = userBeanClass;
        setDatabaseBeanClass(databaseBeanClass);
    }

    @SuppressWarnings("unchecked")
    @Override
    public final BEAN[] get(Criteria criteria) {
        return getUserBeans(get(getDatabaseBeanClass(), criteria));
    }

    @SuppressWarnings("unchecked")
    @Override
    public final BEAN[] get(Criterion... criterions) {
        return getUserBeans(get(getDatabaseBeanClass(), criterions));
    }

    public boolean save(BEAN bean) {
        return saveBean(bean).isSuccess();
    }

    protected SaveResult saveBean(BEAN bean) {
        SaveResult result = save(getDatabaseBean(bean));
        BEAN newBean = getUserBean(result.getEntity());
        if (newBean != null) {
            bean.clone(newBean);
        }
        return result;
    }

    protected final Class<BEAN> getUserBeanClass() {
        return userBeanClass;
    }

    protected final void setUserBeanClass(Class<BEAN> userBeanClass) {
        this.userBeanClass = userBeanClass;
    }

    protected abstract BEAN getUserBean(Serializable databaseBean);

    protected abstract Serializable getDatabaseBean(BEAN userBean);

    @SuppressWarnings("unchecked")
    private BEAN[] getUserBeans(Serializable[] objects) {
        BEAN[] beans = (BEAN[]) Array.newInstance(getUserBeanClass(), objects.length);
        for (int i = 0; i < objects.length; i++) {
            if (objects[i] != null) {
                beans[i] = getUserBean(objects[i]);
            }
        }
        return beans;
    }
}
