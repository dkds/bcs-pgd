/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.admin;

import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.io.Serializable;

/**
 *
 * @author neo
 */
public class Image implements Serializable {

    private String name;
    private int ordinal;

    public Image() {
    }

    public Image(String name, int ordinal) {
        this.name = name;
        this.ordinal = ordinal;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageBase64() {
        return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_ADMIN_IMAGE, getName());
    }

    public int getOrdinal() {
        return ordinal;
    }

    public void setOrdinal(int ordinal) {
        this.ordinal = ordinal;
    }

}
