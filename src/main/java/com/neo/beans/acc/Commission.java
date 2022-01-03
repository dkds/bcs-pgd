/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.acc;

/**
 *
 * @author neo
 */
public class Commission {

    private float lowerLimit;
    private float upperLimit;
    private float persentage;

    public Commission() {
    }

    public Commission(float lowerLimit, float upperLimit, float persentage) {
        this.lowerLimit = lowerLimit;
        this.upperLimit = upperLimit;
        this.persentage = persentage;
    }

    public float getLowerLimit() {
        return lowerLimit;
    }

    public void setLowerLimit(float lowerLimit) {
        this.lowerLimit = lowerLimit;
    }

    public String getLowerLimitFormatted() {
        return String.format("%,.2f", lowerLimit);
    }

    public float getUpperLimit() {
        return upperLimit;
    }

    public void setUpperLimit(float upperLimit) {
        this.upperLimit = upperLimit;
    }

    public String getUpperLimitFormatted() {
        return String.format("%,.2f", upperLimit);
    }

    public float getPersentage() {
        return persentage;
    }

    public void setPersentage(float persentage) {
        this.persentage = persentage;
    }

    public String getPersentageFormatted() {
        return String.format("%,.2f", persentage) + "%";
    }

}
