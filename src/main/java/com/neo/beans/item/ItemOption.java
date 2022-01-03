/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.beans.Bean;

/**
 *
 * @author neo
 */
public class ItemOption extends Bean<ItemOption> {

    private String name;
    private String description;
    private String timeLimit;
    private OptionType optionType;
    private String optionId;

    public ItemOption(String optionId, String name) {
        this.optionId = optionId;
        this.name = name;
    }

    public ItemOption(OptionType optionType, int itemOptionId) {
        this.optionType = optionType;
        setId(itemOptionId);
    }

    public ItemOption(OptionType optionType) {
        this.optionType = optionType;
    }

    public ItemOption(OptionType optionType, String name) {
        this.name = name;
        this.optionType = optionType;
    }

    public ItemOption(OptionType optionType, String optionId, String name) {
        this.optionId = optionId;
        this.name = name;
        this.optionType = optionType;
    }

    public ItemOption(OptionType optionType, String optionId, String name, String description) {
        this.optionId = optionId;
        this.name = name;
        this.description = description;
        this.optionType = optionType;
    }

    public ItemOption(OptionType optionType, String optionId, String name, String description, String timeLimit) {
        this.optionId = optionId;
        this.name = name;
        this.description = description;
        this.timeLimit = timeLimit;
        this.optionType = optionType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(String timeLimit) {
        this.timeLimit = timeLimit;
    }

    public OptionType getOptionType() {
        return optionType;
    }

    public void setOptionType(OptionType optionType) {
        this.optionType = optionType;
    }

    public String getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = String.valueOf(optionId);
    }

    public void setOptionId(String optionId) {
        this.optionId = optionId;
    }

    public int getOptionIdInt() {
        try {
            return Integer.valueOf(optionId);
        } catch (NumberFormatException e) {
            System.out.println("ItemOption.getOptionIdInt() : " + e);
        }
        return -1;
    }

    @Override
    public void clone(ItemOption bean) {
        setName(bean.getName());
        setDescription(bean.getDescription());
        setOptionId(bean.getOptionId());
        setOptionType(bean.getOptionType());
        setTimeLimit(bean.getTimeLimit());
        setId(bean.getId());
    }
}
