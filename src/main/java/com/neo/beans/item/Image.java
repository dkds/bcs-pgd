/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.beans.Bean;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.util.Objects;

/**
 *
 * @author neo
 */
public final class Image extends Bean<Image> {

    private String name;
    private boolean defaultImage;

    public Image(String name, boolean defaultImage) {
        this.name = name;
        this.defaultImage = defaultImage;
    }

    public Image(int itemImageId, String name, boolean defaultImage) {
        this.name = name;
        this.defaultImage = defaultImage;
        setId(itemImageId);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isDefaultImage() {
        return defaultImage;
    }

    public void setDefaultImage(boolean defaultImage) {
        this.defaultImage = defaultImage;
    }

    public String getSrc() {
        return AppConst.Image.REQUEST_IMAGE_ITEM + getName();
    }

    public String getBase64Image() {
        return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_ITEM_IMAGE, getName());
    }

    @Override
    public boolean equals(Object obj) {
        return (obj instanceof Image && obj.hashCode() == hashCode());
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 17 * hash + Objects.hashCode(this.name);
        return hash;
    }

    @Override
    public void clone(Image bean) {
        setName(bean.getName());
        setDefaultImage(bean.isDefaultImage());
        setId(bean.getId());
    }
}
