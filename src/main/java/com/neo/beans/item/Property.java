/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.beans.Bean;
import java.util.Objects;

/**
 *
 * @author neo
 */
public final class Property extends Bean<Property> {

    private String property;
    private String value;
    private boolean visible;
    private boolean defaultProp;
    private int itemId;

    public Property() {
    }

    public Property(String property, boolean defaultProp) {
        this.property = property;
        this.defaultProp = defaultProp;
    }

    public Property(String property, String value, boolean visible) {
        this.property = property;
        this.value = value;
        this.visible = visible;
    }

    public Property(String property, String value, boolean visible, boolean defaultProp) {
        this.property = property;
        this.value = value;
        this.visible = visible;
        this.defaultProp = defaultProp;
    }

    public Property(int itemId, String property, String value, boolean visible) {
        this.itemId = itemId;
        this.property = property;
        this.value = value;
        this.visible = visible;
    }

    public String getProperty() {
        return property;
    }

    public void setProperty(String property) {
        this.property = property;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public boolean isVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public String getPid() {
        return "" + Math.abs(hashCode());
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Property && ((Property) obj).getProperty().equalsIgnoreCase(getProperty());
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 79 * hash + Objects.hashCode(this.property);
        return hash;
    }

    public boolean isDefaultProp() {
        return defaultProp;
    }

    public void setDefaultProp(boolean defaultProp) {
        this.defaultProp = defaultProp;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    @Override
    public void clone(Property bean) {
        setProperty(bean.getProperty());
        setValue(bean.getValue());
        setVisible(bean.isVisible());
        setDefaultProp(bean.isDefaultProp());
        setItemId(bean.getItemId());
        setId(bean.getId());
    }
}
