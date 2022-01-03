/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.beans.admin.Image;
import com.neo.database.entities.AppProperty;
import com.neo.database.entities.CorouselImage;
import com.neo.util.AppConst;
import com.neo.util.AppPropertyContainer;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;

/**
 *
 * @author neo
 */
public final class AppPropertyManager extends BeanController<com.neo.beans.admin.AppProperty> {

    public static AppPropertyManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        AppPropertyManager appPropertyManager = (AppPropertyManager) session.getAttribute(
                AppConst.Application.CONTEXT_ATTR_APP_PROPERTY_MANAGER);
        if (appPropertyManager == null) {
            appPropertyManager = new AppPropertyManager(session);
            session.setAttribute(AppConst.Application.CONTEXT_ATTR_APP_PROPERTY_MANAGER, appPropertyManager);
        }
        appPropertyManager.setRequest(request);
        return appPropertyManager;
    }

    private AppPropertyManager(HttpSession session) {
        super(AppProperty.class, com.neo.beans.admin.AppProperty.class, session);
    }

    public AppPropertyContainer getAppProperties() {
        AppPropertyContainer container = new AppPropertyContainer();
        container.addProperties(get());
        container.setImages(getImages());
        return container;
    }

    public void save(AppPropertyContainer container) {
        for (com.neo.beans.admin.AppProperty property : container.getProperties()) {
            save(property);
        }
    }

    public void save(Image[] images) {
        Serializable[] ses = get(CorouselImage.class);
        for (Serializable se : ses) {
            CorouselImage img = (CorouselImage) se;
            boolean isValid = false;
            for (Image image : images) {
                if (image.getName().equals(img.getName())) {
                    isValid = true;
                    break;
                }
            }
            if (!isValid) {
                addToDelete(se);
            }
        }
        delete();
        for (Image image : images) {
            CorouselImage ci = (CorouselImage) get(CorouselImage.class, Restrictions.eq("name", image.getName()))[0];
            if (ci == null) {
                ci = new CorouselImage();
            }
            ci.setName(image.getName());
            ci.setOrdinal((byte) image.getOrdinal());
            save(ci);
        }
    }

    public Image[] getImages() {
        Criteria criteria = createCriteria(CorouselImage.class);
        criteria.addOrder(Order.asc("ordinal"));
        Serializable[] ses = get(CorouselImage.class, criteria);
        Image[] images = new Image[ses.length];
        for (int i = 0; i < ses.length; i++) {
            CorouselImage corImg = (CorouselImage) ses[i];
            images[i] = new Image(corImg.getName(), corImg.getOrdinal());
        }
        return images;
    }

    @Override
    protected com.neo.beans.admin.AppProperty getUserBean(Serializable databaseBean) {
        AppProperty property = (AppProperty) databaseBean;
        if (property == null) {
            return null;
        }
        com.neo.beans.admin.AppProperty appProperty = new com.neo.beans.admin.AppProperty();
        appProperty.setProperty(property.getProperty());
        appProperty.setValue(property.getPropValue());
        appProperty.setId(property.getAppPropertyId());
        return appProperty;
    }

    @Override
    protected Serializable getDatabaseBean(com.neo.beans.admin.AppProperty userBean) {
        if (userBean == null) {
            return null;
        }
        AppProperty property = (AppProperty) get(userBean.getId());
        if (property == null) {
            property = new AppProperty();
        }
        property.setProperty(userBean.getProperty());
        property.setPropValue(userBean.getValue());
        return property;
    }
}