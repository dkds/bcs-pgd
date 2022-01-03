/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.util.AppConst;
import java.util.ArrayList;

/**
 *
 * @author neo
 */
public class OptionGroup {

    private ArrayList<ItemOption> options;
    private String name;

    public OptionGroup(String name) {
        this.name = name;
    }

    /**
     * @return the options
     */
    public ItemOption[] getOptions() {
        if (options == null) {
            return new ItemOption[]{};
        }
        return options.toArray(new ItemOption[options.size()]);
    }

    /**
     * @param option the options to add
     */
    public void addOption(ItemOption option) {
        if (options == null) {
            options = new ArrayList<>(1);
        }
        if (!option.getName().equals(AppConst.Item.PARA_VAL_ITEM_OPTION_UNSELECTED)) {
            options.add(option);
        }
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

}
