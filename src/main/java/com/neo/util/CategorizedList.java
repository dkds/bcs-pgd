package com.neo.util;

import java.io.Serializable;
import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author neo
 * @param <ITEM>
 * @param <CATEGORY>
 */
public class CategorizedList<ITEM, CATEGORY> implements Serializable {

    private final ArrayList<ITEM> items = new ArrayList<>(5);
    private final ArrayList<CATEGORY> categories = new ArrayList<>(5);

    public boolean add(ITEM item, CATEGORY category) {
        boolean available = false;
        for (int i = 0; i < items.size(); i++) {
            if (categories.get(i).equals(category) && items.get(i).equals(item)) {
                available = true;
            }
        }
        if (available) {
            return false;
        }
        items.add(item);
        categories.add(category);
        return true;
    }

    public ArrayList<ITEM> get(CATEGORY category) {
        ArrayList<ITEM> list = new ArrayList<>(5);
        for (int i = 0; i < items.size(); i++) {
            if (category != null && categories.get(i).equals(category)) {
                list.add(items.get(i));
            } else if (category == null) {
                list.add(items.get(i));
            }
        }
        list.trimToSize();
        return list;
    }

    public int size(CATEGORY category) {
        int count = 0;
        for (int i = 0; i < items.size(); i++) {
            if (categories.get(i).equals(category)) {
                count++;
            }
        }
        return count;
    }

    public void add(ITEM[] items, CATEGORY category) {
        for (ITEM item : items) {
            if (item != null && category != null) {
                add(item, category);
            }
        }
    }

}
