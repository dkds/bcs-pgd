/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.database.entities.ContainerItem;
import com.neo.database.entities.Item;
import com.neo.database.entities.ItemProperty;
import com.neo.database.entities.Property;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.io.Serializable;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class ItemPropertyManager extends BeanController<com.neo.beans.item.Property> {

    public static ItemPropertyManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ItemPropertyManager itemPropertyManager = (ItemPropertyManager) session.getAttribute(
                AppConst.Application.SESSION_ATTR_ITEM_PROPERTY_MANAGER);
        if (itemPropertyManager == null) {
            itemPropertyManager = new ItemPropertyManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_ITEM_PROPERTY_MANAGER, itemPropertyManager);
        }
        itemPropertyManager.setRequest(request);
        return itemPropertyManager;
    }

    private ItemPropertyManager(HttpSession session) {
        super(ItemProperty.class, com.neo.beans.item.Property.class, session);
    }

    @Override
    public Serializable getDatabaseBean(com.neo.beans.item.Property userBean) {
        if (userBean == null) {
            return null;
        }
        ItemProperty property = (ItemProperty) get(ItemProperty.class, userBean.getId());
        if (property == null) {
            property = new ItemProperty((Item) get(Item.class, userBean.getItemId()),
                                        getProperty(userBean.getProperty()));
            property.setValue(userBean.getValue());
            property.setVisible(userBean.isVisible());
            userBean.setId(property.getItemPropertyId());
        }
        return property;
    }

    @Override
    public com.neo.beans.item.Property getUserBean(Serializable databaseBean) {
        ItemProperty property = (ItemProperty) databaseBean;
        if (property == null) {
            return null;
        }
        com.neo.beans.item.Property p = new com.neo.beans.item.Property();
        p.setProperty(property.getProperty().getName());
        p.setValue(property.getValue());
        p.setVisible(property.getVisible() == null ? false : property.getVisible());
        p.setItemId(property.getItem().getItemId());
        p.setDefaultProp(property.getProperty().getDefaultProp() == null ? false : property.getProperty().getDefaultProp());
        p.setId(property.getItemPropertyId());
        return p;
    }

    public void saveItemProperties(int id, com.neo.beans.item.Property[] itemProperties) {
        if (id == 0 || itemProperties == null) {
            System.out.println("Cannot save properties : Item ID : " + id
                               + " , itemProperties : " + itemProperties);
            return;
        }
        Item itm = ((ContainerItem) get(ContainerItem.class, id)).getItem();
        for (int i = 0; i < itemProperties.length; i++) {
            ItemProperty ip = getItemProperty(itm, getProperty(itemProperties[i].getProperty()));
            ip.setValue(itemProperties[i].getValue());
            ip.setVisible(itemProperties[i].isVisible());
            save(ip);
        }
    }

    public com.neo.beans.item.Property[] getDefaultProperties() {
        Criteria propCriteria = createCriteria(Property.class)
                .add(Restrictions.eq("defaultProp", true));
        Serializable[] ses = get(Property.class, propCriteria);
        com.neo.beans.item.Property[] props = new com.neo.beans.item.Property[ses.length];
        for (int i = 0; i < ses.length; i++) {
            Property property = (Property) ses[i];
            com.neo.beans.item.Property p = new com.neo.beans.item.Property();
            p.setProperty(property.getName());
            p.setDefaultProp(property.getDefaultProp());
            props[i] = p;
        }
        return props;
    }

    public ItemProperty[] get(String property, String value) {
        Criteria criteria = createCriteria(ItemProperty.class);
        criteria.createAlias("property", "property").add(
                Restrictions.like("property.name", property, MatchMode.ANYWHERE));
        criteria.add(Restrictions.like("value", value, MatchMode.ANYWHERE));
        return (ItemProperty[]) get(ItemProperty.class, criteria);
    }

    public com.neo.beans.item.Property[] get(com.neo.beans.item.Item item) {
        if (item.getId() == 0) {
            return null;
        }
        Item itm = ((ContainerItem) get(ContainerItem.class, item.getId())).getItem();
        return get(Restrictions.eq("item", itm));
    }

    public String[] getPropertyValues(AppUtil.ConstType type) {
        String propertyName;
        switch (type) {
            case MATERIALS:
                propertyName = "Material";
                break;
            case STYLES:
                propertyName = "Style";
                break;
            case COLORS:
                propertyName = "Color";
                break;
            default:
                throw new AssertionError();
        }
        Criteria criteriaProperty = createCriteria(ItemProperty.class);
        criteriaProperty.createAlias("property", "property")
                .add(Restrictions.eq("property.name", propertyName))
                .setProjection(Projections.distinct(Projections.property("value")));
        Serializable[] values = get(String.class, criteriaProperty);
        ArrayList<String> strings = new ArrayList<>(values.length);
        for (Serializable ser : values) {
            if (ser != null) {
                String name = (String) ser;
                if (!name.trim().isEmpty() && !contains(strings, name)) {
                    strings.add(name);
                }
            }
        }
        return strings.toArray(new String[strings.size()]);
    }

    private ItemProperty getItemProperty(Item item, Property property) {
        ItemProperty itemProperty = (ItemProperty) get(ItemProperty.class, Restrictions.eq("item", item),
                                                       Restrictions.eq("property", property))[0];
        if (itemProperty == null) {
            itemProperty = new ItemProperty(item, property);
            save(itemProperty);
        }
        return itemProperty;
    }

    private Property getProperty(String property) {
        Property prop = (Property) get(Property.class, Restrictions.eq("name", property))[0];
        if (prop == null) {
            prop = new Property();
            prop.setName(property);
            prop.setDefaultProp(Boolean.FALSE);
            save(prop);
        }
        return prop;
    }

    private ItemProperty[] getItemProperties(Item item) {
        Serializable[] ses = get(Restrictions.eq("item", item));
        ItemProperty[] ips = new ItemProperty[ses.length];
        for (int i = 0; i < ses.length; i++) {
            ips[i] = (ItemProperty) ses[i];
        }
        return ips;
    }

    private boolean contains(ArrayList<String> strings, String value) {
        boolean contains = false;
        for (String string : strings) {
            if (string.trim().equalsIgnoreCase(value.trim())) {
                contains = true;
                break;
            }
        }
        return contains;
    }
}
