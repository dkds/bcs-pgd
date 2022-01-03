/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

/**
 *
 * @author neo
 * @param <T> type
 */
public final class CountedList<T extends CountedList.Countable> implements Iterable<T>, Serializable {

    private final TreeSet<T> set = new TreeSet<>();

    public CountedList() {
    }

    public CountedList(List<T> items) {
        for (T item : items) {
            add(item);
        }
    }

    public void add(T item) {
        if (item != null) {
            T previousItem;
            if ((previousItem = contains(item)) != null) {
                item.setCount(previousItem.getCount() + 1);
                set.remove(previousItem);
            } else {
                item.countUp();
            }
            set.add(item);
        }
    }

    public void add(List<T> items) {
        for (T item : items) {
            add(item);
        }
    }

    public T contains(T item) {
        for (T t : set) {
            if (t != null && item != null && t.equals(item)) {
                return t;
            }
        }
        return null;
    }

    public T[] toArray(T[] ts) {
        return set.toArray(ts);
    }

    public int size() {
        return set.size();
    }

    @Override
    public Iterator<T> iterator() {
        return set.iterator();
    }

    public void clear() {
        set.clear();
    }

    public interface Countable {

        public int countUp();

        public int countDown();

        public int setCount(int count);

        public int getCount();
    }
}
