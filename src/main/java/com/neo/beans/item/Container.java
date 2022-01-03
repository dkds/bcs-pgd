/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

/**
 *
 * @author neo
 */
public enum Container {

    STOCK, CART, WISHLIST, BOUGHT, SOLD, DRAFT;

    @Override
    public String toString() {
        String name = name();
        return name.charAt(0) + name.substring(1, name.length()).toLowerCase();
    }
}
