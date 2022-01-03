/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import com.neo.beans.admin.AppProperty;
import com.neo.beans.admin.Image;
import java.io.Serializable;
import java.util.Arrays;
import java.util.HashSet;

/**
 *
 * @author neo
 */
public class AppPropertyContainer implements Serializable {

    private final HashSet<AppProperty> appProperties = new HashSet<>(10);
    private Image[] images;

    public void addProperty(AppProperty appProperty) {
        appProperties.add(appProperty);
    }

    public String getValue(String property) {
        for (AppProperty appProperty : appProperties) {
            if (appProperty.getProperty().equalsIgnoreCase(property)) {
                return appProperty.getValue();
            }
        }
        return null;
    }

    public void addProperties(AppProperty[] appProperties) {
        this.appProperties.addAll(Arrays.asList(appProperties));
    }

    public void setProperty(String property, String value) {
        String str = value.replaceAll("[^\\x20-\\x7E]", "");
        boolean propertyFound = false;
        for (AppProperty appProperty : appProperties) {
            if (appProperty.getProperty().equalsIgnoreCase(property)) {
                appProperty.setValue(str);
                propertyFound = true;
            }
        }
        if (!propertyFound) {
            appProperties.add(new AppProperty(property, str));
        }
    }

    public AppProperty[] getProperties() {
        return appProperties.toArray(new AppProperty[appProperties.size()]);
    }

    public void setImages(Image[] images) {
        this.images = Arrays.copyOf(images, images.length);
    }

    public Image[] getImages() {
        return Arrays.copyOf(images, images.length);
    }
}
