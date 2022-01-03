/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans;

import java.io.Serializable;

/**
 *
 * @author neo
 * @param <BEAN>
 */
public abstract class Bean<BEAN extends Bean<BEAN>> implements Serializable {

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object obj) {
        return (obj instanceof Bean && obj.hashCode() == hashCode());
    }

    public abstract void clone(BEAN bean);

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + this.id;
        return hash;
    }
}
