/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.admin;

import com.neo.beans.Bean;

/**
 *
 * @author neo
 */
public class AppProperty extends Bean<AppProperty> {

    private String property;
    private String value;

    public AppProperty() {
    }

    public AppProperty(String property, String value) {
        this.property = property;
        this.value = value;
    }

    @Override
    public void clone(AppProperty bean) {
        setProperty(bean.getProperty());
        setValue(bean.getValue());
        setId(bean.getId());
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
}
